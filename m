Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h390HYI4024772
	for <selinux@tycho.nsa.gov>; Tue, 8 Apr 2003 20:17:34 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h390DqOv018325
	for <selinux@tycho.nsa.gov>; Wed, 9 Apr 2003 00:13:52 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h390DSY1018317
	for <selinux@tycho.nsa.gov>; Wed, 9 Apr 2003 00:13:50 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 5266EBF47
	for <selinux@tycho.nsa.gov>; Wed,  9 Apr 2003 10:16:52 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 08500-09
 for <selinux@tycho.nsa.gov>; Wed,  9 Apr 2003 10:16:51 +1000 (EST)
Received: from tsv.sws.net.au (unknown [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id EC949BF46
	for <selinux@tycho.nsa.gov>; Wed,  9 Apr 2003 10:16:50 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id A408B92738
	for <selinux@tycho.nsa.gov>; Wed,  9 Apr 2003 10:16:49 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 55658A05
	for <selinux@tycho.nsa.gov>; Wed,  9 Apr 2003 10:16:49 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: Re: ptrace flaw
Date: Wed, 9 Apr 2003 10:16:48 +1000
References: <1049806561.1606.29.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1049806561.1606.29.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304091016.48610.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 8 Apr 2003 22:56, Stephen Smalley wrote:
> Just for your information, the patch for the ptrace flaw in the base
> Linux kernel is _not_ included in the lsm-2.4 kernel tree or kernel

I had added it to my Debian kernel patch package for LSM when it first came 
out as the main Debian packages didn't include it fast enough.

Now I am going to remove it from the next version of my kernel-patch package 
(based on the new NSA release) because the main Debian kernel-source-2.4.20 
package has included the ptrace patch and it made my patch not apply.

People who apply the new version of my Debian LSM patch to an unpatched 2.4.20 
will need to apply the ptrace patch separately.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
