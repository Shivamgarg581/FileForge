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

PriceAtlas can monetize without compromising price neutrality by separating user-visible price intelligence from clearly labeled commercial links and placements.

### Revenue channels
1. Affiliate referrals: product cards can contain an "Open store" action using authorized Amazon India/Flipkart affiliate links and other merchant affiliate programs where available. Revenue is earned when a qualifying purchase is attributed to the affiliate account. Rates vary by category and can change.
2. Display advertising: AdSense can monetize eligible pages once the site/account meets Google's requirements. Ads should not be placed next to a price verdict in a way that makes a commercial relationship look like evidence.
3. Merchant subscriptions: verified local shops can pay for optional business features such as a profile, catalog import, analytics, offers and lead tools. Their paid status must never change the site's factual price evidence or ranking logic.
4. Sponsored placements: clearly labeled sponsored offers can be sold, but sponsored content must remain visually distinct from evidence-based comparisons.
5. Pro user subscription: optional features such as advanced alerts, larger shopping lists, exports, saved analysis, history depth and analytics can be packaged as a paid plan. Core public price evidence should remain accessible.
6. B2B data/API: an API or dashboard can be sold to businesses that need normalized price observations, trend data, market comparisons and source metadata, subject to the licenses/terms of each underlying source.

### Example unit economics
Assume 100,000 monthly visitors, 25% click-through to a merchant, and 2% of those clicks convert. That would be about 500 attributed orders. At an illustrative average commission of ₹40 per order, affiliate revenue would be about ₹20,000/month. This is only a scenario, not a forecast; actual conversion, basket size, commission rates and attribution vary by merchant and category.

A separate ad scenario of 1,000,000 monetized page impressions at an illustrative ₹80 RPM would be ₹80,000 gross ad revenue. Actual RPM varies substantially by audience, geography, ad demand, page type and policy compliance.

### Product rules
- Never sell a higher ranking in the neutral comparison result.
- Label affiliate links and sponsored placements.
- Keep commercial offers separate from source evidence.
- Show source, observation time and verification state for price facts.
- Never use one merchant's payment to manufacture or alter the price truth layer.
