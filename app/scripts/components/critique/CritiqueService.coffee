angular.module('assessory.task').service 'CritiqueService', ($http, $cacheFactory, $location, ConfigService) ->
      
    
  {

    allocateTask: (taskId) ->
      $http(
        withCredentials: true
        method: 'POST'
        url: "#{ConfigService.apiBase}/critique/#{taskId}/allocate"
      ).then(
        (successRes) -> successRes.data
      )

    myAllocations: (taskId) ->
      $http(
        withCredentials: true
        method: 'GET'
        url: "#{ConfigService.apiBase}/critique/#{taskId}/myAllocations"
      ).then(
        (successRes) -> successRes.data
      )

    allAllocations: (taskId) ->
      $http(
        withCredentials: true
        method: 'GET'
        url: "#{ConfigService.apiBase}/critique/#{taskId}/allocations"
      ).then(
        (successRes) -> successRes.data
      )

    getCritique: (taskId, target) ->
      $http(
        withCredentials: true
        method: 'POST'
        url: "#{ConfigService.apiBase}/critique/#{taskId}/findOrCreateCrit"
        data: target
      ).then(
        (successRes) -> successRes.data
      )



  }
