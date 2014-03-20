angular.module('assessory.user').controller "user.UserManyInfo", ($scope, UserService, $location) ->
  $scope.users = UserService.findMany($scope.userIds)


angular.module('assessory.user').directive "userManyInfo", () ->
  {
    scope: { userIds: '=userIds' }
    controller: Assessory.controllers.login.UserManyInfo
    templateUrl: "directive_userManyInfo.html"
    restrict: 'E'
  }

angular.module('assessory.user').directive "userInfo", () ->
  {
    scope: { user: '=user' }
    templateUrl: "directive_userInfo.html"
    restrict: 'E'
  }
