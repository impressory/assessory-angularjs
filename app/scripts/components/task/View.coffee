angular.module('assessory.task').controller 'task.View', ($scope, CourseService, GroupService, TaskService, task) ->

  $scope.task = task

  $scope.course = CourseService.get(task.course)
    
