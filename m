Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8N8jbsJ011563
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 04:45:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8N8hsd0006395
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 08:43:54 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8N8hqVY006392
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 08:43:53 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 215A6BF3F
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 18:45:34 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 13228-09 for <selinux@tycho.nsa.gov>;
 Tue, 23 Sep 2003 18:45:33 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 3DCDDC164
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 18:45:33 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id F2B80924D6
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 18:45:32 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id A02387F005
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 18:45:31 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: please delete kcheckpass.te
Date: Tue, 23 Sep 2003 18:45:31 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200309231845.31131.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Please delete the policy for kcheckpass.

The problem with kcheckpass was that it is SUID root in Debian.  This is a bug 
as it can run fine without being SUID, if kcheckpass is run from your UID 
then the SUID helper program unix_chkpwd will be run (which has appropriate 
policy support).  This is better than granting kcheckpass direct access to /
etc/shadow as it means that we have less programs with access to the shadow 
file so an attacker who wants to obtain a copy of it has less potential 
targets.

Debian users should give kcheckpass mode 0755 (I have filed a Debian bug 
report about this already).  Red Hat appears to not have this bug.

Once kcheckpass is not run UID==0 then the pam_unix.so code will automatically 
run unix_chkpwd.  Currently the pam_unix.so code will abort if it can't 
read /etc/shadow and it's UID==0, I consider this a bug in pam.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
