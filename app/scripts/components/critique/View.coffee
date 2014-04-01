angular.module('assessory.task').controller 'critique.CritInfo', ($scope, CourseService, CritiqueService) ->

  $scope.setSelected = (target) ->
    $scope.selectedTarget = target

  CritiqueService.myAllocations($scope.task.id).then (alloc) ->
    $scope.myAllocations = alloc


# Filling out critiques
angular.module('assessory.task').controller 'critique.CritFill', ($scope, TaskOutputService, CritiqueService) ->

  $scope.saveMsg = []

  $scope.$watch("target", (nv) ->
    $scope.taskOutput = null

    CritiqueService.getCritique($scope.task.id, $scope.target).then (taskOutput) ->
      $scope.taskOutput = taskOutput
  )

  $scope.save = (finalise) ->
    $scope.saveMsg = []
    if $scope.taskOutput?
      copied = angular.copy($scope.taskOutput)
      copied.finalise = finalise
      TaskOutputService.updateBody(copied).then(
        (data) -> $scope.saveMsg = [ "saved" ],
        (err) -> $scope.saveMsg = [ "Yikes, there was an error" ]
      )







angular.module('assessory.task').controller 'critique.AllocationInfo', ($scope, $location, CritiqueService, GroupService) ->

  groupIds = (alloc.group for alloc in $scope.allocation.allocation)

  $scope.cachedGroups = {}

  GroupService.findMany(groupIds).then((groups) ->
    for group in groups
      $scope.cachedGroups[group.id] = group
  )

  $scope.createCritique = (alloc) ->
     GroupCritService.createCritique($scope.allocation.id, alloc.group).then((crit) ->
        $location.path("/taskoutput/#{crit.id}/edit")
     )



angular.module('assessory.task').controller 'critique.AllAllocations', ($scope, UserService, GroupService, CritiqueService) ->

   # We keep our own locally updated cache of users on the scope, so that the table of allocations
   # cannot inadvertently cause individual requests for users to the server
   $scope.cachedUsers = {}

   # We keep our own locally updated cache of users on the scope, so that the table of allocations
   # cannot inadvertently cause individual requests for users to the server
   $scope.cachedGroups = {}

   GroupCritService.allAllocations($scope.task.id).then((allocations) ->
     userIds = (allocation.user for allocation in allocations when allocation.user != null)

     # Bulk fetch the users
     users = UserService.findMany(userIds).then((users) ->
       for user in users
         $scope.cachedUsers[user.id] = user
       users
     )

     # Bulk fetch the groups
     groups = {}
     for allocation in allocations
       for alloc in allocation.allocation
         groups[alloc.group] = 1
     groups = GroupService.findMany(Object.keys(groups)).then((groups) ->
       for group in groups
         $scope.cachedGroups[group.id] = group
     )

     $scope.allocations = allocations
   )

   $scope.allocate = () -> CritiqueService.allocateTask($scope.task.id)


angular.module('assessory.task').directive "critiqueInfo", () ->
  {
    scope: { task: '=task' }
    controller: "critique.CritInfo"
    templateUrl: "/views/components/critique/directive_critInfo.html"
    restrict: 'E'
  }

angular.module('assessory.task').directive "critiqueFill", () ->
  {
    scope: { task: '=task', target: '=target' }
    controller: "critique.CritFill"
    templateUrl: "/views/components/critique/directive_critFill.html"
    restrict: 'E'
  }



angular.module('assessory.task').directive "targetLabel", () ->
  {
    scope: { target: '=target' }
    templateUrl: "/views/components/critique/directive_targetLabel.html"
    restrict: 'E'
  }
    
angular.module('assessory.task').directive "allocationInfo", () ->
  {
    scope: { allocation: '=allocation' }
    controller: "critique.AllocationInfo"
    templateUrl: "/views/components/critique/directive_allocationInfo.html"
    restrict: 'E'
  }

angular.module('assessory.task').directive "allAllocations", () ->
  {
    scope: { task: '=task' }
    controller: "critique.AllAllocations"
    templateUrl: "/views/components/critique/directive_allAllocations.html"
    restrict: 'E'
  }



angular.module('assessory.task').controller 'groupcrit.GCOutputEdit', ($scope, GroupService, GroupCritService) ->
  $scope.group  = GroupService.get($scope.taskoutput.body.forGroup)


angular.module('assessory.task').directive "gcoutputView", () ->
  {
    scope: { task: '=task', taskoutput: "=taskoutput" }
    controller: Assessory.controllers.groupcrit.GCOutputView
    templateUrl: "directive_gcoutputView.html"
    restrict: 'E'
  }


angular.module('assessory.task').directive "gcoutputEdit", () ->
  {
    scope: { task: '=task', taskoutput: "=taskoutput" }
    controller: Assessory.controllers.groupcrit.GCOutputEdit
    templateUrl: "directive_gcoutputEdit.html"
    restrict: 'E'
  }
