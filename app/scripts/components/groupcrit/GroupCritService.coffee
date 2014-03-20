angular.module('assessory.task').service 'GroupCritService', ($http, $cacheFactory, $location, ConfigService) ->
      
    
  {

    allocateTask: (taskId) -> $http.post("#{ConfigService.apiBase}/groupcrit/#{taskId}/allocate").then((res) -> res.data)

    myAllocations: (taskId) ->
      $http.get("#{ConfigService.apiBase}/groupcrit/#{taskId}/myAllocations").then((res) -> res.data)

    allAllocations: (taskId) ->
      $http.get("#{ConfigService.apiBase}/groupcrit/#{taskId}/allocations").then((res) -> res.data)

    createCritique: (allocId, groupId) ->
      $http.post("#{ConfigService.apiBase}/groupcritalloc/#{allocId}/createCritFor/#{groupId}").then((res) ->
        crit = res.data
        crit
      )

  }
