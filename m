Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA27405
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2001 11:11:48 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id PAA26308
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2001 15:11:33 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id PAA26304
	for <selinux@tycho.nsa.gov>; Mon, 23 Jul 2001 15:11:32 GMT
Date: Mon, 23 Jul 2001 11:11:30 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: James Morris <jmorris@intercode.com.au>
cc: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Apache configuration
In-Reply-To: <Pine.LNX.4.31.0107221527160.18789-100000@blackbird.intercode.com.au>
Message-ID: <Pine.SOL.3.95.1010723104715.3466L-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 22 Jul 2001, James Morris wrote:

> I've been working on a simple policy configuration for the Apache server,
> a patch for which is attached below.

A more complex policy configuration for apache has been developed
by some folks at MITRE, but your simple policy configuration may
be more appropriate if you only want to serve static content.  I've
adjusted the MITRE apache policy for our new LSM-based SELinux
prototype, and it will be included in releases of that prototype.
MITRE could probably provide a copy of the original apache policy
for the original SELinux prototype.

> On system boot, it transitions from initrc_t as expected, but I'm not sure
> what the correct way is to then allow a sysadm user to (re)start and stop
> the server.  If I restart it as root, it runs in the root domain:
> 
> 	root:sysadm_r:sysadm_t
> 
> rather than the apache_t domain:
> 
> 	system_u:system_r:apache_t
> 
> Should these tasks be performed via runas?  Or should the policy be
> modified to allow transition from sysadm_t to apache_t?

A domain transition rule, e.g. domain_auto_trans(sysadm_t, apache_exec_t,
apache_t), would only address the domain change, i.e. sysadm_t to
apache_t.  The role and user identity would still be inherited
from the administrator shell.  That might be ok, but you would
need to add apache_t to sysadm_r as well then.

You could use runas to start the daemon with the correct security
context, but runas just runs in the domain of the caller, and
the sysadm_t domain doesn't have the necessary permissions to
transition to the right user identity and role.  It isn't a good
idea to grant those pemissions directly to sysadm_r/sysadm_t,
because they can be abused by malicious software.  That is
why newrole is a separate program that runs in its own
domain (with the necessary permissions) and that is why
newrole re-authenticates the user.  You could create a program
and domain similar to newrole that could be used to start
daemons with the appropriate security context.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
