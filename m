Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id BAA19464
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 01:49:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id FAA18477
	for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 05:48:34 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id FAA18473 for <selinux@tycho.nsa.gov>; Thu, 9 May 2002 05:48:31 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: kmod.te
Date: Thu, 9 May 2002 15:22:14 +1000
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0205030812390.16931-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0205030812390.16931-100000@raven>
MIME-Version: 1.0
Message-Id: <20020509054938.BC169310F@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 3 May 2002 22:19, Stephen Smalley wrote:
> > I don't like that idea.  I have the following:
> > domain_auto_trans(kmod_t,insmod_exec_t,insmod_t)
> >
> > My idea is that it's better to use domain_auto_trans to give access to
> > the insmod_t domain than to give other domains extra privs (although
> > kmod_t should be safe ;).
>
> If you perform a transition from kmod_t to insmod_t, then you can no
> longer distinguish between module insertions initiated by the kernel vs.
> module insertions initiated by some user process that can transition to
> insmod_t.  Consider the scenario where someone wishes to prohibit all
> insertions by user processes but is willing to allow insertions initiated
> by the kernel.  Hence, it seems preferable to remain in kmod_t so that the
> policy can distinguish these events if desired.

Fair point.

In that case I think that we should have a macro for the majority of the 
insmod policy instead of duplicating policy code.  I suggest that the macro 
be in the start of modutil.te and be used twice from there.  I think that 
such policy belongs in modutil.te because the modules utilities are optional 
(you can compile a kernel without module support), but kmod.te will always be 
required.

Also is there any system using a version of modutils that has separate 
programs for insmod, rmmod, and modprobe but which runs the required versions 
of all other software for running SE Linux?  If not then I suggest that we 
remove all references to having separate programs from the policy.

-- 
If you send email to me or to a mailing list that I use which has >4 lines
of legalistic junk at the end then you are specifically authorizing me to do
whatever I wish with the message and all other messages from your domain, by
posting the message you agree that your long legalistic sig is void.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
