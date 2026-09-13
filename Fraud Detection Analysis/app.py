from fastapi import FastAPI
from fastapi.responses import HTMLResponse, FileResponse
from fastapi.staticfiles import StaticFiles
import uvicorn
import sqlite3
import os

app = FastAPI(
    title="Fraud Detection API",
    description="Backend API for the Transactional Fraud Detection Dashboard",
    version="1.0.0"
)

# You can mount a static directory if you have CSS/JS files
# app.mount("/static", StaticFiles(directory="static"), name="static")

@app.get("/", response_class=HTMLResponse)
async def serve_dashboard():
    """Serves the static dashboard.html file"""
    dashboard_path = os.path.join(os.path.dirname(__file__), "dashboard.html")
    if os.path.exists(dashboard_path):
        return FileResponse(dashboard_path)
    return "<h1>Fraud Detection API</h1><p>Dashboard file not found. Please ensure dashboard.html exists.</p>"

@app.get("/api/health")
async def health_check():
    """Simple health check endpoint for Render"""
    return {"status": "ok", "message": "API is running"}

@app.get("/api/stats")
async def get_database_stats():
    """Example endpoint to fetch data from the SQLite database"""
    db_path = os.path.join(os.path.dirname(__file__), "transactions.db")
    if not os.path.exists(db_path):
        return {"error": "Database not found. Please run the SQL pipeline first."}
        
    try:
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()
        
        # We assume a table named 'transactions' exists based on the project context
        # This is just an example. You may need to update the table name to match your DB schema
        cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
        tables = cursor.fetchall()
        
        stats = {"tables": [t[0] for t in tables]}
        return {"status": "success", "data": stats}
    except Exception as e:
        return {"status": "error", "message": str(e)}
    finally:
        if 'conn' in locals():
            conn.close()

if __name__ == "__main__":
    # This block allows you to run the script locally via `python app.py`
    # Render will typically use a start command like `uvicorn app:app --host 0.0.0.0 --port $PORT`
    uvicorn.run("app:app", host="0.0.0.0", port=8000, reload=True)
