
angular.module('assessory.course').controller "course.Admin", ($scope, CourseService, GroupService, TaskService, course) ->

  $scope.course = course

  GroupService.courseGroupSets(course.id).then((groupSets) ->
    $scope.groupSets = groupSets
  )

  CourseService.coursePreenrols(course.id).then((preenrols) ->
    $scope.preenrols = preenrols
  )

  TaskService.courseTasks(course.id).then((tasks) ->
    $scope.tasks = tasks
  )

