Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAE81RSf023242
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 03:01:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAE81QqY020255
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 08:01:26 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hAE81P0o020250 for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 08:01:25 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 164CC61BD5
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 19:01:18 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18322-07 for <selinux@tycho.nsa.gov>;
	Fri, 14 Nov 2003 19:01:17 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id C8CEF61BCF
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 19:01:17 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7BC24925E8
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 19:01:16 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 3611A7F06D
	for <selinux@tycho.nsa.gov>; Fri, 14 Nov 2003 19:01:15 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: unix_chkpwd
Date: Fri, 14 Nov 2003 19:01:14 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200311141901.14660.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When sshd is launched from inetd it inherits the open file handle for the TCP 
socket.  It does not use fcntl(fd, F_SETFD..) to make it close on exec for 
child processes, so when pam_unix.so runs unix_chkpwd (*) the file handle is 
inherited.

We can do one of three things:
1)  dontaudit system_chkpwd_t inetd_t:fd use;
2)  Change sshd to use fcntl() before doing any PAM stuff.
3)  Put code in pam_unix.so to close all file handles after the fork().

Which do you think is best?  2 seems most correct to me, but may be most 
difficult to get accepted upstream.  3 means ~1000 close() calls, which 
doesn't take too long on modern machines.  1 is a hack.

(*) This only happens with my modified PAM and SE Linux policy to prevent all 
login processes from being able to read /etc/shadow directly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
