def lambda_handler(event,context):
    msg = 'Hello {} !'.format(event['key1'])
    return {
        'message' : msg
    }