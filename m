Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11838
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 12:50:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA24772
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 17:50:32 GMT
Received: from blackhole.cc.ndsu.nodak.edu (blackhole.cc.ndsu.NoDak.edu [134.129.106.141])
	by jazzswing.ncsc.mil  with ESMTP id RAA24768
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 17:50:31 GMT
Received: from localhost (kodland@localhost)
	by blackhole.cc.ndsu.nodak.edu (8.11.0/8.11.0) with ESMTP id f2UHr3W29576
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2001 11:53:04 -0600
Date: Fri, 30 Mar 2001 11:53:03 -0600 (CST)
From: Kris Odland <kodland@blackhole.cc.ndsu.nodak.edu>
To: "NSA Linux (E-mail)" <selinux@tycho.nsa.gov>
Subject: Error in tools/build-apps
In-Reply-To: <Pine.SOL.3.95.1010330082748.22613A-100000@clipper.gw.tislabs.com>
Message-ID: <Pine.LNX.4.30.0103301149010.27433-100000@blackhole.cc.ndsu.nodak.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, I am attempting to install this on a rh7 box and the kernel compiled
without any problems.  I get this error twice in the build-apps script
when it is building the syscalls programs.
In file included from msgread.c:17:
../../include/ipc_secure.h:19: warning: `struct msgbuf' declared inside
parameter list
../../include/ipc_secure.h:19: warning: its scope is only this definition
or declaration, which is probably not what you want.
../../include/ipc_secure.h:23: warning: `struct msgbuf' declared inside
parameter list
msgread.c: In function `main':
msgread.c:35: storage size of `buf' isn't known
make[1]: *** [msgread.o] Error 1

Everything else seems to compile fine except this.  Is there something I
missed?

Kris





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
