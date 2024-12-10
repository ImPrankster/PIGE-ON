import type { RequestHandler } from "express";
import { desc, eq } from "drizzle-orm";

import { db } from "../db/index.js";
import { likes, profile } from "../db/schema.js";
import { getSessionContext } from "../lib/auth.js";

export const fetchLikes: RequestHandler = async (req, res) => {
  const session = await getSessionContext(req);

  try {
    const data = await db
      .select({
        uniqueId: likes.id,
        profileId: likes.profileId,
        userId: profile.userId,
        firstName: profile.firstName,
        lastName: profile.lastName,
        description: profile.description,
      })
      .from(likes)
      .leftJoin(profile, eq(likes.profileId, profile.userId))
      .where(eq(likes.userId, session.user.id))
      .orderBy(desc(likes.createdAt));
    res.status(200).json(data);
  } catch (error) {
    console.log(`[fetchLikes] on ${session.user.email}`, error);
    res.status(500).json({ error: "Failed to fetch likes" });
  }
};
