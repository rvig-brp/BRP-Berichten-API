cut -d '.' -f2 token.b64 \
  | tr '_-' '/+' \
  | awk '{ l=length($0)%4; if (l==2) printf "%s==", $0; else if (l==3) printf "%s=", $0; else printf "%s", $0 }' \
  | base64 -d \| jq
