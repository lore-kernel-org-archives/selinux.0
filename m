Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA07370
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 15:16:56 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id UAA07809
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 20:15:25 GMT
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id UAA07805
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 20:15:23 GMT
From: "LA Walsh" <law@sgi.com>
To: <pollard@cats-chateau.net>,
        "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>
Cc: <selinux@tycho.nsa.gov>, <linux-privs-discuss@sourceforge.net>
Subject: RE: [Linux-privs-discuss] SELinux & Linux-privs projects
Date: Tue, 16 Jan 2001 12:15:05 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHCEBLCKAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <01011220390900.30390@tabby>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>



> > >	Can have unintended consequences if someone who has read 'defense-A'
> >"su's" to root and writes /etc/passwd.  But you get the idea -- a lawyer
> >on "A" couldn't be a sysadmin.  The configuration would be an
> implementation
> >detail, but seems "doable".
>
> Is doable, but not with the rigid lattice structure. There the requirement
> is that the subject must already dominate the object before
> access. It would
> be possible to invoke a "transition security" as part of the security
> server. The only limitation then is the rigid definition of what
> the security
> bits mean.
---
	I don't have DS17 memorized, but I don't remember reading that
labels are rigid.  No where do I find that a 'user' has to be involved
in a transition.  The POSIX spec seems to state that "the MAC label of a
file
shall be dominated by the MAC label of a subject for the subject to read the
data
or attributes of a file."

	I don't see that as saying the MAC label of the process is RIGID.  I.e. -
suppose I define my domainates function as "is newer or of equal age".  A
process
always runs with a MAC label of 'current time'.  The MAC label on the file
is 'last modified time'.

	So under File Policy 1, p197, the current time (MAC label of the process)
must be 'newer or equal' to the last-mod time on a file.
	Under FP2 & 4: the 'last-mod' time must dominate, so a write or create
would set it to "equal" age (note that items of equal age dominate each
other).

	This is definintely not RIGID or lattice but does seem meet the POSIX
requirements or am I reading something wrong?

	Assuming my interpretation is valid, it seems that dynamically
altering the MAC-label of a Subject Process such that it dominates an
object to be read would still would still be a conforming DS17
implementation.


>
> Not really - it only prevents downward flow. For compartmentalization the
> user must first be an active member of the compartment, rather
> than assuming
> the compartment of the data if there are no conflicts. The
> "information label"
> only proves that the user is allowed. Not that the user may be
> "conditionally"
> allowed as long as there are no conflicts.
---
	Again, while it talks about the need for a user to possess
CAP_MAC_UPGRADE to upgrade their own MAC label at *their* request, I
don't see anything that prohibits the OS from doing this automatically
based on some set of rules.


> Rather than have two trusted programs that can change each field
> separately,
> it would be better to allow one program to request permission (gain the
> appropriate lable) to change either field. That requires the flexibility
> to have more security bits controlled by the server than are currently
> available.
---
	That's not within the scope of the POSIX spec.  It seems you are
requesting 'more bits' that "applications" could use as they see fit
that are managed by the OS.  I don't see this as some lack with the POSIX
security features as much as simply an implementation-dependent detail.
Linux could choose to provide more bits to user-apps.  Choosing to do
so or not is independent of the discussion concerning the merits of a
DS17 conforming implmentation vs. a DTE system.

-l


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
