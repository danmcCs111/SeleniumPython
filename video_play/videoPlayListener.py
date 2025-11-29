from selenium import webdriver
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
        
    print(f"line: {line}")
    testVideoPlay.open_and_play(driver, line)
    print(f"You entered: {line}")
    print("video launch finished finished.")

if __name__ == "__main__":
    driver = webdriver.Chrome()
    while True:
        print_term(driver)

