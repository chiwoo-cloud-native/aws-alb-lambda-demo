exports.lambdaHandler = async (event, context, callback) => {
    console.log("Called lambdaHandler: helloworld")

    var response = {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": JSON.stringify({message: 'OK'}),
        "isBase64Encoded": false
    };

    callback(null, response);
};
