Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4V1PagA028803
	for <selinux@tycho.nsa.gov>; Mon, 30 May 2005 21:25:36 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4V1JQ29010484
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 01:19:27 GMT
Received: from lkcl.net (host81-155-76-60.range81-155.btcentralplus.com [81.155.76.60])
	by open.hands.com (Postfix) with ESMTP id ADC85BF7C
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 02:19:39 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1DcvYO-00014P-T8
	for selinux@tycho.nsa.gov; Tue, 31 May 2005 02:28:24 +0100
Date: Tue, 31 May 2005 02:28:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: smaller memory footprint for 'strict' policy - helping gentoo as well
Message-ID: <20050531012824.GI28006@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

following on from me blithering on about gentoo, and tying
in valdis' questions about smaller "strict" memory footprints
[gods, i had no idea: i was going to recommend a strict selinux
policy for 128mb machines let alone 256!], what is the way forward?

valdis raised the question: does the new binary module system minimise
the amount of memory used?

does that _actually_ help out wrt complexity of the selinux policy
_source_ (probably not).

hm, to avoid confusion - the requirements:

* to minimise memory usage at runtime

* to keep the number of source code files and size of source code
  files to _absolute_ minimum (if done properly should cover 1st
  requirement as well).

* to still make it possible to have redhat-loved run-time "modules"
  including having their associated runtime booleans.

* to still understand what's going on :)

... would the concept of a macros/unused directory help out, here?
along with a list of the macros you removed (and the files
they're in), valdis - and why.  and chris, also?

... surely... there's some analysis done by the m4 macro
compiler that automatically removes "unwanted" / "unused"
macros?

could that be done as a separate pre-pass / analysis step,
making it unnecessary to consider a macros/unused directory?

any further thoughts, anyone?

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
