Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA12761
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 10:21:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA08005
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 15:19:51 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA08001
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 15:19:50 GMT
Date: Thu, 11 Jan 2001 10:20:34 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Jeffry Smith <smith@missioncriticallinux.com>
cc: selinux@tycho.nsa.gov, linux-privs-discuss@sourceforge.net
Subject: Re: SELinux & Linux-privs projects 
In-Reply-To: <E14GiyE-0000nL-00@smith>
Message-ID: <Pine.SOL.3.95.1010111095226.23465N-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Thu, 11 Jan 2001, Jeffry Smith wrote:

> Sent to both lists
> Since I hadn't seen any traffic on the two lists about the other project, I 
> thought I'd cross-send a message, to ensure the two communities are aware of 
> what the other is doing.  I figure, although the projects are tackling 
> different parts of the security of linux, there should be some overlap, since 
> privileges should make it easier to do the type enforcement (I think), and the 
> type enforcement can help with requirements for privileges (right?).
> 
> Comments?  

The two mechanisms are mostly orthogonal, although SELinux can help
to support the capability model and perhaps to even replace it.  The
POSIX.1e capabilities can be used to decompose superuser privileges for
overriding the traditional Unix access controls.  SELinux provides a
flexible mandatory access control architecture that can support a wide
range of security policies.  There is no need for a mechanism to override
the SELinux mandatory access controls because the security policy can be
configured as needed to support fine-grained privileges for processes
with respect to the mandatory controls.  There is no need for any kind of
"trusted" subject that operates outside of the boundaries of the mandatory
access control architecture in SELinux.

To better support the capability mechanism, the ability to
use a capability is controlled by the SELinux mandatory access controls.
A parallel mandatory access control is defined for each capability
and must be granted by the security policy in order for the
capability to be used. Since SELinux provides subject labeling and 
can support labels derived both from the attributes of the user and the
program, it can restrict the use of capabilities to the appropriate
program through the security policy configuration.

In one of the predecessors of SELinux (the DTOS system), the NSA
implemented a different mechanism than the POSIX.1e capabilities
for decomposing superuser privileges.  The superuser privileges were
partitioned by having the security server return a set of override
decisions along with its access decisions, where these override decisions
could cause access to be granted even if the Unix access control would
ordinarily deny access.  Unlike the Linux capabilities, these override
decisions could be based on both the label of the subject and the label of
the relevant object. This mechanism permitted fine-grained decomposition
(e.g. permission to override DAC read restrictions could be limited to
files with certain security labels) and simpler management (through the
use of the centralized security policy).  Similar support could be added
to the Security-Enhanced Linux as well but is not present in the
current implementation.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
