require 'spec_helper'

describe CreateTable do
  describe 'parsing SQL' do
    before do
      @c = CreateTable.new(%{
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255),
          birthday DATE NOT NULL DEFAULT '2005-01-01',
          license_id INTEGER NULL,
          price NUMERIC(5,2) DEFAULT '14.50',
          PRIMARY KEY (nickname),
          UNIQUE KEY uindex_cats_on_license_id (license_id),
          INDEX index_cats_on_price (price)
        )
      })
    end
    it "gets table name" do
      @c.table_name.should == 'cats'
    end
    it "gets all columns" do
      @c.columns.length.should == 4
    end
    it "gets column names" do
      @c.columns.map(&:name).should == ['nickname', 'birthday', 'license_id', 'price']
    end
    it "gets data types" do
      @c.columns.map(&:data_type).should == ['CHARACTER VARYING(255)', "DATE", 'INTEGER', "NUMERIC(5,2)"]
    end
    it "gets defaults" do
      @c.columns.map(&:default).should == [%{}, %{2005-01-01}, nil, %{14.50}]
    end
    it "gets [not] null" do
      @c.columns.map(&:null).should == [false, false, true, true]
    end
    it "gets primary key" do
      @c.primary_key.column_names.should == ['nickname']
    end
    it "gets all indexes" do
      @c.indexes.length.should == 3
      @c.indexes.map(&:column_names).should == [['nickname'], ['license_id'], ['price']]
    end
    it "gets unique indexes" do
      u = @c.indexes['license_id']
      u.unique.should == true
      u.name.should == 'uindex_cats_on_license_id'
      u.column_names.should == ['license_id']
    end
    it "gets normal indexes" do
      i = @c.indexes['price']
      i.unique.should == false
      i.name.should == 'index_cats_on_price'
      i.column_names.should == ['price']
    end
  end

  describe 'generating SQL' do
    before do
      @c = CreateTable.new
      @c.table_name = 'where' # reserved
      @c.parse_column 'nickname CHARACTER VARYING(255) PRIMARY KEY'
      @c.parse_column 'false CHARACTER VARYING(255)' # reserved word
      @c.parse_column 'else NUMERIC(5,2)' # reserved word
    end
    it "gets table name" do
      @c.table_name.should == 'where'
    end
    it "gets all columns" do
      @c.columns.length.should == 3
    end
    it "gets column names" do
      @c.columns.map(&:name).should == ['nickname', 'false', 'else']
    end
    it "gets all indexes" do
      @c.indexes.length.should == 1
    end
    it "writes minimal SQL" do
      ref = %{
        CREATE TABLE "where" (
          nickname CHARACTER VARYING(255) PRIMARY KEY,
          "false" CHARACTER VARYING(255),
          "else" NUMERIC(5,2)
        )
      }
      assert_same_sql @c.to_postgresql, ref
    end
  end
end
