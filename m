Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k93FjJTi015061
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 11:45:19 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k93FihBu026675
	for <selinux@tycho.nsa.gov>; Tue, 3 Oct 2006 15:44:44 GMT
Subject: Re: RHEL5 Kernel with labeled networking
From: Eric Paris <eparis@parisplace.org>
To: Linda Knippers <linda.knippers@hp.com>
Cc: selinux@tycho.nsa.gov, redhat-lspp@redhat.com, paul.moore@hp.com,
        vyekkirala@TrustedCS.com, jmorris@namei.org
In-Reply-To: <452282F2.1000107@hp.com>
References: <1159834998.28144.115.camel@localhost.localdomain>
	 <452282F2.1000107@hp.com>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 11:45:56 -0400
Message-Id: <1159890356.28144.136.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-03 at 11:34 -0400, Linda Knippers wrote:
> Eric,
> 
> I've booted your kernel on the following systems:
> 
> ia64 box running rhel5 beta 1 targeted policy
> x86 box running fc6t2 mls policy
> 
> I don't have any labeled networking specifically configured.
> 
> Networking only works in permissive mode.  If I put either system
> in enforcing mode, I can't ping, bring up X, or do anything.
> 
> Are there some policy changes that are needed?   Seems like by default
> everything should work like it did before?
> 
> -- ljk

I think there is going to need to be a policy change that I'm actually
talking with Dan about as I type this e-mail.  I think we  need

allow $1 unlabeled_t:packet { flow_in flow_out };

to be added to policy to allow things to work as they did.  I'll post
again as soon as we have a policy that appears to let normal networking
work in enforcing.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
