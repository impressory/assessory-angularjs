angular.module('assessory.task').controller 'groupcrit.CreateTask', ($scope, CourseService, GroupService, TaskService, $location, course) ->

  $scope.course = course

  $scope.groupSets = GroupService.courseGroupSets(course.id)

  $scope.errors = []

  $scope.task = {

    details: {}

    body: {
      kind: "Group critique by an individual"
      questionnaire: {
        questions: []
      }

    }
  }

  $scope.submit = (task) ->
    $scope.errors = [ ]
    TaskService.create(course.id, task).then(
     (task) -> $location.path("/task/#{task.id}")
     (fail) -> $scope.errors = [ fail.data?.error || "Unexpected error" ]
    )
