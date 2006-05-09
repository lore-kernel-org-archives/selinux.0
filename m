Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49MrUHi029909
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 18:53:31 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49MrQa2029062
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 22:53:27 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Janak Desai <janak@us.ibm.com>
Subject: Re: pam_namespace
Date: Wed, 10 May 2006 08:53:25 +1000
Cc: Valdis.Kletnieks@vt.edu, SE-Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@epoch.ncsc.mil>
References: <200605051623.25533.russell@coker.com.au> <200605092257.59047.russell@coker.com.au> <4460A39C.1040703@us.ibm.com>
In-Reply-To: <4460A39C.1040703@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605100853.31555.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 10 May 2006 00:13, Janak Desai <janak@us.ibm.com> wrote:
> >My idea is that the range, high, and low values would be candidates for
> > the file name.
> >
> >The current code in rawhide does not inherit the range from the process,
> > are you referring to a newer version of pam_namespace.c?  If so where can
> > I find a copy?
>
> Range inheritance is done in the kernel when type member rules are
> defined for
> the type that is being polyinstantiated. So when pam_namespace calls
> security_compute_member()
> to compute the context of the instance directory, the range in the
> context returned, will
> be the same as the process range when polyinstantiation is being done
> for the associated type.

OK, this is going to break on MCS where ranged objects on disk are not 
permitted.

> >>In general I am not sure about the intermidiate directory itself. To me,
> >>it complicates the mechanism and mixes it with policy. When using
> >>polyinstantiation with SELinux, you can tighten up access to instances by
> >>type-member rules and by inheriting mls label of the process.
> >
> >For the case of strict and mls policy, yes.  For targeted policy we don't
> > have such protections.
>
> I am not sure I follow. Why can't you setup type member rules in
> targeted policy?

Sure you can, but when all user logins have unconfined_t as the domain SE 
Linux protections (other than MCS protections) won't apply.  MCS protections 
are a long way from what is required in this regard.

> >$HOME is protected, but as $HOME will only be PI on a strict or MLS system
> >this isn't an issue.
> >
> >Sticky bits provide no protection, the entire purpose of PI for /tmp is
> > that the sticky bits don't do an adequate job!  Substituting a race
> > condition attack on /tmp for a race condition attack on
> > /tmp/tmp.inst-user-user is no gain!
> >
> >Also while we are on the topic, the namespace module needs to handle the
> > case of a directory existing with the wrong permissions or having a file
> > with the name existing.
> >
> >Currently with pam_namespace.so configured I can prevent a user from
> > logging in by creating a file named /tmp/tmp.inst-user-user.  I can
> > create a directory of that name as another user to take over ownership of
> > another user's instance of /tmp.  I can make /tmp/tmp.inst-user-user a
> > sym-link to /etc which then makes /tmp a copy of /etc for the user who
> > logs in (I'm sure that there is potential for an exploit here).
>
> yes, probably. However, remember, ordinary users will not see the "real"
> /tmp.

Apart from users who are listed as exceptions in /etc/security/namespace.conf.

Also applying the "defense in depth" principle we want to make sure that it 
offers protection even in the case of misconfiguration or other situations 
that result in user sessions running in the global name space.

Imagine that an administrator misconfigures the system such that crond does 
not use unshared name spaces, that would then permit a hostile user to attack 
other users and daemons via race conditions and DOS attacks.

> So 
> for anyone who is trying to create directory/symlink with the same name
> as the
> instance of another user, they will need permission to unmount their
> polyinstantiated
> /tmp first.

Or merely login first.  Consider the case of a company that has a fixed scheme 
for allocating login names, anyone who hears of a new employee joining can 
guess the account name and start a DOS attack by creating such links or 
files.

> If a user has power to perform mount/unmount, they can 
> really subvert
> the polyinstanted mechanism because it is based on giving a user a
> namespace that
> he/she cannot change.

True, but it can be done with a lot less than that.

> >There are two algorithms that occur to me to deal with these issues, one
> > is that if there is an existing directory of the name in question then we
> > first check the ownership, permissions, and context against what we would
> > create, if they don't match (or if the name is taken by something other
> > than a directory) then we append ".1" to the name and try again, we keep
> > either incrementing the number we append until we find a directory that
> > has appropriate perms or which does not exist.  The other algorithm is to
> > have a specific subdirectory created with a name such as /tmp/.inst that
> > has restrictive permissions under both Unix and SE Linux and then create
> > all directories under that.  This second algorithm also removes the need
> > to create two levels of directory each time a user logs in (saves 4K of
> > disk space per session and a tiny amount of CPU time).
> >
> >The first algorithm doesn't deal well with DOS attacks.  The second
> > algorithm has the creation of a permanent directory under /tmp with the
> > need to create the directory very early in the boot process for systems
> > with tmpfs on /tmp (not SE Linux as we don't have policy support for
> > tmpfs on /tmp).  Creating a directory in such a manner is messy, but
> > there is precedent for it in /tmp/.X11-unix, /tmp/.ICE-unix, and
> > /tmp/.font-unix.
>
> What about other directories that are being polyinstantiated? What if
> the admin decides to add/delete a directory from the list to
> polyinstantiate? 

How are these problems with what I suggested?  /var/tmp/.inst and $HOME/.inst 
will work just as well as any other naming method.  If the admin deletes a 
directory from the list then there will be a .inst directory hanging around 
that they will have to manually remove, which incidentally should be easier 
than removing a bunch of "tmp.inst*" directories.

Adding ".1", ".2", etc to the end of the directory name may expand the list of 
directories to remove, but this is only in the case of attack (which will 
involve extra work for the sys-admin no matter how you look at it).

Adding a directory to the PI list is no big deal, with the second algorithm 
they just have to create the ".inst" directory first, with the first 
algorithm they don't need to do anything.

> I do see your point that there are exploits that we can address with this,
> but I am still not conviced that it's worth the trouble to address them.

I don't think that it's any great trouble.  I have already described how to 
solve every problem that I can imagine with each of these methods.

> >>>>>On a non-SE system "0wned uid=0 daemon" is considered to be game-over.
> >>>>
> >>>>So you're saying that on a non-SE system, namespaces are *not* in the
> >>>>least expected to slow down a rogue daemon.  OK, as long as we make a
> >>>>note of that..
> >>>
> >>>Not at all!  I'm saying that on a non-SE system a uid=0 process can do
> >>>anything it wants so there's no point even attempting to constrain such
> >>> a process.  However nowadays most daemons never run as root, and the
> >>> ones that do run as root drop their privs for as much code as possible.
> >>>
> >>>Attack by a non-root daemon on a non-SE system is something we want to
> >>>prevent.
> >>
> >>Again, this attack, valid only on non-SELinux mode, would only
> >>consititute the
> >>daemon creating files in user's instance of /tmp or /var/tmp. Because of
> >>the sticky bit,
> >>the daemon will not be able delete any files there, right?
> >
> >The attack is not only valid on non-SE Linux mode.  Such attacks that work
> > on non-SE Linux will also mostly work on targeted systems.  On strict
> > systems bugs and design flaws that permit integrity attacks on non-SE and
> > targeted systems will generally be expected to become DOS attacks.
> >
> >I think that generally deleting files is the last thing we are concerned
> >about.  Some systems use a ram disk for /tmp by default (Solaris), some
> >systems clean out /tmp on boot by default (Debian).  Generally /tmp should
> > be considered as transient.  The concerns for /tmp are race condition
> > attacks on system integrity (causing a process to expose or corrupt data
> > when it is operating on files other than the ones the programmer or the
> > user intended it to use) and exposing secret data through revealing
> > sensitive file names.  The current operation of the pam_namespace.so
> > module fails on the issue of protecting secret file names and doesn't do
> > very well on the issue of protecting integrity against race conditions.
>
> Yes, I agree that if you manage to get a shell as root through some
> application exploit,
> pam_namespace will not contain the damage because you can manipulate your
> namespace. However, it is quite possible that if you can mount/unmount,
> you can
> also bypass standard dac checks on a more restrictive intermediate
> directory. Maybe
> I can add more information to the man page regarding what pam_namespace
> will or will not guard against.

I'm not sure that you understood my previous messages.

Root shell on non-SE system is game-over.  Root shell on SE system is a 
situation we want to contain, and we can contain it.  In most cases with the 
strict and MLS policies a root process will not have the ability to umount 
anything and in some cases it won't have dac_override.

We want to have very restrictive Unix permissions on accessing the PI 
directories (I suggest making /tmp/.inst mode 000) so that a process must 
have dac_override to even get started as well as having restrictive 
permissions under the domain-type part of SE Linux.

Incidentally we can probably reduce the number of daemons with dac_override 
capability, in many cases such access was granted because it's easier than 
redesigning the application in a better manner.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
