Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA06285
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 13:06:54 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA24151
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 17:05:43 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA24145 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 17:05:42 GMT
Date: Thu, 18 Apr 2002 13:05:53 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: every.te
In-Reply-To: <20020418165519.6F4DF1B18@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204181302250.5560-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 18 Apr 2002, Russell Coker wrote:

> The following operation from ls produces the access described below.
> _sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xbffff5f4, 32, (nil), 0}) = 0
>
> Apr 18 18:51:23 lyta kernel: avc:  denied  { search } for  pid=3006
> exe=/bin/ls
> scontext=system_u:system_r:dpkg_t tcontext=system_u:object_r:sysctl_kernel_t
> tclass=dir
> Apr 18 18:51:23 lyta kernel:
> Apr 18 18:51:23 lyta kernel: avc:  denied  { read } for  pid=3006 exe=/bin/ls
> scontext=system_u:system_r:dpkg_t tcontext=system_u:object_r:sysctl_kernel_t
> tclass=file
>
> Would it make sense to add this to every.te?  It seems that almost everything
> wants to know the kernel version...

You might not want to grant read access to /proc/sys/kernel to every
process on the system.  Hence, I'd suggest that these kinds of permissions
belong in macros within global_macros.te (e.g. the
existing general_proc_read_access macro or something finer-grained) that
can be selectively applied to individual domains.  In contrast, the init_t
sigchld permission is essentially necessary from a functional perspective
for all processes, so it makes sense to place it in every.te.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
