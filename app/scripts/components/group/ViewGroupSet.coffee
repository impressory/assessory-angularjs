angular.module("assessory.group").controller "group.ViewGroupSet", ($scope, CourseService, GroupService, groupSet) ->

  $scope.groupSet = groupSet

  CourseService.get(groupSet.course).then (course) ->
    $scope.course = course

  $scope.refreshGroups = () ->
    GroupService.byGroupSet(groupSet.id).then (groups) ->
      $scope.groups = groups

  $scope.refreshGroups()
