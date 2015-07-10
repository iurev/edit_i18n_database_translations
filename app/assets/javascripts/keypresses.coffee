$ ->
  $document = $(document)
  $body = $("body")
  ESC = 27
  ENTER = 13

  $document.keyup (e) ->
    if e.keyCode == ESC
      $body.trigger("edit_i18n_database_translations.esc")

  $document.keydown (e) ->
    if (event.metaKey || event.ctrlKey) && event.keyCode == ENTER
      $body.trigger("edit_i18n_database_translations.enter")
