angular.module('assessory.task').controller 'task.Admin', ($scope, CourseService, GroupService, TaskService, task) ->

  $scope.task = task

  CourseService.get(task.course).then (course) ->
    $scope.course = course
