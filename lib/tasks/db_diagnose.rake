namespace :db do
  desc "Diagnose database issues"
  task diagnose: :environment do
    puts "Database adapter: #{ActiveRecord::Base.connection.adapter_name}"
    puts "Database name: #{ActiveRecord::Base.connection.current_database}"
    puts "Tables:"
    ActiveRecord::Base.connection.tables.each do |table|
      puts "  #{table}"
    end
  end
end