angular.module("assessory.group").controller "group.CreateGPreenrol", ($scope, GroupService) ->
  $scope.gpreenroll = { }

  $scope.errors = []

  $scope.submit = (gpreenrol) ->
    $scope.errors = [ ]
    GroupService.createGroupPreenrol($scope.groupSet.id, gpreenrol).then(
     (gs) -> $scope.refreshGroups()
     (fail) -> $scope.errors = [ fail.data?.error || "Unexpected error" ]
    )
