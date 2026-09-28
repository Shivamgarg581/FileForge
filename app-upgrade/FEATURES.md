# PriceAtlas Advanced Feature Map

This document defines the advanced product surface for PriceAtlas.

## User features
- Global product search with Hindi/common aliases
- Product detail pages with source, timestamp, price type and confidence state
- Multi-merchant offer comparison
- Unit normalization and price-per-unit comparison
- Price history, high/low, average, median and range
- Good/normal/high price interpretation only when enough dated evidence exists
- Local shop and mandi comparison by location
- Shopping basket and list management
- Favorites
- Target-price alerts
- Receipt checking and line-item math
- MRP and hidden-cost calculators
- Shrinkflation/effective-unit-price analysis
- Merchant/source pages
- Source coverage and connector health
- Map-based local market discovery
- Mobile-first responsive UI and reduced-motion support
- PWA install/offline shell
- Account/profile support through Supabase Auth

## Data channels
- Consumer Affairs official reference snapshots
- data.gov.in / AGMARKNET / e-NAM where permitted
- Verified community observations
- Authorized merchant/affiliate APIs and feeds
- User-provided product URLs as a permitted observation input

## Required integrity rules
- Show observed date/time and source for every price observation.
- Never represent a stale snapshot as live.
- Never invent a local or online quote when evidence is missing.
- Keep licensed/authorized feeds separate from user-submitted observations.
- Store raw observation metadata for auditability.

## Online connector architecture
PriceAtlas should use a server-side connector layer. Secrets must never be shipped to browser JavaScript. Amazon India should use the current Creators API, not the deprecated PA-API 5 flow. The connector layer should normalize each merchant into one offer shape and persist observations into Supabase.

## Advanced analytics
- price trend and volatility
- market-vs-online spread
- cheapest observed offer by normalized unit
- delivery/shipping/coupon-adjusted effective price when supplied by the source
- stale-data detection
- outlier detection
- source freshness and coverage indicators
- change logs for catalog and connector updates

## Future-proof scale
The catalog model targets 1,000,000+ product variants through ingestion and normalization rather than hardcoding one million records in the UI.
