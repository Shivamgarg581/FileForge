# PriceAtlas — Full Platform Blueprint

## Product promise
PriceAtlas is a price intelligence and comparison platform for India. A product can be compared across:
- local verified shops
- official retail/wholesale references
- mandi/APMC observations
- online merchant observations
- historical observations

Every displayed price retains channel, source and observation date.

## Catalog
Target: 100,000+ product records at launch architecture level, with continued growth.

### Product domains
Grocery, vegetables, fruits, dairy, bakery, snacks, beverages, meat/seafood, household, personal care, baby care, pet care, medicines/health, stationery/books, clothing, footwear, electronics, appliances, mobile accessories, automotive, fuel/energy, construction/hardware, gardening/agriculture, furniture/home, sports/fitness, travel/luggage, office/business, services.

### Product identity
canonical product → brand → variant → pack size → unit → identifiers (GTIN/EAN/UPC/ASIN/ISBN/MPN/SKU where licensed).

Catalog existence never implies price availability.

## Price channels
1. Official retail
2. Official wholesale
3. Mandi/APMC
4. Local shop
5. Online merchant
6. Community observation

Do not merge channel semantics.

## Online comparison
Supported merchant patterns include:
- official APIs
- affiliate feeds
- licensed feeds
- permitted product URLs
- user-provided product links

Possible Indian merchant coverage:
Amazon India, Flipkart, BigBasket, JioMart, Blinkit, Zepto, Swiggy Instamart, Myntra, Croma, Reliance Digital, DMart Ready and other sources when permitted.

## Local market network
- market directory
- shop directory
- merchant onboarding
- verified price submissions
- moderation
- location-aware discovery
- price freshness
- evidence/source label

## Intelligence
- current vs historical
- min/max/average/median
- 7/30/90/365-day windows
- normalized unit price
- offer price vs MRP
- effective price after shipping/coupon
- trend and volatility
- price-drop alerts
- basket optimization
- market/merchant comparison
- anomaly/surprise detection

## User features
- account
- favorites
- shopping lists
- saved searches
- price alerts
- receipt upload/verification
- barcode/GTIN lookup
- reviews
- language preferences
- optional city/market selection

## Merchant features
- merchant profile
- local store locator
- product/price upload
- verification
- offer history
- analytics
- correction workflow

## Admin
- product catalog moderation
- duplicate merge
- source health
- price anomaly queue
- merchant verification
- report moderation
- audit log
- data quality dashboard
- import/export

## UX
- mobile-first
- desktop dashboard
- fast search
- product intelligence page
- map/market discovery
- comparison tables
- compact cards
- PWA/offline shell
- reduced-motion support
- accessible navigation

## Data truth rules
- Never fabricate a local shop price.
- Never label a stale price “live”.
- Never compare incompatible quantities without normalization.
- Never treat a search result or catalog entry as evidence of current price.
- Preserve source URL/name and observation timestamp.
- Keep uncertainty visible.

## Security
Private user data must remain behind authenticated backend/RLS boundaries. Public static pages can expose only public datasets. Secrets never enter frontend bundles.
