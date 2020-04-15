import requests
import urllib.request
import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from datetime import datetime
from selenium.webdriver.common.by import By
import re
import os


# def startWith(masterWebsite, url):
#     chrome_options = webdriver.ChromeOptions()
#     chrome_options.binary_location = os.environ.get("GOOGLE_CHROME_BIN")
#     chrome_options.add_argument("--headless")
#     chrome_options.add_argument("--disable-dev-shm-usage")
#     chrome_options.add_argument("--no-sandbox")
#     driver = webdriver.Chrome(chrome_options=chrome_options,
#                               executable_path=os.environ.get("CHROMEDRIVER_PATH"))
#     return process_price(driver, masterWebsite, url)


def startWith(masterWebsite, url):
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument("--headless")
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument("--disable-dev-shm-usage")
    # chrome_options.add_argument('--disable-gpu')
    # chrome_options.add_argument("--window-size=1920x1080")
    chrome_driver = '/home/anuj/Pictures/Anuj/Office Code/wishlist/scripts/chromedriver_linux1'
    # chrome_driver = '.chromedriver_linux1'

    driver = webdriver.Chrome(
        chrome_options=chrome_options, executable_path=chrome_driver)
    # driver = webdriver.Chrome(
        # executable_path='/usr/bin/chromedriver', options=chrome_options)

    # driver = webdriver.Chrome(chrome_options=chrome_options,executable_path="/usr/bin/chromedriver")
    return process_price(driver, masterWebsite, url)


def process_price(driver, masterWebsite, url):
    try:
        driver.get(url)
        return extract_info(driver, masterWebsite)
    except Exception as err:
        print(err)
        return ''
    finally:
        driver.quit()


def extract_info(driver, masterWebsite):
    product_info = {"image": "", "price": "", "rating": ""}
    product_info["price"] = get_price(driver, masterWebsite)
    product_info["image"] = get_images(driver, masterWebsite)
    product_info["rating"] = get_rating(driver, masterWebsite)
    product_info["productName"] = get_productName(driver, masterWebsite)

    return product_info


def get_price(driver, masterWebsite):
    try:
        if masterWebsite.priceClass:
            price = driver.find_element_by_class_name(masterWebsite.priceClass)
        else:
            price = driver.find_element_by_id(masterWebsite.priceId)
        price = price.text
        price = re.findall(r"[0 -9]+", price)
        temp_price = ""
        for p in price:
            if "." in p:
                temp_p = re.findall(r".*(?=\.)", p)
                temp_p = len(temp_p) and temp_p[0]
            else:
                temp_p = p
            temp_price = re.sub("\\W+", '', temp_p)
            if temp_price:
                break
        return re.sub("\\W+", '', temp_price)
    except Exception as err:
        print(err)
        return ""


def get_images(driver, masterWebsite):
    try:
        temp_images = driver.find_element_by_class_name(
            masterWebsite.imagesClass)
        images = temp_images.find_element_by_tag_name('img').get_attribute(
            'src') or temp_images.find_element_by_tag_name('img').get_attribute('data-src')
        return images
    except Exception as err:
        print(err)
        return ""


# def parse_style_attribute(style_string):
#     if 'background-image' in style_string:
#         style_string = style_string.split(' url("')[1].replace('");', '')
#         return style_string
#     return None


def get_rating(driver, masterWebsite):
    try:
        rating = driver.find_element_by_class_name(masterWebsite.ratingClass)
        if rating:
            rating = rating.get_attribute("innerHTML")
            # rating = re.findall("\\d+\\.\\d+", rating)
            rating = re.findall("\\d*[.,]?\\d*", rating)
            rating = len(rating) and rating[0]
        return rating
    except Exception as err:
        print(err)
        return ""


def get_productName(driver, masterWebsite):
    try:
        if masterWebsite.nameClass:
            name = driver.find_element_by_class_name(masterWebsite.nameClass)
        else:
            name = driver.find_element_by_id(masterWebsite.nameId)

        name = name.text
        return name
    except Exception as err:
        print(err)
        return ""
