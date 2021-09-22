# PasswordGenerator

Files to generate passwords from random English words, combining them with a randomly chosen punctuation mark as a separator and capitalizing a randomly chosen word.

The lists are reduced to words that have 6 to 9 characters. Having longer words causes passwords to have longer average lengths. In addition, the final generated passwords are limited to 32 characters or less. Some systems silently ignore the extra characters; this can be problematic. Each file permits "verbose" mode to enable the user to see all the longer passwords generated,

See the <a href="https://github.com/edwcarney/RandomDotOrg.jl.git">RandomDotOrg.jl</a> and <a href="https://github.com/edwcarney/RandomDotOrgAPI.jl.git">RandomDotOrgAPI.jl</a> repositories for info on using "true" random numbers as provided by the RANDOM.org site.

The files are as follows:<br>
<b>PasswordGenerator.jl</b>&mdash;generate a single password using Julia default RNG<br>
<b>PasswordGeneratorMulti.jl</b>&mdash;generate multiple passwords using Julia default RNG<br>
<b>PasswordGeneratorRDO.jl</b>&mdash;generate a single password using RANDOM.org<br>
<b>PasswordGeneratorRDOMulti.jl</b>&mdash;generate multiple passwords using RANDOM.org<br>
<b>PasswordGeneratorRDOAPI.jl</b>&mdash;generate a single password using RANDOM.org API<br>
<b>PasswordGeneratorRDOAPIMulti.jl</b>&mdash;generate multiple passwords using RANDOM.org API<br>
<b>ProcListRegexp.jl</b>&mdash;search lists for words that match regular expressions<br>
