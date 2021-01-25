if [ $# -eq 2 ]
then
        echo "Processing customized arguments."
        curl -s -X POST http://localhost:4000/login -H "content-type: application/x-www-form-urlencoded" -d "username=$1&orgName=$2" > userCred.json
else

        curl -s -X POST http://localhost:4000/login -H "content-type: application/x-www-form-urlencoded" -d 'username=Jim&orgName=importerorg' > userCred.json
fi
JWT=$(jq '.token' userCred.json)
if [ $JWT == null ]
then
        echo "Failed to login user Jim"
else
        echo "Successfully obtained user Jim login credentials. See 'userCred.json'."
fi
