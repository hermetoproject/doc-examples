const express = require("express");

const port = 9000;
const app = express();

app.get("/", (req, res) => res.send("Hello world!"));

app.listen(port, () => console.log(`App started on port ${port}...`));
