'use strict';

angular.module('assessory.course').controller 'course.MyCourses', ($scope, CourseService) ->

  $scope.findMyCourses = () ->
    CourseService.doPreenrolments().then((d) ->
      $scope.refreshMyCourses()
    )

  $scope.refreshMyCourses = () ->
    CourseService.my().then((courses) ->
      $scope.courses = courses
    )

  $scope.refreshMyCourses()
