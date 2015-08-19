module EditI18nDatabaseTranslations
  class TranslationController < ActionController::Base
    include EditI18nDatabaseTranslations::ControllerModule

    before_action :set_locale, only: [:admin]

    helper_method :show_images?

    def save
      create_or_update_translation(params[:value])
      conf.after_save.call(locale: params[:locale],
                           key: params[:key],
                           value: params[:value])
      render(json: {})

    end

    def admin
      @list_of_keys = []
      update_list_of_keys(prefix, allowed_translations)
      load_translations_keys_from_db
      render template: 'edit_i18n_database_translations/admin.html.erb'
    end

    def upload
      save_file
      file_path = ["/#{conf.save_images_path}", random_file_name].join('/')
      create_or_update_translation(file_path)
      conf.after_save.call(locale: params[:locale],
                           key: params[:key],
                           value: params[:value],
                           file_path: file_path)
      redirect_to params[:redirect_to]
    end

    private

    def load_translations_keys_from_db
      keys = Translation
             .where(locale: I18n.locale)
             .pluck(:key)

      if show_images?
        keys.select! do |key|
          conf.check_images_proc.call(key)
        end
      end

      if !prefix.empty?
        keys.select! do |key|
          key.index(prefix) == 0
        end
      end

      @list_of_keys = @list_of_keys + keys
      @list_of_keys.uniq!
    end

    def create_or_update_translation(value)
      if translation
        save_history(prefix, translation.value, value)
        translation.update(value: value)
      else
        Translation.create(locale: params[:locale],
                           key: prefix,
                           value: value)
      end
      I18n.reload!
    end

    def random_file_name
      return @random_file_name if @random_file_name
      @random_file_name = random_string +
                          File.extname(uploaded_io.original_filename)
    end

    def random_string
      (0...25).map { ('a'..'z').to_a[rand(26)] }.join
    end

    def save_file
      file_path = Rails.root.join('public',
                                  conf.save_images_path,
                                  random_file_name)
      File.open(file_path, 'wb') do |file|
        file.write(uploaded_io.read)
      end
    end

    def uploaded_io
      params[:picture]
    end

    def save_history(key, previous_value, new_value)
      return unless conf.save_changes_history

      TranslationsChangesHistory.create(key: key,
                                        previous_value: previous_value,
                                        new_value: new_value)
    end

    def are_you_i18n_editor?
      true
    end

    def update_list_of_keys(prefix, x)
      if x.is_a? Hash
        if (not prefix.empty?)
            prefix += "."
        end
        x.each {|key, value|
          update_list_of_keys(prefix + key.to_s, value)
        }
      else
        if show_images?
          return unless conf.check_images_proc.call(prefix)
        end
        @list_of_keys.push(prefix)
      end
    end

    def translation
      @translation ||= Translation.where(key: params[:key], locale: params[:locale]).first
    end

    def allowed_keys
      conf.allowed_keys
    end

    def all_translations
      I18n.t('.')
    end

    def allowed_translations
      if show_images?
        return all_translations
      end

      if !prefix.empty?
        I18n.t(prefix)
      else
        all_translations.select { |key, _| allowed_keys.include?(key) }
      end
    end

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def prefix
      params[:key].to_s
    end

    def show_images?
      conf.show_images_tab && params[:images]
    end

    def conf
      EditI18nDatabaseTranslations.config
    end
  end
end
