Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8M52OsJ005705
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2003 01:02:24 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8M52N2R008439
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2003 05:02:23 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8M52L1A008430 for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2003 05:02:22 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 58F42BF45
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2003 15:02:19 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32179-03 for <selinux@tycho.nsa.gov>;
 Mon, 22 Sep 2003 15:02:15 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 717E6BF1F
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2003 15:02:15 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B47D2924D6
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2003 15:02:13 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id C7C907F004
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2003 15:02:09 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
Subject: ssh: UseLogin yes
Date: Mon, 22 Sep 2003 15:02:08 +1000
To: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309221502.08912.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Does anyone have UseLogin set to yes in their sshd config?  If so what
 changes did you have to make to get it to work, and why do you use it?

The sshd patch that I'm using does not support that mode of operation, a
 quick read of the patch for sshd on 2.6 SE Linux suggests that it also does
 not support it.  I imagine that the SE Linux PAM module will support it, but
 that's not in wide use yet.

I am considering removing the policy for sshd_login_t from ssh.te, it makes
the policy MUCH more complex (and therefore difficult to understand and
audit), probably isn't being used by anyone, and probably provides little or
no benefit if it was to be used.

--
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
