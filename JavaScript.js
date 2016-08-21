//Array in Javascript
var cars = ["Saab", "Volvo", "BMW"];
//or you can define it as
var cars = new Array("Saab", "Volvo", "BMW");
// toString() converts an array to a string
console.log(cars.toString()); //Saab,Volvo,BMW
//join() joins all array elements into a string.
console.log(cars.join(" * ")); //Saab * Volvo * BMW
// pop() method removes the last element from an array  (at the end)
cars.pop(); //BMW
// pop() method adds a new element to an array (at the end)
cars.push("BMW");
//shift() method removes the first array element and "shifts" all other elements to a lower index.
cars.shift(); //Saab
//unshift() method adds a new element to an array (at the beginning)
cars.unshift("Saab");
//http://www.w3schools.com/jsref/jsref_obj_array.asp

