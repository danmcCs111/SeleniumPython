from selenium import webdriver
from selenium.webdriver.common.by import By
import time

driver = webdriver.Chrome()
driver.get('https://therokuchannel.roku.com/')
time.sleep(2)
elem = driver.find_element(By.CLASS_NAME, 'css-1s3s188')
elem.click()
time.sleep(2)
print(driver.page_source)
driver.quit()