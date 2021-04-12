#!/usr/bin/python3
import re

import requests

#</div></a></center></td><td class="title"><a href="https://www.thedrive.com/news/34554/some-of-the-most-impressive-backyard-engineering-weve-seen-goes-down-on-this-obscure-youtube-channel" class="storylink">Impressive backyard engineering on an obscure YouTube channel</a>
#<span class="rank">3.<

link = "https://news.ycombinator.com/"


f = requests.get(link)
news = f.text

nhs = open("/tmp/HNnews.headlines", "w")
nls = open("/tmp/HNnews.links", "w")

nhs.write("" + "News" + "\n")

for i in range(10):
    result = re.search(".*<span class=\"rank\">" + str(i + 1) + "\.<.*<td class=\"title\"><a href=\"(.*?)\" class=\"storylink\">(.*?)</a>", news)

    if result :
        nhs.write("" + str(i + 1) + ". " + result.group(2) + "\n")
        nls.write(str(i + 1) + ". " + result.group(1) + "\n")



