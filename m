Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i29CmARb011864
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 07:48:15 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i29Cm90F007427
	for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 12:48:09 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i29ClugZ007268 for <selinux@tycho.nsa.gov>; Tue, 9 Mar 2004 12:48:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 3DC9261BC5
	for <selinux@tycho.nsa.gov>; Tue,  9 Mar 2004 23:46:33 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16593-01 for <selinux@tycho.nsa.gov>;
	Tue, 9 Mar 2004 23:46:32 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 721C761BA9
	for <selinux@tycho.nsa.gov>; Tue,  9 Mar 2004 23:46:31 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 720642F589
	for <selinux@tycho.nsa.gov>; Tue,  9 Mar 2004 23:46:30 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: can_ypbind()
Date: Tue, 9 Mar 2004 23:46:29 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200403092346.29875.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems that on a NIS system most domains need access to it.  So it seems 
reasonable to put a call to can_ypbind() in daemon_domain() to cover most 
daemons.  I considered daemon_base_domain() or daemon_core_rules() but that 
makes it too awkward to implement a basic daemon that has no network access 
on a NIS system.

Also it seems that anything which needs NIS access will also need NSCD or LDAP 
access depending on the configuration of the system.  So maybe instead of 
can_ypbind() we should have can_account_lookup() (or some better name) which 
will then permit NIS, NIS+, LDAP, NSCD, or whatever else is necessary to do 
the job.

What do you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
