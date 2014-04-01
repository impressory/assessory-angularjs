angular.module("assessory.group").controller "group.View", ($scope, CourseService, GroupService, group) ->

  CourseService.get(group.course).then (course) ->
    $scope.course = course

  $scope.group = group

  GroupService.getGroupSet($scope.group.set).then (gs) ->
    $scope.groupSet = gs



angular.module("assessory.group").controller "group.GroupInfo", ($scope, GroupService) ->
  GroupService.getGroupSet($scope.group.set).then (gs) ->
    $scope.groupSet = gs


angular.module("assessory.group").controller "group.GroupLabel", ($scope, GroupService) ->
  $scope.$watch("groupId", (nv) ->
    GroupService.get($scope.groupId).then (g) ->
      $scope.group = g
  )


angular.module("assessory.group").directive "groupInfo",  () ->
  {
    scope: { group: '=group' }
    controller: "group.GroupInfo"
    templateUrl: "/views/components/group/directive_groupInfo.html"
    restrict: 'E'
  }

angular.module("assessory.group").directive "groupLabel",  () ->
  {
    scope: { groupId: '=groupId' }
    controller: "group.GroupLabel"
    templateUrl: "/views/components/group/directive_groupLabel.html"
    restrict: 'E'
  }