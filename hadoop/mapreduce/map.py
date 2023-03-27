#! /usr/bin/env python

import sys
import re


# Some Python basics:
# string.strip() - removes all leading and trailing spaces
# The re.sub regex replaces all occurrences of one or more non-word character chunks with a single space.
# The result: Clean alphanumeric symbol chunks (words) separated by single spaces on lines with no padding.


for line in sys.stdin:
    line = re.sub( r'\W+', ' ', line.strip() )
    symbols = line.split()  # on whitespace

    for symbol in symbols:
        print( f'{symbol}\t{1}' )

