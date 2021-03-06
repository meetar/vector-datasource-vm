SELECT name, area, kind, source, __geometry__

FROM
(
    --
    -- Ocean
    --
    SELECT '' AS name,
           ST_Area(the_geom)::bigint AS area,
           'ocean' AS kind,
           'naturalearthdata.com' AS source,
           the_geom AS __geometry__
    
    FROM ne_50m_ocean
    
    WHERE the_geom && !bbox!
    
    --
    -- Lakes
    --
    UNION

    SELECT name,
           ST_Area(the_geom)::bigint AS area,
           'lake' AS kind,
           'naturalearthdata.com' AS source,
           the_geom AS __geometry__
    
    FROM ne_50m_lakes
    
    WHERE the_geom && !bbox!
    
    --
    -- Playas
    --
    UNION

    SELECT name,
           ST_Area(the_geom)::bigint AS area,
           'playa' AS kind,
           'naturalearthdata.com' AS source,
           the_geom AS __geometry__
    
    FROM ne_50m_playas
    
    WHERE the_geom && !bbox!

) AS water_areas
