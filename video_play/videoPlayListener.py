from selenium import webdriver
from selenium.webdriver import Keys
from selenium.webdriver.chrome.options import Options
import sys
import time
import testVideoPlay

def print_term(driver):
    print("Enter Videoname or 'Exit' to close")
    line = sys.stdin.readline().strip()
    
    if "exit" == line.lower():
        driver.quit()
        sys.exit()
    if "https://" not in line:
        line = "https://" + line
        
    print(f"video: {line}")
    testVideoPlay.open_and_play(driver, line)
    
    while True:
        print("")
        print("Enter 'P to play/pause' or 'f to fullscreen' ")
        print("or 'Exit' to return to main menu")
        line = sys.stdin.readline().strip()
        if "exit" == line.lower():
                break
        if "p" == line.lower():
            testVideoPlay.send_key(driver, Keys.SPACE)
        if "f" == line.lower():
            testVideoPlay.send_key(driver, "f")

if __name__ == "__main__":
    options = Options()
    options.add_argument("--disable-infobars")
    options.add_argument("--disable-notifications")
    options.add_experimental_option("excludeSwitches", ["enable-automation"])
    driver = webdriver.Chrome(options=options)
    while True:
        print_term(driver)

