angular.module('assessory.task').controller 'task.Admin', ($scope, CourseService, GroupService, TaskService, task) ->

  $scope.task = task

  $scope.course = CourseService.get(task.course)
