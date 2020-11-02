// dependencies
const AWS = require('aws-sdk');
const util = require('util');

// get reference to S3 client
const s3 = new AWS.S3();

exports.handler = async (event, context, callback) => {

    // Read options from the event parameter.
    console.log("Reading options from event:\n", util.inspect(event, {depth: 5}));
    const srcBucket = event.Records[0].s3.bucket.name;
    // Object key may have spaces or unicode non-ASCII characters.
    const srcKey    = decodeURIComponent(event.Records[0].s3.object.key.replace(/\+/g, " "));
    
    console.log("objectName:Bucketname = "+srcBucket);
    console.log("objectName:srcKey = "+srcKey);
    
     var params = {
        Bucket: "cmg-test-one-cmg",
        CopySource: "/"+srcBucket+"/"+srcKey,
        Key : srcKey
     }
    const result = await s3.copyObject(params).promise();
  
};