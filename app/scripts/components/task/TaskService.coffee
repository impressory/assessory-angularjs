
angular.module('assessory.task', [
  'assessory.config',
  'assessory.course'
])


angular.module('assessory.task').service 'TaskService', ($http, $cacheFactory, CourseService, ConfigService) ->
      
  taskCache = $cacheFactory("taskCache")

  {

    get: (id) ->
      taskCache.get(id) || (
        prom = $http(
          withCredentials: true
          method: 'GET'
          url: "#{ConfigService.apiBase}/task/#{id}"
        ).then(
          (successRes) -> successRes.data
        )
        taskCache.put(id, prom)
        prom
      )

    create: (courseId, task) ->
      $http(
        withCredentials: true
        method: 'POST'
        url: "#{ConfigService.apiBase}/course/#{courseId}/task/create"
        data: task
      ).then((res) ->
        gs = res.data
        taskCache.put(gs.id, gs)
        gs
      )

    updateBody: (task) ->
      $http(
        withCredentials: true
        method: 'POST'
        url: "#{ConfigService.apiBase}/task/#{task.id}/body"
        data: task
      ).then((res) ->
        gs = res.data
        taskCache.put(gs.id, gs)
        gs
      )

    courseTasks: (courseId) ->
      $http(
        withCredentials: true
        method: 'GET'
        url: "#{ConfigService.apiBase}/course/#{courseId}/tasks"
      ).then((res) -> res.data)

  }
