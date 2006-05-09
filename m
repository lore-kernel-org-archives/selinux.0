Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49Cw08D014337
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 08:58:00 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49Cvsp8006178
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 12:57:55 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Janak Desai <janak@us.ibm.com>
Subject: Re: pam_namespace
Date: Tue, 9 May 2006 22:57:53 +1000
Cc: Valdis.Kletnieks@vt.edu, SE-Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@epoch.ncsc.mil>
References: <200605051623.25533.russell@coker.com.au> <200605081328.02493.russell@coker.com.au> <445F4B38.9080808@us.ibm.com>
In-Reply-To: <445F4B38.9080808@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605092257.59047.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 08 May 2006 23:44, Janak Desai <janak@us.ibm.com> wrote:
> >>ignore_config_error is only sufficient if there is no possibility of
> >>any option misbehaving - in particular, we can't have an option 'both'
> >>that works in MCS/MLS environments as well - we'll need to have a
> >> both_mcs if the mcs label is to be included, and a both_no_mcs if it
> >> should behave in the same way as the non-mcs 'both'.
> >
> >Having "both" and "both_no_mcs" is confusing.  Maybe it would be best to
> >have "user" and "context" as separate items to replace "both" and then
> >support a fourth option as "range", "high" or "low".
>
> I am not sure I understand. We have "user", "context" and "both", where
> type in the context can be controlled through type-member policy rules and
> the mls range is inherited from the process. Can you give an example of what
> context the instance would have with "range" or "high" or "low"?

My idea is that the range, high, and low values would be candidates for the 
file name.

The current code in rawhide does not inherit the range from the process, are 
you referring to a newer version of pam_namespace.c?  If so where can I find 
a copy?

For inheriting the range to be viable then we need to support names for the 
temporary directory based on the range so that different ranges for the 
current user can be supported.  I am not sure whether we will support 
choosing a range at login time, if we do then we must support this.  If we 
will never support choosing the range at login time there is the case of su 
which may be run after a newrole command and therefore be used to enter the 
same user role in different contexts.  Another case is that of a user who has 
their default range changed by the sys-admin while they are logged in (this 
may be uncommon in the case of MLS use but for MCS I expect it to be regular 
system use).

Probably the easiest thing to do is to default to including the entire 
security context of the process in the directory name.

> In general I am not sure about the intermidiate directory itself. To me,
> it complicates the mechanism and mixes it with policy. When using
> polyinstantiation with SELinux, you can tighten up access to instances by
> type-member rules and by inheriting mls label of the process.

For the case of strict and mls policy, yes.  For targeted policy we don't have 
such protections.

> In non-SELinux use, an admin can seperate users from each
> other by configuring the instance to be a subdirectory of the
> polyinstantiated directory.
> We can get additional protection from non-root daemons by creating an
> intermdiate directory. However, is it really worth the trouble to protect a
> user's instance of /tmp or /var/tmp beyond what will be protected by sticky
> bits? Since instances inherit the polyinstantiated directory's mode, $HOME
> etc are already protected from non-root daemons.

$HOME is protected, but as $HOME will only be PI on a strict or MLS system 
this isn't an issue.

Sticky bits provide no protection, the entire purpose of PI for /tmp is that 
the sticky bits don't do an adequate job!  Substituting a race condition 
attack on /tmp for a race condition attack on /tmp/tmp.inst-user-user is no 
gain!

Also while we are on the topic, the namespace module needs to handle the case 
of a directory existing with the wrong permissions or having a file with the 
name existing.

Currently with pam_namespace.so configured I can prevent a user from logging 
in by creating a file named /tmp/tmp.inst-user-user.  I can create a 
directory of that name as another user to take over ownership of another 
user's instance of /tmp.  I can make /tmp/tmp.inst-user-user a sym-link 
to /etc which then makes /tmp a copy of /etc for the user who logs in (I'm 
sure that there is potential for an exploit here).

There are two algorithms that occur to me to deal with these issues, one is 
that if there is an existing directory of the name in question then we first 
check the ownership, permissions, and context against what we would create, 
if they don't match (or if the name is taken by something other than a 
directory) then we append ".1" to the name and try again, we keep either 
incrementing the number we append until we find a directory that has 
appropriate perms or which does not exist.  The other algorithm is to have a 
specific subdirectory created with a name such as /tmp/.inst that has 
restrictive permissions under both Unix and SE Linux and then create all 
directories under that.  This second algorithm also removes the need to 
create two levels of directory each time a user logs in (saves 4K of disk 
space per session and a tiny amount of CPU time).

The first algorithm doesn't deal well with DOS attacks.  The second algorithm 
has the creation of a permanent directory under /tmp with the need to create 
the directory very early in the boot process for systems with tmpfs on /tmp 
(not SE Linux as we don't have policy support for tmpfs on /tmp).  Creating a 
directory in such a manner is messy, but there is precedent for it 
in /tmp/.X11-unix, /tmp/.ICE-unix, and /tmp/.font-unix.

> >>>On a non-SE system "0wned uid=0 daemon" is considered to be game-over.
> >>
> >>So you're saying that on a non-SE system, namespaces are *not* in the
> >>least expected to slow down a rogue daemon.  OK, as long as we make a
> >>note of that..
> >
> >Not at all!  I'm saying that on a non-SE system a uid=0 process can do
> >anything it wants so there's no point even attempting to constrain such a
> >process.  However nowadays most daemons never run as root, and the ones
> > that do run as root drop their privs for as much code as possible.
> >
> >Attack by a non-root daemon on a non-SE system is something we want to
> >prevent.
>
> Again, this attack, valid only on non-SELinux mode, would only
> consititute the
> daemon creating files in user's instance of /tmp or /var/tmp. Because of
> the sticky bit,
> the daemon will not be able delete any files there, right?

The attack is not only valid on non-SE Linux mode.  Such attacks that work on 
non-SE Linux will also mostly work on targeted systems.  On strict systems 
bugs and design flaws that permit integrity attacks on non-SE and targeted 
systems will generally be expected to become DOS attacks.

I think that generally deleting files is the last thing we are concerned 
about.  Some systems use a ram disk for /tmp by default (Solaris), some 
systems clean out /tmp on boot by default (Debian).  Generally /tmp should be 
considered as transient.  The concerns for /tmp are race condition attacks on 
system integrity (causing a process to expose or corrupt data when it is 
operating on files other than the ones the programmer or the user intended it 
to use) and exposing secret data through revealing sensitive file names.  The 
current operation of the pam_namespace.so module fails on the issue of 
protecting secret file names and doesn't do very well on the issue of 
protecting integrity against race conditions.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
