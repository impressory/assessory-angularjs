angular.module('assessory.course').controller "course.ViewPreenrol", ($scope, CourseService, $location, preenrol) ->
  $scope.preenrol = preenrol

  $scope.errors = []
