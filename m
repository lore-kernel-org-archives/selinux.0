Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA15772
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2001 14:22:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA24178
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2001 19:22:03 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA24174
	for <selinux@tycho.nsa.gov>; Mon, 8 Jan 2001 19:22:02 GMT
Date: Mon, 8 Jan 2001 14:21:06 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Andrew Morgan <morgan@transmeta.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Comparison with POSIX.1e MAC
In-Reply-To: <3A59FF89.52186FE8@transmeta.com>
Message-ID: <Pine.SOL.3.95.1010108135736.2077B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Mon, 8 Jan 2001, Andrew Morgan wrote:

> I've not found the archives for this list anywhere, so someone may have
> already answered this, but how does the selinux framework compare with
> the Mandatory Access Control stuff contained in the withdrawn POSIX.1e
> draft? The draft can be found here:
> 
>   http://www.guug.de/~winni/posix.1e/download.html

There is currently an unofficial archive of the mailing list at
http://marc.theaimsgroup.com/?l=selinux.  An official archive
should be forthcoming soon.

As discussed in the paper "The Inevitability of Failure:  The
Flawed Assumption of Security in Modern Computing Environments"
(accessible via the Background web page), the TCSEC provides
a narrow definition of mandatory security that is tightly coupled to 
the multi-level security policy.  Recent work has explored alternative 
forms of mandatory (aka nondiscretionary) security such as Role-Based
Access Control and Type Enforcement.  These alternative forms of mandatory
security offer better support for protecting applications against
tampering or bypass, for preventing the execution of untrustworthy
programs, and for enforcing least privilege.

The Security-Enhanced Linux has a well-defined architecture (named Flask)
for flexible mandatory access controls that has been experimentally
validated through several prototype systems (DTMach, DTOS, and Flask).
The architecture is a generalization of Type Enforcement.  It provides
clean separation of policy from enforcement, well-defined policy decision
interfaces, flexibility in labeling and access decisions, support for
policy changes, and fine-grained controls over the kernel abstractions.
Detailed studies have been performed of the ability of the architecture to
support a wide variety of security policies and are available on the DTOS
and Flask web pages accessible via the Background page 
(http://www.nsa.gov/selinux/background.html).  A published paper about
the Flask architecture is also available on the Background page.  The
architecture and its implementation in Linux are described in detail in
the documentation (http://www.nsa.gov/selinux/docs.html).  

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
