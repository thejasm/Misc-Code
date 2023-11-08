from bs4 import BeautifulSoup
import os

# Set the directory where your HTML files are located
html_dir = r'C:\xampp\htdocs'

for root, dirs, files in os.walk(html_dir):
    for file in files:
        if file.endswith(".html"):
            file_path = os.path.join(root, file)
            
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()

            soup = BeautifulSoup(content, 'html.parser')

            for picture in soup.find_all('picture'):
                source = picture.find('source', type='image/avif')
                img = picture.find('img')

                if source and img:
                    avif_filename = os.path.splitext(os.path.basename(img['src']))[0] + '.avif'
                    source['srcset'] = f'images/{avif_filename}'
            
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(str(soup))
            
            print(f'Edited {file_path}')