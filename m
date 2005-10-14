Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9ELlONs011484
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 17:47:24 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9ELjPTX009049
	for <selinux@tycho.nsa.gov>; Fri, 14 Oct 2005 21:45:26 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chad Hanson <chanson@TrustedCS.com>
Subject: Re: MLS policy
Date: Sat, 15 Oct 2005 07:44:41 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <36282A1733C57546BE392885C0618592D3952A@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592D3952A@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510150744.49522.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 15 October 2005 00:23, Chad Hanson <chanson@trustedcs.com> wrote:
> > Currently a default root login gets a default level of s2.  This means
> > that daemons initially run with the range s0-s9 but run with the range
> > s2-s9 after being restarted.  Should we have range-transition rules in the
> > daemon_domain family of macros to deal with this?
>
> We do have range_transition policy to handle this. This will be included in
> a MLS policy update we are working on.

OK.

> > What is the benefit of assigning root the default level of s2 anyway?
>
> Historically on MLS users login in above the lowest level. Part of this
> reason is for integrity, which is not necessary for on a system with TE.

Does that mean we should have a default of s2 or s0 for root?

> A last comment is that an MLS/RBAC/CAPP system should not allow direct root
> logins, but instead just the ability to su.

Why is that?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
