Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA27530
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 10:16:45 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA14839
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 14:14:42 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id OAA14835 for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 14:14:41 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA14988
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 10:16:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA25037
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 04:52:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA01182
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 08:50:14 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id IAA01178 for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 08:50:13 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 331B392465
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 18:52:04 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 60545B88
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2002 10:51:56 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: procps package
Date: Thu, 17 Oct 2002 10:51:55 +0200
MIME-Version: 1.0
Message-Id: <200210171051.55994.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The procps upstream now includes SE Linux support.

On http://www.coker.com.au/selinux/procps/ I've put a new Debian/unstable 
package of procps and a small patch that I used to generate it (there were 
some minor typos in the code merge that needed fixing).

Brian, I recommend that you back-port this procps to woody as having a package 
that's close to the upstream version is easier to manage.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
