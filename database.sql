-- UBakwit Disaster Response Database Schema
-- Optimized for Supabase (PostgreSQL)

-- 1. Create Sensors table
CREATE TABLE sensors (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sensor_code VARCHAR(10) UNIQUE NOT NULL,
    location_name TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'ACTIVE',
    last_ping TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. Create Weather Readings table
CREATE TABLE weather_readings (
    id BIGSERIAL PRIMARY KEY,
    sensor_id UUID REFERENCES sensors(id),
    rainfall_mm DECIMAL(5,2) NOT NULL,
    temperature_c DECIMAL(4,1) NOT NULL,
    humidity_pct INTEGER NOT NULL,
    wind_speed_kmh DECIMAL(5,2) NOT NULL,
    wind_direction VARCHAR(3),
    reading_timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 3. Create Evacuation Routes table
CREATE TABLE evacuation_routes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    route_name TEXT NOT NULL,
    distance_meters INTEGER NOT NULL,
    eta_minutes INTEGER NOT NULL,
    status VARCHAR(20) DEFAULT 'OPTIMAL',
    hazards JSONB DEFAULT '[]', -- List of hazard objects
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. Create Active Protocols table
CREATE TABLE active_protocols (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    protocol_code VARCHAR(10) UNIQUE NOT NULL,
    name TEXT NOT NULL,
    trigger_condition TEXT NOT NULL,
    current_status VARCHAR(20) DEFAULT 'READY',
    last_activated TIMESTAMP WITH TIME ZONE
);

-- Sample Data Seeding
INSERT INTO sensors (sensor_code, location_name) VALUES 
('S001', 'Main Campus - Lipa'),
('S002', 'Gate Area - Lipa');

INSERT INTO evacuation_routes (route_name, distance_meters, eta_minutes, status) VALUES 
('Main Gate to Gymnasium shelter', 450, 5, 'OPTIMAL'),
('Library to Field Shelter', 320, 4, 'CAUTION');

INSERT INTO active_protocols (protocol_code, name, trigger_condition) VALUES 
('P001', 'Class Suspension Protocol', 'rainfall > 50mm/hr');

-- Sample Queries
-- Get latest weather for a specific sensor
SELECT * FROM weather_readings 
WHERE sensor_id = (SELECT id FROM sensors WHERE sensor_code = 'S001')
ORDER BY reading_timestamp DESC 
LIMIT 1;

-- List all caution routes
SELECT route_name, distance_meters, eta_minutes 
FROM evacuation_routes 
WHERE status = 'CAUTION';

-- How to integrate with Supabase code:
-- const { data, error } = await supabase
--   .from('weather_readings')
--   .select('*')
--   .order('reading_timestamp', { ascending: false })
--   .limit(1);
