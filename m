Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KDefrT003834
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 09:40:41 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KDeeQ4026200
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 13:40:40 GMT
Subject: Re: policy for scponly - need help
From: Colin Walters <walters@verbum.org>
To: Stefan SF <stefan@sf-net.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20040820080156.GA8602@crux.sternplastic>
References: <20040819173620.GA8543@crux.localdomain>
	 <1092967183.29540.30.camel@nexus.verbum.private>
	 <20040820080156.GA8602@crux.sternplastic>
Content-Type: text/plain
Date: Fri, 20 Aug 2004 09:41:17 -0400
Message-Id: <1093009277.4336.11.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-20 at 10:01 +0200, Stefan SF wrote:
> Hi!
> 
> > scponly seems similar to rssh.  You may want to try my rssh policy:
> > http://verbum.org/files/rssh_macros.te
> > http://verbum.org/files/rssh.te
> > http://verbum.org/files/rssh.fc
> 
> Hmm I can't make head or tail of this. I think the scponly-problem is another one.
>  Because you don't have to transit or anything else in the rssh-policy (user -> role).

Exactly the point!  The kernel thus ensures that the user is not able to
enter the user_r role at all.  This is far more secure than what you are
doing with transitioning from user_t to scponly_exec_t.  Instead, I only
authorize the user for the rssh role.

Here, I documented the process a bit better a while ago:
http://marc.theaimsgroup.com/?l=selinux&m=107395821724390&w=2

You shouldn't need to touch user_t at all.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
