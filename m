Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA25436
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 08:20:19 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA08114
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 12:18:27 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA08110
	for <selinux@tycho.nsa.gov>; Fri, 3 May 2002 12:18:27 GMT
Date: Fri, 3 May 2002 08:19:50 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: kmod.te
In-Reply-To: <20020503030905.08E4049@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0205030812390.16931-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 3 May 2002, Russell Coker wrote:

> In the latest sample policy we have:
> can_exec(kmod_t,modprobe_exec_t)
> can_exec(kmod_t,insmod_exec_t)

This isn't new to the latest sample policy - in fact, these rules even
appear in the original SELinux prototype's policy.

> I don't like that idea.  I have the following:
> domain_auto_trans(kmod_t,insmod_exec_t,insmod_t)
>
> My idea is that it's better to use domain_auto_trans to give access to the
> insmod_t domain than to give other domains extra privs (although kmod_t
> should be safe ;).

If you perform a transition from kmod_t to insmod_t, then you can no
longer distinguish between module insertions initiated by the kernel vs.
module insertions initiated by some user process that can transition to
insmod_t.  Consider the scenario where someone wishes to prohibit all
insertions by user processes but is willing to allow insertions initiated
by the kernel.  Hence, it seems preferable to remain in kmod_t so that the
policy can distinguish these events if desired.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
