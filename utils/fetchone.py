from django.db import connections
from psycopg2.extras import RealDictCursor

def fetch_one_query(query):
    conn = connections['default']
    conn.ensure_connection()
    cur = conn.connection.cursor(cursor_factory=RealDictCursor)
    cur.execute("SET SEARCH_PATH TO THECIMS;")
    cur.execute(query)
    result = cur.fetchone()
    result = dict(result)
    conn.commit()
    
    cur.close()
    conn.close()

    return result