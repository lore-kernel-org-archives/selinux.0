Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA08684
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 19:27:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id AAA18733
	for <selinux@tycho.nsa.gov>; Wed, 17 Jan 2001 00:25:51 GMT
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id AAA18728
	for <selinux@tycho.nsa.gov>; Wed, 17 Jan 2001 00:25:50 GMT
From: "LA Walsh" <law@sgi.com>
To: "Jesse Pollard" <pollard@tomcat.admin.navo.hpc.mil>,
        <pollard@cats-chateau.net>
Cc: <selinux@tycho.nsa.gov>, <linux-privs-discuss@sourceforge.net>
Subject: RE: [Linux-privs-discuss] SELinux & Linux-privs projects
Date: Tue, 16 Jan 2001 16:30:34 -0800
Message-ID: <NBBBJGOOMDFADJDGDCPHCEBMCKAA.law@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200101162200.QAA32788@tomcat.admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> > 	This is definintely not RIGID or lattice but does seem meet
> the POSIX
> > requirements or am I reading something wrong?
>
> 1. You are now using bits that are not under MAC control.
---
	?  I'm using bits not under MAC control?   What does that mean?
Is that defined somewhere in the POSIX spec?  It is Mandatory Access
Control.

	On a system, you can write to a file 'in the future', but you can't
read the future until it is the present or past (and your PID time dominates
the file time).  You can 'read' the past but can't write to the 'past'
without
updating the file label such that it is dominated by your process.  This is
mandatory -- not discretionary access.  Someone cannot "chmod a+r" "future"
files with the expectation that they can be read.  It's a consistent
Mandatory
Access Model.

	So...where does DS17 talk about "bits"?  I see a "mac_dominate" and
a "mac_equal" function.  They don't mention bits.


> 2. The date being shown cannot be used as part of an access
> policy (changed
>    by the user/group). That would call for another field to contain the
>    the real "last-mod" date, which could ONLY be changed by the OS+FS.
---
	Right.  The user couldn't change my "last-mod" label.  Which shouldn't
be viewed as the same bits as the 'file modification time".  I just
implemented
a policy (opaquely) that uses 'time' as a MAC check.

>
> The "rigid" here means what can be stored in the label. Usually
> this is limited to "level" access and/or a "compartment" mask.
---
	?Usually?  I think you may be making assumptions that impose
arbitrary limits on a conforming DS17 implementation.  We are comparing
DS17 features vs. DTE -- not some "usual" implementation.

	Another example.  "Dominate" may mean a 'chaos' function.  I assign
a "Chaos" value to files and processes.  System files are assumed to be
low in "Chaos" as are the system level processes that read them.  User
processes are assumed to be more chaotic and can only produces files
at higher chaos levels.  Since the state of these files is "more chaotic",
my system processes (or say, uid==0) cannot read more chaotic files.  This
prevents virii and worm infection of system processes as the system process
labels don't dominate user files and can't read them.  User processes,
don't dominate system files so they can't write to system files.

	Another example.  Dominate may be implmented to include both
a sensitivity/division (ala Bell-LaPadula), *AND* 'chaos' dominance (BIBA
integrity).

	The point is that the actual contents of a mac_label isn't defined
in POSIX nor is it said that they are fixed in time (that I am aware of).




> The ability to
> change the label to include time does not exist, especially since the
> owner can change the date and invalidate its use as a label.
---
	Changing the file date would be a separate operation from changing the
MAC_LABEL on the file.  The MAC_LABEL is only changed by the system or by
a process possessing appropriate privilege.

>
> > 	Assuming my interpretation is valid, it seems that dynamically
> > altering the MAC-label of a Subject Process such that it dominates an
> > object to be read would still would still be a conforming DS17
> > implementation.
>
> Subject altering is possible as long as the "MAC_UPGRADE" is
> permitted first.
---
	You need both CAP_MAC_RELABEL_SUBJ and CAP_MAC_UPGRADE[DOWNGRADE] for
a process to alter its own label.  However the kernel itself has "all"
capabilities on startup -- what the kernel sets and does on processes is
dependent on system security policy.

> I don't believe an action is defined to allow a dynamic upgrade,
> the security
> server would have to be the one doing the upgrade - and that
> would work though
> now the security server is no longer matching the POSIX
> definition of providing
>
> "The information label interfaces specified support the following
> functions:
>
>      test information label relationship - includes interfaces
> that will determine
> 		dominance between two labels, and equivalence
> between two labels.
>      float a label - includes an interface that will produce a
> label that is the
> 		combination of a label associated with a source,
> and the label
> 		associated with a destination. This new label will then be
> 		associated with the destination.
>      label validity - includes an interface for determining
> whether an information
> 		label is valid. The definition of a valid
> information label is
> 		implementation defined; however, examples include:
> the label is
> 		malformed, the label contains components that are
> not currently
> 		defined on the system, or the label is simply
> forbidden to be dealt
> 		with by the system. "
>
> from "http://csrc.nist.gov/nistpubs/800-7/node17.html" POSIX
> Security Interfaces
> and Mechanisms.
---
	What part of the above does my dynamic "mac_dominate" function
voilate?  My mac_dominate function said nothing about the implementation
of inf_float.

>
> It doesn't appear to prevent additional functions though that
> would be extending
> the POSIX interface. I do note that the "float a label" does not
> include the
> subject.
----
	I don't understand your statement.  "float a label"?  It takes
2 labels, a source and destination and writes a new label, based on those
inputs, to the destination.

>
> > > That requires the  flexibility
> > > to have more security bits controlled by the server than are currently
> > > available.
> > ---
> > 	That's not within the scope of the POSIX spec.  It seems you are
> > requesting 'more bits' that "applications" could use as they see fit
> > that are managed by the OS.  I don't see this as some lack with
> the POSIX
> > security features as much as simply an implementation-dependent detail.
> > Linux could choose to provide more bits to user-apps.  Choosing to do
> > so or not is independent of the discussion concerning the merits of a
> > DS17 conforming implmentation vs. a DTE system.
>
> True, but it doesn't eliminate the need though, it just eliminates the
> ability to implement it. (I have a LOT more to study before this statement
> has any real assurance of correctness. I could be all wet here.)
---
	The 'need' is dependent on the type of security policy you wish
to implement in a system.  Indeed, I'd tend to agree, in a complete
security-distribution, files that are in the "Trusted Base" or TCB, but that
are not in the kernel may want capabilities.  The problem is one of
"enforcement".  The kernel cannot enforce the minutia of which field in
a database is writeable by a user.  That layer of "abstraction" is normally
provided in an application that ensures conformity.

	The alternative would be a kernel that, for example, could parse
the passwd file and decide if an access was allowed or not.  Is it good
design for the kernel to manage bits that it doesn't enforce?  Maybe it
is convenient -- but once the usage monitoring leaves the kernel, those
bits are essentially 'user data' to the kernel (even though they may be
part of 'system software' in a TCB).



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
