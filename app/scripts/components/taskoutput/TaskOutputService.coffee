

angular.module('assessory.task').service 'TaskOutputService', ($http, $cacheFactory, CourseService, ConfigService) ->

  toCache = $cacheFactory("taskOutputCache")

  {

    get: (id) ->
      toCache.get(id) || (
        prom = $http.get("#{ConfigService.apiBase}/taskoutput/#{id}").then(
          (successRes) -> successRes.data
        )
        toCache.put(id, prom)
        prom
      )

    updateBody: (to) -> $http.post("#{ConfigService.apiBase}/taskoutput/#{to.id}", to).then((res) ->
      gs = res.data
      toCache.put(gs.id, gs)
      gs
    )

    saveNew: (to) -> $http.post("#{ConfigService.apiBase}/task/#{to.task}/newOutput", to).then((res) ->
      gs = res.data
      toCache.put(gs.id, gs)
      gs
    )

    save: (to) ->
      if to.id?
        @updateBody(to)
      else
        @saveNew(to)

    relevantToMe: (taskId) -> $http.get("#{ConfigService.apiBase}/task/#{taskId}/relevantToMe").then((res) -> res.data)

    myOutputs: (taskId) -> $http.get("#{ConfigService.apiBase}/task/#{taskId}/myOutputs").then((res) -> res.data)
  }
