Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA08406
	for <selinux@tycho.nsa.gov>; Fri, 6 Sep 2002 13:14:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA06984
	for <selinux@tycho.nsa.gov>; Fri, 6 Sep 2002 17:12:47 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id RAA06980 for <selinux@tycho.nsa.gov>; Fri, 6 Sep 2002 17:12:46 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA16571
	for <selinux@tycho.nsa.gov>; Fri, 6 Sep 2002 13:14:27 -0400 (EDT)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA04319
	for <selinux@tycho.nsa.gov>; Fri, 6 Sep 2002 04:54:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA11632
	for <selinux@tycho.nsa.gov>; Fri, 6 Sep 2002 08:53:32 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id IAA11628
	for <selinux@tycho.nsa.gov>; Fri, 6 Sep 2002 08:53:30 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2ACC692466
	for <selinux@tycho.nsa.gov>; Fri,  6 Sep 2002 18:54:44 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 910E563E5
	for <selinux@tycho.nsa.gov>; Fri,  6 Sep 2002 10:55:00 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new login Debian package
Date: Fri, 6 Sep 2002 10:55:00 +0200
MIME-Version: 1.0
Message-Id: <200209061055.00180.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have released a new login package for both woody and sarge that fixes a 
nasty bug.  It's on my web site in an apt'able repository.  I recommend that 
anyone who is using the old version upgrade at their earliest conveniance.

For woody:
deb http://www.coker.com.au/selinux/ ./

For Sarge/unstable:
deb http://www.coker.com.au/selinux/ ./

For the source:
http://www.coker.com.au/selinux/login/


Russell Coker


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
