#!/usr/bin/env python
"""Test that we can connect to the database"""

import sys
import psycopg2

try:
    psycopg2.connect("host='database' port=5432 user='aiida' password='password' dbname='aiida_db'")
except Exception as error:  # pylint: disable=broad-except
    print("failed: ", error)
    sys.exit(1)

print("succeeded")
sys.exit(0)
