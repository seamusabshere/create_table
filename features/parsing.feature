Feature: Parsing

  Scenario Outline: parsing columns
    Given column definition <column_definition>
    Then the name should be <name>
    And the data_type should be <data_type>
    And the primary_key should be <primary_key>
    And the unique should be <unique>
    And the autoincrement should be <autoincrement>
    And the allow_null should be <allow_null>
    And the default should be <default>
    Examples:
    | column_definition                                       | name | data_type                | primary_key | unique | autoincrement | allow_null  | default      |
    | "foo" INTEGER                                           | foo  | INTEGER                  | false       | false  | false         | true        | nil          |
    | "foo" NUMERIC(5,2) UNIQUE                               | foo  | NUMERIC(5,2)             | false       | true   | false         | true        | nil          |
    | "foo" CHARACTER VARYING(255) UNIQUE                     | foo  | CHARACTER VARYING(255)   | false       | true   | false         | true        | nil          |
    | "foo" INTEGER PRIMARY KEY AUTO_INCREMENT                | foo  | INTEGER                  | true        | true   | true          | false       | nil          |
    | "foo" INTEGER PRIMARY KEY AUTOINCREMENT                 | foo  | INTEGER                  | true        | true   | true          | false       | nil          |
    | "foo" CHARACTER VARYING(255) PRIMARY KEY                | foo  | CHARACTER VARYING(255)   | true        | true   | false         | false       |              |
    | "foo" AUTO AUTO AUTOINCREMEN                            | foo  | AUTO AUTO AUTOINCREMEN   | false       | false  | false         | true        | nil          |
    | "foo" UN UNI UNIQ UNIQU UNIQU UNIQUE                    | foo  | UN UNI UNIQ UNIQU UNIQU  | false       | true   | false         | true        | nil          |
    | "foo" INTEGER NULL                                      | foo  | INTEGER                  | false       | false  | false         | true        | nil          |
    | "foo" INTEGER NOT NULL                                  | foo  | INTEGER                  | false       | false  | false         | false       | nil          |
    | "foo" INTEGER UNIQUE AUTOINCREMENT                      | foo  | INTEGER                  | false       | true   | true          | true        | nil          |
    | "foo" SERIAL                                            | foo  | INTEGER                  | false       | false  | true          | true        | nil          |
    | "foo" SERIAL PRIMARY KEY                                | foo  | INTEGER                  | true        | true   | true          | false       | nil          |
    | "foo" INTEGER UNIQUE GAR                                | foo  | INTEGER                  | false       | true   | false         | true        | nil          |
    | "foo" INTEGER DEFAULT 4                                 | foo  | INTEGER                  | false       | false  | false         | true        | 4            |
    | "foo" INTEGER DEFAULT '4'                               | foo  | INTEGER                  | false       | false  | false         | true        | 4            |
    | "foo" CHARACTER VARYING(255) DEFAULT ' z x y '          | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z x y "    |
    | "foo" CHARACTER VARYING(255) DEFAULT ' z ''x ''y'       | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z 'x 'y"   |
    | "foo" CHARACTER VARYING(255) DEFAULT ' z ''x ''y '      | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z 'x 'y "  |
    | "foo" CHARACTER VARYING(255) DEFAULT " z x y "          | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z x y "    |
    | "foo" CHARACTER VARYING(255) DEFAULT " z ''x ''y"       | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z 'x 'y"   |
    | "foo" CHARACTER VARYING(255) DEFAULT " z ''x ''y "      | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z 'x 'y "  |

  Scenario Outline: parsing indexes
    Given index definition <index_definition>
    Then the name should be <name>
    And the column_names should be <column_names>
    And the unique should be false
    Examples:
    | index_definition                                                | name                                | column_names     |
    | ( `column1` )                                                   | nil                                 | column1          |
    | ( `column1`, "column2" )                                        | nil                                 | column1, column2 |
    | "index_table1_on_column1" ( `column1` )                         | index_table1_on_column1             | column1          |
    | "index_table1_on_column1_and_column2" ( `column1`, "column2" )  | index_table1_on_column1_and_column2 | column1, column2 |

  Scenario Outline: parsing uniques
    Given unique definition <unique_definition>
    Then the name should be <name>
    And the column_names should be <column_names>
    And the unique should be true
    Examples:
    | unique_definition                                                | name                                 | column_names     |
    | ( `column1` )                                                    | nil                                  | column1          |
    | ( `column1`, "column2" )                                         | nil                                  | column1, column2 |
    | "uindex_table1_on_column1" ( `column1` )                         | uindex_table1_on_column1             | column1          |
    | "uindex_table1_on_column1_and_column2" ( `column1`, "column2" )  | uindex_table1_on_column1_and_column2 | column1, column2 |

  Scenario Outline: parsing a CREATE TABLE SQL statement with auto-increment in the PostgreSQL style
    Given CREATE TABLE sql
      """
      CREATE TABLE cats (
        id SERIAL PRIMARY KEY,
        nickname CHARACTER VARYING(255),
        birthday DATE NOT NULL DEFAULT '2010-01-05',
        license_id INTEGER UNIQUE,
        price NUMERIC(5,2) DEFAULT '15.05',
        INDEX idx_p (price)
      )
      """
    Then column <column_name> name should be <column_name>
    And column <column_name> data_type should be <data_type>
    And column <column_name> primary_key should be <primary_key>
    And column <column_name> indexed should be <indexed>
    And column <column_name> unique should be <unique>
    And column <column_name> autoincrement should be <autoincrement>
    And column <column_name> allow_null should be <allow_null>
    And column <column_name> default should be <default>
    Examples:
    | column_name | data_type                | primary_key | indexed                | unique | autoincrement | allow_null  | default      |
    | id          | INTEGER                  | true        | true                   | true   | true          | false       | nil          |
    | nickname    | CHARACTER VARYING(255)   | false       | false                  | false  | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | false       | 2010-01-05   |
    | license_id  | INTEGER                  | false       | true                   | true   | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | true                   | false  | false         | true        | 15.05        |