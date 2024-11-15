//
//  Supabase.swift
//  PIGE-ON
//
//  Created by Ruofan Wang on 2024/11/8.
//

import Supabase
import Foundation

let PUBLIC_SUPABASE_URL = "https://gpafnkazyfmogkujuqxz.supabase.co"
let PUBLIC_SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdwYWZua2F6eWZtb2drdWp1cXh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEwODE4MDEsImV4cCI6MjA0NjY1NzgwMX0.Njn7WNM2avGfx5G5LpLma1sssi-HQZ5ai0ECUfLr0e4"

let supabase = SupabaseClient(supabaseURL: URL(string: PUBLIC_SUPABASE_URL)!, supabaseKey: PUBLIC_SUPABASE_KEY)
