from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver import Keys, ActionChains
import time

options = Options()
#options.add_argument("--headless=new")
driver = webdriver.Chrome(options=options)
driver.get('https://therokuchannel.roku.com/')
time.sleep(4)
body = driver.find_element("tag name", "body") 
body.send_keys(Keys.ESCAPE)
time.sleep(2)
elem = driver.find_element(By.CLASS_NAME, 'css-1s3s188')
elem.click()
time.sleep(2)
print(driver.page_source)
driver.quit()