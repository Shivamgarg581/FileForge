create extension if not exists pgcrypto;

create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text unique not null,
  category text,
  subcategory text,
  brand text,
  variant text,
  default_unit text,
  aliases text[] default '{}',
  created_at timestamptz not null default now()
);

create table if not exists markets (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  city text,
  district text,
  state text,
  latitude double precision,
  longitude double precision,
  market_type text,
  created_at timestamptz not null default now()
);

create table if not exists sources (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  source_type text not null,
  url text,
  created_at timestamptz not null default now()
);

create table if not exists price_records (
  id uuid primary key default gen_random_uuid(),
  product_id uuid references products(id) on delete cascade,
  market_id uuid references markets(id) on delete set null,
  source_id uuid references sources(id) on delete set null,
  price numeric(12,2) not null check (price >= 0),
  quantity numeric(12,4) not null check (quantity > 0),
  unit text not null,
  normalized_price numeric(12,4),
  brand text,
  quality text,
  verification_status text not null default 'unverified',
  observed_at timestamptz not null,
  created_at timestamptz not null default now()
);

create index if not exists price_records_product_time on price_records(product_id, observed_at desc);
create index if not exists price_records_market_time on price_records(market_id, observed_at desc);

create table if not exists price_submissions (
  id uuid primary key default gen_random_uuid(),
  product_id uuid references products(id) on delete cascade,
  market_id uuid references markets(id) on delete set null,
  price numeric(12,2) not null check (price >= 0),
  quantity numeric(12,4) not null check (quantity > 0),
  unit text not null,
  evidence_url text,
  notes text,
  status text not null default 'pending',
  submitted_at timestamptz not null default now()
);

create table if not exists price_statistics (
  id uuid primary key default gen_random_uuid(),
  product_id uuid references products(id) on delete cascade,
  market_id uuid references markets(id) on delete set null,
  window_days integer not null,
  average numeric(12,4),
  median numeric(12,4),
  p10 numeric(12,4),
  p90 numeric(12,4),
  min_price numeric(12,4),
  max_price numeric(12,4),
  sample_count integer not null default 0,
  updated_at timestamptz not null default now()
);

create table if not exists alerts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  product_id uuid references products(id) on delete cascade,
  market_id uuid references markets(id) on delete set null,
  target_price numeric(12,2) not null,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists audit_log (
  id uuid primary key default gen_random_uuid(),
  entity_type text not null,
  entity_id uuid,
  action text not null,
  actor_id uuid,
  payload jsonb,
  created_at timestamptz not null default now()
);

-- Multi-channel price intelligence
create table if not exists price_observations (
  id uuid primary key default gen_random_uuid(),
  product_id uuid references products(id) on delete cascade,
  channel text not null check (channel in ('official_retail','official_wholesale','mandi','local_shop','online')),
  merchant text,
  market_id uuid references markets(id) on delete set null,
  price numeric(12,2) not null check (price >= 0),
  quantity numeric(12,4) not null check (quantity > 0),
  unit text not null,
  normalized_price numeric(12,4),
  currency text not null default 'INR',
  source_url text,
  source_name text,
  observed_at timestamptz not null,
  verification_status text not null default 'unverified',
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index if not exists price_observations_product_channel_time
  on price_observations(product_id, channel, observed_at desc);

create index if not exists price_observations_merchant_time
  on price_observations(merchant, observed_at desc);

create table if not exists product_identifiers (
  id uuid primary key default gen_random_uuid(),
  product_id uuid references products(id) on delete cascade,
  identifier_type text not null check (identifier_type in ('gtin','ean','upc','sku','asin','isbn','mpn')),
  identifier text not null,
  source text,
  created_at timestamptz not null default now(),
  unique(identifier_type, identifier)
);

create table if not exists merchants (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  domain text,
  channel text not null check (channel in ('online','local_shop')),
  country text default 'IN',
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists price_history_daily (
  id uuid primary key default gen_random_uuid(),
  product_id uuid references products(id) on delete cascade,
  merchant_id uuid references merchants(id) on delete set null,
  market_id uuid references markets(id) on delete set null,
  channel text not null,
  observation_date date not null,
  min_price numeric(12,2),
  avg_price numeric(12,2),
  max_price numeric(12,2),
  sample_count integer not null default 0,
  created_at timestamptz not null default now(),
  unique(product_id, merchant_id, market_id, channel, observation_date)
);
