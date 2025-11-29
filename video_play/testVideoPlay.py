from selenium import webdriver
from selenium.webdriver import Keys, ActionChains
from selenium.webdriver.common.by import By
import time

def open_and_play(driver, url):
    driver.get(url)
    time.sleep(5)
    page_element=driver.find_element(By.ID, "content")
    ActionChains(driver).send_keys_to_element(page_element, Keys.SPACE).perform()
    time.sleep(20)

driver = webdriver.Chrome()
open_and_play(driver, 'https://tubitv.com/movies/100002844/zola')
open_and_play(driver, 'http://tubitv.com/movies/652136/zoe-gone')

print(driver.page_source)
driver.quit()