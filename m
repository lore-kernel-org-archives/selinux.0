Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3G48LI4029892
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 00:08:21 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3G44YOv000943
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 04:04:34 GMT
Received: from lyta.coker.com.au (c16702.sunsh1.vic.optusnet.com.au [210.49.228.68])
	by jazzswing.ncsc.mil  with ESMTP id h3G44HY1000940
	for <selinux@tycho.nsa.gov>; Wed, 16 Apr 2003 04:04:33 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: SELinux version of sudo
Date: Wed, 16 Apr 2003 14:08:06 +1000
Cc: selinux@tycho.nsa.gov
References: <3E9C17E9.2060203@redhat.com> <1050428015.1051.98.camel@moss-huskers.epoch.ncsc.mil>
In-Reply-To: <1050428015.1051.98.camel@moss-huskers.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200304161408.06042.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 16 Apr 2003 03:33, Stephen Smalley wrote:
> The idea of merging su and newrole has been suggested on the list
> previously; please be sure that you have read the earlier discussions
> and are aware of the potential risks, e.g. see the thread starting at
> http://marc.theaimsgroup.com/?l=selinux&m=102643997004008&w=2, so that
> you can avoid common pitfalls.

That thread did not entirely convince me not to do it, but did convince me 
that it would take much of consideration and testing, and that there were 
more important things to spend time on.

Another potential solution to this issue is to allow the administrators in 
question to ssh into an account with UID=0 and then they only need to use 
newrole to get all the privs they need.

> via allow rules.  It isn't clear that you should be using the existing
> $1_su_t domain for this purpose, unless you are also patching su to
> provide this functionality and to ensure that it does not allow

I agree.  The $1_su_t domain only makes sense when you are limiting the 
transitions to a certain set of domains.  If you grant the su/sudo program 
privrole access then there is no benefit in having more than one domain in 
the way it is currently done.

Maybe we should work from the other direction and consider adding setuid() 
support to newrole?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
