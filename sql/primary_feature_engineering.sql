-- ============================================================
-- TravelTide: Primary Feature Engineering (SQL)
-- ------------------------------------------------------------
-- Purpose:
--   Build user-level behavioral and demographic features
--   for customer segmentation and rewards program analysis.
--
-- Scope:
--   - Only sessions after 2023-01-04
--   - Only engaged users (more than 7 sessions)
-- ============================================================

WITH sessions_2023 AS (
    -- Restrict sessions to the 2023 analysis period
    SELECT *
    FROM sessions
    WHERE session_start > '2023-01-04'
),

filtered_users AS (
    -- Keep only sufficiently active users
    -- (filters out low-engagement or one-off visitors)
    SELECT user_id
    FROM sessions_2023
    GROUP BY user_id
    HAVING COUNT(session_id) > 7
)

SELECT 
    -- =====================
    -- User demographics
    -- =====================
    u.user_id,
    u.birthdate,
    u.gender,
    u.married,
    u.has_children,
    u.home_city,
    u.home_airport,
    u.sign_up_date,

    -- =========================================================
    -- Booking behavior features
    -- =========================================================

    -- Average lead time (in days) between session end and trip start
    -- Trip start is defined as:
    --   - the earlier of flight departure or hotel check-in if both exist
    --   - otherwise, whichever of the two is available
    AVG(
        EXTRACT(
            EPOCH FROM (
                CASE
                    WHEN f.departure_time IS NOT NULL 
                         AND h.check_in_time IS NOT NULL
                        THEN LEAST(f.departure_time, h.check_in_time)
                    ELSE COALESCE(f.departure_time, h.check_in_time)
                END
                - s.session_end
            )
        ) / 86400.0
    ) AS avg_lead_time,

    -- Average number of checked bags per flight
    AVG(f.checked_bags) AS avg_bags,

    -- Average hotel spend per room (USD)
    AVG(h.hotel_per_room_usd) AS avg_hotel_spend,

    -- Proportion of sessions where any discount was applied
    -- (proxy for price sensitivity)
    AVG(
        CASE 
            WHEN s.flight_discount = TRUE 
              OR s.hotel_discount = TRUE 
            THEN 1 ELSE 0 
        END
    ) AS discount_sensitivity,

    -- Average monetary value of discounts received (USD)
    AVG(
        COALESCE(s.flight_discount_amount, 0) 
      + COALESCE(s.hotel_discount_amount, 0)
    ) AS avg_discount_value,

    -- Ratio of hotel trips to flight trips
    -- (captures bundling behavior)
    CAST(COUNT(h.trip_id) AS FLOAT) 
        / NULLIF(COUNT(f.trip_id), 0) AS bundling_ratio,

    -- True cancellation rate:
    --   cancelled trips / total distinct trips
    CAST(
        COUNT(DISTINCT 
            CASE WHEN s.cancellation = TRUE THEN s.trip_id END
        ) AS FLOAT
    ) 
    / NULLIF(COUNT(DISTINCT s.trip_id), 0) AS true_cancellation_rate,

    -- Average number of page clicks per session
    -- (proxy for engagement and browsing intensity)
    AVG(s.page_clicks) AS avg_page_clicks,

    -- Average base fare for flights (USD)
    AVG(f.base_fare_usd) AS avg_base_fare,

    -- Average number of hotel nights stayed
    AVG(h.nights) AS avg_nights_stayed,

    -- Most recent session activity date
    MAX(s.session_start) AS last_active_date 

FROM users u
    -- Restrict to active users only
    JOIN filtered_users fu 
        ON u.user_id = fu.user_id

    -- Join user sessions in the analysis period
    JOIN sessions_2023 s 
        ON u.user_id = s.user_id

    -- Optional trip-level joins
    LEFT JOIN flights f 
        ON s.trip_id = f.trip_id
    LEFT JOIN hotels h 
        ON s.trip_id = h.trip_id

-- Keep only sessions associated with an actual trip
WHERE s.trip_id IS NOT NULL

-- Aggregate to user level
GROUP BY 
    u.user_id, 
    u.birthdate, 
    u.gender, 
    u.married, 
    u.has_children, 
    u.home_city, 
    u.home_airport, 
    u.sign_up_date;
