import { RequestHandler } from "express";
import { getSessionContext } from "~/lib/auth";
import z from "zod";
import { db } from "~/db";
import { profile } from "~/db/schema";

const profileSchema = z.object({
  firstName: z.string().min(1),
  lastName: z.string().min(1),
  description: z.string().min(1),
});

export const insertProfileRoute: RequestHandler = async (req, res) => {
  const session = await getSessionContext(req);
  const { firstName, lastName, description } = profileSchema.parse(req.body);
  try {
    await db
      .insert(profile)
      .values([
        {
          userId: session.user.id,
          firstName,
          lastName,
          description,
        },
      ])
      .onConflictDoUpdate({
        target: profile.userId,
        set: {
          firstName,
          lastName,
          description,
        },
      });
    res.status(200).send();
  } catch (error) {
    console.log(`[insertProfile on ${session.user.email}]`, error);
    res.status(500).json({ error: "Failed to insert profile" });
  }
};
