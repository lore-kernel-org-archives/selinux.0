Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA13816
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 10:28:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA14747
	for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 14:26:31 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA14742 for <selinux@tycho.nsa.gov>; Tue, 10 Sep 2002 14:26:31 GMT
Date: Tue, 10 Sep 2002 10:27:18 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Tracy R Reed <treed@ultraviolet.org>
cc: SE Linux <selinux@tycho.nsa.gov>, Trent Jaeger <jaegert@us.ibm.com>
Subject: Re: IBM's Multics paper
In-Reply-To: <20020909163557.K20187@ultraviolet.org>
Message-ID: <Pine.GSO.4.33.0209100953200.23354-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 9 Sep 2002, Tracy R Reed wrote:

> At the top of page 3 of the report (page 5 in your pdf viewed) they
> specifically mention SE Linux. They compared Multics 768k bytes of
> executable code and data 1767k bytes and suggest that it is far too big to
> be secure and that the complexity leading to that large size needs to be
> corrected. I infer that due to the Linux kernels monolithic design that
> this may not be possible.

IMHO, the comparison in the first paper seems very odd.  I take their
point to be that SELinux is far from being a small, verifiable,
security kernel.  No kidding.  You can see that simply by looking at the
size of the base Linux kernel, although that size can vary depending on
your particular kernel configuration.  It also seems questionable to blend
the example policy size with the module size, as the example policy can be
easily stripped down for a particular system and is merely an access
matrix.  If you are going to incorporate that kind of information into
your size estimate, then you had better also include the size information
for all of the ACLs stored on a Multics system.

> Is it realistic to compare a modern OS to Multics? Of course the logical
> requirements of multi-level OS security haven't really changed in 28 years
> and there is no reason why it should take more bytes to implement the same
> ideas so perhaps they are right.

SELinux provides flexible support for mandatory access controls, which is
more than just multi-level security.  Other non-discretionary access
control models like TE and RBAC offer definite benefits.

The authors' position doesn't seem constructive.  Advocating work on
structuring new systems around a security kernel is fine, but attacking
efforts to incrementally improve the security of existing systems is not
helpful.  It also seems questionable that the two examples of security
kernels (VAX VMM, GEMSOS) that the authors hold up as models for
commercial products happen to have been developed by the authors
themselves.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com













--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
