angular.module("assessory.group").controller "group.View", ($scope, CourseService, GroupService, group) ->

  $scope.course = CourseService.get(group.course)

  $scope.group = group

  $scope.groupSet = GroupService.getGroupSet($scope.group.set)


angular.module("assessory.group").controller "group.GroupInfo", ($scope, GroupService) ->
  $scope.groupSet = GroupService.getGroupSet($scope.group.set)


angular.module("assessory.group").directive "groupInfo",  () ->
  {
    scope: { group: '=group' }
    controller: "group.GroupInfo"
    templateUrl: "/views/components/group/directive_groupInfo.html"
    restrict: 'E'
  }
