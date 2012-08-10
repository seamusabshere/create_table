Feature: Parsing

  Scenario Outline: parsing columns
    Given column definition <column_definition>
    Then name should be <name>
    And data_type should be <data_type>
    And primary_key should be <primary_key>
    And unique should be <unique>
    And autoincrement should be <autoincrement>
  Examples:
    | column_definition                           | name | data_type                | primary_key | unique | autoincrement |
    | "foo" INTEGER                               | foo  | INTEGER                  | false       | false  | false         |
    | "foo" NUMERIC(5,2) UNIQUE                   | foo  | NUMERIC(5,2)             | false       | true   | false         |
    | "foo" CHARACTER VARYING(255) UNIQUE         | foo  | CHARACTER VARYING(255)   | false       | true   | false         |
    | "foo" INTEGER PRIMARY KEY AUTO_INCREMENT    | foo  | INTEGER                  | true        | false  | true          |
    | "foo" INTEGER PRIMARY KEY AUTOINCREMENT     | foo  | INTEGER                  | true        | false  | true          |
    | "foo" CHARACTER VARYING(255) PRIMARY KEY    | foo  | CHARACTER VARYING(255)   | true        | false  | false         |
    | "foo" AUTO AUTO AUTOINCREMEN                | foo  | AUTO AUTO AUTOINCREMEN   | false       | false  | false         |
    | "foo" UN UNI UNIQ UNIQU UNIQU UNIQUE        | foo  | UN UNI UNIQ UNIQU UNIQU  | false       | true   | false         |

  Scenario Outline: parsing indexes
    Given index definition <index_definition>
    Then name should be <name>
    And column_names should be <column_names>
    And unique should be false
  Examples:
    | index_definition                                                | name                                | column_names     |
    | ( `column1` )                                                   |                                     | column1          |
    | ( `column1`, "column2" )                                        |                                     | column1, column2 |
    | "index_table1_on_column1" ( `column1` )                         | index_table1_on_column1             | column1          |
    | "index_table1_on_column1_and_column2" ( `column1`, "column2" )  | index_table1_on_column1_and_column2 | column1, column2 |

  Scenario Outline: parsing uniques
    Given unique definition <unique_definition>
    Then name should be <name>
    And column_names should be <column_names>
    And unique should be true
  Examples:
    | unique_definition                                                | name                                 | column_names     |
    | ( `column1` )                                                    |                                      | column1          |
    | ( `column1`, "column2" )                                         |                                      | column1, column2 |
    | "uindex_table1_on_column1" ( `column1` )                         | uindex_table1_on_column1             | column1          |
    | "uindex_table1_on_column1_and_column2" ( `column1`, "column2" )  | uindex_table1_on_column1_and_column2 | column1, column2 |
