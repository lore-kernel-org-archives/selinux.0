Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5QDqdNB008722
	for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2013 09:52:55 -0400
Received: by mail-gh0-f179.google.com with SMTP id f16so4618955ghb.10
        for <selinux@tycho.nsa.gov>; Wed, 26 Jun 2013 06:52:39 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, eparis@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 0/9] Labeled networking patches for 3.11
Date: Wed, 26 Jun 2013 09:52:35 -0400
Message-ID: <1673112.0yesQv5a1q@sifl>
In-Reply-To: <51CA2D5E.5010501@schaufler-ca.com>
References: <20130625211306.5057.31329.stgit@localhost> <51CA2D5E.5010501@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tuesday, June 25, 2013 04:53:02 PM Casey Schaufler wrote:
> On 6/25/2013 2:18 PM, Paul Moore wrote:
> > Nothing new here, all of these patches have been posted before.  I'm
> > 
> > posting these patches again for two reasons:
> >  1. Remind Eric he still hasn't merged them into the SELinux tree
> >  2. Send notice that I've pushed the patches to my -next tree so
> >     they should be in the next spin of linux-next
> > 
> > I was hoping that there patches would have hit linux-next by now via
> > the SELinux tree but that hasn't happened so I'm going to do it via
> > my labeled networking tree (all the patches are labeled networking
> > related anyway).
> 
> No objection from this end, but I'm curious about the motivation
> for the changes as they affect the LSM interface.

I assume you are talking about patch 2/9?

I guess first things first, the changes don't affect how the rest of the 
kernel sees the LSM, only how an individual LSM is implemented.  If you look 
at the pre-patch LSM hook implementation for security_xfrm_state_alloc() and 
security_xfrm_state_alloc_acquire() you notice that they share a common LSM-
specific implementation function, xfrm_state_alloc_security(), which takes 
different arguments depending on the LSM hook.  If you look at how SELinux 
implements this function (SELinux is the only example available that uses this 
hook) you will notice that there the behavior varies quite a bit depending on 
the LSM hook caller; in reality, the function is much cleaner and simpler if 
we split it so that we have one hook implementation for each LSM hook - like 
pretty much everything else in the LSM.

-- 
paul moore
security and virtualization @ redhat

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
