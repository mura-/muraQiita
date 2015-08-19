table_names = %w(users)
puts "Env is = #{Rails.env}"
table_names.each do |table_name|
  path = Rails.root.join('db', 'seeds', Rails.env, "#{table_name}.rb")
  puts "path is #{path}"
  if File.exist?(path)
    puts "Creating #{table_name}...."
    require(path)
  end
end
