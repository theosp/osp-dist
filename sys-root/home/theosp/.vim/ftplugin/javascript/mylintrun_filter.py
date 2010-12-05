#!/usr/bin/env python

import re, sys

source = sys.stdin.read()

# django filters {{{
source = re.sub(r'{%\s+include\s+[^%]*?%}', '', source)
source = re.sub(r'{{.+?}}', '', source) # remove vars

source = re.sub(r'{% comment %}', '/*', source)
source = re.sub(r'{% endcomment %}', '*/', source)

source = re.sub(r'{%\s*option.*?%}', "''", source)
# }}}

print source,

# vim:fdm=marker:
