Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA14764
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 17:19:11 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id WAA22131
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 22:18:42 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id WAA22127
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 22:18:41 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id RAA27944
	for <selinux@tycho.nsa.gov>; Fri, 22 Dec 2000 17:17:45 -0500 (EST)
Date: Fri, 22 Dec 2000 17:17:45 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Re: NSA's Security-enchanced Linux now available
In-Reply-To: <3A438196.C01DD9B3@tac.ch>
Message-ID: <Pine.SOL.3.95.1001222155551.24350B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Fri, 22 Dec 2000, ratz wrote:

> I'll definitely have a closer look at it during the christmas days. However
> would it be possible for you to make some comparisons between other open source
> or not open source implementations of MAC or/and rule based access controls
> such as referred to in the Orange Book, in POSIX1e or various thesis? I would
> like to get some information about the implementation model used (although I
> can and will of course glance at the code) and what is different to other 
> models like the ones used in:
> 
> RSBAC           (http://www.rsbac.org)
> argus-B1        (http://www.argus-systems.com/)
> Trusted Solaris (somewhere in the depth of http://www.sun.com)
> Trusted Irix    (http://oss.sgi.com/projects/ob1/)
> 
> and lots of others...

The Security-Enhanced Linux has a well-defined architecture for
flexible mandatory access controls that has been experimentally
validated through several prototype systems (DTMach, DTOS, and Flask).
The architecture provides clean separation of policy from enforcement,
well-defined policy decision interfaces, flexibility in labeling
and access decisions, support for policy changes, and fine-grained
controls over the kernel abstractions.  Detailed studies have been
performed of the ability of the architecture to support a wide variety of
security policies and are available on the DTOS and Flask web pages
accessible via the Background page.

The security architecture is described in the overview
section of the kernel document (Integrating Flexible Support
for Security Policies into the Linux Operating System).  On
the Background page, you will also find a copy of a published paper
about the security architecture (The Flask Security Architecture:
System Support for Diverse Security Policies).

RSBAC appears to have similar goals to the Security-Enhanced Linux.
Like the Security-Enhanced Linux, it separates policy from enforcement
and supports a variety of security policies.  RSBAC uses a different
architecture (the GFAC) than the Security-Enhanced Linux, although the
Flask paper notes that at the highest level of abstraction, the
the Flask architecture is consistent with the GFAC.  However,
the GFAC does not seem to fully address the issue of policy changes
and revocation, as discussed in the Flask paper.  RSBAC also differs
in the specifics of its policy interfaces and its controls, but
a careful evaluation of the significance of these differences has
not been performed.

Unlike traditional trusted operating systems, the Security-Enhanced
Linux provides flexible support for security policies.  It can
support multi-level security, but it can also support Type
Enforcement, Role-Based Access Control, and other kinds of
policies.  Furthermore, since it cleanly separates policy
from enforcement, the security policy logic can be radically
revised without requiring any changes to the rest of the 
operating system.  

The POSIX.1e capabilities allow one to decompose superuser
privileges.  This is not the same as a mandatory access control
mechanism, and it does not support enforcing the separation of 
information based on integrity and confidentiality requirements.
In the Security-Enhanced Linux, these capabilities do not
override the mandatory access controls.  In fact, the ability
to use a capability is controlled by the mandatory access controls.
Since the Security-Enhanced Linux provides subject labeling,
it can restrict the use of capabilities to the appropriate programs
through the centralized security policy configuration.

In one of the predecessors of the Flask architecture (the DTOS system),
the NSA implemented a more general mechanism for decomposing superuser
privileges.  The superuser privileges were partitioned by having the
security server return a set of override decisions along with its
access decisions, where these override decisions could cause access
to be granted even if the Unix access control would ordinarily deny
access.  Unlike the Linux capabilities, these override decisions could be
based on both the label of the subject and the label of the relevant
object. This mechanism permitted fine-grained decomposition (e.g.
permission to override DAC read restrictions could be limited to files
with certain security labels) and simpler management (through the use of
the centralized security server).  Similar support could be added to the
Security-Enhanced Linux as well but is not present in the
current implementation.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com







You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
