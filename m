Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA08068
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 17:00:28 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA12627
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 21:58:57 GMT
Received: from tomcat.admin.navo.hpc.mil (tomcat.admin.navo.hpc.mil [204.222.179.33])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id VAA12623
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 21:58:56 GMT
Date: Tue, 16 Jan 2001 16:00:07 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101162200.QAA32788@tomcat.admin.navo.hpc.mil>
To: law@sgi.com, <pollard@cats-chateau.net>,
        "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>
Subject: RE: [Linux-privs-discuss] SELinux & Linux-privs projects
Cc: <selinux@tycho.nsa.gov>, <linux-privs-discuss@sourceforge.net>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

"LA Walsh" <law@sgi.com>:
> > > >	Can have unintended consequences if someone who has read 'defense-A'
> > >"su's" to root and writes /etc/passwd.  But you get the idea -- a lawyer
> > >on "A" couldn't be a sysadmin.  The configuration would be an
> > implementation
> > >detail, but seems "doable".
> >
> > Is doable, but not with the rigid lattice structure. There the requirement
> > is that the subject must already dominate the object before
> > access. It would
> > be possible to invoke a "transition security" as part of the security
> > server. The only limitation then is the rigid definition of what
> > the security
> > bits mean.
> ---
> 	I don't have DS17 memorized, but I don't remember reading that
> labels are rigid.  No where do I find that a 'user' has to be involved
> in a transition.  The POSIX spec seems to state that "the MAC label of a
> file
> shall be dominated by the MAC label of a subject for the subject to read the
> data
> or attributes of a file."
>
> 	I don't see that as saying the MAC label of the process is RIGID.  I.e. -
> suppose I define my domainates function as "is newer or of equal age".  A
> process
> always runs with a MAC label of 'current time'.  The MAC label on the file
> is 'last modified time'.
> 
> 	So under File Policy 1, p197, the current time (MAC label of the process)
> must be 'newer or equal' to the last-mod time on a file.
> 	Under FP2 & 4: the 'last-mod' time must dominate, so a write or create
> would set it to "equal" age (note that items of equal age dominate each
> other).
> 
> 	This is definintely not RIGID or lattice but does seem meet the POSIX
> requirements or am I reading something wrong?

1. You are now using bits that are not under MAC control.

2. The date being shown cannot be used as part of an access policy (changed
   by the user/group). That would call for another field to contain the
   the real "last-mod" date, which could ONLY be changed by the OS+FS.

The "rigid" here means what can be stored in the label. Usually
this is limited to "level" access and/or a "compartment" mask. The ability to
change the label to include time does not exist, especially since the
owner can change the date and invalidate its use as a label.

> 	Assuming my interpretation is valid, it seems that dynamically
> altering the MAC-label of a Subject Process such that it dominates an
> object to be read would still would still be a conforming DS17
> implementation.

Subject altering is possible as long as the "MAC_UPGRADE" is permitted first.

> >
> > Not really - it only prevents downward flow. For compartmentalization the
> > user must first be an active member of the compartment, rather
> > than assuming
> > the compartment of the data if there are no conflicts. The
> > "information label"
> > only proves that the user is allowed. Not that the user may be
> > "conditionally"
> > allowed as long as there are no conflicts.
> ---
> 	Again, while it talks about the need for a user to possess
> CAP_MAC_UPGRADE to upgrade their own MAC label at *their* request, I
> don't see anything that prohibits the OS from doing this automatically
> based on some set of rules.

I don't believe an action is defined to allow a dynamic upgrade, the security
server would have to be the one doing the upgrade - and that would work though
now the security server is no longer matching the POSIX definition of providing

"The information label interfaces specified support the following functions: 

     test information label relationship - includes interfaces that will determine
		dominance between two labels, and equivalence between two labels. 
     float a label - includes an interface that will produce a label that is the
		combination of a label associated with a source, and the label
		associated with a destination. This new label will then be
		associated with the destination. 
     label validity - includes an interface for determining whether an information
		label is valid. The definition of a valid information label is
		implementation defined; however, examples include: the label is
		malformed, the label contains components that are not currently
		defined on the system, or the label is simply forbidden to be dealt
		with by the system. "

from "http://csrc.nist.gov/nistpubs/800-7/node17.html" POSIX Security Interfaces
and Mechanisms.

It doesn't appear to prevent additional functions though that would be extending
the POSIX interface. I do note that the "float a label" does not include the
subject.

> 
> > Rather than have two trusted programs that can change each field
> > separately,
> > it would be better to allow one program to request permission (gain the
> > appropriate lable) to change either field. That requires the flexibility
> > to have more security bits controlled by the server than are currently
> > available.
> ---
> 	That's not within the scope of the POSIX spec.  It seems you are
> requesting 'more bits' that "applications" could use as they see fit
> that are managed by the OS.  I don't see this as some lack with the POSIX
> security features as much as simply an implementation-dependent detail.
> Linux could choose to provide more bits to user-apps.  Choosing to do
> so or not is independent of the discussion concerning the merits of a
> DS17 conforming implmentation vs. a DTE system.

True, but it doesn't eliminate the need though, it just eliminates the
ability to implement it. (I have a LOT more to study before this statement
has any real assurance of correctness. I could be all wet here.)

I do have to go find that DS 16 document since I already know that
DS 17 has never been made public information (to my knowlege). I understand
that the differences were for clarification only, though.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
