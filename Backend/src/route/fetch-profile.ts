import { ne, sql } from "drizzle-orm";
import type { RequestHandler } from "express";
import { z } from "zod";
import { randomUUID } from "crypto";

import { db } from "../db/index.js";
import { profile } from "../db/schema.js";
import { getSessionContext } from "../lib/auth.js";

const FetchRandomArraySchema = z.object({
  count: z.number().int().positive(),
});

export const fetchProfileRandomArray: RequestHandler = async (req, res) => {
  const session = await getSessionContext(req);
  const { count } = FetchRandomArraySchema.parse(req.body);

  try {
    const data = await db
      .select({
        userId: profile.userId,
        firstName: profile.firstName,
        lastName: profile.lastName,
        description: profile.description,
      })
      .from(profile)
      .where(ne(profile.userId, session.user.id))
      .orderBy(sql`random()`)
      .limit(count);
    const dataWithUniqueId = data.map((item, _) => ({
      ...item,
      uniqueId: randomUUID(),
    }));
    res.status(200).json(dataWithUniqueId);
  } catch (error) {
    console.log(`[fetchRandomProfileArray]`, error);
    res.status(500).json({ error: "Failed to fetch random profile" });
  }
};
