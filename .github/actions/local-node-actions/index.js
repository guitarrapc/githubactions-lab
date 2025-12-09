// Standard output
console.log("Hello, World!");

// input example
const name = process.env['INPUT_NAME'];

// output example
const greeting = `Hello, ${name}!`;
console.log(greeting);
console.log(`::set-output name=greeting::${greeting}`);
