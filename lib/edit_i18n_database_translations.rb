module EditI18nDatabaseTranslations
  require 'edit_i18n_database_translations/config.rb'
  def config
    @config ||= Config.new
  end
  module_function :config

  def configure(&block)
    yield config
  end
  module_function :configure

  require 'edit_i18n_database_translations/helper.rb'
  require 'edit_i18n_database_translations/engine.rb'
  require 'edit_i18n_database_translations/controller_module.rb'
  require 'edit_i18n_database_translations/translation_controller.rb'
  require 'edit_i18n_database_translations/view_and_sass_helpers.rb'
end
