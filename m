Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i75IJ3rT007296
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 14:19:03 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i75IJ2Zl029196
	for <selinux@tycho.nsa.gov>; Thu, 5 Aug 2004 18:19:02 GMT
Subject: Re: netifcon
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alexis Wagner <venon@fugusec.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <41127650.5060007@fugusec.net>
References: <41127650.5060007@fugusec.net>
Content-Type: text/plain
Message-Id: <1091729898.2583.123.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 05 Aug 2004 14:18:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-08-05 at 14:02, Alexis Wagner wrote:
> Hi,
> 
> I have read this comment in the file attrib.te : ... operations on the 
> interface (XXX obsolete, not supported via LSM) .
> 
> I would like to know if I define a security context for an interface via 
> netifcon would it be supported by SELinux ?

You can still assign security contexts to interfaces and control traffic
sent or received on the interface based on that security context.  Only
operations on the interface (e.g. ioctls to configure the interface) are
being referenced by that comment; in the pre-LSM SELinux, permission
checks were directly inserted into the devinet code to check permissions
between the process security context and the interface security context;
LSM sought to avoid such deeply embedded security hooks.  In the
LSM-based SELinux, you can still leverage the existing capability
checks, as SELinux performs a parallel permission check whenever a
capability check is applied, so the SELinux policy still has to grant
you cap_net_admin in order to configure the interface, but this is just
a process-based authorization, not a per-interface based authorization.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
