angular.module('assessory.user').controller "user.UserManyInfo", ($scope, UserService, $location) ->
  UserService.findMany($scope.userIds).then (users) ->
    $scope.users = users


angular.module('assessory.user').directive "userManyInfo", () ->
  {
    scope: { userIds: '=userIds' }
    controller: "user.UserManyInfo"
    templateUrl: "/views/components/user/directive_userManyInfo.html"
    restrict: 'E'
  }

angular.module('assessory.user').directive "userInfo", () ->
  {
    scope: { user: '=user' }
    templateUrl: "/views/components/user/directive_userInfo.html"
    restrict: 'E'
  }
