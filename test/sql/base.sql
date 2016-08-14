\set ECHO none
\i test/sql/setup/setup.sql

-- int
SELECT count_distinct(x::int) FROM test_data_1_1000;
SELECT count_distinct(mod(x,10)::int) FROM test_data_1_1000;

-- bigint
SELECT count_distinct(x::bigint) FROM test_data_1_1000;
SELECT count_distinct(mod(x,10)::bigint) FROM test_data_1_1000;

-- timestamp
select count_distinct(now()::timestamp + (x || ' days')::interval) from test_data_1_1000;
select count_distinct(now() + (x || ' days')::interval) from test_data_1_1000;

-- bool
select count_distinct(x::bool) from test_data_0_1000;

-- int2
select count_distinct(x::int2) from test_data_1_1000;

-- array of int
SELECT count_distinct_elements(z) FROM (
    SELECT ARRAY[x::int, (x+1)::int] AS z FROM generate_series(1,1000) s(x)
) foo;

SELECT count_distinct_elements(z) FROM (
    SELECT ARRAY[mod(x,10)::int, mod(x+1,10)::int] AS z FROM generate_series(1,1000) s(x)
) foo;

-- array of bigint
SELECT count_distinct_elements(z) FROM (
    SELECT ARRAY[x::bigint, (x+1)::bigint] AS z FROM generate_series(1,1000) s(x)
) foo;

SELECT count_distinct_elements(z) FROM (
    SELECT ARRAY[mod(x,10)::bigint, mod(x+1,10)::bigint] AS z FROM generate_series(1,1000) s(x)
) foo;

-- array of timestamp
SELECT count_distinct_elements(z) FROM (
    SELECT ARRAY[now()::timestamp + (x || ' days')::interval,
                 now()::timestamp + ((x + 1) || ' days')::interval] AS z
    FROM generate_series(1,1000) s(x)
) foo;

SELECT count_distinct_elements(z) FROM (
    SELECT ARRAY[now() + (x || ' days')::interval,
                 now() + ((x + 1) || ' days')::interval] AS z
    FROM generate_series(1,1000) s(x)
) foo;

-- array of bool
SELECT count_distinct_elements(z) FROM (
    SELECT ARRAY[x::bool, (x+1)::bool] AS z FROM generate_series(1,1000) s(x)
) foo;

SELECT count_distinct_elements(z) FROM (
    SELECT ARRAY[mod(x,10)::bool, mod(x+1,10)::bool] AS z FROM generate_series(1,1000) s(x)
) foo;

-- array of int2
SELECT count_distinct_elements(z) FROM (
    SELECT ARRAY[x::int2, (x+1)::int2] AS z FROM generate_series(1,1000) s(x)
) foo;

SELECT count_distinct_elements(z) FROM (
    SELECT ARRAY[mod(x,10)::int2, mod(x+1,10)::int2] AS z FROM generate_series(1,1000) s(x)
) foo;

ROLLBACK;
