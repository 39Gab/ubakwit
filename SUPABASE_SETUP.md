# Supabase Integration Guide for UBakwit

Follow these steps to set up the backend for the UBakwit Disaster Response System.

## 1. Create a Supabase Project
- Go to [supabase.com](https://supabase.com) and sign in.
- Click "New Project" and follow the setup wizard.
- Note your **Project URL** and **API Key (service_role or anon)**.

## 2. Initialize Database Schema
- Go to the **SQL Editor** in your Supabase dashboard.
- Create a new query and paste the contents of `database.sql` from this project.
- Click **Run**. This will create the following tables:
  - `sensors`: Registry of weather stations.
  - `weather_readings`: Historical environmental records.
  - `evacuation_routes`: Tactical transit path metadata.
  - `active_protocols`: Safety trigger logic.

## 3. Environment Configuration
Add the following to your `.env.local`:
```env
VITE_SUPABASE_URL=https://your-project-id.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key
```

## 4. Install Supabase Client
Run the following in your terminal:
```bash
npm install @supabase/supabase-js
```

## 5. Integration Code Example
Create a file `src/lib/supabase.ts`:
```typescript
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
```

## 6. Fetching Real-Time Data
In your components, you can now fetch live data:
```typescript
const fetchLatestWeather = async () => {
    const { data, error } = await supabase
        .from('weather_readings')
        .select(`
            *,
            sensors (location_name)
        `)
        .order('reading_timestamp', { ascending: false })
        .limit(1);
    
    return data;
};
```

## 7. Real-Time Subscriptions
Enable real-time updates for the `weather_readings` table in the Supabase Dashboard (Database -> Replication) to have the dashboard auto-update when sensors report new data.
