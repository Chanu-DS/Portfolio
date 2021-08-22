from bs4 import BeautifulSoup
import requests
import csv
source = requests.get('https://coreyms.com/').text
soup = BeautifulSoup(source,'lxml')

csv_file=open('C:/Users/Desktop/cms_scrape.csv','w')

csv_writer=csv.writer(csv_file)
csv_writer.writerow(['headline','summary','video_link'])
for article in soup.find_all('article'):
        
    headline=article.h2.a.text
    print(headline)
    summary=article.find('div',class_='entry-content').p.text
    print(summary)
    
    
    try:
        video_source=article.find('iframe',class_='youtube-player')['src']
        vid_id=video_source.split('/')[4]
        vid_id=vid_id.split('?')[0]

        ytb_link=f'https://youtube.com/watch?v={vid_id}'
    except Exception as e:
        ytb_link=None
    print(ytb_link)

    print('\n\n\n')

    csv_writer.writerow([headline,summary,ytb_link])
csv_file.close()

