Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBB1K1Rb001165
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 20:20:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBB1JGlU018986
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 01:19:16 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hBB1IxSX018921
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 01:19:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: nagray@austin.rr.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: changing root to default to sysadm_r
Date: Thu, 11 Dec 2003 12:18:18 +1100
References: <1071096702.4060.948.camel@hawaii.efficax.net>
In-Reply-To: <1071096702.4060.948.camel@hawaii.efficax.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312111218.18454.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 11 Dec 2003 09:51, Nick <nagray@austin.rr.com> wrote:
> I thought I could do make root come up in the sysadm_r initially by
> changing the users.te file
>
> diff users .users
> 42c42
> < user root roles { sysadm_r staff_r };
> ---
>
> > user root roles { staff_r sysadm_r };

As far as I am aware there are no order dependencies at all in the policy 
(Steve, please correct me if I am wrong).

A quick test on my machine shows that the policy database has the same MD5 
checksum regardless of the order of roles in such statements.  But even if 
there was a difference, there is no API for applications to learn about such 
differences.

The way to solve this is to change the order in
/etc/security/default_contexts, change this:
system_r:local_login_t  user_r:user_t staff_r:staff_t sysadm_r:sysadm_t
to this:
system_r:local_login_t  sysadm_r:sysadm_t user_r:user_t staff_r:staff_t

On Thu, 11 Dec 2003 11:04, forrest whitcher <fw@fwsystems.com> wrote:
> If root defaults to sysadm_r, then certain kinds of sshd exploits
> (kinds that _heve_ been seen before) can get the attacker sysadm_r,
> game over, not good.

It's true that we don't want to permit sshd to transition to sysadm_r.  
However I believe that it's OK to permit this from local_login_t for the 
following reasons:
1)  /bin/login code is simpler than sshd code.
2)  /bin/login can only be accessed from system console which prevents entire 
classes of attack.
3)  The standard administration practise is to ssh to servers as non-root and 
then "su" to perform admin tasks, using newrole is a variation on that theme 
and corresponds to expectations of users.  It is standard practise to login 
directly as root at the console, because of this users expect to be able to 
login as sysadm_r at the console.

2 is probably the killer arguement, 1 is important too, 3 is necessary for 
user acceptance (we could have an arguement about whether it makes sense from 
a security POV).

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
