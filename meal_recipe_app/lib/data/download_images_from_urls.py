# import re
# import os
# import shutil
# from icrawler.builtin import BingImageCrawler

# def fetch_fresh_meal_images(file_path):
#     # 1. Read the Dart file content
#     try:
#         with open(file_path, 'r', encoding='utf-8') as f:
#             content = f.read()
#     except FileNotFoundError:
#         print(f"Error: Could not find {file_path}. Please ensure it is in the same folder.")
#         return

#     # 2. Create a folder for the final images
#     final_output_folder = "assets_images"
#     if not os.path.exists(final_output_folder):
#         os.makedirs(final_output_folder)

#     # 3. Extract ID and Title (Ignoring the old imageURL)
#     # Regex looks for: id: 'm1', ... title: 'Masala Dosa'
#     pattern = re.compile(r"id:\s*'(.*?)'.*?title:\s*'(.*?)'", re.DOTALL)
#     matches = pattern.findall(meal_imageURL)

#     print(f"Found {len(matches)} meals. Starting search and download...\n")

#     # 4. Loop through each meal and fetch a NEW image
#     for meal_title, title in matches:
#         # Clean the title and add 'food dish' for better search results
#         clean_title = title.strip()
#         search_term = f"{clean_title} food dish"
        
#         print(f"Searching for: {clean_title} (ID: {meal_title})...")

#         # Use a temporary folder for the crawler
#         temp_dir = "temp_crawler"
        
#         # Configure the crawler (using Bing for reliable results)
#         crawler = BingImageCrawler(
#             feeder_threads=1,
#             parser_threads=1,
#             downloader_threads=1,
#             storage={'root_dir': temp_dir},
#             log_level='ERROR' # Suppress unnecessary output
#         )

#         # Download exactly 1 image
#         crawler.crawl(keyword=search_term, max_num=1)

#         # 5. Rename and move the file
#         try:
#             downloaded_files = os.listdir(temp_dir)
#             if downloaded_files:
#                 src_path = os.path.join(temp_dir, downloaded_files[0])
                
#                 # Create new filename: m1.jpg, m2.png, etc.
#                 extension = src_path.split('.')[-1]
#                 new_filename = f"{meal_title}.{extension}"
#                 dst_path = os.path.join(final_output_folder, new_filename)

#                 # Move and rename
#                 shutil.move(src_path, dst_path)
#                 print(f"  ✅ Saved as {new_filename}")
#             else:
#                 print(f"  ❌ No image found for {clean_title}")
#         except Exception as e:
#             print(f"  ⚠️ Error processing {clean_title}: {e}")

#         # Cleanup temp folder for the next iteration
#         if os.path.exists(temp_dir):
#             shutil.rmtree(temp_dir)

#     print(f"\n--- Process Complete ---")
#     print(f"Successfully downloaded images to the '{final_output_folder}' folder.")

# if __name__ == "__main__":
#     fetch_fresh_meal_images('meal_data.dart')



# import re
# import requests
# import os

# def download_meal_images_from_file(file_path):
#     # 1. Read the Dart file content
#     try:
#         # Read the file content
#         with open(file_path, 'r', encoding='utf-8') as f:
#             content = f.read()
#     except FileNotFoundError:
#         print(f"Error: Could not find {file_path}. Make sure it is in the same folder.")
#         return

#     # 2. Create a folder for the downloaded images
#     output_folder = "downloaded_meal_images"
#     if not os.path.exists(output_folder):
#         os.makedirs(output_folder)
#         print(f"Created output directory: '{output_folder}'")

#     # 3. Regex to find Meal blocks and extract ID, Title, and URL
#     # We look for the pattern: id: '...', then eventually title: '...', then finally imageURL: '...'
#     # re.DOTALL allows the dot (.) to match newlines
#     pattern = re.compile(r"id:\s*'(.*?)'.*?title:\s*'(.*?)'.*?imageURL:\s*'(.*?)'", re.DOTALL)
    
#     matches = pattern.findall(content)

#     print(f"\nFound {len(matches)} meals. Starting download from provided URLs...")

#     # Set a common User-Agent header to avoid being blocked by some servers
#     headers = {
#         'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
#     }

#     successful_downloads = 0
    
#     for meal_id, title, url in matches:
#         meal_id = meal_id.strip()
#         url = url.strip()

#         if not url:
#             print(f"Skipping {meal_id} ({title.strip()}): No URL found.")
#             continue

#         # 4. Determine file extension based on the URL (default to .jpg)
#         ext = 'jpg'
#         if '.png' in url.lower(): ext = 'png'
#         elif '.jpeg' in url.lower(): ext = 'jpeg'
#         elif '.gif' in url.lower(): ext = 'gif'
#         elif '.webp' in url.lower(): ext = 'webp'
        
#         # Create filename using the meal ID (e.g., m1.jpg, m2.png)
#         filename = f"{meal_id}.{ext}"
#         save_path = os.path.join(output_folder, filename)

#         try:
#             print(f"Downloading {meal_id} ({title.strip()})...")
#             # Fetch the image content
#             response = requests.get(url, headers=headers, timeout=15, allow_redirects=True)
            
#             if response.status_code == 200:
#                 # Write the binary content to the file
#                 with open(save_path, 'wb') as img_file:
#                     img_file.write(response.content)
#                 successful_downloads += 1
#                 print(f"  ✅ Saved as {filename}")
#             else:
#                 print(f"  ❌ Failed to download {meal_id} (Status: {response.status_code})")
                
#         except requests.exceptions.RequestException as e:
#             print(f"  ❌ Error downloading {meal_id}: {e}")
#         except Exception as e:
#             print(f"  ⚠️ An unexpected error occurred for {meal_id}: {e}")

#     print(f"\n--- Process Complete ---")
#     print(f"Successfully downloaded {successful_downloads} images to the '{output_folder}' folder.")

# if __name__ == "__main__":
#     download_meal_images_from_file('meal_data.dart')



# import re
# import requests
# import os
# import time

# def download_meal_images_from_file(file_path):
#     # 1. Read the Dart file content
#     try:
#         with open(file_path, 'r', encoding='utf-8') as f:
#             content = f.read()
#     except FileNotFoundError:
#         print(f"Error: Could not find {file_path}. Please ensure it is in the same folder.")
#         return

#     # 2. Create a folder for the downloaded images
#     output_folder = "downloaded_meal_images_with_titles"
#     if not os.path.exists(output_folder):
#         os.makedirs(output_folder)
#         print(f"Created output directory: '{output_folder}'")

#     # 3. Regex to extract ID, Title, and URL
#     # We look for the pattern: id: '...', then title: '...', then imageURL: '...'
#     pattern = re.compile(r"id:\s*'(.*?)'.*?title:\s*'(.*?)'.*?imageURL:\s*'(.*?)'", re.DOTALL)
    
#     matches = pattern.findall(content)

#     print(f"\nFound {len(matches)} meals. Starting download from provided URLs...")

#     # Set robust headers to mimic a web browser and avoid server blocks
#     headers = {
#         'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
#         'Accept': 'image/webp,image/apng,image/*,*/*;q=0.8',
#     }

#     successful_downloads = 0
    
#     for meal_id_raw, title_raw, url_raw in matches:
#         meal_id = meal_id_raw.strip()
#         title = title_raw.strip()
#         url = url_raw.strip()

#         if not url:
#             print(f"Skipping {meal_id} ({title}): No URL found.")
#             continue

#         # Clean title for filename (removes special characters and replaces spaces with underscores)
#         clean_title = re.sub(r'[^\w\s-]', '', title).strip().replace(' ', '_')
        
#         # 4. Determine file extension based on the URL (default to .jpg)
#         ext = 'jpg'
#         if '.png' in url.lower(): ext = 'png'
#         elif '.jpeg' in url.lower(): ext = 'jpeg'
#         elif '.gif' in url.lower(): ext = 'gif'
        
#         # Create filename: m1_Masala_Dosa.jpg
#         filename = f"{meal_id}_{clean_title}.{ext}"
#         save_path = os.path.join(output_folder, filename)

#         try:
#             print(f"Attempting to download {meal_id}: {title}...")
#             # Fetch the image content with a longer timeout
#             response = requests.get(url, headers=headers, timeout=20, allow_redirects=True)
            
#             if response.status_code == 200:
#                 # Check content type to ensure it's a valid image
#                 if 'image' in response.headers.get('Content-Type', '').lower():
#                     with open(save_path, 'wb') as img_file:
#                         img_file.write(response.content)
#                     successful_downloads += 1
#                     print(f"  ✅ Saved as {filename}")
#                 else:
#                     print(f"  ⚠️ URL for {meal_id} ({title}) did not return an image. Skipping.")
#             else:
#                 print(f"  ❌ Failed to download {meal_id} (Status: {response.status_code}) from {url}")
                
#         except requests.exceptions.RequestException as e:
#             print(f"  ❌ Connection error or timeout for {meal_id} ({title}): {e}")
#         except Exception as e:
#             print(f"  ⚠️ An unexpected error occurred for {meal_id}: {e}")

#         # Add a small delay between requests to avoid overwhelming the hosting server
#         time.sleep(0.5)

#     print(f"\n--- Process Complete ---")
#     print(f"Successfully downloaded {successful_downloads} images to the '{output_folder}' folder.")

# if __name__ == "__main__":
#     download_meal_images_from_file('meal_data.dart')









import re
import os
import shutil
import time
from icrawler.builtin import BingImageCrawler

def search_and_download_new_images(file_path):
    # 1. Read the Dart file content
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: Could not find {file_path}. Please ensure it is in the same folder.")
        return

    # 2. Create a folder for the final images
    final_output_folder = "new_meal_images"
    if not os.path.exists(final_output_folder):
        os.makedirs(final_output_folder)
        print(f"Created output directory: '{final_output_folder}'")


    # 3. Extract ID and Title (Ignoring imageURL)
    # Regex looks for: id: 'm1', ... title: 'Masala Dosa'
    pattern = re.compile(r"id:\s*'(.*?)'.*?title:\s*'(.*?)'", re.DOTALL)
    matches = pattern.findall(content)

    print(f"\nFound {len(matches)} meals. Starting web search and download...")

    # 4. Loop through each meal and fetch a NEW image
    for meal_id_raw, title_raw in matches:
        meal_id = meal_id_raw.strip()
        title = title_raw.strip()
        
        # Search term enhanced for better results
        search_term = f"{title} authentic recipe dish"
        
        print(f"Searching for: {title} (ID: {meal_id})...")

        # Use a temporary folder for the crawler to download into
        temp_dir = "temp_crawler"
        if os.path.exists(temp_dir):
            shutil.rmtree(temp_dir)
        
        # Configure the Bing crawler (which avoids Wikipedia sources)
        crawler = BingImageCrawler(
            feeder_threads=1,
            parser_threads=1,
            downloader_threads=1,
            storage={'root_dir': temp_dir},
            log_level='ERROR' # Suppress unnecessary output
        )

        # Download exactly 1 image
        crawler.crawl(keyword=search_term, max_num=1)

        # 5. Rename and move the file
        try:
            downloaded_files = os.listdir(temp_dir)
            
            if downloaded_files:
                # Get the path of the downloaded file (should be only one)
                src_path = os.path.join(temp_dir, downloaded_files[0])
                
                # Determine extension
                extension = src_path.split('.')[-1]
                
                # Clean title for filename (removes special chars, replaces spaces with underscores)
                clean_title = re.sub(r'[^\w\s-]', '', title).strip().replace(' ', '_')
                
                # Create final filename: m1_Masala_Dosa.jpg
                new_filename = f"{meal_id}_{clean_title}.{extension}"
                dst_path = os.path.join(final_output_folder, new_filename)

                # Move and rename
                shutil.move(src_path, dst_path)
                print(f"  ✅ Saved as {new_filename}")
            else:
                print(f"  ❌ No image found for {title}")
        except Exception as e:
            print(f"  ⚠️ Error processing {title}: {e}")

        # Cleanup temp folder before the next iteration
        if os.path.exists(temp_dir):
            shutil.rmtree(temp_dir)
        
        # Pause briefly to be polite to the search engine
        time.sleep(1)

    print(f"\n--- Process Complete ---")
    print(f"Successfully finished searching. Check the '{final_output_folder}' folder for your new images.")

if __name__ == "__main__":
    search_and_download_new_images('meal_data.dart')