import psycopg2
import sys
import boto3
import os

ENDPOINT="python-rds-demo.c1relqosvmae.eu-central-1.rds.amazonaws.com"
PORT="5432"
USER="demo"
REGION="eu-central-1"
DBNAME="demo"

#gets the credentials from .aws/credentials
session = boto3.Session(profile_name='RDSCreds')
client = session.client('rds')

token = client.generate_db_auth_token(DBHostname=ENDPOINT, Port=PORT, DBUsername=USER, Region=REGION)

try:
    conn = psycopg2.connect(host=ENDPOINT, port=PORT, database=DBNAME, user=USER, password=token, sslrootcert="SSLCERTIFICATE")
    cur = conn.cursor()
    print("PostgreSQL server information")
    print(conn.get_dsn_parameters(), "\n")
    # Executing a SQL query
    cur.execute("SELECT version();")
    # Fetch result
    record = cur.fetchone()
    print("You are connected to - ", record, "\n")
except Exception as e:
    print("Database conn failed due to {}".format(e))
