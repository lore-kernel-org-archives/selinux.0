Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91HgYsJ027368
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 13:42:34 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h91HgX7d018953
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 17:42:34 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
        by jazzband.ncsc.mil  with ESMTP id h91HgWRn018949 for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 17:42:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>, Chris PeBenito <pebenito@gentoo.org>
Subject: Re: file_labels_t
Date: Thu, 2 Oct 2003 00:53:19 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1064984367.1511.30.camel@chris.pebenito.net> <1065016578.350.51.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1065016578.350.51.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200310020053.19205.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Oct 2003 23:56, Stephen Smalley wrote:
> You can remove the type, and just map the initial SID to unlabeled_t
> until we get around to cleaning up the initial SIDs.  Cleaning up the
> initial SIDs does presently require rebuilding the kernel module with
> updated headers so that it reflects the current values of the subsequent
> initial SIDs, which will be perturbed by the removal of earlier initial
> SIDs, so we would likely increment the policy version number at that

One way of addressing this is to never remove an entry until there is 
something else to take it's place, and to only add new entries on at the end.  
It seems much simpler to do that than to update the policy version number so 
often.

Also when we rename entries it may be easier to add new entries before adding 
the old entries so that the same policy source can be used to compile 
policies for two successive kernels.

One problem that we have is that the upgrade proceedure too often has been:
Build new kernel with new kernel source, compile new policy from new policy 
source, and install both at once.

This is fine if the new kernel works well.  If the new kernel doesn't work so 
well and if it has some bug that doesn't show up for some weeks or months 
(it's happened before) then you are left with a system that has had it's 
policy changed (or maybe even worse you don't know whether it's had any 
significant changes due to lack of change control) and you can't compile the 
newest changes to your policy for your old kernel.

This problem is exacerbated by the fact that there is only ever official 
releases for one kernel.  I haven't complained about this in the past because 
I have my own repository of SE Linux kernel patches (every kernel from 
2.4.19) and I'm happy to port each new NSA release to other kernel versions 
as necessary.

Of course this is something that distributions should and will take care of.  
I'm doing it for Debian and James will do it for Red Hat.  However at the 
moment I get the impression that a large portion (the majority?) of SE Linux 
users are just using the kernel patches from the NSA site.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
