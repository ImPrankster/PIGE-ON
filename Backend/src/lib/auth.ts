import { Request } from "express";
import { supabase } from "./supabase";

export const getSessionContext = async (req: Request) => {
  const accessToken = req.headers["x-access-token"] as string;
  const refreshToken = req.headers["x-refresh-token"] as string;

  const sessionResponse = await supabase.auth.setSession({
    access_token: accessToken,
    refresh_token: refreshToken,
  });

  if (!sessionResponse.error) {
    const {
      data: { session },
    } = sessionResponse;
    if (session) {
      return session;
    } else {
      throw new Error("Not logged in");
    }
  } else {
    throw new Error("Failed to get session");
  }
};

export const getSessionContextSafe = async (req: Request) => {
  const accessToken = req.headers["x-access-token"] as string;
  const refreshToken = req.headers["x-refresh-token"] as string;

  const sessionResponse = await supabase.auth.setSession({
    access_token: accessToken,
    refresh_token: refreshToken,
  });

  return sessionResponse;
};
