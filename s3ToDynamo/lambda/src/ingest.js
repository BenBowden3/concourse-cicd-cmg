const AWS = require('aws-sdk')
const readline = require('readline')

const config = require('./config.json')
const s3 = new AWS.S3()
const sqs = new AWS.SQS()

// Transforms a line into a JSON object
function transformLine(line) {
  // CSV format: id,type,val1,val2,val3...
  const fields = line.split(',')
  return {
    id: fields[0],
    timestamp: Date.now(),
    recordType: fields[1],
    values: fields.slice(2),
  }
}

async function sendToQueue(record) {
  const params = {
    MessageBody: JSON.stringify(record),
    QueueUrl: config.write_lambda_queue.value,
  }
  await sqs.sendMessage(params).promise()
}

async function processFile(record) {
  const params = {
    Bucket: record.s3.bucket.name,
    Key: record.s3.object.key,
  }

  await new Promise((resolve, reject) => {
    const readStream = s3.getObject(params).createReadStream()
    const rl = readline.createInterface({ input: readStream })

    rl.on('line', async (line) => {
      // Turn the line into a JSON object
      record = transformLine(line)

      // Send it to SQS queue
      await sendToQueue(record)
    })

    rl.on('close', resolve)
    rl.on('error', reject)
    readStream.on('error', reject)
  })

  // Remove the file from S3
  await s3.deleteObject(params).promise()
}

async function handler(event) {
  // processRecord called for each record in the event.  Wait for all records to be processed.
  await Promise.all(event.Records.map(processFile))
}

module.exports.handler = handler
