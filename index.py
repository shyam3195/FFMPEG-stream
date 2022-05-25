import pymongo # For Mongo DB operation
import json # For JSON operation, because the metadata for video is in json format

meta_data_file_name = 'output_file.json'

# Opening the metadata json file and store it as dictionary
with open(meta_data_file_name) as json_file:
    data = json.load(json_file)

# Connecting to local pymongo which is running in 27017
myclient = pymongo.MongoClient("mongodb://localhost:27017/")
# Creating database mydatabase if not exist
mydb = myclient["mydatabase"]
# Creating table hadoop if not exist
mycol = mydb["hadoop"]

# Insert Json data to the table named hadoop
x = mycol.insert_one(data)