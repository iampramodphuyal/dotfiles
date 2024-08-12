import base64
import argparse


def base64_encode(data):
    return base64.b64encode(data.encode()).decode()

def base64_decode(data):
    return base64.b64decode(data.encode()).decode()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Encode or decode base64')
    parser.add_argument('operation', choices=['encode','-e', 'decode', '-d'], help='encode or decode operation')
    parser.add_argument('data', help='Actual data to process')

    args = parser.parse_args()

    if args.operation == 'encode' or args.operation == '-e':
        print(base64_encode(args.data))
    elif args.operation == 'decode' or args.operation == '-d':
        print(base64_decode(args.data))
    else:
        print("Not a valid operation provided")
