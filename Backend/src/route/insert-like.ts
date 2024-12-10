import type { RequestHandler } from "express";
import { z } from "zod";

import { db } from "../db/index.js";
import { likes } from "../db/schema.js";
import { getSessionContext } from "../lib/auth.js";

const insertLikeSchema = z.object({
  profileId: z.string().uuid(),
});

export const insertLike: RequestHandler = async (req, res) => {
  const session = await getSessionContext(req);
  const { profileId } = insertLikeSchema.parse(req.body);

  try {
    await db
      .insert(likes)
      .values({
        userId: session.user.id,
        profileId,
      })
      .onConflictDoNothing({
        target: [likes.userId, likes.profileId],
      });
    res.status(200).json({ message: "Like inserted successfully" });
  } catch (error) {
    console.log(`[insertLike] on ${session.user.email}`, error);
    res.status(500).json({ error: "Failed to insert like" });
  }
};
