from selenium import webdriver
from selenium.webdriver import Keys, ActionChains
from selenium.webdriver.common.by import By
import time


def open_and_play(driver, url):
    driver.get(url)
    
def send_key(driver, key):
    page_element=driver.find_element(By.ID, "content")
    ActionChains(driver).send_keys_to_element(page_element, key).perform()
