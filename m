Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6UHVDHa028362
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 13:31:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6UHVCDW002896
	for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 17:31:12 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h6UHVBeN002893 for <selinux@tycho.nsa.gov>; Wed, 30 Jul 2003 17:31:11 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id A216ABF63
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 03:31:03 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 26048-04
 for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 03:31:01 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id EAAECBF64
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 03:31:00 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id F02E892554
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 03:30:57 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id CAED07F005
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 04:26:39 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: per-user tmpdir
Date: Mon, 28 Jul 2003 13:29:59 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200307281329.59379.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently there is some discussion on the debian-devel mailing list about 
libpam-tmpdir and other methods for creating a per-user directory under /tmp 
and setting $TMP to it.

Under SE Linux this will require mkdir_secure() as the directory will be 
created under the context of the calling program (/bin/login, sshd, or maybe 
even crond) not the context of the user.

Of course a per-user $TMP directory provides less benefits under SE Linux.  
Sym-link attacks are not effective against regular users and will only do any 
good against sysadm_t.  A special $TMP for administrative logins can be 
easily handled as a special case, however getting it to work for cron jobs is 
more difficult (and sysadm_crond_t is a domain that is particularly prone to 
feature-creep).

Writing a SE Linux libpam-tmpdir would probably be a good introduction to SE 
Linux programming...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
