#!/bin/bash

text=$( curl -s "https://news.google.com/rss?hl=ko&gl=KR&ceid=KR:ko" | xq -r .rss.channel.item[].title | rev | cut -d'-' -f2- | rev )

#text=$( echo "${text}" | sed -e "s/“/\"/g" -e "s/”/\"/g"  )
#text=$( echo "${text}" | sed -e "s/'/\\\'/g" -e 's/"/\\"/g' )
#text=$( echo "${text}" | sed -e "s/\//\\//g" )
#text=$( echo "${text}" | sed 's/$'"/`echo \\\r`/g" )
#echo "${text}"

numOfLines=$( echo "${text}" | wc -l)
leng=$( echo "${text}" | wc -m )

while [ ${leng} -ge 1200 ]
do
        numOfLines=$((numOfLines-1))

        text=$( echo "${text}" | head -n ${numOfLines} )

        leng=$( echo ${text} | wc -m )
done

text=$( echo "${text}" | head -n 4 )
text=$( echo "${text}" |  tr '\n' ';')
echo "${text}"

#encoded=$( jq -rn --arg x "${text}" '$x|@uri' )
#echo "${encoded}"

rm bongOCookie

curl -vv -s --cookie-jar bongOCookie --proxy '59.29.245.151:3128' 'http://www.airforce.mil.kr:8081/user/indexSub.action?codyMenuSeq=156893223&siteId=last2&menuUIType=sub&dum=dum&command2=getEmailList&searchName=%EB%AC%B8%EB%B4%89%EC%98%A4&searchBirth=19971012&memberSeq=245273926' \
  -H 'Connection: keep-alive' \
  -H 'Cache-Control: max-age=0' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Referer: http://www.airforce.mil.kr:8081/user/indexSub.action?codyMenuSeq=156893223&siteId=last2&menuUIType=sub&dum=dum&' \
  -H 'Accept-Language: ko-KR,ko;q=0.9,zh-CN;q=0.8,zh;q=0.7,en-US;q=0.6,en;q=0.5' \
  --compressed \
  --insecure > /dev/null

curl -vv --cookie bongOCookie --proxy '59.29.245.151:3128' 'http://www.airforce.mil.kr:8081/user/emailPicSaveEmail.action' \
  -H 'Connection: keep-alive' \
  -H 'Cache-Control: max-age=0' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'Origin: http://www.airforce.mil.kr:8081' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9' \
  -H 'Accept-Language: ko-KR,ko;q=0.9,zh-CN;q=0.8,zh;q=0.7,en-US;q=0.6,en;q=0.5' \
  --data-raw 'siteId=last2&parent=%252Fuser%252FindexSub.action%253FcodyMenuSeq%253D156893223%2526siteId%253Dlast2%2526menuUIType%253Dtop%2526dum%253Ddum%2526command2%253DwriteEmail%2526searchCate%253D%2526searchVal%253D%2526page%253D1&page=1&command2=writeEmail&searchCate=&searchVal=&letterSeq=&memberSeq=245273926&senderZipcode=16675&senderAddr1=%EA%B2%BD%EA%B8%B0%EB%8F%84+%EC%88%98%EC%9B%90%EC%8B%9C+%EC%98%81%ED%86%B5%EA%B5%AC+%EC%8B%A0%EC%9B%90%EB%A1%9C+280&senderAddr2=%EA%B8%80%EB%A1%9C%EB%B2%8C%ED%83%80%EC%9A%B4+109%EB%8F%99+604%ED%98%B8&senderName=%EB%B0%95%EB%8F%84%ED%98%84&relationship=%EC%B9%9C%EA%B5%AC&title=%EC%95%88%EB%85%95+%EB%B4%89%EC%98%A4%EC%95%BC&contents='"${text}"'&password=3983' \
  --compressed \
  --insecure

rm bongOCookie
