angular.module('assessory.task').controller 'taskoutput.View', ($scope, CourseService, GroupService, TaskService, taskoutput) ->

  $scope.taskoutput = taskoutput

  $scope.task = TaskService.get(taskoutput.task).then((t) ->
    $scope.course = CourseService.get(t.course)
    t
  )
    
