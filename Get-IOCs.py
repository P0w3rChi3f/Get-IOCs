import os
import re

URLPattern = re.compile(r'([A-Za-z]+://)([-\w]+(?:\.\w[-\w]*)+)(:\d+)?(/[^.!,?"<>\[\]{}\s\x7F-\xFF]*(?:[.!,?]+[^.!,?"<>\[\]{}\s\x7F-\xFF]+)*)?')
HashPattern = re.compile(r'(\b[A-F-0-9]{32}\b)|(\b[A-F-0-9]{40}\b)|(\b[A-F-0-9]{64}\b)|(\b[A-F-0-9]{96}\b)|(\b[A-F-0-9]{128}\b)|(\b[A-F-0-9]{192}\b)|(\b[A-F-0-9]{256}\b)')
IPPattern = re.compile(r'(?:(?:\d|[01]?\d\d|2[0-4]\d|25[0-5])\.){3}(?:25[0-5]|2[0-4]\d|[01]?\d\d|\d)(?:\/\d{1,2})?')

file = open("C:\\Users\\honey\\Google Drive\\GitHub\\Scripts\\Hunt Scripts\\Get-IOCs\\TestData\\flash_citrix_exploit.txt", "r")
#def getiocs():
fileContents = file.read()
for word in fileContents.split(" "):
    if re.match(URLPattern, word) == True:
        print(word + " is a match to URL")
    elif re.match(HashPattern, word) == True:
        print(word + " is a match to a hash")
    elif re.match(IPPattern, word):
        print(word + " is a match to an IP")
    #print(word)