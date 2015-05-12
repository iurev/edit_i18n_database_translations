module EditI18nDatabaseTranslations
  module ControllerModule
    def are_you_i18n_editor?
      params[:i18n_editor] == 'true'
    end

    def i18n_editor_options
      config = EditI18nDatabaseTranslations.config
      {
        name: config.user_name,
        password: config.password,
        if: :are_you_i18n_editor?
      }
    end

    def i18n_editor_auth!
      self.class.http_basic_authenticate_with i18n_editor_options
    end

    def self.included(base)
      base.class_eval do
        helper_method :are_you_i18n_editor?
        before_action :i18n_editor_auth!
      end
    end
  end
end
