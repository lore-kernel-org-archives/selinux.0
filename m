Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h87CxGLa008103
	for <selinux@tycho.nsa.gov>; Sun, 7 Sep 2003 08:59:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h87CxFmw007797
	for <selinux@tycho.nsa.gov>; Sun, 7 Sep 2003 12:59:15 GMT
Received: from leapster.dwerryhouse.com.au (www.teledurecords.com [203.30.75.104])
        by jazzband.ncsc.mil  with ESMTP id h87CxE9d007794 for <selinux@tycho.nsa.gov>; Sun, 7 Sep 2003 12:59:15 GMT
Received: from rosso.dwerryhouse.com.au (leapster [127.0.0.1])
	by leapster.dwerryhouse.com.au (Postfix) with ESMTP id B59FF146BF
	for <selinux@tycho.nsa.gov>; Sun,  7 Sep 2003 22:59:07 +1000 (EST)
Date: Sun, 7 Sep 2003 14:59:06 +0200
From: Paul Dwerryhouse <paul@dwerryhouse.com.au>
To: selinux@tycho.nsa.gov
Subject: SE Linux packages for SuSE 8.2
Message-ID: <20030907125906.GA26580@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi all,

I don't know if anyone is interested, but I've built a bunch of RPMs
of the new 2.4-based SE Linux for SuSE 8.2:

http://leapster.org/linux/selinux/suse/

In some cases (checkpolicy, libselinux, policy, policycoreutils and
selinux-doc), the packages are straight RPM builds of the supplied
files on the SE Linux download page.

In others, I've backported the supplied patches so that they cleanly
compile against the SRPM packages made by SuSE, and in a couple of cases
have used patches that Colin has posted to the list, too.

SRPM files are provided also. 

I haven't yet adjusted the policy files for any differences between
Redhat & SuSE.

My testing hasn't been particularly thorough yet: it all works fine for me,
but beware ;)

If anyone has any comments or suggestions, feel free to let me know.

Cheers,

Paul.

-- 
Paul Dwerryhouse						| PGP Key ID: 
Amsterdam, The Netherlands (X) <-> Melbourne, Australia ( )	| 0x6B91B584

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
