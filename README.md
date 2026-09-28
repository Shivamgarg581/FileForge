# PriceAtlas — evidence-aware price intelligence

PriceAtlas is an India-first public price intelligence application. It separates published official reference data, verified local observations, derived calculations and uncertainty.

## Launch stack
- GitHub Pages public frontend
- Versioned JSON datasets
- GitHub Actions scheduled data refresh
- Static, mobile-first application
- No browser-side API secrets

## Current official data
The bundled reference snapshot is from the Department of Consumer Affairs Price Monitoring System and carries its observation date in the dataset. It is a national reference, not a claim about every local shop.

## Local observations
Local reports enter through the structured GitHub issue form. Only reports verified by a maintainer are exported to the public local dataset.

## Core features
- Search with English + common Hindi aliases
- Official retail and wholesale references
- Dated history
- Change pulse
- Price status based on available history
- True unit price comparison
- Reference basket calculator
- MRP checker
- Hidden-cost calculator
- Receipt arithmetic
- Shrinkflation/effective unit price
- Community price-report workflow
- Offline shell

## Important truth rule
The frontend never invents a local price. A missing local observation remains unknown. A dated official snapshot is displayed with its date and source.

## Local run
`python -m http.server 8080`
Then open `http://localhost:8080`.

## Deployment
The repository is currently configured around GitHub Pages. Deploy the `production-rebuild` branch for review, then merge after validation.

## Security
See `SECURITY.md` for the defense-in-depth architecture and the boundary between the static launch and future backend-only controls.

## Monetization model

PriceAtlas uses exactly two revenue channels:

### 1. Affiliate commission
PriceAtlas can send users to authorized merchant/affiliate links such as Amazon India and Flipkart. The site earns a referral/advertising fee when qualifying purchases are attributed to those links. Amazon requires an Associates account and current Creators API access for API-based product integrations; PA-API 5 has been deprecated. citeturn132989search1turn132989search7 Flipkart publishes category-specific affiliate rates and provides affiliate tools/APIs. citeturn132989search0turn132989search10

### 2. Google AdSense
PriceAtlas can monetize eligible pages with Google AdSense. Google requires publishers to have their own original, high-quality content and meet AdSense policies; current eligibility guidance also requires the publisher to be 18 or over. citeturn132989search2turn132989search3

No paid merchant listings, subscriptions, sponsored placements or other revenue channels are part of the PriceAtlas business model.

Commercial links and ads must remain clearly separate from source evidence and price calculations. The price engine must not change a comparison result because a merchant pays an affiliate commission.
