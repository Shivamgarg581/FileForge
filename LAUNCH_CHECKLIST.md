# BuyRight launch checklist

This branch is production-oriented and contains no illustrative local shop prices. The public app uses the dated official snapshot in `data/official-prices.json`; local observations remain empty until a real submission is verified.

## Before broad promotion

- [ ] Merge `production-rebuild` into `main`.
- [ ] Keep GitHub Pages enabled from the `main` branch root.
- [ ] Confirm the existing CNAME is intentional before launch.
- [ ] Run **Sync official prices** manually from GitHub Actions.
- [ ] Confirm the official dataset date changed/was revalidated successfully.
- [ ] Submit one real local observation through the public report form.
- [ ] Review the issue for privacy and factual quality.
- [ ] Add the `verified-price` label only after verification.
- [ ] Run **Build verified community prices** manually once.
- [ ] Confirm the verified observation appears on the site.
- [ ] Protect `main` with branch rules and required checks.
- [ ] Enable repository secret scanning and push protection where available.
- [ ] Add uptime monitoring before large-scale promotion.

## Monetization launch

- [ ] Join Amazon Associates and create current Creators API access.
- [ ] Join Flipkart Affiliate and configure approved tracking/deep links.
- [ ] Add merchant affiliate links only where the source/program permits them.
- [ ] Apply for Google AdSense when the site has sufficient original content and meets eligibility requirements.
- [ ] Add the exact AdSense publisher ID to `ads.txt` after approval.
- [ ] Keep ads visually distinct from PriceAtlas navigation, product cards and interactive controls.
- [ ] Never ask users to click ads or generate artificial ad impressions/clicks.
- [ ] Clearly disclose affiliate relationships.

## Important

PriceAtlas uses only two revenue channels: affiliate commission and Google AdSense. Commercial links do not alter price evidence or comparison calculations.
