namespace :scheduled_tasks do 

desc "This task is called by the Heroku scheduler add-on to update Disease/Story Data"
task :update_data => :environment do

    puts "Cleaning Up The DB..."

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean

    puts "Seeding the DB again..."
    Rake::Task["db:seed"].invoke
    puts "done!"
end
end

