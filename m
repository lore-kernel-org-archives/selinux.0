Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBQAvgIi013758
	for <selinux@tycho.nsa.gov>; Sun, 26 Dec 2004 05:57:43 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBQAtqEM006619
	for <selinux@tycho.nsa.gov>; Sun, 26 Dec 2004 10:55:54 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 2A44161AFD
	for <selinux@tycho.nsa.gov>; Sun, 26 Dec 2004 21:57:39 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 17703-04 for <selinux@tycho.nsa.gov>;
	Sun, 26 Dec 2004 21:57:38 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id BF45961AF9
	for <selinux@tycho.nsa.gov>; Sun, 26 Dec 2004 21:57:38 +1100 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id D70BBA4
	for <selinux@tycho.nsa.gov>; Sun, 26 Dec 2004 21:57:37 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: r_dir_file() and sym-links
Date: Sun, 26 Dec 2004 21:57:34 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200412262157.36359.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

In retrospect it was a mistake to make r_dir_file() and friends operate on 
lnk_file types as well.  We should have had separate macros for sym-links and 
without sym-link access.

Currently there are many instances in the policy of r_dir_file() being used 
for cases where sym-links are not possible (EG for some parts of /proc).

Also r_dir_perms and r_file_perms grant more access than is usually required.  
Maybe we should have a macro like the following:

define(`s_dir_r_file', `
allow $1 $2:dir search;
allow $1 $2:file { getattr read };
')

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
