angular.module("assessory.group").controller "group.CreateGroupSet", ($scope, GroupService, $location, course) ->
  $scope.groupSet = { }

  $scope.errors = []

  $scope.submit = (groupSet) ->
    $scope.errors = [ ]
    GroupService.createGroupSet(course.id, groupSet).then(
     (gs) -> $location.path("/groupSet/#{gs.id}")
     (fail) -> $scope.errors = [ fail.data?.error || "Unexpected error" ]
    )
