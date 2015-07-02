module EditI18nDatabaseTranslations
  module ControllerModule
    def are_you_i18n_editor?
      params[:i18n_editor] == 'true'
    end

    def i18n_editor_auth!
      return unless are_you_i18n_editor?

      config = EditI18nDatabaseTranslations.config

      authenticate_or_request_with_http_basic("Application") do |name, password|
        name == config.user_name && password == config.password
      end
    end

    def self.included(base)
      base.class_eval do
        helper_method :are_you_i18n_editor?
        before_action :i18n_editor_auth!
      end
    end
  end
end
