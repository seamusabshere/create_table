Feature: Parsing

  Scenario Outline: parsing columns
    Given column definition <column_definition>
    Then name should be <name>
    And data_type should be <data_type>
    And primary_key should be <primary_key>
    And unique should be <unique>
    And autoincrement should be <autoincrement>
    And null should be <null>
    And default should be <default>
  Examples:
    | column_definition                                       | name | data_type                | primary_key | unique | autoincrement | null  | default      |
    | "foo" INTEGER                                           | foo  | INTEGER                  | false       | false  | false         | true  | nil          |
    | "foo" NUMERIC(5,2) UNIQUE                               | foo  | NUMERIC(5,2)             | false       | true   | false         | true  | nil          |
    | "foo" CHARACTER VARYING(255) UNIQUE                     | foo  | CHARACTER VARYING(255)   | false       | true   | false         | true  | nil          |
    | "foo" INTEGER PRIMARY KEY AUTO_INCREMENT                | foo  | INTEGER                  | true        | false  | true          | false | nil          |
    | "foo" INTEGER PRIMARY KEY AUTOINCREMENT                 | foo  | INTEGER                  | true        | false  | true          | false | nil          |
    | "foo" CHARACTER VARYING(255) PRIMARY KEY                | foo  | CHARACTER VARYING(255)   | true        | false  | false         | false |              |
    | "foo" AUTO AUTO AUTOINCREMEN                            | foo  | AUTO AUTO AUTOINCREMEN   | false       | false  | false         | true  | nil          |
    | "foo" UN UNI UNIQ UNIQU UNIQU UNIQUE                    | foo  | UN UNI UNIQ UNIQU UNIQU  | false       | true   | false         | true  | nil          |
    | "foo" INTEGER NULL                                      | foo  | INTEGER                  | false       | false  | false         | true  | nil          |
    | "foo" INTEGER NOT NULL                                  | foo  | INTEGER                  | false       | false  | false         | false | nil          |
    | "foo" INTEGER UNIQUE AUTOINCREMENT                      | foo  | INTEGER                  | false       | true   | true          | true  | nil          |
    | "foo" INTEGER UNIQUE GAR                                | foo  | INTEGER                  | false       | true   | false         | true  | nil          |
    | "foo" INTEGER DEFAULT 4                                 | foo  | INTEGER                  | false       | false  | false         | true  | 4            |
    | "foo" INTEGER DEFAULT '4'                               | foo  | INTEGER                  | false       | false  | false         | true  | 4            |
    | "foo" CHARACTER VARYING(255) DEFAULT ' z x y '          | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true  | " z x y "    |
    | "foo" CHARACTER VARYING(255) DEFAULT ' z ''x ''y '      | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true  | " z 'x 'y "  |

  Scenario Outline: parsing indexes
    Given index definition <index_definition>
    Then name should be <name>
    And column_names should be <column_names>
    And unique should be false
  Examples:
    | index_definition                                                | name                                | column_names     |
    | ( `column1` )                                                   | nil                                 | column1          |
    | ( `column1`, "column2" )                                        | nil                                 | column1, column2 |
    | "index_table1_on_column1" ( `column1` )                         | index_table1_on_column1             | column1          |
    | "index_table1_on_column1_and_column2" ( `column1`, "column2" )  | index_table1_on_column1_and_column2 | column1, column2 |

  Scenario Outline: parsing uniques
    Given unique definition <unique_definition>
    Then name should be <name>
    And column_names should be <column_names>
    And unique should be true
  Examples:
    | unique_definition                                                | name                                 | column_names     |
    | ( `column1` )                                                    | nil                                  | column1          |
    | ( `column1`, "column2" )                                         | nil                                  | column1, column2 |
    | "uindex_table1_on_column1" ( `column1` )                         | uindex_table1_on_column1             | column1          |
    | "uindex_table1_on_column1_and_column2" ( `column1`, "column2" )  | uindex_table1_on_column1_and_column2 | column1, column2 |
