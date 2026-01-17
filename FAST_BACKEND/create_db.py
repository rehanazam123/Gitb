# create_db.py
from app.core.container import Container
import sys, traceback
def main():
    try:
        c = Container()
        db = c.db()
        print("Creating DB schema (if not exist)...")
        db.create_database()
        print("Schema creation completed.")
    except Exception as e:
        print("Error creating DB schema:", e)
        traceback.print_exc()
        sys.exit(1)

if __name__ == "__main__":
    main()
