Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA13460
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 09:23:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA15130
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 14:23:41 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id OAA15126
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 14:23:40 GMT
Date: Tue, 20 Mar 2001 09:22:47 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Jeff Largent <jlargent@imagelinks.com>
cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: lids
In-Reply-To: <3AB66197.26D95512@imagelinks.com>
Message-ID: <Pine.SOL.3.95.1010320083916.9741B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Security-Enhanced Linux (SELinux) has a well-defined architecture for
flexible mandatory access controls that has been experimentally
validated through several prototype systems (DTMach, DTOS, and Flask).
The architecture provides clean separation of policy from enforcement,
well-defined policy decision interfaces, flexibility in labeling and
access decisions, support for dynamic policy changes, caching to
minimize the performance overhead, and fine-grained controls over the
kernel abstractions.  Detailed studies have been performed of the ability
of the architecture to support a wide variety of security policies, and
are available through the links on the Background page.  The architecture,
interfaces, and controls are described in detail in the paper "Integrating
Flexible Support for Security Policies into the Linux Operating System"
accessible via the Documentation page.  The example security server
provided with SELinux supports Role-Based Access Control, Type
Enforcement, and optionally Multi-Level Security, and other
kinds of policies can be easily supported by the architecture.

My understanding of LIDS is that it provides support for
administratively-defined program-based ACLs for files and certain
security-critical objects (e.g. memory devices, raw devices, io ports),
controls over capabilities, "unkillable" processes, hiding 
files and processes in directory listings and /proc listings,
sending security alerts on security failures, and detecting
port scan attempts.  The first three features of LIDS are similar
to some of the SELinux mandatory access controls, but lack the
flexible support for security policies and do not address the
full set of services controlled by SELinux.  The fourth feature,
hiding file names and /proc entries, is not provided by SELinux, but
SELinux does control all attempts to access files and /proc entries.
The fifth feature, sending security alerts, has no direct equivalent in
SELinux.  SELinux does provide some simple support for selective auditing
of access grantings and/or denials based on the security policy
configuration.  However, the audit data is currently handled by the
existing kernel logging support, which we recognize as being insufficient
for auditing.  The last feature, detecting port scans, has no
relationship to mandatory access controls and consequently has no
equivalent in SELinux.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Mon, 19 Mar 2001, Jeff Largent wrote:

> In just a brief look I didn't see a lot of difference
> between lids and seLinux, am I missing something.
> 
> 
> -- 
> Jeff Largent                   ImageLinks, Inc.
> System Admin                   Melbourne, Fl 32935
> (321) 253-0011                 fax:(321) 253-5559
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
