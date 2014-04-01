

angular.module('assessory.task').service 'TaskOutputService', ($http, $cacheFactory, CourseService, ConfigService) ->

  toCache = $cacheFactory("taskOutputCache")

  {

    get: (id) ->
      toCache.get(id) || (
        prom = $http(
          withCredentials: true
          method: "GET"
          url: "#{ConfigService.apiBase}/taskoutput/#{id}"
        ).then(
          (successRes) -> successRes.data
        )
        toCache.put(id, prom)
        prom
      )

    updateBody: (to) ->
      $http(
        withCredentials: true
        method: "POST"
        url: "#{ConfigService.apiBase}/taskoutput/#{to.id}"
        data: to
      ).then(
        (successRes) -> successRes.data
      )

    saveNew: (to) ->
      $http(
        withCredentials: true
        method: "POST"
        url: "#{ConfigService.apiBase}/task/#{to.task}/newOutput"
        data: to
      ).then((res) ->
        gs = res.data
        toCache.put(gs.id, gs)
        gs
      )


    save: (to) ->
      if to.id?
        @updateBody(to)
      else
        @saveNew(to)

    relevantToMe: (taskId) ->
      $http(
        withCredentials: true
        method: "GET"
        url: "#{ConfigService.apiBase}/task/#{taskId}/relevantToMe"
      ).then((res) -> res.data)

    myOutputs: (taskId) ->
      $http(
        withCredentials: true
        method: "GET"
        url: "#{ConfigService.apiBase}/task/#{taskId}/myOutputs"
      ).then((res) -> res.data)
  }
