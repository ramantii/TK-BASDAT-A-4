from django.db import connections
from psycopg2.extras import RealDictCursor

def fetch_all_query(query):
    conn = connections['default']
    conn.ensure_connection()
    cur = conn.connection.cursor(cursor_factory=RealDictCursor)
    cur.execute("SET SEARCH_PATH TO THECIMS;")
    cur.execute(query)
    result = cur.fetchall()
    conn.commit()

    cur.close()
    conn.close()

    result = [dict(row) for row in result]
    return result