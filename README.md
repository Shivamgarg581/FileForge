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
