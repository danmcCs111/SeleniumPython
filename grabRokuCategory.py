from selenium import webdriver
from selenium.webdriver.common.by import By
import time

driver = webdriver.Chrome()
driver.get('https://therokuchannel.roku.com/browse/w.2AljKal2x6FlR4aGJN3QT4RoK0QpmkhKopeAyK6gIDRY801Q9RtBqR2ekmywsBrwr/action')
time.sleep(3)
print(driver.page_source)
driver.quit()