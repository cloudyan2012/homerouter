#这样可以获取完整的天猫精灵回掉请求，试过只用read或tee的话不行
  read -n $CONTENT_LENGTH POST_DATA <&0
  IFS='=&'
  set -- $POST_DATA
  post_req=$(echo "$POST_DATA"| sed 's/,/\n/g' | grep "intentName"| sed 's/:/\n/g'| sed '1d'|sed 's/"//g')
