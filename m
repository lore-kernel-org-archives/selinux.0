Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA03349
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 14:44:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA03845
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 19:44:04 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id TAA03841
	for <selinux@tycho.nsa.gov>; Tue, 4 Dec 2001 19:44:04 GMT
Date: Tue, 4 Dec 2001 14:43:28 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: OOPS, the earlier script had an error
In-Reply-To: <1007491244.3468.2.camel@jsmith.org>
Message-ID: <Pine.GSO.4.33.0112041403260.28408-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Thanks for the updated script.  You might want to make it a filter,
reading from standard input and writing to standard output.  Then you can
just do 'dmesg | script > newrules.te' or 'script < /var/log/messages >
newrules.te'.  Could you clarify under what terms you are releasing
this script (e.g. GPL)?

In addition to my earlier caveat about carefully reviewing the output to
see whether you should add some new domains and/or types rather than
simply granting the permission for the existing domains and/or types, let
me add a couple of other notes of caution:

1) The script assumes that a denial occurs due to a lack of permission in
the Type Enforcement (TE) configuration.  But a denial might also occur
due to a lack of authorization in the Role-Based Access Control (RBAC)
configuration or a constraint in the constraints configuration (or, if
MLS is enabled, a violation of the MLS policy).  Due to the encapsulation
of the security policy logic and the caching of security decisions, there
is no way to know the particular policy component that caused the denial
when the access is denied and the audit message is generated.  You can't
address this problem in your script - it requires other support either
from the checkpolicy program or from policy analysis tools.  But you
should be aware of it, since you may find yourself encountering the same
denial even after adding the permission to the TE configuration.

2) The script doesn't know whether the application truly needs the
permission in order to function.  For example, the library functions for
accessing utmp file entries always try to open utmp with read and write
access, and fall back to opening with read-only access if this fails.  So
applications that only need to read from utmp will still show up as trying
to open with write access.  In this case, there is no legitimate reason to
grant write permission, but it will show up in the audit messages unless
you suppress it using the auditdeny rules.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com










--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
