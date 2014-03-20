'use strict';

#
# Controller for log-in form.
#
angular.module('assessory').controller "user.LogIn", ($scope, UserService, ConfigService, $location, $sce) ->

  $scope.twitter = $sce.trustAsResourceUrl("#{ConfigService.apiBase}/oauth/twitter")

  $scope.github = $sce.trustAsResourceUrl("#{ConfigService.apiBase}/oauth/github")

  $scope.user = { }

  $scope.errors = []

  $scope.submit = (user) ->
    $scope.errors = [ ]
    UserService.logIn(user).then(
     (data) -> $location.path("/")
     (fail) -> $scope.errors = [ fail.data?.error || "Unexpected error" ]
    )
