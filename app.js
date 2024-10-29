const express = require('express');
const app = express();
const port = process.env.PORT || 9000;

app.get('/', (req, res) => {
    res.send(`
        <h1>Welcome to Express App</h1>
        <p>This application was deployed using Jenkins and Docker!</p>
        <p>Server time: ${new Date().toLocaleString()}</p>
    `);
});

app.get('/health', (req, res) => {
    res.json({ status: 'healthy', timestamp: new Date() });
});

app.listen(port, () => {
    console.log(`Express app listening at http://localhost:${port}`);
});