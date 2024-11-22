import { RequestHandler } from "express";
import { getSessionContextSafe } from "~/lib/auth";

export const authMiddleware: RequestHandler = async (req, res, next) => {
  const sessionResponse = await getSessionContextSafe(req);
  if (sessionResponse.error) {
    res.status(401).json({
      message: "Failed to get session",
    });
    console.log("Failed to get session");
  } else {
    if (sessionResponse.data.session) {
      console.log("Authenticated as", sessionResponse.data.session.user.email);
      next();
    } else {
      res.status(401).json({
        message: "Not logged in",
      });
      console.log("Not authenticated");
    }
  }
};

export const loggingMiddleware: RequestHandler = async (req, _, next) => {
  console.log("Request received:", req.method, req.url);
  next();
};
