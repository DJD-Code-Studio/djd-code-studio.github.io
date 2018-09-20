from html.parser import HTMLParser
from urllib import parse

class LinkFinder(HTMLParser):
    
    def __init__(self):
        super().__init__()
    
    def error(self, message):
        pass
    
    def handle_starttag(self, tag, attrs):
        print(tag)
        
        
finder = LinkFinder()
finder.feed('<html><head><title>Test<\title><\head>'
            '<body><h1>Parse me!<\h1><\body><\html>')
