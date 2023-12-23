from webdriver_manager.chrome import ChromeDriverManager
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
import json
import time

chrome_options = Options()
chrome_options.add_argument("--headless")
chrome_options.add_argument("--disable-gpu")
chrome_options.add_argument(
    "user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36")

driver = webdriver.Chrome(ChromeDriverManager().install(),options=chrome_options)

def scrape_videos(channel_url):
    driver.get(channel_url)
    time.sleep(5)

    videos = driver.find_elements(By.XPATH, '//*[@id="video-title"]')
    data = []

    for video in videos[:10]:
        title = video.get_attribute('title')
        url = video.get_attribute('href')
        video_id = url.split("v=")[-1]
        thumbnail_url = f'https://img.youtube.com/vi/{video_id}/maxresdefault.jpg'

        decoded_title = title.encode().decode('unicode_escape')

        data.append({
            "title": decoded_title,
            "url": url,
            "thumbnail_url": thumbnail_url,
            "video_id": video_id
        })

    return data

channel_url = 'https://www.youtube.com/@Fireship'
video_data = scrape_videos(channel_url)

with open('youtube_videos.json', 'w') as file:
    json.dump(video_data, file, indent=4)

driver.quit()
