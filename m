Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB24uXRb012323
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2003 23:56:33 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB24trp5003968
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 04:55:53 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hB24tpt0003956
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 04:55:52 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 4F39161BF2
	for <selinux@tycho.nsa.gov>; Tue,  2 Dec 2003 15:56:25 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02825-06 for <selinux@tycho.nsa.gov>;
	Tue, 2 Dec 2003 15:56:24 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id 9551361BF0
	for <selinux@tycho.nsa.gov>; Tue,  2 Dec 2003 15:56:24 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 68D849268A
	for <selinux@tycho.nsa.gov>; Tue,  2 Dec 2003 15:56:24 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B50077F26F
	for <selinux@tycho.nsa.gov>; Tue,  2 Dec 2003 15:56:22 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: 2.4.23
Date: Tue, 2 Dec 2003 15:56:05 +1100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200312021556.22071.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

http://lists.debian.org/debian-security-announce/
debian-security-announce-2003/msg00212.html

The above URL gives some information on the kernel bug that was using in 
hacking the Debian servers.

The bug exists in all 2.4.x kernels prior to 2.4.23 and all 2.5/2.6 kernels 
prior to 2.6.0-test6.  The bug was known for a while but was not thought to 
be a serious bug.

The bug can only be used for local attacks, so to exploit it the attacker 
needs an account on the target system or needs to exploit a server program 
such as a web server or mail server.  NB A web server that allows users to 
upload their own CGI scripts will be vulnerable to this...

On my web site http://www.coker.com.au/selinux/kern/ I have put some Debian 
packages of exec-shield, acl, and LSM patches for 2.4.23 kernels (which 
include tar-balls of the patch files that can be used for non-Debian 
systems).

The exec-shield patch required no modification, the LSM patch for 2.4.22 
applied with no issues too.  The ACL patch needed three modifications due to 
some of the ACL code being merged into the kernel.org kernel.


Russell Coker

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/zBtqwrB5/PXHUlYRAhdyAKDK0a90Rbjsfv6iLkz52CaXLXGYCgCfZpFP
dzdz7eXbowhTz9FhFSAe7Eg=
=1HHZ
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
