Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA05459
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 10:57:23 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0PFvMI16108
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 15:57:22 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0PFvLf16104 for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 15:57:21 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 26FE892666
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 02:57:17 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 893902B6D
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 16:57:09 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: tmpfs_t
Date: Sat, 25 Jan 2003 16:57:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200301251657.08983.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been looking into using tmpfs as /tmp .

Currently tmpfs is labeled tmpfs_t and there is no policy for allowing file 
creation under it.  So I have experimented with labelling it as tmp_t and 
changing the tmp_domain() macro to have the following rule:
allow $1_tmp_t tmp_t:filesystem associate;

To do this properly I would also have to change every
allow whatever fs_t:filesystem getattr;
to:
allow whatever { fs_t tmp_t }:filesystem getattr;

Or should I instead leave the tmpfs filesystem labelled as tmpfs_t and add 
appropriate file_type_auto_trans() rules for it?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
