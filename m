Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GE03L9015761
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 09:00:03 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GDuSNj017959
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 13:56:28 GMT
Date: Wed, 16 Feb 2005 14:08:49 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: dynamic context transitions
Message-ID: <20050216140849.GQ31121@lkcl.net>
References: <20050215213455.GF26294@lkcl.net> <1108559153.19756.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108559153.19756.49.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 16, 2005 at 08:05:53AM -0500, Stephen Smalley wrote:
> On Tue, 2005-02-15 at 16:34, Luke Kenneth Casson Leighton wrote:
> > i assume it _is_ necessary to perform dynamic auto transitions?
> > 
> > such that i can track to alternative contexts, yes?
> 
> No.  Dynamic transitions are always explicitly requested by
> applications, just like setuid(2) calls.  Since you must modify the
> application anyway to introduce the dynamic context transition (unlike
> an automatic transition upon an existing execve call), there is no such
> thing as an automatic dynamic transition.  

 the patch i created last night provides exactly that functionality.

 whether it's the right thing to do, and whether it checks appropriate 
 permissions or not is an entirely different matter :)

 i picked process:dyntransition and process:setcontext out of thin air,
 based on observing the use of allow $1 $3:process transition and
 allow $3 $2:file entrypoint in the domain_trans macro.

 heck, maybe it _should_ be process:dyntransition and process:entrypoint.

 ... i will wait until someone absorbs the impact and implications
 of the patch i created.


> Now, the issue of how to get
> the right new domain is another matter.  For user contexts, we want
> something akin to get_default_context().  

 yes.
 
 [i understand about get_default_context() only supporting
 transition not dyntransition]

> But in this case, you are
> again dealing with two fixed domains that are not associated with a
> user, 

 no, that's wrong.
 
 i _do_ need a domain which is associated with the user,
 in an easily derivable manner, that can be specified in the
 SE-Linux policy source.

 why?

 in order to be able to restrict users from logging in on a per-IP
 basis.

 e.g. so restricted_user1 can ONLY ssh in from 192.168.0.223, because
 i set up a net_context that said so, and associated
 sshd_priv_restricted_user1_t with that network context

 (instead of using the can_network() macro, i'd use a hacked version
  of can_network())

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
