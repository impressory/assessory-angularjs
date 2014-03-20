'use strict';

#
# Controller for sign-up form.
#
angular.module('assessory.user').controller "user.Self", ($scope, UserService) ->
    
  $scope.user = UserService.self()
    
