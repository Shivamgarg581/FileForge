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

-- PriceAtlas platform expansion: users, favorites, shopping lists, product catalog,
-- online/local merchant profiles, offers, price alerts, receipts, reviews and analytics.
create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  language text default 'en',
  city text,
  state text,
  country text default 'IN',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists product_variants (
  id uuid primary key default gen_random_uuid(),
  product_id uuid references products(id) on delete cascade,
  canonical_name text not null,
  brand text,
  variant text,
  pack_size numeric(12,4),
  pack_unit text,
  barcode text,
  gtin text,
  mpn text,
  attributes jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);
create index if not exists product_variants_search
  on product_variants using gin (to_tsvector('simple', coalesce(canonical_name,'') || ' ' || coalesce(brand,'') || ' ' || coalesce(variant,'')));


create table if not exists offers (
  id uuid primary key default gen_random_uuid(),
  product_variant_id uuid references product_variants(id) on delete cascade,
  merchant_id uuid references merchants(id) on delete cascade,
  price numeric(12,2) not null check (price >= 0),
  mrp numeric(12,2),
  quantity numeric(12,4) not null check (quantity > 0),
  unit text not null,
  shipping numeric(12,2) default 0,
  coupon numeric(12,2) default 0,
  availability text,
  offer_url text,
  source_name text,
  observed_at timestamptz not null,
  verification_status text not null default 'unverified',
  created_at timestamptz not null default now()
);
create index if not exists offers_product_time on offers(product_variant_id, observed_at desc);
create index if not exists offers_merchant_time on offers(merchant_id, observed_at desc);

create table if not exists favorite_products (
  user_id uuid references auth.users(id) on delete cascade,
  product_id uuid references products(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key(user_id, product_id)
);

create table if not exists shopping_lists (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  name text not null,
  created_at timestamptz not null default now()
);

create table if not exists shopping_list_items (
  id uuid primary key default gen_random_uuid(),
  list_id uuid references shopping_lists(id) on delete cascade,
  product_id uuid references products(id) on delete cascade,
  quantity numeric(12,4) not null default 1,
  unit text not null default 'piece',
  checked boolean not null default false,
  created_at timestamptz not null default now()
);

create table if not exists price_alerts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  product_id uuid references products(id) on delete cascade,
  target_price numeric(12,2) not null check (target_price >= 0),
  market_id uuid references markets(id) on delete set null,
  channel text,
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists receipts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  merchant text,
  purchased_at timestamptz,
  currency text default 'INR',
  subtotal numeric(12,2),
  total numeric(12,2),
  image_url text,
  parse_status text default 'pending',
  created_at timestamptz not null default now()
);

create table if not exists receipt_items (
  id uuid primary key default gen_random_uuid(),
  receipt_id uuid references receipts(id) on delete cascade,
  product_id uuid references products(id) on delete set null,
  description text not null,
  quantity numeric(12,4),
  unit text,
  unit_price numeric(12,2),
  line_total numeric(12,2)
);

create table if not exists product_reviews (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade,
  product_id uuid references products(id) on delete cascade,
  rating integer check (rating between 1 and 5),
  title text,
  body text,
  created_at timestamptz not null default now()
);

create table if not exists platform_events (
  id uuid primary key default gen_random_uuid(),
  event_name text not null,
  product_id uuid references products(id) on delete set null,
  merchant_id uuid references merchants(id) on delete set null,
  metadata jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

-- RLS baseline for user-owned tables.
alter table profiles enable row level security;
alter table favorite_products enable row level security;
alter table shopping_lists enable row level security;
alter table shopping_list_items enable row level security;
alter table price_alerts enable row level security;
alter table receipts enable row level security;
alter table receipt_items enable row level security;
alter table product_reviews enable row level security;

create policy if not exists profiles_owner on profiles for all using (auth.uid() = id) with check (auth.uid() = id);
create policy if not exists favorites_owner on favorite_products for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy if not exists lists_owner on shopping_lists for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy if not exists alerts_owner on price_alerts for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy if not exists receipts_owner on receipts for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy if not exists reviews_public_read on product_reviews for select using (true);
create policy if not exists reviews_owner_write on product_reviews for insert with check (auth.uid() = user_id);
