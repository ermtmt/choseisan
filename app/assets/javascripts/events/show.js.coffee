$ ->
  $("#btn-event-delete").popover()
  $(":radio[id^=event_entry]:checked").parent("label").addClass("active")
