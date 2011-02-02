/*
Copyright (c) 2010 Daniel Chcouri (adaptation to node.js) (blogy.me)
Copyright (c) 2008 Kai Hendry (hendry.iki.fi)
Copyright (c) 2008 Cory Bennett (www.corybennett.org)

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

The Software shall be used for Good, not Evil.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

var stdin = process.openStdin(),
    body = "";

stdin.setEncoding('utf8');
stdin.on('data', function (chunk) {
    body += chunk;
}
stdin.on('end', function () {
    // require jslint
    var path = require('path');
    var jslint = require(path.dirname(__filename) + '/fulljslint.js');

    // check for the jsfile
    var input_file_name = process.argv[2];
    if (typeof input_file_name == undefined)
    {
        process.exit(1);
    }

    // Good parts minus white space
    boolOptions = {
        bitwise : false, // Disallow bitwise operators
        eqeqeq : true, // === should be required
        regexp : false, // if the . should not be allowed in regexp literals
        undef : false, // if variables should be declared before used
        white : true, // if strict whitespace rules apply
        browser : true, // Standard browser globals should be predefined
        plusplus : false, // ++/-- should not be allowed
        nomen : true, // names should be checked for initial or trailing underbars
        indent : 4, // The number of spaces used for indentation
        nomen : false // true if names should be checked for initial or trailing underbars
    };

    var result = jslint.JSLINT(body, boolOptions);
    if (!result) {
        for ( i=0; i < jslint.JSLINT.errors.length; i++){
            obj = jslint.JSLINT.errors[i];
            if(obj != null)
            {
                console.log ( input_file_name + ":" + obj["line"] + ":" + obj["character"] + ":" + obj["reason"] );
            }
        }
    }
});

