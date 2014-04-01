angular.module('assessory.task').controller 'task.View', ($scope, CourseService, GroupService, TaskService, task) ->

  $scope.task = task

  CourseService.get(task.course).then (course) ->
    $scope.course = course
    
