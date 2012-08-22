Feature: Parsing

# yah i know this is long, just add stuff to the bottom

  Scenario Outline: parsing columns
    Given column definition <column_definition>
    Then the name should be <name>
    And the default should be <default>
    And the data_type should be <data_type>
    And the primary_key should be <primary_key>
    And the unique should be <unique>
    And the autoincrement should be <autoincrement>
    And the allow_null should be <allow_null>
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
    | "foo" INTEGER DEFAULT 4                                 | foo  | INTEGER                  | false       | false  | false         | true        | "4"          |
    | "foo" INTEGER DEFAULT 44                                | foo  | INTEGER                  | false       | false  | false         | true        | "44"         |
    | "foo" INTEGER DEFAULT '4'                               | foo  | INTEGER                  | false       | false  | false         | true        | "4"          |
    | "foo" INTEGER DEFAULT '44'                              | foo  | INTEGER                  | false       | false  | false         | true        | "44"         |
    | "foo" CHARACTER VARYING(255) DEFAULT ' z x y '          | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z x y "    |
    | "foo" CHARACTER VARYING(255) DEFAULT ' z ''x ''y'       | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z 'x 'y"   |
    | "foo" CHARACTER VARYING(255) DEFAULT ' z ''x ''y '      | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z 'x 'y "  |
    | "foo" CHARACTER VARYING(255) DEFAULT " z x y "          | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z x y "    |
    | "foo" CHARACTER VARYING(255) DEFAULT " z ''x ''y"       | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z 'x 'y"   |
    | "foo" CHARACTER VARYING(255) DEFAULT " z ''x ''y "      | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z 'x 'y "  |
    | "foo" CHARACTER VARYING(255) DEFAULT ' z \\\'x \\\'y'   | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z 'x 'y"   |
    | "foo" CHARACTER VARYING(255) DEFAULT ' z \\\'x \\\'y '  | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z 'x 'y "  |
    | "foo" CHARACTER VARYING(255) DEFAULT " z x y "          | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z x y "    |
    | "foo" CHARACTER VARYING(255) DEFAULT " z \\\"x \\\'y"   | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z "x 'y"   |
    | "foo" CHARACTER VARYING(255) DEFAULT " z \\\'x \\\"y "  | foo  | CHARACTER VARYING(255)   | false       | false  | false         | true        | " z 'x "y "  |
    | "foo" INTEGER DEFAULT NULL                              | foo  | INTEGER                  | false       | false  | false         | true        | NULL         |
    | "foo" INTEGER DEFAULT '4' AUTOINCREMENT                 | foo  | INTEGER                  | false       | false  | true          | true        | "4"          |
    | "foo" INTEGER DEFAULT 4 AUTOINCREMENT                   | foo  | INTEGER                  | false       | false  | true          | true        | "4"          |
    | "foo" INTEGER DEFAULT NULL AUTOINCREMENT                | foo  | INTEGER                  | false       | false  | true          | true        | NULL         |
    | "foo" INTEGER NULL DEFAULT NULL AUTOINCREMENT           | foo  | INTEGER                  | false       | false  | true          | true        | NULL         |
    | "foo" INTEGER NOT NULL DEFAULT NULL AUTOINCREMENT       | foo  | INTEGER                  | false       | false  | true          | false       | NULL         |

#-------------------------------------------

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

#-------------------------------------------

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

#-------------------------------------------

  Scenario Outline: Auto-increment in the PostgreSQL style
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

  Scenario Outline: Auto-incrementing primary key defined inline (0)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          id SERIAL PRIMARY KEY,
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2)
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
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Auto-incrementing primary key defined inline (1)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          id SERIAL,
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2),
          PRIMARY KEY ("id")
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
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Auto-incrementing primary key defined inline (2)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          id INTEGER PRIMARY KEY AUTO_INCREMENT,
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2)
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
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Auto-incrementing primary key defined inline (3)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          id INTEGER AUTO_INCREMENT,
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2),
          PRIMARY KEY ("id")
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
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Auto-incrementing primary key defined inline (4)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          id INTEGER AUTO_INCREMENT,
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2),
          CONSTRAINT PRIMARY KEY ("id")
        )
      """
    Then the column_count should be 5
    And column <column_name> name should be <column_name>
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
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Auto-incrementing primary key defined inline (5)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2)
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
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Auto-incrementing primary key defined inline (6)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          id INTEGER AUTOINCREMENT,
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2),
          PRIMARY KEY ("id")
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
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: MySQL-style backticks with TEMPORARY (0)
    Given CREATE TABLE sql
      """
        CREATE TEMPORARY TABLE `cats` (
          `nickname` CHARACTER VARYING(255),
          `birthday` DATE,
          `license_id` INTEGER,
          `price` NUMERIC(5,2)
        )
      """
    Then the temporary should be true
    And column <column_name> name should be <column_name>
    And column <column_name> data_type should be <data_type>
    And column <column_name> primary_key should be <primary_key>
    And column <column_name> indexed should be <indexed>
    And column <column_name> unique should be <unique>
    And column <column_name> autoincrement should be <autoincrement>
    And column <column_name> allow_null should be <allow_null>
    And column <column_name> default should be <default>
    Examples:
    | column_name | data_type                | primary_key | indexed                | unique | autoincrement | allow_null  | default      |
    | nickname    | CHARACTER VARYING(255)   | false       | false                  | false  | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: MySQL-style backticks (0)
    Given CREATE TABLE sql
      """
        CREATE TABLE `cats` (
          `nickname` CHARACTER VARYING(255),
          `birthday` DATE,
          `license_id` INTEGER,
          `price` NUMERIC(5,2)
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
    | nickname    | CHARACTER VARYING(255)   | false       | false                  | false  | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Comments with "/* */", including multiline (0)
    Given CREATE TABLE sql
      """
        /* b o yah */CREATE TABLE cats (/* daom */
          nickname /*yah
          see
          i didn't
          think
          so*/ CHARACTER VARYING(255), /*this is a great nickname*/
          birthday /* did you notice this? */ DATE,
          license_id INTEGER, /* oh yah that's cool too */
          /* oh yah that's hilarious */ price NUMERIC(5,2)
        )/* gosh 
        when
        will
        it
        end
        */
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
    | nickname    | CHARACTER VARYING(255)   | false       | false                  | false  | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Double-quoted (0)
    Given CREATE TABLE sql
      """
        CREATE TABLE "cats" (
          "nickname" CHARACTER VARYING(255),
          "birthday" DATE,
          "license_id" INTEGER,
          "price" NUMERIC(5,2)
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
    | nickname    | CHARACTER VARYING(255)   | false       | false                  | false  | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Index defined in the "table constraints" section (0)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2),
          KEY index_cats_on_nickname (nickname)
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
    | nickname    | CHARACTER VARYING(255)   | false       | true                   | false  | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Index defined in the "table constraints" section (1)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2),
          INDEX index_cats_on_nickname (nickname)
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
    | nickname    | CHARACTER VARYING(255)   | false       | true                   | false  | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Named unique indexes (0)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2),
          UNIQUE KEY uindex_cats_on_nickname (nickname)
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
    | nickname    | CHARACTER VARYING(255)   | false       | true                   | true   | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Named unique indexes (1)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2),
          UNIQUE INDEX uindex_cats_on_nickname (nickname)
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
    | nickname    | CHARACTER VARYING(255)   | false       | true                   | true   | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Reserved words in table and column names (0)
    Given CREATE TABLE sql
      """
        CREATE TABLE "where" (
          nickname CHARACTER VARYING(255),
          "false" CHARACTER VARYING(255),
          "else" NUMERIC(5,2)
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
    | nickname    | CHARACTER VARYING(255)   | false       | false                  | false   | false        | true        | nil          |
    | "false"     | CHARACTER VARYING(255)   | false       | false                  | false   | false        | true        | nil          |
    | else        | NUMERIC(5,2)             | false       | false                  | false   | false         | true        | nil          |
    

  Scenario Outline: String primary key (0)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255) PRIMARY KEY,
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2)
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
    | nickname    | CHARACTER VARYING(255)   | true        | true                   | true   | false         | false       | ""           |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: String primary key (1)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2),
          PRIMARY KEY (nickname)
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
    | nickname    | CHARACTER VARYING(255)   | true        | true                   | true   | false         | false       | ""           |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Uniques (0)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255) UNIQUE,
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2)
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
    | nickname    | CHARACTER VARYING(255)   | false       | true                   | true   | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Uniques (1)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2),
          UNIQUE (nickname)
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
    | nickname    | CHARACTER VARYING(255)   | false       | true                   | true   | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    

  Scenario Outline: Uniques (2)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2),
          CONSTRAINT UNIQUE (nickname)
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
    | nickname    | CHARACTER VARYING(255)   | false       | true                   | true   | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |


  Scenario Outline: Unquoted (0)
    Given CREATE TABLE sql
      """
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2)
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
    | nickname    | CHARACTER VARYING(255)   | false       | false                  | false  | false         | true        | nil          |
    | birthday    | DATE                     | false       | false                  | false  | false         | true        | nil          |
    | license_id  | INTEGER                  | false       | false                  | false  | false         | true        | nil          |
    | price       | NUMERIC(5,2)             | false       | false                  | false  | false         | true        | nil          |
    
