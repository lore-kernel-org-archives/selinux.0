Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA20430
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 12:01:10 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA07205
	for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 17:00:14 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id RAA07201 for <selinux@tycho.nsa.gov>; Wed, 20 Feb 2002 17:00:13 GMT
Date: Wed, 20 Feb 2002 12:00:35 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Giovanni Mugnai <giovanni@unirel.it>
cc: <selinux@tycho.nsa.gov>
Subject: Re: Some questions?
In-Reply-To: <200202201636.g1KGa9s02252@unirel.unirel.it>
Message-ID: <Pine.GSO.4.33.0202201144000.9757-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 20 Feb 2002, Giovanni Mugnai wrote:

> Configuring the kernel i found, and set, the "Security Option" as reported in
> the README, but i found, and set, only the "Network Packet Filtering" option
> from the "Networking Options". I couldn't find neither "Kernel/User Netlink
> Socket" and "Routing Messages".
> There's someone can explain me why?
> There could be problems?

The Kernel/User Netlink Socket and Routing Messages options were
mainstreamed in 2.4.17, so you no longer need to explicitly enable them in
the kernel configuration.  They have also been mainstreamed in the 2.5
kernel as of 2.5.3, so the discussion of these options will be removed
from the README before the next release of SELinux.

> I'm at the beginning so there's someone that could help me to know which
> users put in the context_file and which in the cron_context file?

Most of the entries in /etc/passwd don't require an entry in policy/users
or the *context files, because they don't need to login/ssh to the system
or set up cron jobs.  From your passwd listing, it looks like you would
want an entry for root, sysadm, and guest.  You need an entry for these
users in each of the policy/users, default_context, and cron_context
files.  You also need the system_u entry in the cron_context file.

In the next release, there will be support for mapping all unspecified
Linux users to a single generic unprivileged SELinux user, so that will
reduce the maintenance burden for ordinary users.  Also, at some point,
the *context files will be replaced by a single default_contexts file that
won't require per-user entries at all, and you will only need to maintain
policy/users.  This has been discussed previously on the list - please see
the mailing list archives.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
