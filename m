Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h54E1uI4022391
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 10:01:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h54E1ttV016106
	for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 14:01:55 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h54E1oal016102 for <selinux@tycho.nsa.gov>; Wed, 4 Jun 2003 14:01:52 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 93B59BF27
	for <selinux@tycho.nsa.gov>; Thu,  5 Jun 2003 00:01:47 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 07493-08
 for <selinux@tycho.nsa.gov>; Thu,  5 Jun 2003 00:01:46 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 546B6BF25
	for <selinux@tycho.nsa.gov>; Thu,  5 Jun 2003 00:01:46 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 11B1092740
	for <selinux@tycho.nsa.gov>; Thu,  5 Jun 2003 00:01:46 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 297C87778
	for <selinux@tycho.nsa.gov>; Thu,  5 Jun 2003 00:00:59 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: executing /dev/zero
Date: Thu, 5 Jun 2003 00:00:58 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200306050000.58024.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

avc:  denied  { execute } for  pid=3927 exe=/usr/bin/mplayer path=/zero 
dev=00:06 ino=12 scontext=faye:staff_r:staff_t 
tcontext=system_u:object_r:zero_device_t tclass=chr_file

It seems that mplayer is requesting execute access to /dev/zero for some 
reason.  I guess it's mmaping it to allocate memory and then executing code 
in that memory region.

It works OK without the access, but is there any reason for allowing it?  I'm 
not sure whether I should give it an allow or dontaudit rule...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
