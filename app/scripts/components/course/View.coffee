
angular.module('assessory.course').controller "course.View", ($scope, CourseService, GroupService, TaskService, course) ->

  $scope.course = course

  GroupService.myGroups(course.id).then (groups) ->
    $scope.groups = groups

  TaskService.courseTasks(course.id).then (tasks) ->
    $scope.tasks = tasks



angular.module('assessory.course').directive "courseInfo", (ConfigService, $sce) ->
  {
    scope: { course: '=course' }
    templateUrl: "/views/components/course/directive_courseInfo.html"
    restrict: 'E'
  }
