'use strict';

angular.module('assessory.user').service 'UserService', ($http, $cacheFactory, $q, ConfigService) ->

  cache = $cacheFactory("userCache")

  {

    # Fetches a JSON representation of the user themselves
    self: () ->
      cache.get("self") || (
        prom = $http(
          withCredentials: true
          method: "POST"
          url: "#{ConfigService.apiBase}/self"
        ).then(
          (successRes) -> successRes.data
        )
        cache.put("self", prom)
        prom
      )

    get: (id) ->
      cache.get(id) || (
        prom = $http(
          withCredentials: true
          method: "GET"
          url: "#{ConfigService.apiBase}/user/#{id}"
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
        url: "#{ConfigService.apiBase}/user/findMany"
        data: { ids: ids }
      ).then(
          (successRes) ->
            data = successRes.data
            for user in data
              cache.put(user.id, user)
            data
        )

    forgetSelf: () -> cache.remove("self")

    signUp: (json) ->
      prom = $http(
        withCredentials: true
        method: "POST"
        url: "#{ConfigService.apiBase}/signUp"
        data: json
      ).then((res) -> res.data)
      cache.put("self", prom)
      prom


    logIn: (json) ->
      prom = $http(
        withCredentials: true
        method: "POST"
        url: "#{ConfigService.apiBase}/logIn"
        data: json
      ).then((res) -> res.data)
      cache.put("self", prom)
      prom

    logOut: () ->
      cache.remove("self")
      $http(
        withCredentials: true
        method: "POST"
        url: "#{ConfigService.apiBase}/logOut"
      ).then(
        (res) -> null
        (res) -> null
      )
  }
