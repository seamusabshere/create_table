require 'spec_helper'

describe CreateTable do
  describe 'parsing standards-compliant unquoted SQL' do
    before do
      @c = CreateTable.new(%{
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2)
        )
      })
    end
    it "reads table name" do
      @c.table_name.should == 'cats'
    end
    it "reads all columns" do
      @c.columns.length.should == 4
    end
    it "reads column names" do
      @c.columns.map(&:name).should == ['nickname', 'birthday', 'license_id', 'price']
    end
    it "reads column options" do
      @c.columns.map(&:options).should == ['CHARACTER VARYING(255)', 'DATE', 'INTEGER', 'NUMERIC(5,2)']
    end
  end

  describe 'parsing standards-compliant quoted SQL' do
    before do
      @c = CreateTable.new(%{
        CREATE TABLE "cats" (
          "nickname" CHARACTER VARYING(255),
          "birthday" DATE,
          "license_id" INTEGER,
          "price" NUMERIC(5,2)
        )
      })
    end
    it "reads table name" do
      @c.table_name.should == 'cats'
    end
    it "reads all columns" do
      @c.columns.length.should == 4
    end
    it "reads column names" do
      @c.columns.map(&:name).should == ['nickname', 'birthday', 'license_id', 'price']
    end
    it "reads column options" do
      @c.columns.map(&:options).should == ['CHARACTER VARYING(255)', 'DATE', 'INTEGER', 'NUMERIC(5,2)']
    end
  end

  describe 'generating minimal cross-platform standards-compliant SQL' do
    before do
      @c = CreateTable.new
      @c.table_name = 'cats'
      @c.add_column 'nickname', 'CHARACTER VARYING(255)'
      @c.add_column 'birthday', 'DATE'
      @c.add_column 'license_id', 'INTEGER'
      @c.add_column 'price', 'NUMERIC(5,2)'
    end
    it "reads table name" do
      @c.table_name.should == 'cats'
    end
    it "reads all columns" do
      @c.columns.length.should == 4
    end
    it "reads column names" do
      @c.columns.map(&:name).should == ['nickname', 'birthday', 'license_id', 'price']
    end
    it "reads column options" do
      @c.columns.map(&:options).should == ['CHARACTER VARYING(255)', 'DATE', 'INTEGER', 'NUMERIC(5,2)']
    end
    it "writes minimal SQL" do
      ref = %{
        CREATE TABLE cats (
          nickname CHARACTER VARYING(255),
          birthday DATE,
          license_id INTEGER,
          price NUMERIC(5,2)
        )
      }
      assert_same_sql @c.to_sql, ref
    end
  end
end
