angular.module("assessory.group").controller "group.ViewGroupSet", ($scope, CourseService, GroupService, groupSet) ->

  $scope.groupSet = groupSet

  $scope.course = CourseService.get(groupSet.course)

  $scope.refreshGroups = () ->
    $scope.groups = GroupService.byGroupSet(groupSet.id)

  $scope.refreshGroups()
