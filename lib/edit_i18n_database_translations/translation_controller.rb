module EditI18nDatabaseTranslations
  class TranslationController < ActionController::Base
    include EditI18nDatabaseTranslations::ControllerModule

    def save
      @translation = Translation.find_by_key(params[:key])
      if @translation
        @translation.update(value: params[:value])
      else
        Translation.create(locale: I18n.locale,
                           key: params[:key],
                           value: params[:value])
      end
      I18n.reload!
      return render(json: {})
    end

    private

    def are_you_i18n_editor?
      true
    end
  end
end
