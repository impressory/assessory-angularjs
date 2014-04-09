'use strict';

angular.module('assessory.config').controller "SavedMessage", ($scope) ->

  $scope.$watch("promise", (nv) ->
    $scope.error = null
    $scope.success = null

    nv.then(
      (success) -> $scope.success = $scope.successMessage,
      (error) -> $scope.error = error.error || "Unexpected error"
    )
  )

angular.module('assessory.config').directive "savedMessage", () ->
  {
    controller: "SavedMessage"
    restrict: 'E'
    scope: { promise: '=', successMessage: '@'}
    templateUrl: "/views/directives/directive_savedMessage.html"
  }