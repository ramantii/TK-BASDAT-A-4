from django.db import connections
from psycopg2.extras import RealDictCursor

def run_query(query):
    conn = connections['default']
    conn.ensure_connection()
    cur = conn.connection.cursor(cursor_factory=RealDictCursor)
    cur.execute("SET SEARCH_PATH TO THECIMS;")
    cur.execute(query)
    conn.commit()

    cur.close()
    conn.close()