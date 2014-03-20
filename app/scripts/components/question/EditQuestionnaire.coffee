angular.module('assessory.task').controller 'question.EditQuestionnaire', ($scope) ->
  $scope.addQuestion = (kind) ->
    $scope.questionnaire.questions.push({ kind: kind })



angular.module('assessory.task').controller 'question.FillQuestionnaire', ($scope) ->
  
  $scope.questions = $scope.questionnaire.questions

  $scope.answerMap = {}

  for answer in ($scope.answers || [])
    $scope.answerMap[answer.question] = answer

  for question in $scope.questions
    ans = $scope.answerMap[question.id]
    if not (ans?)
      ans =  {
        kind: question.kind
        question: question.id
        answer: null
      }
      $scope.answers.push(ans)
      $scope.answerMap[question.id] = ans
      


angular.module('assessory.task').controller 'question.ViewQuestionnaire', ($scope) ->
    
  $scope.questions = $scope.questionnaire.questions

  $scope.answerMap = {}

  for answer in $scope.answers
    $scope.answerMap[answer.question] = answer

  $scope.showQuestion = (q) -> (!$scope.qfilter?) || $scope.qfilter(q)


angular.module('assessory.task').directive "questionnaireEdit", () ->
  {
    scope: { questionnaire: '=questionnaire' }
    controller: 'question.EditQuestionnaire'
    templateUrl: "directive_questionnaireEdit.html"
    restrict: 'E'
  }


angular.module('assessory.task').directive "questionnaireFill", () ->
  {
    scope: { questionnaire: '=questionnaire', answers: "=answers" }
    controller: 'question.FillQuestionnaire'
    templateUrl: "directive_questionnaireFill.html"
    restrict: 'E'
  }

angular.module('assessory.task').directive "questionnaireView", () ->
  {
    scope: { questionnaire: '=questionnaire', answers: "=answers", qfilter: "=filter" }
    controller: 'ViewQuestionnaire'
    templateUrl: "directive_questionnaireView.html"
    restrict: 'E'
  }