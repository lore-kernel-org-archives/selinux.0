Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA13871
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 12:01:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA12881
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:59:58 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA12877
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:59:58 GMT
Date: Thu, 11 Jan 2001 11:59:47 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: selinux@tycho.nsa.gov, linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] SELinux & Linux-privs projects
In-Reply-To: <20010111171602.B5816@caldera.de>
Message-ID: <Pine.SOL.3.95.1010111115658.23465U-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Thu, 11 Jan 2001, Christoph Hellwig wrote:

> > It is also quite different
> > from POSIX.1e mandatory access controls, which are tied to a 
> > specific kind of mandatory security policy.
> 
> Capabilities and mac are of course different, otherwise you probably
> won't find them in the same posix standard...

I guess my antecedent was ambiguous.  I was trying to say that
the SELinux mandatory access controls are quite different from
POSIX.1e mandatory access controls, because SELinux provides
a flexible mandatory access control architecture that can
support many different kinds of security policies while
POSIX.1e is limited to a particular kind of security
policy (multi-level security, and perhaps Biba integrity
or other lattice-based models).  SELinux can support
lattice-based models like multi-level security, but it
can also support Type Enforcement, Role-Based Access
Control, and other models.  So POSIX.1e MAC only does
a subset of what SELinux does.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
