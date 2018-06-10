//not using array

function numberReverse(numberPassed) {
  var reverse = 0;
  var defactor = 10;
  var num = numberPassed;
  console.log("Starting Number : " + numberPassed + "  has lenght  " + numberPassed.toString().length );

  do {
    var hold = num % defactor;
    reverse = (reverse * defactor) + hold;
    num = parseInt(num / defactor);
  } while (num > 0);
  console.log("Reversed Number : " + reverse);
}

//using array

function numberReverseUsingArray(numberPassed) {
numberPassed = numberPassed + "";
console.log();
console.log("The number as array : " + numberPassed.split("").reverse().join(""));
}

var num = 1230040005670009;

numberReverse(num);
numberReverseUsingArray(num);
