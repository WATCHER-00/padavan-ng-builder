# script is run before the build
# e.g.:
# sudo apt install <pkg>
#!/usr/bin/env bash
set -euo pipefail

THEMES_DIR="themes"
TARGET_DIR="padavan-ng/trunk/user/www/n56u_ribbon_fixed"

echo "::group::Applying custom themes"

if [[ ! -d "$THEMES_DIR" ]]; then
    echo "❌ Themes directory '$THEMES_DIR' not found, skipping"
    echo "::endgroup::"
    exit 0
fi

if [[ ! -d "$TARGET_DIR" ]]; then
    echo "❌ Target directory '$TARGET_DIR' not found, skipping"
    echo "::endgroup::"
    exit 0
fi

for theme in blue2-theme common-theme grey2-theme; do
    src="$THEMES_DIR/$theme"
    if [[ -d "$src" ]]; then
        echo "Copying $theme -> $TARGET_DIR/$theme"
        cp -r "$src" "$TARGET_DIR/"
    else
        echo "⚠️  Theme folder '$src' not found, skipping"
    fi
done

if [[ -f "$THEMES_DIR/jquery.js" ]]; then
    echo "Replacing jquery.js"
    cp -f "$THEMES_DIR/jquery.js" "$TARGET_DIR/jquery.js"
else
    echo "⚠️  '$THEMES_DIR/jquery.js' not found, skipping"
fi

echo "::endgroup::"
