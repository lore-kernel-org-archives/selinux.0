Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91CXXsJ024577
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 08:33:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h91CXWCG000865
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 12:33:32 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h91CXVqJ000862 for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 12:33:32 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 274EE924F2
	for <selinux@tycho.nsa.gov>; Wed,  1 Oct 2003 22:33:26 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id C7EF57F25E
	for <selinux@tycho.nsa.gov>; Wed,  1 Oct 2003 22:33:24 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: assertions in kernel
Date: Wed, 1 Oct 2003 22:33:24 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310012233.24193.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In assert.te we can prevent doing stupid things, for example if I never want 
to have a file labeled as root_t I can do the following:
neverallow domain root_t:file { relabelto create };

However doing this sort of thing means that we have to create asymetric policy 
regarding relabeling as if we get a file labeled as root_t (through a 
previous policy, through a file system error, or through kernel memory 
corruption resulting in bad data being written to disk) we need a way to 
label it back to some sane type.

I think that this approach does not work.  I think that to maintain sane state 
of the file system labeling we need to have some rules in the kernel, if 
those rules are violated (either on first access after boot or when a new 
policy load changes the rules) then the filesystem object gets relabeled to 
unlabeled_t.  Then setfiles only needs relabelfrom access to unlabeled_t to 
be able to fix all manner of file system stuff-ups.

I am aware that what I am suggesting involves a moderate amount of kernel 
coding (which I am not capable of doing).  However there has been some recent 
discussion for a number of new features in regard to kernel management of 
policy, so I presume that the feature list is up for discussion.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
