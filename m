Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA14966
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 13:32:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id SAA17547
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 18:31:12 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id SAA17541
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 18:31:06 GMT
Date: Thu, 11 Jan 2001 13:31:44 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
Reply-To: Stephen Smalley <sds@tislabs.com>
To: Casey Schaufler <casey@sgi.com>
cc: selinux@tycho.nsa.gov, linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] SELinux & Linux-privs projects
In-Reply-To: <3A5DEEFB.6C988852@sgi.com>
Message-ID: <Pine.SOL.3.95.1010111132105.23465e-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


On Thu, 11 Jan 2001, Casey Schaufler wrote:

> I don't know who told you that, but it certainly wasn't
> anyone who worked on the standard. The 1e MAC specification
> is explicitly devoid of any such assumptions. That's one
> reason there's no specification on Moldy directories, for
> example.

I assume that "devoid of any assumptions" refers to the kind
of label as opposed to being designed for a particular kind
of security policy.  Are you suggesting that POSIX.1e was
not designed specifically for lattice-based models like
BLP and Biba?  The fundamental statement of mandatory access
control policy in the standard is hardly suitable for all
mandatory security policies:  Subjects cannot cause information
labeled at some MAC label L1 to become accessible to subjects
at L2 unless L2 dominates L1.  You can't represent Type
Enforcement by such a statement.  And the kind of label is
implicit by the dominates relatinship.

> That's because those are the only operations POSIX systems
> support! It's implicit in being a POSIX (DRAFT) standard.

You can define distinct operations (permissions) in the
mandatory security policy for distinct kernel services
without altering the interfaces or behavior for discretionary
access controls.  

> > In order to support Type Enforcement or Role-Based Access
> > Control or other kinds of mandatory security, you are very likely
> > to need to change or at least recompile the file system code,
> > the networking code, etc.
> 
> Yes, and?

As discussed ad nauseum on the robust open source mailing list,
Type Enforcement is desirable for its support for ensuring that
applications are unbypassable and tamperproof, that processes
with any sort of privileges cannot execute untrustworthy
code, and for providing least privilege.  BLP and Biba
are not enough for everyone.  And I'm not suggesting that
Type Enforcement is the magic solution either - the
point is that we need a flexible mandatory access control
architecture so that the system can be customized and
can evolve easily to meet different security requirements.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
