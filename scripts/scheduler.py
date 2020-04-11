# from apscheduler.schedulers.blocking import BlockingScheduler
from apscheduler.schedulers.background import BackgroundScheduler
import userWishScrape
import app
import time


def scrape_wish():
    print('Getting wishlist price.')
    userWishScrape.get_active_wish()


def print_date_time():
    print(time.strftime("%A, %d. %B %Y %I:%M:%S %p"))


sched = BackgroundScheduler(timezone="Asia/Kolkata")
sched.add_job(scrape_wish, 'interval', hours=1)
# sched.add_job(print_date_time, "interval", seconds=3)

sched.start()
