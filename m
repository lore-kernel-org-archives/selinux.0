Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA07018
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 08:36:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA25278
	for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:35:15 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA25274 for <selinux@tycho.nsa.gov>; Mon, 19 Aug 2002 12:35:14 GMT
Date: Mon, 19 Aug 2002 08:36:14 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Brad Chapman <jabiru_croc@yahoo.com>
cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: entrypoint permission
In-Reply-To: <20020817125827.67159.qmail@web40017.mail.yahoo.com>
Message-ID: <Pine.GSO.4.33.0208190738530.14458-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 17 Aug 2002, Brad Chapman wrote:

>       What does the 'entrypoint' permission do? It seems to be related to
> domains transfer and program execution, but not in an intuitive way.

As an aside, the meaning of each SELinux permission was originally
described in the old technical report available from
http://www.nsa.gov/selinux/slinux-abs.html.  Changes to the SELinux
permissions for LSM are described in the module technical report available
in selinux/doc/module or from http://www.nsa.gov/selinux/module-abs.html.

For the TE model, the entrypoint permission controls what program types
can be executed to initially enter a given domain.  It is typically
granted via the domain_trans macro or domain_auto_trans macro, except for
the special check performed by crond to deal with crontab files [since
crontabs are "interpreted", not executed].  In the policy configuration, a
distinct xxx_exec_t type is usually (but not always) defined for each
domain and used as that domain's entrypoint type.  This type should only
be assigned to programs used to enter the domain, and should preferably
be limited to a single program for each domain whenever possible.  The
entrypoint permission in combination with the process transition
permission provides strong control over domain transitions based on the
initial domain, the program type, and the new domain.

In contrast to entrypoint permission, the execute_no_trans permission
controls what program types by a domain can be executed without
transitioning to another domain.  For example, although the login process
can execute a user shell, it should always change its SID at the same
time, so it does not need execute_no_trans permission to the shell
program.  The execute_no_trans permission is typically granted via the
can_exec* macros.  can_exec access for any kind of privileged domain
should also be minimized when possible to reduce risk (e.g. it is
preferable that daemons not be able to execute shells without at least
changing to another domain).

The execute permission is checked whenever Linux would perform an execute
check via the kernel permission() function, as well as in mmap or mprotect
when execute access is requested (e.g. for shared libraries).  This
permission provides coarse-grained control over the full set of types that
can be executed by a domain.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com








--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
