Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8ODMgsJ018051
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 09:22:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8ODKwd0021253
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 13:20:58 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8ODKtVY021237
	for <selinux@tycho.nsa.gov>; Wed, 24 Sep 2003 13:20:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Inger, Slav (S.B.)" <vinger@ford.com>,
   "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Sample SELinux policy that's equivalent to standard root?
Date: Wed, 24 Sep 2003 23:22:26 +1000
References: <F5441DDE18FFD9418974338018C522B718BDAB@na1fcm61.dearborn.ford.com>
In-Reply-To: <F5441DDE18FFD9418974338018C522B718BDAB@na1fcm61.dearborn.ford.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200309242322.26079.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 24 Sep 2003 07:16, Inger, Slav (S.B.) wrote:
> I hope this is the right mailing list to ask this question.  Here's my
> setup:  a freshly compiled Linux 2.6.0-test3-selinux1, using a default
> policy supplied in selinux-usr/policy.  What I would like to do is, instead
> of starting with the most restrictive mode and easing my way to less
> restrictive, I'd like to start with a relaxed root access policy (i.e.
> start with root as "God" even in enforced mode, as is the case with
> standard Linux) and tighten up from there.  So my question is, does anyone
> know where I could get the configs for a policy with root rights equivalent
> to that on a standard Linux system?  TIA.

The domain sysadm_t has 99% of the ability that "root" has on a non-SE 
machine, of course you need to have both UID=0 and context 
something:sysadm_r:sysadm_t to get full access.

Adding the ability to directly read /etc/shadow, block devices, and the few 
things that are denied to sysadm_t is easy enough.  However in many cases 
programs that you run will automatically transition to other domains which 
have less access.  For example fdisk has no access files on a file system.  
So if you want to do "fdisk < /root/commands > /tmp/output" then it will not 
work.

Why would you want things to be other than they are in the default policy?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
