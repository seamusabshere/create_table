# CreateTable

Analyze and inspect CREATE TABLE SQL statements and translate across databases.

See the [introductory post on Brighter Planet's blog](http://numbers.brighterplanet.com/2012/08/27/analyze-create-table-sql-with-ragel-and-ruby/).

## BETA

Tests and documentation are being added constantly.

TODO: stop making excuses and write a proper README.

## Quickstart

### Parsing

    >> require 'create_table'
    => true
    >> c = CreateTable.new(%{
      CREATE TABLE employees
      (employeeid INTEGER NOT NULL,
      lastname VARCHAR(25) NOT NULL,
      firstname VARCHAR(25) NOT NULL,
      reportsto INTEGER NULL); 
    })
    => #<CreateTable>
    >> c.columns.map(&:name)
    => ["employeeid", "lastname", "firstname", "reportsto"]
    >> c.columns.map(&:data_type)
    => ["INTEGER", "CHARACTER VARYING(25)", "CHARACTER VARYING(25)", "INTEGER"]
    >> c.columns.map(&:allow_null)
    => [false, false, false, true]

### Generating cross-platform SQL

    >> require 'create_table'
    => true
    >> c = CreateTable.new(%{
      CREATE TABLE cats (
        id INTEGER AUTO_INCREMENT, /* AUTO_INCREMENT with an underscore is MySQL-style... */
        nickname CHARACTER VARYING(255),
        birthday DATE,
        license_id INTEGER,
        price NUMERIC(5,2),
        PRIMARY KEY ("id")
      )
    })
    => #<CreateTable>
    >> c.to_mysql
    => ["CREATE TABLE cats ( `id` INTEGER PRIMARY KEY AUTO_INCREMENT, nickname CHARACTER VARYING(255), birthday DATE, license_id INTEGER, price NUMERIC(5,2) )"]
    >> c.to_postgresql
    => ["CREATE TABLE cats ( \"id\" SERIAL PRIMARY KEY, nickname CHARACTER VARYING(255), birthday DATE, license_id INTEGER, price NUMERIC(5,2) )"]
    >> c.to_sqlite3
    => ["CREATE TABLE cats ( \"id\" INTEGER PRIMARY KEY AUTOINCREMENT, nickname CHARACTER VARYING(255), birthday DATE, license_id INTEGER, price NUMERIC(5,2) )"]

## As a web service

Check out the [CreateTable demo web service](http://create-table.herokuapp.com)!

    $ curl -i -X POST -H "Accept: application/json" --data "CREATE TABLE cats ( id INTEGER AUTO_INCREMENT, nickname CHARACTER VARYING(255), birthday DATE, license_id INTEGER, price NUMERIC(5,2), PRIMARY KEY (\"id\") )" http://create-table.herokuapp.com/statements
    HTTP/1.1 201 Created
    Cache-Control: max-age=0, private, must-revalidate
    Content-Type: application/json; charset=utf-8
    Date: Fri, 24 Aug 2012 22:24:52 GMT
    Etag: "f13513b9126eb1fb909229e828c6a7cd"
    Location: http://create-table.herokuapp.com/statements/9
    Server: thin 1.4.1 codename Chromeo
    X-Rack-Cache: invalidate, pass
    X-Runtime: 0.051092
    X-Ua-Compatible: IE=Edge,chrome=1
    Content-Length: 1490
    Connection: keep-alive

    {"statement":{"original":"CREATE TABLE cats ( id INTEGER AUTO_INCREMENT, nickname CHARACTER VARYING(255), birthday DATE, license_id INTEGER, price NUMERIC(5,2), PRIMARY KEY (\"id\") )","mysql":"CREATE TABLE cats ( `id` INTEGER PRIMARY KEY AUTO_INCREMENT, nickname CHARACTER VARYING(255), birthday DATE, license_id INTEGER, price NUMERIC(5,2) )","postgresql":"CREATE TABLE cats ( \"id\" SERIAL PRIMARY KEY, nickname CHARACTER VARYING(255), birthday DATE, license_id INTEGER, price NUMERIC(5,2) )","sqlite3":"CREATE TABLE cats ( \"id\" INTEGER PRIMARY KEY AUTOINCREMENT, nickname CHARACTER VARYING(255), birthday DATE, license_id INTEGER, price NUMERIC(5,2) )","columns":[{"name":"id","data_type":"INTEGER","allow_null":false,"default":null,"primary_key":true,"unique":true,"autoincrement":true,"charset":null,"collate":null},{"name":"nickname","data_type":"CHARACTER VARYING(255)","allow_null":true,"default":null,"primary_key":false,"unique":false,"autoincrement":false,"charset":null,"collate":null},{"name":"birthday","data_type":"DATE","allow_null":true,"default":null,"primary_key":false,"unique":false,"autoincrement":false,"charset":null,"collate":null},{"name":"license_id","data_type":"INTEGER","allow_null":true,"default":null,"primary_key":false,"unique":false,"autoincrement":false,"charset":null,"collate":null},{"name":"price","data_type":"NUMERIC(5,2)","allow_null":true,"default":null,"primary_key":false,"unique":false,"autoincrement":false,"charset":null,"collate":null}]}}

## Real-world usage

<p><a href="http://brighterplanet.com"><img src="https://s3.amazonaws.com/static.brighterplanet.com/assets/logos/flush-left/inline/green/rasterized/brighter_planet-160-transparent.png" alt="Brighter Planet logo"/></a></p>

We will soon use `create_table` for the [Brighter Planet reference data web service](http://data.brighterplanet.com).

## Copyright

Copyright 2012 Brighter Planet, Inc.
