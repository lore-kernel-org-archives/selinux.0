Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4JE0xI4003637
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 10:00:59 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4JE0bQj001273
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 14:00:37 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h4JE0YxS001270
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 14:00:36 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 7E498BF4E
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 00:00:55 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 01931-06
 for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 00:00:54 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 5AB79BF3D
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 00:00:54 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 2FF2292705
	for <selinux@tycho.nsa.gov>; Tue, 20 May 2003 00:00:54 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 7D97D7CCC
	for <selinux@tycho.nsa.gov>; Mon, 19 May 2003 23:59:09 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: rw_sem_perms() etc
Date: Mon, 19 May 2003 23:59:08 +1000
References: <200305192132.12745.russell@coker.com.au> <1053347556.4729.965.camel@moss-huskers.epoch.ncsc.mil> <200305192326.37384.russell@coker.com.au>
In-Reply-To: <200305192326.37384.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305192359.08315.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 19 May 2003 23:26, Russell Coker wrote:
> I've made the suggested changes to the shm and sem macros in my tree.  I've
> attached the modified file (which also has lots of other changes).

The change I made to the global-macros was not enough.  I have put a new 
archive of my tree on http://www.coker.com.au/selinux/policy.tgz which fixes 
all (or at least most) of the problems that the macro change caused.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
