Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA25307
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2001 09:59:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA28000
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2001 14:59:01 GMT
Received: from angusbay.vnl.com ([194.46.8.33])
	by jazzband.ncsc.mil  with ESMTP id OAA27996
	for <selinux@tycho.nsa.gov>; Mon, 10 Dec 2001 14:59:00 GMT
Date: Mon, 10 Dec 2001 15:05:38 +0000
From: Dale Amon <amon@vnl.com>
To: selinux@tycho.nsa.gov
Subject: Selecting build target root path
Message-ID: <20011210150538.GD22266@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The discussion came up earlier wrt Debian dist paths.
I'd like to generalize the discussion and suggest
that all the selinux Makefiles have as their default

	ROOT=/usr/local
	LSMDIR=../../lsm
	MODDIR=../../selinux/module
	FLASKDIR=$ROOT/selinux/flask
	INCDIR=$ROOT/selinux/include
	BINDIR=$ROOT/selinux/bin

This actually a very common way of doing things so that
you can do things like:

	* build for a target machine:
		make ROOT=/usr/src/MyTargetRoot install

	* build for a local host or a tgz install:
		make install

	* build it for a debian package:
		make ROOT=/usr install

	* build it for a chrooted test
		make ROOT=/testroot install

I find a need for all of these procedures at one time
or another, and I notice it in particular now because
I'm building an selinux that I'm not going to install
on the machine doing the building... so I'll have to
modify the Makefile to do the above.

-- 
------------------------------------------------------
    Nuke bin Laden:           Dale Amon, CEO/MD
  improve the global          Islandone Society
     gene pool.               www.islandone.org
------------------------------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
