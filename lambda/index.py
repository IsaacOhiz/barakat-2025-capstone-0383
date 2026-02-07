import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    try:
        for record in event['Records']:
            key = record['s3']['object']['key']
            print(f"Image received: {key}")
            logger.info(f"Image received: {key}")
        return { 'statusCode': 200, 'body': json.dumps('Image processed successfully!') }
    except Exception as e:
        logger.error(str(e))
        raise e