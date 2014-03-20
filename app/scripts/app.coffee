'use strict'

#
# Declare the app
#
angular.module('assessory', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',

  'assessory.user',
  'assessory.course',
  'assessory.group',
  'assessory.task'
])
  .config ($locationProvider) ->
    $locationProvider.html5Mode(true)
  .config ($httpProvider) ->
    $httpProvider.defaults.headers.common['Accept']='application/json'



# Helper functions
merge = (options, overrides) ->
  extend (extend {}, options), overrides


# individual resolvers

resolveSelf =
  user: ['$route', 'UserService', ($route, UserService) ->
    UserService.self().then(
      (s) -> s
      (err) -> null
    )
  ]

resolveCourse =
  course: ['$route', 'CourseService', ($route, CourseService) ->
    CourseService.get($route.current.params.courseId)
  ]

resolvePreenrol =
  preenrol: ['$route', 'CourseService', ($route, CourseService) ->
    CourseService.getPreenrol($route.current.params.preenrolId)
  ]


resolveGroup =
  group: ['$route', 'GroupService', ($route, GroupService) ->
    GroupService.get($route.current.params.groupId)
  ]


resolveGroupSet =
  groupSet: ['$route', 'GroupService', ($route, GroupService) ->
    GroupService.getGroupSet($route.current.params.gsId)
  ]

resolveTask =
  task: ['$route', 'TaskService', ($route, TaskService) ->
    TaskService.get($route.current.params.taskId)
  ]

resolveTaskOutput =
  taskoutput: ['$route', 'TaskOutputService', ($route, TaskOutputService) ->
    TaskOutputService.get($route.current.params.taskoutputId)
  ]


#
# Temporary route provider
#
angular.module('assessory').config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: '/views/main.html'
      controller: 'Front'
      resolve: resolveSelf
    .when '/logIn',
      templateUrl: '/views/logIn.html'
      controller: 'user.LogIn'
    .when '/signUp',
      templateUrl: '/views/signUp.html'
      controller: 'user.SignUp'
    .when '/self',
      templateUrl: '/views/components/user/self.html'
      controller: 'user.Self'
    .when '/course/create',
      templateUrl: '/views/components/course/create.html'
      controller: 'course.Create'
    .when '/course/:courseId/createGroupCritTask',
      templateUrl: '/views/components/groupcrit/createTask.html'
      controller: 'groupcrit.CreateTask'
      resolve: resolveCourse
    .when '/course/:courseId/createOutputCritTask',
      templateUrl: '/views/components/outputcrit/createTask.html'
      controller: 'outputcrit.CreateTask'
      resolve: resolveCourse
    .when '/course/:courseId/createGroupSet',
      templateUrl: '/views/components/group/createGroupSet.html'
      controller: 'group.CreateGroupSet'
      resolve: resolveCourse
    .when '/course/:courseId/createPreenrol',
      templateUrl: '/views/components/course/createPreenrol.html'
      controller: 'course.CreatePreenrol'
      resolve: resolveCourse
    .when '/course/:courseId/admin',
      templateUrl: '/views/components/course/admin.html'
      controller: 'course.Admin'
      resolve: resolveCourse
    .when '/course/:courseId',
      templateUrl: '/views/components/course/view.html'
      controller: 'course.View'
      resolve: resolveCourse
    .when '/group/:groupId',
      templateUrl: '/views/components/group/view.html'
      controller: 'group.View'
      resolve: resolveGroup
    .when '/groupSet/:gsId',
      templateUrl: '/views/components/group/viewGroupSet.html'
      controller: 'group.ViewGroupSet'
      resolve: resolveGroupSet
    .when '/preenrol/:preenrolId',
      templateUrl: '/views/components/course/viewPreenrol.html'
      controller: 'course.ViewPreenrol'
      resolve: resolvePreenrol
    .when '/task/:taskId/admin',
      templateUrl: '/views/components/task/admin.html'
      controller: 'task.Admin'
      resolve: resolveTask
    .when '/task/:taskId',
      templateUrl: '/views/components/task/view.html'
      controller: 'task.View'
      resolve: resolveTask
    .when '/taskoutput/:taskoutputId/edit',
      templateUrl: '/views/components/taskoutput/edit.html'
      controller: 'taskoutput.Edit'
      resolve: resolveTaskOutput
    .when '/taskoutput/:taskoutputId',
      templateUrl: '/views/components/taskoutput/view.html'
      controller: 'taskoutput.View'
      resolve: resolveTaskOutput
    .otherwise
      redirectTo: '/'


#
# Handles route change errors so that the user doesn't just see a blank page
#
angular.module('assessory').controller 'ErrorController', ($scope) ->
  $scope.$on("$routeChangeError", (event, current, previous, rejection) ->
    $scope.error = rejection
  )
  $scope.$on("$routeChangeSuccess", () ->
    $scope.error = null
  )


console.log("Angular app defined")




