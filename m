Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3SKS1Rb009896
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 16:28:01 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3SKRxYW019550
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 20:27:59 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i3SKRlBf019397 for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 20:27:58 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 799BC61C5B
	for <selinux@tycho.nsa.gov>; Thu, 29 Apr 2004 06:26:24 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07229-02 for <selinux@tycho.nsa.gov>;
	Thu, 29 Apr 2004 06:26:24 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id E488661BD6
	for <selinux@tycho.nsa.gov>; Thu, 29 Apr 2004 06:26:23 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id A312DB586F
	for <selinux@tycho.nsa.gov>; Thu, 29 Apr 2004 06:26:26 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: type for less trusted files
Date: Thu, 29 Apr 2004 06:26:26 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200404290626.26073.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have been involved in some discussions of packaging issues.

There is a desire to have support for treating packages differently depending 
on signature status.  If a package is signed by a trusted key then things 
operate in the current manner.  If the package is unsigned or the key is 
untrusted then things will be different, we want rpm to decline to install 
such files to certain directories (discussion on how to do this is continuing 
- but it looks like having rpm query the kernel as to whether the SE Linux 
policy permits an untrusted version of itself to write to the directories etc 
is best).

For files from an untrusted package we want different labelling.  Maybe 
untrusted_bin_t for files that might otherwise be labelled as bin_t, and have 
an attribute untrusted_file for all such types.

Then we want a "make relabel" operation to not change untrusted_bin_t to 
bin_t.  We could do this by having setfiles know about the types that it 
should not relabel (some policy query), or we could simply deny it 
relabelfrom access.

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
