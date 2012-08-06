require 'spec_helper'

describe CreateTable do
  describe 'unquoted' do
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

  describe 'quoted' do
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

  describe 'backticked' do
    before do
      @c = CreateTable.new(%{
        CREATE TABLE `cats` (
          `nickname` CHARACTER VARYING(255),
          `birthday` DATE,
          `license_id` INTEGER,
          `price` NUMERIC(5,2)
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
end
