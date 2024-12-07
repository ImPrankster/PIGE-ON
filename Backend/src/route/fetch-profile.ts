import { sql } from "drizzle-orm";
import type { RequestHandler } from "express";
import { db } from "../db/index.js";
import { profile } from "../db/schema.js";
import { z } from "zod";
import { randomUUID } from "crypto";

const FetchRandomArraySchema = z.object({
  count: z.number().int().positive(),
});

export const profiles: {
  fetchRandom: RequestHandler;
  fetchRandomArray: RequestHandler;
} = {
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

  fetchRandomArray: async (req, res) => {
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
        .orderBy(sql`random()`)
        .limit(count);
      const dataWithUniqueId = data.map((item, index) => ({
        ...item,
        uniqueId: randomUUID(),
      }));
      res.status(200).json(dataWithUniqueId);
    } catch (error) {
      console.log(`[fetchRandomProfileArray]`, error);
      res.status(500).json({ error: "Failed to fetch random profile" });
    }
  },
};
