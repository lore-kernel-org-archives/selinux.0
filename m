Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA17253
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 19:28:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id AAA21218
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 00:27:45 GMT
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id AAA21214
	for <selinux@tycho.nsa.gov>; Fri, 12 Jan 2001 00:27:44 GMT
Message-ID: <3A5E4F12.74C9D3AF@sgi.com>
Date: Thu, 11 Jan 2001 16:25:54 -0800
From: Casey Schaufler <casey@sgi.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: selinux@tycho.nsa.gov, linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] SELinux & Linux-privs projects
References: <Pine.SOL.3.95.1010111132105.23465e-100000@clipper.gw.tislabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Stephen Smalley wrote:
> 
> On Thu, 11 Jan 2001, Casey Schaufler wrote:
> 
> > I don't know who told you that, but it certainly wasn't
> > anyone who worked on the standard. The 1e MAC specification
> > is explicitly devoid of any such assumptions. That's one
> > reason there's no specification on Moldy directories, for
> > example.
> 
> I assume that "devoid of any assumptions" refers to the kind
> of label as opposed to being designed for a particular kind
> of security policy.

No, it means that the developers of the DRAFT couldn't
agree on what the right policy was, so they made sure
that no one would have an advantage by having the DRAFT
specificly match their policy. For example, Sun was doing
restricted Bell&LaPadula sensitivity. SGI did modified
Bell&LaPadula sensitivity and Biba integrity. Data General,
well, we were never sure what they were up to, but it
sure sounded like a reasonably pure Bell&LaPadula. In
the early days AT&T was pushing for time stamp sorts of
policy, too.

> Are you suggesting that POSIX.1e was
> not designed specifically for lattice-based models like
> BLP and Biba?

I'm suggesting that the design goals included supporting
those policies, but also included generality. No one
who came to more than one meeting advocated anything
other than policy independence.

> The fundamental statement of mandatory access
> control policy in the standard is hardly suitable for all
> mandatory security policies:  Subjects cannot cause information
> labeled at some MAC label L1 to become accessible to subjects
> at L2 unless L2 dominates L1.  You can't represent Type
> Enforcement by such a statement.  And the kind of label is
> implicit by the dominates relatinship.

I'll take your word for it that you couldn't represent
TE using the 1e scheme.

> > That's because those are the only operations POSIX systems
> > support! It's implicit in being a POSIX (DRAFT) standard.
> 
> You can define distinct operations (permissions) in the
> mandatory security policy for distinct kernel services
> without altering the interfaces or behavior for discretionary
> access controls.

You're correct. If you really think it's valueable to
seperate left-hand-twiddle permission from write permission
the POSIX.1e scheme is not for you.


> ... - the
> point is that we need a flexible mandatory access control
> architecture so that the system can be customized and
> can evolve easily to meet different security requirements.

I have to disagree. It has not been the policy inflexibility
of MLS systems which have held them back, if in fact they
can be said to have been held back at all. It is the fact
that they're *different*. Flexible policy will not help in
the marketplace, it will hurt. We finally got people to the
point where they generally understood permission bits, when
along come NT ACLs, and the whole thing goes on the floor.
We'd be in much better shape if the MAC policies on MULTICS,
Solaris, HP/UX, AIX, and Irix where all the same. Flexibility?
Bad for the community.

-- 

Casey Schaufler				Manager, Trust Technology, SGI
casey@sgi.com				voice: 650.933.1634
casey_p@pager.sgi.com			Pager: 888.220.0607

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
