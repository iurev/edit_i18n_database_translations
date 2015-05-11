$ ->
  $body = $('body')
  $editor = $('.js-i18n-text-editor')
  $input = $editor.find('.js-input')
  $text = null

  save_email_path = $editor.data('save-path')

  field_name = ''
  text = ''

  $body.on 'click', '.js-i18n-text-editor .js-save', ->
    val = $input.val()
    $text.text(val)
    $editor.hide()
    data =
      key: field_name
      value: val
    $.post(save_email_path, data)

  $body.on 'contextmenu', '.js-i18n-translation', (e) ->
    e.preventDefault()
    $text = $(@)
    field_name = $text.data('i18n-path')
    text = $(@).text()
    $input.val(text)
    $editor.show()
