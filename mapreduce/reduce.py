#! /usr/bin/env python

import sys


# Some Python basics:
# These three variables are declared here because their state is needed after the for loop.
# "count" is potentially declared within the loop, which is fine, because it is not used outside the loop.
current_symbol = None
current_count = 0
symbol = None


for line in sys.stdin:
    line = line.strip()
    symbol, count = line.split('\t', 1)

    try:
        count = int(count)
    except ValueError:
        continue

    if current_symbol == symbol:
        current_count += count
    else:
        if current_symbol:
            print( f'{current_symbol}\t{current_count}' )

        current_symbol = symbol
        current_count = count


if current_symbol == symbol:
    print( f'{current_symbol}\t{current_count}' )

