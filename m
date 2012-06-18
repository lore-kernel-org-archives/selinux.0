Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5I846YT010180
	for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2012 04:04:07 -0400
Received: from xev.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id F3B9F18046
	for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2012 18:03:58 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: KDE and SE Linux
Date: Mon, 18 Jun 2012 18:03:59 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201206181803.59321.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The current version of KDE in Debian is 4.8.4, it seems that large parts of 
the KDE environment depend on execmem access, this includes kwin and plasma-
desktop.  Basically there is no possibility of having a KDE desktop 
environment without them.

Debugging this is difficult as the important programs SEGV when denied execmem 
access and the KDE crash handler really gets in the way of debugging it - 
running /usr/bin/plasma-desktop results in the process forking a child and 
detaching from the gdb session.

The most clear example of an execmem issue in KDE is from the program 
/usr/lib/kde4/libexec/kwin_opengl_test which gives the following error:
LLVM ERROR: Allocation failed when allocating new memory in the JIT
Can't allocate RWX Memory: Permission denied

What should I do?  Obviously setting the allow_execmem makes things work, but 
that also allows a lot of unwanted stuff.

I could label the programs in question as unconfined_execmem_t, but that would 
rely on finding all of them and would also give a problem for sessions with 
the user_t domain.

Is it possible to change the way KDE works or is there any other easy fix?

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
