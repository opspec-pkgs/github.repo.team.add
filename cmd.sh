#!/usr/bin/env sh

set -e

cat > body <<EOF
{
  "permission": "$permission"
}
EOF

statusCode=$(curl \
    --silent \
    --output \
    /dev/stderr \
    --write-out "%{http_code}" \
    -X PUT "https://api.github.com/teams/${teamId}/repos/${org}/${repo}" \
    --header "Authorization: token ${accessToken}" \
    -d @body)

if test "$statusCode" -ne 204; then
exit 1
fi