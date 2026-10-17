// Used in Plugin Settings page to delete transition
function deleteTransitionField(from_id) {
  // changes field name to remove from settings.
  document.getElementById('settings_status_transitions_' + from_id).name = "deleted_transition" + from_id;
}

// Used in Plugin Settings page to add transition
function addTransitionField() {
  // inserts new hidden tag for new status transition.
  var elem = document.getElementById('add-transition');
  var to_id = document.getElementById('new-transition-to').value;
  var from_id = document.getElementById('new-transition-from').value;
  var new_tag = '<input type="hidden" id="settings_status_transition_'+ from_id + '" name="settings[status_transitions][' + from_id + ']" value="' + to_id + '">';
  elem.innerHTML= new_tag;
}

// timer
let x;
let startstop = 0;
let started_on = 0;
/* holds incrementing value */
let seconds = 0;
let minutes = 0;
let hours = 0;
/* Contains and outputs returned value of  function checkTime */
let secOut = 0;
let minOut = 0;
let hourOut = 0;

function pause_timer() {
  if (!x) { return; } // no timer running
  stop_timer();
}

function start_timer(sec, min, hour) {
  if (x) { return; } // a timer is already running

  // get the time
  seconds = sec;
  minutes = min;
  hours = hour;

  x = setInterval(tl_timer, 1000);
}

function stop_timer() {
  clearInterval(x);
  x = null;
}

// Output variable End
function tl_timer() {
  secOut = checkTime(seconds);
  minOut = checkTime(minutes);
  hourOut = checkTime(hours);

  seconds = ++seconds;

  if (seconds === 60) {
    minutes = ++minutes;
    seconds = 0;
  }

  if (minutes === 60) {
    minutes = 0;
    hours = ++hours;
  }

  document.getElementById("sec").innerHTML = secOut;
  document.getElementById("min").innerHTML = minOut;
  document.getElementById("hour").innerHTML = hourOut;
}

// Adds 0 when value is <10
function checkTime(i) {
  if (i < 10) {
    i = "0" + i;
  }
  return i;
}