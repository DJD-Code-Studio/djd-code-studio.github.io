//1. Write a JavaScript program to display the current day and time //in the following format.  Go to the editor
//Sample Output : Today is : Friday.
//Current time is : 4 PM : 50 : 22
// output variations : 12 Midnight : 00 : 00 , 12 Noon: 00 : 00 , 12 AM : 50 : 22, 12 PM : 50 : 22,
// output variations : 12 Midnight , 12 Noon, 12 : 50 : 22 AM, 12 : 50 : 22 PM,


// Write your code here.
var weekdays = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
// var todaydate = new Date();
var todaydate = new Date(2018, 06, 04, 12, 00, 00, 0);
var day = todaydate.getDay();
var dayName = weekdays[day];
//console.log(todaydate);
console.log("Today  is : " + dayName);
var curHours = todaydate.getHours();
// console.log(curHours);
var curMins = todaydate.getMinutes();
//console.log(curMins);
var curSecs = todaydate.getSeconds();
//console.log(curSecs);
var amORpm = "";
amORpm = (curHours >= 12)? "PM" : "AM";
// console.log(amORpm);

// the checking logic
if (curMins === 0 && curSecs === 0) {
      if (curHours === 0) {
        curHours = 12;
        amORpm = "Midnight";
      }
      else {
        if (curHours === 12) {
          curHours = 12;
          amORpm = "Noon";
        }
      }
    }
else {
  // check for AM range
  if (amORpm === "AM") {
    if (curHours === 0) {
      curHours = 12;
      } else {
    }
  }
// check for PM range
  else {
    if (curHours === 12) {
    }
    else {
      curHours = curHours - 12;
    }
  }
}

console.log("Current time is : " + curHours + " " + amORpm + " : " + curMins + " : " + curSecs);
