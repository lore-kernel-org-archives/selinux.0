Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA20274
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2001 09:20:59 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA20306
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2001 14:20:56 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id OAA20302
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2001 14:20:56 GMT
Date: Wed, 21 Mar 2001 09:20:11 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Pedro Rosa <Pedro.Rosa@ksu.ru>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: lids
In-Reply-To: <3AB7FC36.1050007@ksu.ru>
Message-ID: <Pine.SOL.3.95.1010321082240.12705E-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


As I mentioned earlier, the LIDS FAQ itself uses the term
"mandatory access control" to describe some of the LIDS features.
The LIDS ACLs and capability assignments are administratively-defined,
so a system-wide security policy can be enforced on the granting of file
accesses and capabilities.  The protections against killing certain
processes in LIDS are a limited form of the general process-to-process
signal access controls in SELinux.

I'm not sure what you mean when you say that SELinux MAC is controlled
from a central point and that LIDS is not controlled from any center.  If
you are referring to the security server, keep in mind that the security
server is merely a subsystem in the kernel that reads the policy
configuration from a local file during startup (or during subsequent
policy reloads). The lack of an equivalent to the security server in LIDS
is simply a reflection of the fact that LIDS does not try to provide
flexible support for security policies.  But both systems allow different
policies to be defined for different machines if desired.

I'm also not sure what you mean by your discussion of untrusted
vs. trusted environments.  The mandatory access controls of SELinux
are quite useful for limiting the damage that can be caused by
flawed or malicious applications and for supporting different
levels of trust among users.  So SELinux should be quite useful
in the same environments where LIDS is useful.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
