if [ $# -gt 0 ]
then
    tradeid=$1
else
    tradeid="2ks89j9"
fi

JWT=$(jq '.token' userCred.json)
if [ ${JWT:0:1} == "\"" ]
then
	JWT=${JWT:1}
fi
let "JLEN = ${#JWT} - 1"
if [ ${JWT:$JLEN:1} == "\"" ]
then
	JWT=${JWT:0:$JLEN}
fi
CC=$(curl -s -X POST http://localhost:4000/chaincode/issueEL -H "content-type: application/json" -H "authorization: Bearer $JWT" -d '{ "ccversion": "v0", "args": ["'"$tradeid"'", "AX1Bwx5qlmh0", "2020-12-14"] }')
JWT=$(echo $CC | jq '.success')
if [ $JWT == true ]
then
	echo "SUCCESS: "$(echo $CC | jq '.message')
else
	echo "FAILURE: "$(echo $CC | jq '.message')
fi
