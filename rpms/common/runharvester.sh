#!/bin/sh
su apache <<'EOF'
  /opt/data/ckan/pyenv/bin/paster --plugin=ckanext-harvest harvester run --config=/etc/kata.ini >/dev/null 2>&1
EOF
