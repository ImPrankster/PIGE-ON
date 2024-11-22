import { sql } from "drizzle-orm";
import { RequestHandler } from "express";
import { db } from "~/db";
import { profile } from "~/db/schema";

export const profiles: Record<string, RequestHandler> = {
  fetchRandom: async (_, res) => {
    try {
      const data = await db
        .select({
          userId: profile.userId,
          firstName: profile.firstName,
          lastName: profile.lastName,
          description: profile.description,
        })
        .from(profile)
        .orderBy(sql`random()`)
        .limit(1);
      res.status(200).json(data[0]!);
    } catch (error) {
      console.log(`[fetchRandomProfile]`, error);
      res.status(500).json({ error: "Failed to fetch random profile" });
    }
  },
};
