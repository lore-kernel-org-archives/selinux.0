Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA08349
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 10:56:17 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA02590
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 14:54:39 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA02586 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 14:54:38 GMT
Date: Mon, 19 Aug 2002 10:55:19 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: ptrace permissions
In-Reply-To: <20020813134933.93C5D411@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0208191040170.14458-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 13 Aug 2002, Russell Coker wrote:

> I am trying to strace programs in my chroot environment.  I can trace a
> syslogd, a sshd, but the child sshd and a bash login shell it spawned are
> untracable.  Here's the AVC message:
>
> avc:  denied  { sys_ptrace } for  pid=31984 comm=strace capability=19
> scontext=root:user_r:user_t tcontext=root:user_r:user_t tclass=capability
>
> I'm using the latest SE Linux from the latest LSM kernel patch.
>
> The bash process is UID!=0, but the sshd is UID==0.

SELinux performs a sys_ptrace permission check whenever the kernel checks
the CAP_SYS_PTRACE capability.  The kernel checks this capability on
ptrace_attach if:
1) There is a mismatch between the current process' real uid and any of
the target process' uids (real, effective, or saved), or
2) There is a mismatch between the current process' real gid and any of
the target process' gids, or
3) The target process is no longer dumpable, e.g. due to a prior change in
uid or gid or lack of read access to the executable.

On a successful ptrace_attach, the kernel will also check this capability
and save the result in the ptrace flags (PT_PTRACE_CAP if granted) of the
target task.  This result is subsequently used in the
kernel must_not_trace_exec check to guard against tracing across set[ug]id
program execution unless the tracer had the capability.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
