class FillInitialData < ActiveRecord::Migration
  def self.up
    execute("insert into roles(name) values('admin');")
    execute("insert into roles(name) values('user');")
    execute("insert into catalogs(name,created_at,updated_at) values('catalog1',now(),now());")
    execute("insert into catalogs(name,created_at,updated_at) values('catalog2',now(),now());")
    execute("insert into catalogs(name,created_at,updated_at) values('catalog3',now(),now());")
  end
end
