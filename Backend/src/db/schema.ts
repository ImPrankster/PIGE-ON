import { pgTable, uuid, timestamp, text } from "drizzle-orm/pg-core";

export const profile = pgTable("profile", {
  id: uuid().defaultRandom().primaryKey().notNull(),
  createdAt: timestamp("created_at", { withTimezone: true, mode: "string" })
    .defaultNow()
    .notNull(),
  userId: uuid("user_id").notNull().unique(),
  firstName: text("first_name").default("").notNull(),
  lastName: text("last_name").default("").notNull(),
  description: text().default("").notNull(),
});

export const likes = pgTable("likes", {
  id: uuid().defaultRandom().primaryKey().notNull(),
  profileId: uuid("profile_id").notNull(),
  userId: uuid("user_id").notNull(),
  createdAt: timestamp("created_at", { withTimezone: true, mode: "string" })
    .defaultNow()
    .notNull(),
});
