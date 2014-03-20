angular.module('assessory.task').controller 'task.TaskInfo', ($scope, TaskService) ->
    

angular.module('assessory.task').directive "taskInfo", () ->
  {
    scope: { task: '=task' }
    controller: 'task.TaskInfo'
    templateUrl: "/views/components/task/directive_taskInfo.html"
    restrict: 'E'
  }
