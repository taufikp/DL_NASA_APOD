# DL_NASA_APOD
Powershell script (PS1) and batch script to download NASA Astronomy Picture Of The Day.

## How To Install
Put both script in folder/directory of your choice

## How To Run
I use Windows Task Scheduler to execute the .bat file once a day. I run the .bat file instead of the .ps1 file because it is more convenient.

During the first run, it will create a new folder called 'NASA_APOD' inside user's Pictures folder. You can change this to your liking of course.


**Note**: This script uses NASA free API key called 'DEMO_KEY'. This key has rate limit of 30 requests per hour.
