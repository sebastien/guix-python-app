from aiohttp import web
from datetime import datetime
import asyncio


async def handle_ping(request):
    """Handles the API ping request."""
    return web.Response(text=f"OK {datetime.now().isoformat()}\n", headers={'Content-Type': 'text/event-stream'})


def app_factory():
    """Creates the AIOHTTTP Web server"""
    app = web.Application()
    app.add_routes([
        web.get('/ping', handle_ping),
    ])
    return app


async def run_sever_async(host: str = "0.0.0.0", port: int = 8000):
    """Runs the async web server"""
    runner = web.AppRunner(app_factory())
    site = web.TCPSite(runner, host, port)
    print(f"guix-python-app: Runing server on {host}:{port}")
    print(f">> try: curl http://{host}:{port}/ping")
    await site.start()


def run_server(**options):
    """Runs the server synchronously"""
    loop = asyncio.get_event_loop()
    loop.set_exception_handler(async_exception_handler)
    loop.create_task(run_server_async(**options))
    loop.run_forever()


run_server()
