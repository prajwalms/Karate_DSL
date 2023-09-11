@hooks
Feature: Before and after Hooks

Background: hooks
#   * def DummyData = callonce read('classpath:helpers/Dummy.feature')
#   * def returnedUserName = DummyData.userName

    * configure afterFeature = function(){karate.call('classpath:helpers/Dummy.feature')}
    * configure afterScenario =
    """
   function(){
          karate.log("This is executed after each Scenario")
   }
    """

  Scenario: first Scenario
#    * print returnedUserName
    * print 'first scenario output'

  Scenario: Second Scenario
#    * print returnedUserName
    * print 'Second scenario output'
