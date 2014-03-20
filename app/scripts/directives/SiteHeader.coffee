'use strict';

angular.module('assessory').controller "SiteHeader", ($scope, UserService, $location, $route) ->

  UserService.self().then (user) ->
    $scope.user = user

  $scope.logOut = () ->
    UserService.logOut().then(
      (res) ->
        $location.path("/")
        $route.reload()
      (res) ->
        $location.path("/")
        $route.reload()
    )


angular.module('assessory').directive "siteHeader", (UserService) ->
  {
    controller: "SiteHeader"
    restrict: 'E'
    scope: {}
    templateUrl: "/views/directives/directive_siteHeader.html"
  }

