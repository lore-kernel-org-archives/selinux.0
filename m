Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i04DEWRb029994
	for <selinux@tycho.nsa.gov>; Sun, 4 Jan 2004 08:14:34 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i04DEV7m015741
	for <selinux@tycho.nsa.gov>; Sun, 4 Jan 2004 13:14:31 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i04DEJLC015720 for <selinux@tycho.nsa.gov>; Sun, 4 Jan 2004 13:14:30 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 0C36A61C0E
	for <selinux@tycho.nsa.gov>; Mon,  5 Jan 2004 00:12:54 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 13488-03 for <selinux@tycho.nsa.gov>;
	Mon, 5 Jan 2004 00:12:53 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id B06AA61BE2
	for <selinux@tycho.nsa.gov>; Mon,  5 Jan 2004 00:12:53 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 844C0924F3
	for <selinux@tycho.nsa.gov>; Mon,  5 Jan 2004 00:12:53 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 0800BB5993
	for <selinux@tycho.nsa.gov>; Mon,  5 Jan 2004 00:12:52 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: /dev/random
Date: Mon, 5 Jan 2004 00:12:51 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200401050012.51481.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've been playing with SSP (AKA ProPolice).  It seems that SSP requires
/dev/urandom access for useful operation, and thus every domain that runs a 
SSP compiled program (IE every domain which has a privileged process dealing 
with untrusted data) needs /dev/urandom access.

Also shell scripts sometimes fall into the category of privileged processes 
using untrusted data which means that every domain which has a shell script 
asks for /dev/urandom access.

Consequently I plan to introduce a new type so that I can enable urandom 
access without enabling random access, and allow many system domains to 
access /dev/urandom.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
