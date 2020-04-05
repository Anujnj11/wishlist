from apscheduler.schedulers.blocking import BlockingScheduler
import userWishScrape

sched = BlockingScheduler()


@sched.scheduled_job('interval', minutes=5)
def timed_job():
    print('This job is run every three minutes.')


@sched.scheduled_job('interval', minutes=60)
def scrape_wish():
    print('Getting wishlist price.')
    userWishScrape.get_active_wish()


sched.start()
