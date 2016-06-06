module EditI18nDatabaseTranslations
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "This generator creates an initializer file at config/initializers"
      def create_initializer_file
        relative_path = '../templates/initializer.rb'
        absolute_path = File.expand_path(relative_path, __FILE__)
        content = File.read absolute_path
        create_file "config/initializers/edit_i18n_database_translations.rb",
                    content

        relative_path = '../templates/sync_from_prod.rake'
        absolute_path = File.expand_path(relative_path, __FILE__)
        content = File.read absolute_path
        create_file "lib/tasks/sync_from_prod.rake",
                    content

        generate 'migration',
                 'create_translations locale:string key:string value:text interpolations:text is_proc:boolean'

        generate 'model',
                 'TranslationsChangesHistory key:string previous_value:string new_value:string'
      end
    end
  end
end
