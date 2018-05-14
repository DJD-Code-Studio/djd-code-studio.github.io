console.log('hi');
console.log("hello");

let x = 7;
let y = 9;
let z = x + y * x;

console.log('Check-1  :: ' + z );
console.log('Check-2  :: ' + y + x * y);
// + WILL CAUSE STRING CONCATENATION AND NOT ADDITION IF NOT SEPERATED OUT USING PARENTHESIS; HOWEVER * EVALUATES AS MULTIPLICATION AS USUAL
console.log('Check-3  :: ' + (y + x * y));
