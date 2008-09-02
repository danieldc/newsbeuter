#!/usr/bin/env ruby
# tests the urls-source "opml" configuration option
require 'tuitest'

Kernel.system("rm -f cache")

Tuitest.init
verifier = Tuitest::Verifier.new("test-opmlsrc.rb.log")


Tuitest.run("../newsbeuter -c cache -C config-tuitest2 -u /dev/null")

Tuitest.wait_until_idle
verifier.expect(1, 3, "1         (0/0) http://testbed.newsbeuter.org/rss20.xml")

Tuitest.keypress("r"[0])

Tuitest.wait_until_idle
verifier.expect(0, 29, "1")
verifier.expect(1, 5, "N       (3/3) RSS 2.0 testbed feed                   ")

Tuitest.keypress(":"[0])
Tuitest.keypress("3"[0])
Tuitest.keypress(10)
Tuitest.keypress("r"[0])

Tuitest.wait_until_idle
verifier.expect(3, 5, "N       (2/2) newsbeuter testbed")

Tuitest.keypress("q"[0])
Tuitest.wait_until_idle

Tuitest.close
verifier.finish

Kernel.system("rm -f cache")

# EOF