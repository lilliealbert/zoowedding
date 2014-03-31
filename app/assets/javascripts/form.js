$(document).ready(function () {
  function rsvpsExist () {
    return $('.rsvp_checkboxes input:checked').length > 0;
  }

  function setSubmitDisabledState () {
    $('input.rsvp-yes').prop('disabled', !rsvpsExist());
  }

  $('.rsvp_checkboxes input').on('change', setSubmitDisabledState);
  setSubmitDisabledState();

  $('.rsvp-submit-wrapper').on('click', function () {
    if (!rsvpsExist()) {
      alert('You must select at least one event before RSVPing.');
    }
  });
});
