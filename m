Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA11933
	for <selinux@tycho.nsa.gov>; Wed, 17 Jan 2001 10:22:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA18780
	for <selinux@tycho.nsa.gov>; Wed, 17 Jan 2001 15:20:47 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA18776
	for <selinux@tycho.nsa.gov>; Wed, 17 Jan 2001 15:20:46 GMT
Date: Wed, 17 Jan 2001 09:22:09 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101171522.JAA50509@tomcat.admin.navo.hpc.mil>
To: law@sgi.com, "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>,
        <pollard@cats-chateau.net>
Subject: RE: [Linux-privs-discuss] SELinux & Linux-privs projects
Cc: <selinux@tycho.nsa.gov>, <linux-privs-discuss@sourceforge.net>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

I'll leave the other parts... I'm not fully familiar yet with DS16/17
and it is beginning to feel like we are discussing the differences
between macintosh apples and granny smith... (the representation of
the controls vs the representation of the policy limits -
It feels like I'm coming round to your thoughts too..)

> > > > That requires the  flexibility
> > > > to have more security bits controlled by the server than are currently
> > > > available.
> > > ---
> > > 	That's not within the scope of the POSIX spec.  It seems you are
> > > requesting 'more bits' that "applications" could use as they see fit
> > > that are managed by the OS.  I don't see this as some lack with
> > the POSIX
> > > security features as much as simply an implementation-dependent detail.
> > > Linux could choose to provide more bits to user-apps.  Choosing to do
> > > so or not is independent of the discussion concerning the merits of a
> > > DS17 conforming implmentation vs. a DTE system.
> >
> > True, but it doesn't eliminate the need though, it just eliminates the
> > ability to implement it. (I have a LOT more to study before this statement
> > has any real assurance of correctness. I could be all wet here.)
> ---
> 	The 'need' is dependent on the type of security policy you wish
> to implement in a system.  Indeed, I'd tend to agree, in a complete
> security-distribution, files that are in the "Trusted Base" or TCB, but that
> are not in the kernel may want capabilities.  The problem is one of
> "enforcement".  The kernel cannot enforce the minutia of which field in
> a database is writeable by a user.  That layer of "abstraction" is normally
> provided in an application that ensures conformity.
> 
> 	The alternative would be a kernel that, for example, could parse
> the passwd file and decide if an access was allowed or not.  Is it good
> design for the kernel to manage bits that it doesn't enforce?  Maybe it
> is convenient -- but once the usage monitoring leaves the kernel, those
> bits are essentially 'user data' to the kernel (even though they may be
> part of 'system software' in a TCB).

The kernel is the conduit of sensitive data. I think it will become
likely that the security data will be supported by a database server
at some time in the future - a password server. It would be usefull
to be able to have that daemon provide/accept data via the kernel interface
(and libc) for things like "getpwent". I think it likely that there should
be some symetry with a "modpwent" and "putpwent" (or "newpwent").

The restrictions on access to the data must be defined by something, and
I think that something is best served by the security monitor. Storage of
the data is better served by the database, as controled by the security server.
Especially since the security server already implements the functions that
can evaluate the policy being defined. The data flow for this is

1: user process <---> kernel interface <---> security monitor <---> logindb

or

2: user process <---> kernel interface <---> security monitor
                               \
                                +--> logindb

or even (though more work has to be done by the logindb and the
  	security monitor):

3: user process <---> kernel interface <---> logindb <---> security monitor

That way the security monitor determines what gets passed to the logindb.
I think just a "yes/no" decision should be sufficient, yes the data is passed
no, the data is not. The advantage is the elimination of passwd as a trusted
program, NIS as a trusted facility, and the password and shadow files as a
trusted disk file (though the equivalent may be present as part of the logindb
storage structure). It may possibly reduce the support complications of
various authentication daemons, since currently, each must be trusted to
handle security data safely. the authentication daemons only have to match
password/kerberos/... and not have to deal with accessing the passwd and
shadow files.

I would prefer 1 or 2 over 3 because it feels like a better and more auditable
operation. The logindb doesn't have to be trusted for anything but proper
storage/retrieval of the data. #3 also depends on logindb having access to
the user process credentials, and passing those same credentials for
evaluation by the security monitor, AND respecting the result of the decision.

And I prefer #1 over #2 for similar reasons, plus it starts defining a
series of interface definitions for other security database interfaces
(IPSec SAD for one, a generic authentication daemon for another, security
configuration control, policy database, audit event log, ...)

Much better than having two different security monitors that may make
conflicting decisions.

I haven't tried to implement it though...

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
