import express from "express";
import { supabase } from "./lib/supabase";

const app = express();
const port = 3005;

app.get("/hello", async (req, res) => {
  const accessToken = req.headers["x-access-token"] as string;
  const refreshToken = req.headers["x-refresh-token"] as string;

  const sessionResponse = await supabase.auth.setSession({
    access_token: accessToken,
    refresh_token: refreshToken,
  });

  if (!sessionResponse.error && sessionResponse.data.session) {
    const {
      data: { session },
    } = sessionResponse;
    console.log("Received request from", session.user.email);
    res.json({
      message: "Hello from the server",
      user: session.user.email ?? "",
    });
  } else {
    console.log("Received request but not logged in");
    res.json({
      message: "Not logged in",
    });
  }
});

app.listen(port, () => {
  console.log(`[server]: Server is running at http://localhost:${port}`);
});
