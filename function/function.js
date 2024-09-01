// index.js

const functions = require('@google-cloud/functions-framework');

functions.http('helloWorld', (req, res) => {
  console.log('Cloud Function fue invocada.');
  
  const name = req.query.name || 'World';
  console.log(`Nombre recibido: ${name}`);
  
  const message = `Hello, ${name}!`;
  console.log(`Mensaje a enviar: ${message}`);
  
  res.status(200).send(message);
  
  console.log('Cloud Function completada exitosamente.');
});
