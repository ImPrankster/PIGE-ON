import express from "express";
import bodyParser from "body-parser";

import { authMiddleware, loggingMiddleware } from "../src/middleware.js";
import { insertProfile } from "../src/route/insert-profile.js";
import { profiles } from "../src/route/fetch-profile.js";

const app = express();
const port = process.env.PORT || 3005;

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
app.use(loggingMiddleware);

app.listen(port, () => {
  console.log(`[server]: Server is running at http://localhost:${port}`);
});

app.use("/insert-profile", authMiddleware);

app.post("/insert-profile", insertProfile);

app.get("/fetch-profile-random", profiles.fetchRandom);

app.post("/fetch-profile-random-array", profiles.fetchRandomArray);
