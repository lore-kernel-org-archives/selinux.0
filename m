Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7F7U2Ha002252
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2003 03:30:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7F7U1j6020080
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2003 07:30:01 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h7F7TtNN020070 for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2003 07:30:00 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id EF71E92719
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2003 17:29:46 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5F69E7F06D
	for <selinux@tycho.nsa.gov>; Fri, 15 Aug 2003 17:29:39 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Depends:
Date: Fri, 15 Aug 2003 17:29:38 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308151729.38711.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I propose that whenever we have a Depends: line in a policy file then we don't 
use an ifdef() for the policy file in question.

For example the Qmail policy has never been usable without inetd.te.  The 
policy had numerous assumptions regarding Qmail running from inetd (no matter 
how you run Qmail the process that receives SMTP connections must be run by a 
program that is equivalent to inetd, so may as well run as inetd_t).

The 2.6 policy branch currently has some ifdef(`inetd.te' lines, this will 
guarantee that the policy always compiles, but does not mean that you will 
actually be able to use the programs.  In my tree I just put in
"Depends: inetd.te" instead.  This will give the same result of having a 
compilable policy for any system which respects the Depends lines, and the 
policy will be shorter, easier to read and debug.

Another possibility would be to have ifdef(`inetd.te' around the entire file, 
because Qmail is virtually useless without inetd.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
