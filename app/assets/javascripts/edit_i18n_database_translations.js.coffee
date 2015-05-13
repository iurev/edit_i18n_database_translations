//= require jquery

$ ->
  $body = $('body')
  $editor = $('.js-i18n-text-editor')
  $input = $editor.find('.js-input')
  $text = null

  save_email_path = $editor.data('save-path')
  locale = $editor.data('locale')

  field_name = ''
  text = ''

  $body.on 'click', '.js-i18n-text-editor .js-save', ->
    val = $input.val()
    $text.text(val)
    data =
      key: field_name
      value: val
      locale: locale
    $.post(save_email_path, data)
    clear()

  $body.on 'contextmenu', '.js-i18n-translation', (e) ->
    e.preventDefault()
    $text = $(@)
    field_name = $text.data('i18n-path')
    text = $(@).text()
    $input.val(text)
    $editor.show()

  clear = ->
    $editor.hide()
    $text = null
    field_name = ''
    text = ''

  $body.on 'click', '.js-i18n-text-editor .js-undo', clear
