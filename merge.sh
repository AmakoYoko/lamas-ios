#!/bin/bash
# Fusionne les sources de apps.txt en une seule source SideStore « Lamas » (source.json).
set -euo pipefail
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
i=0
grep -vE '^\s*(#|$)' apps.txt | while read -r url; do
  i=$((i+1)); curl -fsSL "$url" -o "$tmp/$i.json" || echo "source injoignable : $url" >&2
done
jq -s '{
  name: "Lamas", identifier: "one.lamas.source.all", subtitle: "Applis de Lamas Suite",
  iconURL: "https://courrier.lamas.one/ios/icon.png",
  apps: (map(.apps) | add | unique_by(.bundleIdentifier)), news: []
}' "$tmp"/*.json > source.json.new
# garde l'ancienne source si une appli a disparu faute de réponse
old=$(jq '.apps | length' source.json 2>/dev/null || echo 0); new=$(jq '.apps | length' source.json.new)
if [ "$new" -lt "$old" ]; then echo "moins d'applis qu'avant ($new < $old) : source inchangée" >&2; rm source.json.new; exit 0; fi
mv source.json.new source.json
