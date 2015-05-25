$ ->
  $body = $('body')
  $editor = $('.js-i18n-text-editor')
  $input = $editor.find('.js-input')
  $textarea = $editor.find('.js-textarea')
  $help = $editor.find('.js-help')
  $text = null
  $active_input = null

  save_email_path = $editor.data('save-path')
  locale = $editor.data('locale')

  field_name = ''
  text = ''

  $body.on 'click', '.js-i18n-text-editor .js-save', ->
    val = $active_input.val()
    $text.html(val)
    data =
      key: field_name
      value: val
      locale: locale
    $.post(save_email_path, data)
    clear()

  show_or_hide_inputs = (field_name) ->
    if field_name.indexOf("_html") != -1
      $active_input = $textarea.show()
      $input.hide()
      $help.show()
    else
      $active_input = $input.show()
      $textarea.hide()
      $help.hide()

  add_text_on_inputs = (text) ->
    $input.val(text)
    $textarea.val(text)

  $body.on 'contextmenu', '.js-i18n-translation', (e) ->
    e.preventDefault()
    $text = $(@)
    field_name = $text.data('i18n-path')
    show_or_hide_inputs(field_name)
    add_text_on_inputs($text.html())
    $editor.show()

  $body.on 'keyup', '.js-i18n-text-editor .js-input', ->
    $text.html($(@).val())

  $body.on 'keyup', '.js-i18n-text-editor .js-textarea', ->
    $text.html($(@).val())

  clear = ->
    $editor.hide()
    $text = null
    field_name = ''
    text = ''
    $input.val('')
    $textarea.val('')
    $active_input = null

  $body.on 'click', '.js-i18n-text-editor .js-undo', clear

  # http://stackoverflow.com/questions/1173194/select-all-div-text-with-single-mouse-click
  select_text = (elem) ->
    if document.selection
      range = document.body.createTextRange()
      range.moveToElementText elem
      range.select()
    else if window.getSelection
      range = document.createRange()
      range.selectNode elem
      window.getSelection().addRange range

  $body.on 'click', '.js-i18n-text-editor .js-help td', ->
    select_text(@)
