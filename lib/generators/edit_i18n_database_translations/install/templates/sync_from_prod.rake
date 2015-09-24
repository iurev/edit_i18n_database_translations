namespace :i18n do
  desc 'Sync localizations from production database to local'
  task :sync_from_prod => [:dump, :restore]

  task :dump do
    dumpfile = "#{Rails.root}/tmp/i18n.dump"
    puts 'PG_DUMP on production database...'
    production = Rails.application.config.database_configuration['production']
    ssh_user = ''
    ssh_host = ''
    pg_dump_path = ''
    system "ssh #{ssh_user}@#{ssh_host} #{pg_dump_path} #{production['database']} -t \"translations*\" -F t > #{dumpfile}"
    puts 'Done!'
  end

  task :restore do
    dev = Rails.application.config.database_configuration['development']
    dumpfile = "#{Rails.root}/tmp/i18n.dump"
    puts 'PG_RESTORE on development database...'
    system "pg_restore --verbose --clean --no-acl --no-owner -d #{dev['database']} #{dumpfile}"
    puts 'Done!'
  end
end
