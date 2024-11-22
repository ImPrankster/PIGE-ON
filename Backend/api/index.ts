import express from "express";
import { authMiddleware, loggingMiddleware } from "../src/middleware.js";
import { getSessionContext } from "../src/lib/auth.js";
import bodyParser from "body-parser";
import { insertProfileRoute } from "../src/route/insert-profile.js";

const app = express();
const port = process.env.PORT || 3005;

app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({ extended: true })); // for parsing application/x-www-form-urlencoded
app.use(authMiddleware);
app.use(loggingMiddleware);

app.listen(port, () => {
  console.log(`[server]: Server is running at http://localhost:${port}`);
});

app.get("/", async (req, res) => {
  const session = await getSessionContext(req);

  res.json({
    message: "Hello from the server",
    user: session.user.email ?? "",
  });
});

app.post("/insert-profile", insertProfileRoute);
