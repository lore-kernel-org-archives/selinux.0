Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA25994
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 09:54:06 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA24347
	for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 14:52:10 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id OAA24341 for <selinux@tycho.nsa.gov>; Mon, 4 Nov 2002 14:52:08 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 0BB8192713
	for <selinux@tycho.nsa.gov>; Tue,  5 Nov 2002 01:53:50 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 90A65E4C
	for <selinux@tycho.nsa.gov>; Mon,  4 Nov 2002 15:53:42 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
Subject: Fwd: expect problem
Date: Mon, 4 Nov 2002 15:53:42 +0100
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_I1425AJ7WS2AFUL8H49Z"
Message-Id: <200211041553.42140.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_I1425AJ7WS2AFUL8H49Z
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

I have attached a test program demonstrating a problem that I have with 
expect.

I type the following:
open_init_pty ./testit

The result I desire is that the command "sleep 100" is running in the
background.  However sleep doesn't seem to get run.

I can't determine the exact cause of the problem because all methods of
tracing it (strace etc) stop it occurring).

Putting a "sleep 1" at the end of the testit script will solve the problem,
however when dealing with daemon startup scripts this isn't an option.

Due to this problem some daemons (such as kdm) can't be started from an 
administrator command shell.  So we'll have wither solve this or back out the 
initrc_devpts_t changes before the next release.  :(

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_I1425AJ7WS2AFUL8H49Z
Content-Type: application/x-shellscript;
  charset="us-ascii";
  name="testit"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="testit"

#!/bin/bash

setsid sleep 100 </dev/null >/dev/null 2>/dev/null &

--------------Boundary-00=_I1425AJ7WS2AFUL8H49Z--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
