from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import sys

url=sys.argv[1]
print(sys.argv[1])

driver = webdriver.Chrome()
driver.get(url)
time.sleep(3)
print(driver.page_source)
driver.quit()