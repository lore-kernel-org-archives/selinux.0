Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i65FKarT025374
	for <selinux@tycho.nsa.gov>; Mon, 5 Jul 2004 11:20:36 -0400 (EDT)
Received: from sphinx.mythic-beasts.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i65FKZUd001407
	for <selinux@tycho.nsa.gov>; Mon, 5 Jul 2004 15:20:35 GMT
Received: from dubfire by sphinx.mythic-beasts.com with local (Exim 3.33 #3)
	id 1BhVGV-0000KK-00
	for selinux@tycho.nsa.gov; Mon, 05 Jul 2004 16:20:19 +0100
Date: Mon, 5 Jul 2004 16:20:19 +0100
From: Christopher Soghoian <genome4hire@dubfire.net>
To: selinux@tycho.nsa.gov
Subject: Question
Message-ID: <20040705162019.A5156@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi All,

I'm working on a summer project for IBM research, and we're interested
in gathering forensic information on misbehaving processes.

Consider the case when a process is trying to do something it shouldn't,
SELinux steps in, denies the read/write/whatever request, and then prints
out an error message.

What we'd like to be able to do, is to freeze the process right before
the read/write request gets rejected.. and then call a script, which
can gather some forensic information on the process.

It's important for us to be able to do this -before- the process's request
is rejected.

I don't think theres anything in place right now to do this (or am I wrong?),
but could someone please let me know how difficult it would be to add this,
and where the code would have to go?

Ideally, we'd like to do a `kill -s SIGSTOP` on the process, and then run
a script (passing in the misbehaving pid).

Thanks in advance,

Chris

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
