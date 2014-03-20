'use strict';

angular.module('assessory.course').service 'CourseService', ($http, $cacheFactory, ConfigService, UserService, $q) ->

  cache = $cacheFactory("courseCache")
  preenrolCache = $cacheFactory("preenrolCache")

  {

    create: (course) ->
      prom = $http(
        withCredentials: true
        method: "POST"
        url: "#{ConfigService.apiBase}/course/create"
        data: course
      ).then((res) ->
        course = res.data
        defer = $q.defer()
        cache.put(course.id, defer)
        defer.resolve(course)
        course
      )

    get: (id) ->
      cache.get(id) || (
        prom = $http(
          withCredentials: true
          method: "GET"
          url: "#{ConfigService.apiBase}/course/#{id}"
        ).then(
          (successRes) -> successRes.data
        )
        cache.put(id, prom)
        prom
      )

    findMany: (ids) ->
      $http(
        withCredentials: true
        method: "POST"
        url: "#{ConfigService.apiBase}/course/findMany"
        data: { ids: ids }
      ).then(
        (successRes) -> successRes.data
      )

    my: () ->
      $http(
        withCredentials: true
        method: "POST"
        url: "#{ConfigService.apiBase}/course/my"
      ).then(
        (successRes) -> successRes.data
      )

    createPreenrol: (courseId, preenrol) ->
      $http(
        withCredentials: true
        method: "POST"
        url: "#{ConfigService.apiBase}/course/#{courseId}/createPreenrol"
      ).then((res) ->
        d = res.data
        preenrolCache.put(d.id, d)
        d
      )

    getPreenrol: (id) ->
      preenrolCache.get(id) || (
        prom = $http(
          withCredentials: true
          method: "GET"
          url: "#{ConfigService.apiBase}/preenrol/#{id}"
        ).then(
          (successRes) -> successRes.data
        )
        preenrolCache.put(id, prom)
        prom
      )

    coursePreenrols: (courseId) ->
      $http(
        withCredentials: true
        method: "GET"
        url: "#{ConfigService.apiBase}/course/#{courseId}/preenrols"
      ).then((res) -> res.data)

  }

