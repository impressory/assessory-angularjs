'use strict';

#
# Controller for sign-up form.
#
angular.module('assessory.user').controller "user.Self", ($scope, UserService) ->
    
  UserService.self().then (user) ->
    $scope.user = user
    
