Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA07735
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 10:43:37 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA04129
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 15:41:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id PAA04121 for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 15:41:41 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA08263
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 10:43:35 -0500 (EST)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA03827
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 19:47:09 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA24795
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 00:45:15 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id AAA24791
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 00:45:14 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 65ACB92713
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 11:47:05 +1100 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id D3F361AB1
	for <selinux@tycho.nsa.gov>; Thu, 31 Oct 2002 01:46:57 +0100 (CET)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: new ssh and login packages
Date: Thu, 31 Oct 2002 01:46:57 +0100
MIME-Version: 1.0
Message-Id: <200210310146.57123.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've put new ssh and login packages for Debian/Unstable online.  They are 
compiled against the latest libraries and based on the latest patches from 
the NSA.  In the case of Login I've patched the Debian version which is based 
on shadow utils so it's quite different from the NSA version in all aspects 
other than the patch.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
