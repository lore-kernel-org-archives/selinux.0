Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA06030
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 13:40:20 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0PIeJI20516
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 18:40:19 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h0PIeHf20512 for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 18:40:17 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E313692666
	for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2003 05:40:15 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 93B3445A5
	for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2003 19:40:07 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: UML and SE Linux
Date: Sat, 25 Jan 2003 19:40:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200301251940.05843.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Last night I got the kernel code for UML and SE Linux going.  It turned out to 
be only about a dozen lines of (somewhat ugly) code.  I'll post a patch soon.

Now I've got SKAS working (the Separate Kernel Address Space) with UML.  I've 
adjusted my UML policy to allow UML instances to write to proc_t files for 
/proc/mm (yes I know this isn't desirable - but this shouldn't be a big deal, 
and it will go away in SKAS4 hopefully).

I've got policy for tmpfs working which I will release soon after some 
discussion on this list.

So now this gives secure well-performing virtual SE Linux machines.  So to use 
this I'm going to offer accounts on my SE play machine with UML access for 
anyone who'd like to administer their own virtual SE machine.

Let me know by private email if you are interested in this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
