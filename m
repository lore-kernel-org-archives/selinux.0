Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7S1WSeY028424
	for <selinux@tycho.nsa.gov>; Sun, 27 Aug 2006 21:32:28 -0400
Received: from web36613.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k7S1Vqn4006439
	for <selinux@tycho.nsa.gov>; Mon, 28 Aug 2006 01:31:52 GMT
Message-ID: <20060828013218.664.qmail@web36613.mail.mud.yahoo.com>
Date: Sun, 27 Aug 2006 18:32:18 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: poly-instantiated directories and call-gate
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200608281001.39935.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Russell Coker <russell@coker.com.au> wrote:

> On Monday 28 August 2006 04:31, Casey Schaufler
> <casey@schaufler-ca.com> 
> wrote:
> > > Thus the consequences of a single user breaking
> out
> > > of their instance of /tmp
> > > is mitigated.
> >
> > Contrary to popular belief, the motivation behind
> > polyinstatiated directories was allowing programs
> > that used /tmp to continue to work,
> 
> Well, to be pedantic doing a few "chmod -R 777"
> commands will also allow 
> programs to continue to work (I've seen this done). 
> The reason for PI is to 
> allow programs to continue to work while providing
> good security (where mode 
> 1777 is not good enough).

Polyinstatiation was developed in the context
of MLS and explicitly to deal with the issue
that the MLS label of a traditional /tmp
would allow only processes with that MLS
label to write to it. Giving /tmp a "wildcard"
MLS label would have been considered a
design flaw by the TCSEC evaluators, and
was not an option. The alternative to
polyinstatiation is directory entries
comprised of a name/inode/MLS-label triple
instead of the traditional name/inode pair,
resulting in directory entries being objects
in their own right, and thus subject to
all of the protection requirements of objects.

> > not to 
> > assist in keeping programs with different
> > attributes (MLS values in particular) seperate.
> > In the early days of Unix MLS design we seriously
> > considered tossing /tmp into the bitbucket and
> > encouraging everyone to set a rational value
> > to $TMPDIR and being done with it. In the end
> > we figured that the install base really did
> > require access to /tmp, and polyinstatiation
> > emerged as the most popular scheme for providing
> > that access.
> 
> There are some technical advantages to /tmp in terms
> of management.  /tmp can 
> be a filesystem with no persistent storage (the
> default action on Solaris).  
> Even if /tmp is a real filesystem if space runs low
> the sys-admin can do a 
> few "rm -rf" commands with the knowledge that the
> potential risk is quite 
> low.  You can set up strict quotas on home
> directories for storage that is 
> backed up while allowing large (or no) quotas on
> /tmp for operations that 
> require a lot of space (eg sort).

These are all real advantages. They all pale
in comparison to the arguement that the customer
is shipping the box (@ $20,000,000) back because
their application won't work.

> Setting $TMPDIR=/tmp/$USER would work reasonably
> well if all programs would 
> actually use $TMPDIR.

Which is, of course, the rub.

> > All of the Unix schemes provide a way to get
> > at the "real" file system name space. Solaris
> > uses "adorned" path components. Trix uses a
> > process attribute (the Moldy bit), and UNICOS
> > used a symlink scheme that avoided the whole
> > issue. With the usual file system protections
> > in place there is no compelling reason to
> > worry about "breaking out". There are good
> > reasons to allow it, including sharing (upward)
> > and monitoring.
> 
> I recall from playing with Trix that you had to be
> the administrator to see 
> the full name space.

su -M allows (or used to!) anyone to flip the bit.

> Was Solaris the same in this regard?

Originally anyone could use adorned pathnames.
I do not know if it got changed.

> As for the Unicos symlink scheme, how did that work?

Symlink processing allowed variables. If you
created a symlink /tmp -> /a/$B/c it would
look in your environment for a definition of
B. /tmp -> /$TEMPDIR/ . Cute.
 
> > > In terms of having a call-gate, apparently this
> has
> > > been done before (Casey -
> > > would you care to comment?).
> >
> > Yes, it has been done. It's a Bad Idea.
> 
> That was my gut feeling too.  Apart from the reasons
> I outline below what were 
> the problems with it?  I expect that I'll be asked
> the same question the next 
> time I speak about such things and want to have a
> good answer ready.  Also 
> it'll be good to have this in the list archives.

It's demonstrably unnecessary as there are
several better ways to do the job. The path
lookup scheme is "small enough to analyze",
I'm not convinced that dynamic components
meet that aspect of the TCB principle.

Besides, what it the problem if you do
"break out of /tmp"? By rule, every directory
is going to enforce policy, so if you
get into someone else's /tmp policy will
still be enforced.

> I think it might be worth having a wikipedia page on
> this.  What would be a 
> good title?

I like "moldy directories", from an attempt
to pronounce the initials for Multi-Level
Directory (MLD) as "mold" and running with
the bad joke.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
