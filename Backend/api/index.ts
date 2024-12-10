import express from "express";
import bodyParser from "body-parser";

import { authMiddleware, loggingMiddleware } from "../src/middleware.js";
import { insertProfile } from "../src/route/insert-profile.js";
import { fetchProfileRandomArray } from "../src/route/fetch-profile.js";
import { insertLike } from "../src/route/insert-like.js";
import { fetchLikes } from "../src/route/fetch-likes.js";

const app = express();
const port = process.env.PORT || 3005;

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
app.use(loggingMiddleware);

app.listen(port, () => {
  console.log(`[server]: Server is running at http://localhost:${port}`);
});

app.post("/insert-profile", authMiddleware, insertProfile);

app.post(
  "/fetch-profile-random-array",
  authMiddleware,
  fetchProfileRandomArray
);

app.post("/insert-like", authMiddleware, insertLike);

app.get("/fetch-likes", authMiddleware, fetchLikes);
