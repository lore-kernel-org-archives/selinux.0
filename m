Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA8JNfSf028830
	for <selinux@tycho.nsa.gov>; Sat, 8 Nov 2003 14:23:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hA8JNeKl027434
	for <selinux@tycho.nsa.gov>; Sat, 8 Nov 2003 19:23:40 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id hA8JNc5m027431 for <selinux@tycho.nsa.gov>; Sat, 8 Nov 2003 19:23:39 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 3011A61BA9
	for <selinux@tycho.nsa.gov>; Sun,  9 Nov 2003 05:22:17 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
 by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 17024-05 for <selinux@tycho.nsa.gov>;
 Sun,  9 Nov 2003 05:22:16 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id CAA3461BA7
	for <selinux@tycho.nsa.gov>; Sun,  9 Nov 2003 05:22:16 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id C32089260A
	for <selinux@tycho.nsa.gov>; Wed,  5 Nov 2003 08:03:07 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 7BC5D7F004
	for <selinux@tycho.nsa.gov>; Wed,  5 Nov 2003 07:57:55 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: insmod
Date: Wed, 5 Nov 2003 07:57:54 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200311050757.54690.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

We have been discussing some potential changes to make insmod work better with 
SE Linux.

Insmod runs with the security domain insmod_t, and so does the initialisation 
phase of the kernel code it runs.  When kernel code is blocked by SE Linux 
the usual result is an Oops (buggy code, but even if it handles the error 
correctly it won't be operational unless access is granted).  To prevent 
Oopsen and modules failing to operate we need to either have the code always 
run in kernel_t by having the process that loads the module be in kernel_t or 
we have to give insmod_t the same access as kernel_t (which essentially means 
running the insmod program in kernel_t).

So it seems that we need have insmod run in kernel_t and have modprobe run in 
it's own domain modprobe_t.

This means that we can't have insmod and modprobe be the same binary.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
