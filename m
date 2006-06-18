Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5I3Xjd4019204
	for <selinux@tycho.nsa.gov>; Sat, 17 Jun 2006 23:33:47 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5I3Xh92018121
	for <selinux@tycho.nsa.gov>; Sun, 18 Jun 2006 03:33:44 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id D578361B1D
	for <selinux@tycho.nsa.gov>; Sun, 18 Jun 2006 13:33:45 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 32035-06 for <selinux@tycho.nsa.gov>;
	Sun, 18 Jun 2006 13:33:45 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 8C08361B0B
	for <selinux@tycho.nsa.gov>; Sun, 18 Jun 2006 13:33:45 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 8EC72A7EA6
	for <selinux@tycho.nsa.gov>; Sun, 18 Jun 2006 13:33:36 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: moving modules into base
Date: Sun, 18 Jun 2006 13:33:36 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200606181333.36369.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Due to problems with modules I want to compile a policy with amavis and clamav 
in base.pp.

I built the rpms but get the following when trying to install them:

libsepol.scope_copy_callback: amavis: Duplicate declaration in module: 
type/attribute amavis_var_log_t
libsemanage.semanage_link_sandbox: Link packages failed
semodule:  Failed!

I then built a module with just clamav in base.pp and got the following:

libsepol.scope_copy_callback: clamav: Duplicate declaration in module: 
type/attribute clamd_var_lib_t
libsemanage.semanage_link_sandbox: Link packages failed
semodule:  Failed!

This prevents the installation process from completing correctly.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
