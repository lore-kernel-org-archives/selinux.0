Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA79WISf022266
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2003 04:32:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA79WHKl007017
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2003 09:32:17 GMT
Received: from zurdle.zonnet.net (zurdle.zonnet.net [62.58.50.80])
        by jazzband.ncsc.mil  with ESMTP id hA79WG5m007013 for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2003 09:32:17 GMT
Received: from rosso.dwerryhouse.com.au (localhost [127.0.0.1])
	by zurdle.zonnet.net (Postfix) with ESMTP id 2320A16629
	for <selinux@tycho.nsa.gov>; Fri,  7 Nov 2003 10:32:10 +0100 (CET)
Date: Fri, 7 Nov 2003 10:32:10 +0100
From: Paul Dwerryhouse <paul@dwerryhouse.com.au>
To: selinux@tycho.nsa.gov
Subject: SELinux kernel RPMs for SuSE.
Message-ID: <20031107093210.GA1052@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hi all,

In September, I built a bunch of SELinux userspace RPMs for SuSE Linux
8.2. I have now ported the 2.4 backport of the 'new' SELinux code to Hubert
Mantel's SuSE default kernel 2.4.21-121, and subsequently have built an
RPM of the kernel itself.

I've cheated in a couple of places: the Mantel release had a patch for a
variable HZ value, but I hardcoded it to 100 because I didn't know how
to work around a patch conflict it caused; also I really doubt the
sonypi code will work now because of a kludge I used to make it compile.

The patch, kernel binary and patched kernel sources can all be
downloaded from here:

http://leapster.org/linux/selinux/suse/

I have not thoroughly tested this patch. The new kernel boots fine on my
machine and it hasn't crashed and burned (yet), but I do _not_ recommend
anyone try it on production machines.

Cheers,

Paul

-- 
Paul Dwerryhouse						| PGP Key ID: 
Amsterdam, The Netherlands (X) <-> Melbourne, Australia ( )	| 0x6B91B584

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
