Feature: DB connection example feature

  Background:
    * def javaDBConnection = Java.type('helpers.DBhandler')

  Scenario: connect to DB and insert data to customerinfo table
    * eval javaDBConnection.dbConnectionWithInsert("protractor")


  Scenario: get inserted data from DB
    * def dbValue = javaDBConnection.dbConnectionWithselect("protractor")
    * print dbValue.courseAmt
    * print dbValue.courseLocation


