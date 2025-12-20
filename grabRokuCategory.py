from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver import Keys, ActionChains
import time
import sys

def enterUrl(driver, url):
    driver.get(url)
    time.sleep(5)
    print(driver.page_source)
    body = driver.find_element("tag name", "body") 
    return body

def scrollDown(body):
    body.send_keys(Keys.ESCAPE)
    for i in range(7):
        body.send_keys(Keys.PAGE_DOWN)
        time.sleep(1)
    time.sleep(5)

if __name__ == "__main__":
    url = sys.argv[1]
    print(url)
    options = Options()
    #options.add_argument("--headless=new")
    driver = webdriver.Chrome(options=options)
    body = enterUrl(driver, url)
    scrollDown(body)
    print(driver.page_source)
    driver.quit()