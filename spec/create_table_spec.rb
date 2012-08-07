require 'spec_helper'

describe CreateTable do
  describe 'parsing SQL' do
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

  describe 'generating SQL' do
    before do
      @c = CreateTable.new
      @c.table_name = 'where' # reserved
      @c.add_column 'nickname', 'CHARACTER VARYING(255)'
      @c.add_column 'false', 'CHARACTER VARYING(255)' # reserved word
      @c.add_column 'else', 'NUMERIC(5,2)' # reserved word
    end
    it "reads table name" do
      @c.table_name.should == 'where'
    end
    it "reads all columns" do
      @c.columns.length.should == 3
    end
    it "reads column names" do
      @c.columns.map(&:name).should == ['nickname', 'false', 'else']
    end
    it "reads column options" do
      @c.columns.map(&:options).should == ['CHARACTER VARYING(255)', 'CHARACTER VARYING(255)', 'NUMERIC(5,2)']
    end
    it "writes minimal SQL" do
      ref = %{
        CREATE TABLE "where" (
          nickname CHARACTER VARYING(255),
          "false" CHARACTER VARYING(255),
          "else" NUMERIC(5,2)
        )
      }
      assert_same_sql @c.to_sql, ref
    end
  end
end
