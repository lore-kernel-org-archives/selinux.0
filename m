Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA8AhRIi014655
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 05:43:28 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA8AhUDE017094
	for <selinux@tycho.nsa.gov>; Mon, 8 Nov 2004 10:43:31 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id B7A31BFC2
	for <selinux@tycho.nsa.gov>; Mon,  8 Nov 2004 10:43:15 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1CR7A6-0008Bm-2c
	for selinux@tycho.nsa.gov; Mon, 08 Nov 2004 10:54:14 +0000
Date: Mon, 8 Nov 2004 10:54:14 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: filesystems and selinux
Message-ID: <20041108105414.GD31026@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

this is going to sound a bit weird and i will do my best to _not_
confuse matters.

has anyone considered writing selinux policy - and using it instead of
unix authorisation - for networked fileservers?

(note i didn't say authentication there).

in other words, you write an selinux policy which dictates the
circumstances under which users are allowed access to files
off of a networked file server.

... or is that what the selinux-nfs patches do, already?

i am starting to think how to roll out selinux in a secured network
environment.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
