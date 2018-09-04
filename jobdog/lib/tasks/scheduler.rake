task :clear_old_sessions => :environment do
  puts "Clearing old sessions..."
  sql = "DELETE FROM sessions WHERE updated_at < (CURRENT_TIMESTAMP - INTERVAL '1 days');"
  ActiveRecord::Base.connection.execute(sql)
  puts "done."
end