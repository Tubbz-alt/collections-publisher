(function () {
  'use strict'
  window.GOVUK = window.GOVUK || {}
  var $ = window.jQuery
  var csrfToken = $('meta[name="csrf-token"]').attr('content')

  GOVUK.orderedLists = {
    init: function () {
      $('#switch-to-list-sorting').clickToggle(
        function () {
          $('body').addClass('list-drag-in-progress')
          $(this).text('Done')
        },
        function () {
          $('body').removeClass('list-drag-in-progress')
          $(this).text('Sort lists')
        }
      )

      var $listContainer = $('.curated-lists')
      $listContainer.sortable({
        stop: function (event, draggable) {
          var $lists = $listContainer.children()
          var $droppedList = draggable.item
          var startIndex = $droppedList.data('index')
          var stopIndex = $lists.index($droppedList)

          $droppedList.data('index', stopIndex)

          var indexToUpdateFrom = Math.min(startIndex, stopIndex)
          var $listsToUpdate = $lists.slice(indexToUpdateFrom)

          GOVUK.orderedLists.reindex($listsToUpdate, indexToUpdateFrom)
          GOVUK.publishing.unlockPublishing()
        },
        placeholder: 'sortable-placeholder'
      })
    },
    reindex: function ($lists, offset) {
      $lists.each(function (index, list) {
        var $list = $(list)
        var updateURL = $list.data('update-url')
        var newIndex = offset + index

        $list.data('index', newIndex)
        GOVUK.orderedLists.updateRow(updateURL, newIndex)
      })
    },
    updateRow: function (updateURL, index) {
      $.ajax(updateURL, {
        type: 'PUT',
        data: JSON.stringify({
          list: {
            index: index
          }
        }),
        contentType: 'application/json',
        dataType: 'json',
        headers: { 'X-CSRF-Token': csrfToken }
      })
    }
  }
}())
