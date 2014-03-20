
angular.module('assessory.group', [
  'assessory.config',
  'assessory.course'
])


angular.module('assessory.group').service 'GroupService', ($http, $cacheFactory, CourseService, ConfigService) ->
      
  gsCache = $cacheFactory("gsCache")

  groupCache = $cacheFactory("groupCache")

  {

    get: (id) ->
      groupCache.get(id) || (
        prom = $http(
          withCredentials: true
          method: 'GET'
          url: "#{ConfigService.apiBase}/group/#{id}"
        ).then(
          (successRes) -> successRes.data
        )
        groupCache.put(id, prom)
        prom
      )

    createGroupSet: (courseId, groupSet) ->
      $http(
        withCredentials: true
        method: 'POST'
        url: "#{ConfigService.apiBase}/course/#{courseId}/createGroupSet"
        data: groupSet
      ).then((res) ->
        gs = res.data
        gsCache.put(gs.id, gs)
        gs
      )

    findMany: (ids) ->
      $http(
        withCredentials: true
        method: 'POST'
        url: "#{ConfigService.apiBase}/group/findMany"
        data: { ids: ids }
      ).then(
          (successRes) ->
            data = successRes.data
            for group in data
              groupCache.put(group.id, group)
            data
        )

    getGroupSet: (id) ->
      gsCache.get(id) || (
        prom = $http(
          withCredentials: true
          method: 'GET'
          url: "#{ConfigService.apiBase}/groupSet/#{id}"
        ).then(
          (successRes) -> successRes.data
        )
        gsCache.put(id, prom)
        prom
      )

    byGroupSet: (groupSetId) ->
      $http(
        withCredentials: true
        method: 'POST'
        url: "#{ConfigService.apiBase}/groupSet/#{groupSetId}/groups"
        data: { ids: ids }
      ).then((res) -> res.data)

    courseGroupSets: (courseId) ->
      $http(
        withCredentials: true
        method: 'GET'
        url: "#{ConfigService.apiBase}/course/#{courseId}/groupSets"
      ).then((res) -> res.data)

    createGroupPreenrol: (groupSetId, gpreenrol) ->
      $http(
        withCredentials: true
        method: 'POST'
        url: "#{ConfigService.apiBase}/groupSet/#{groupSetId}/createGPreenrol"
        data: greenrol
      ).then((res) -> res.data)

    myGroups: (courseId) ->
      $http(
        withCredentials: true
        method: 'GET'
        url: "#{ConfigService.apiBase}/course/#{courseId}/group/my"
      ).then((res) -> res.data)
  }
