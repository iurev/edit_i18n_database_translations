$ ->
  $body = $('body')
  $form = $('.js-images-uploader-form')
  $preview_image = $('.js-images-uploader-form .js-image')
  $key_input = $('.js-images-uploader-form .js-i18n-key')
  $redirect_to = $('.js-images-uploader-form .js-redirect-to')

  $redirect_to.val(location.href)

  stop_watching = false

  get_src = ($dom_element) ->
    if $dom_element.is('img')
      $dom_element.attr('src')
    else
      value = $dom_element.css('background-image')
      value.replace('url(', '').replace(')', '')

  get_parametr_by_name = (name, url) ->
    name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]')
    regex = new RegExp('[\\?&]' + name + '=([^&#]*)')
    results = regex.exec(url)
    if results == null
      null
    else
      decodeURIComponent(results[1].replace(/\+/g, ' '))

  $body.on 'contextmenu', '*', (e) ->
    return if stop_watching

    e.preventDefault()
    $this = $(@)
    src = get_src($this)
    key = get_parametr_by_name('i18n_key', src)

    return unless key

    stop_watching = true

    $preview_image.attr('src', src)
    $key_input.val(key)
    $form.show()

  clear = ->
    stop_watching = false
    $form.hide()

  $body.on 'click', '.js-images-uploader-form .js-undo', clear
