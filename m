Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA06675
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 13:35:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id RAA24134
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 17:33:45 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id RAA24130
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 17:33:43 GMT
Date: Tue, 1 Oct 2002 13:35:02 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: <ml-selinux@unpatched.net>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Bug in selinux_task_reparent_to_init (?)
In-Reply-To: <Pine.LNX.4.33.0210011937280.6143-100000@crypt.netvision.net.il>
Message-ID: <Pine.GSO.4.33.0210011324510.14489-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 1 Oct 2002 ml-selinux@unpatched.net wrote:

> During a brief code review of selinux-lsm I noticed that in the function
> hooks.c:selinux_task_reparent_to_init() there is:
>
> tsec = current->security;
>
> I assume this code was copied from selinux_task_kmod_set_label(), but
> shouldn't it be 'tsec = p->security;' and act on p instead of current in
> this case ?

Strictly speaking, yes.  But it doesn't matter, because the kernel
reparent_to_init() function [in kernel/sched.c in 2.4, or kernel/exit.c
in 2.5] always operates on the current task (this_task = current in 2.4,
and direct use of current in 2.5).  We pass the task to the hook for
generality in case the kernel code changes in the future to use a
different task, so the hook should use 'p' instead of 'current', but it
doesn't make any difference at present.  A kernel thread gets its own task
structure.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
