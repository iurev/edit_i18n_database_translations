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

        generate 'model',
                 'Translation locale:string key:string value:text interpolations:textis_proc:boolean'

        generate 'model',
                 'TranslationsChangesHistory key:string previous_value:string new_value:string'
      end
    end
  end
end
