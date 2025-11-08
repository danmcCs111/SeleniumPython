from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import sys

url=sys.argv[0]
print(sys.argv[0])

driver = webdriver.Chrome()
driver.get(url)
time.sleep(3)
print(driver.page_source)
driver.quit()