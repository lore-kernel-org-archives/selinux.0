Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4B04JaT027073
	for <selinux@tycho.nsa.gov>; Wed, 10 May 2006 20:04:19 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4B04D8W013803
	for <selinux@tycho.nsa.gov>; Thu, 11 May 2006 00:04:15 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Janak Desai <janak@us.ibm.com>
Subject: Re: pam_namespace
Date: Thu, 11 May 2006 10:04:09 +1000
Cc: Valdis.Kletnieks@vt.edu, SE-Linux <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@epoch.ncsc.mil>
References: <200605051623.25533.russell@coker.com.au> <200605100853.31555.russell@coker.com.au> <4461F43A.2020004@us.ibm.com>
In-Reply-To: <4461F43A.2020004@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200605111004.14112.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 11 May 2006 00:10, Janak Desai <janak@us.ibm.com> wrote:
> >>>>In general I am not sure about the intermidiate directory itself. To
> >>>> me, it complicates the mechanism and mixes it with policy. When using
> >>>> polyinstantiation with SELinux, you can tighten up access to instances
> >>>> by type-member rules and by inheriting mls label of the process.
> >>>
> >>>For the case of strict and mls policy, yes.  For targeted policy we
> >>> don't have such protections.
> >>
> >>I am not sure I follow. Why can't you setup type member rules in
> >>targeted policy?
> >
> >Sure you can, but when all user logins have unconfined_t as the domain SE
> >Linux protections (other than MCS protections) won't apply.  MCS
> > protections are a long way from what is required in this regard.
>
> Agreed. Although targeted policy does constrain many daemons (that's what
> we are concerned about, right?), I can see that there might be daemons that
> are running
> in unconfined_t whose vulnarabilities can be exploited to gain a
> non-root shell
> running in unconfined_t. Just wanted to point out that since we are
> concerned about
> non-root daemons, that targeted does constrain many of them.

1) Attack by user on user
2) Attack by user on daemon
3.1) Attack by non-root daemon on user
3.2) Attack by root daemon on user (will always succeed without SE Linux)

I believe that the above are the attack scenarios we should consider and the 
below are the types of attack we should consider.

A) Race-condition attacks on the integrity of processes and data (sym-link 
attacks, race conditions on renaming objects, or pre-creating a file to take 
ownership of data)
B) Leaks of confidential data via secrets in file names
C) Denial Of Service (DOS) attacks based on race conditions and pre-allocating 
file/directory names

The current implementation of pam_namespace does not address attack scenario 
3.1 on non-SE systems and attack scenarios 3.1 and 3.2 on strict systems.  
Even on MLS systems there may be a vulnerability to attack C and possibly 
attack B as well.

> >>>Currently with pam_namespace.so configured I can prevent a user from
> >>>logging in by creating a file named /tmp/tmp.inst-user-user.  I can
> >>>create a directory of that name as another user to take over ownership
> >>> of another user's instance of /tmp.  I can make /tmp/tmp.inst-user-user
> >>> a sym-link to /etc which then makes /tmp a copy of /etc for the user
> >>> who logs in (I'm sure that there is potential for an exploit here).
> >>
> >>yes, probably. However, remember, ordinary users will not see the "real"
> >>/tmp.
> >
> >Apart from users who are listed as exceptions in
> > /etc/security/namespace.conf.
> >
> >Also applying the "defense in depth" principle we want to make sure that
> > it offers protection even in the case of misconfiguration or other
> > situations that result in user sessions running in the global name space.
> >
> >Imagine that an administrator misconfigures the system such that crond
> > does not use unshared name spaces, that would then permit a hostile user
> > to attack other users and daemons via race conditions and DOS attacks.
>
> Users listed as exceptions in namespace.conf is an intentional action of
> the admin.

Which does not mean that they are fully trusted users who should be permitted 
to override security measures that protect other users.

> I agree that we should try and limit the damage from misconfiguration.
> However, there
> is always a trade-off between how far you will go to protect against
> misconfiguration.
> IMHO adding .inst with a very restrictive mode of 000 in the polydir
> does not
> protect you a whole lot more against the type of attack that you are
> describing.
> If we assume that the user has managed to gain access to the original
> /tmp (by
> gaining unmount privs or by subverting an unconfined daemon running
> in system namespace) then they can still write in /tmp. They can just move
> .inst to junk.

If the user gains access to the real version of /tmp by calling umount() then 
you are probably correct.  If however the user gains access to the real 
version of /tmp by exploiting a buggy login program (maybe the login program 
has a bug that skips some PAM session modules), by being granted such access 
to the system by an intentional action of the sys-admin (just because the 
sys-admin gave them some privs that most users don't get that doesn't mean 
they are trusted), by remaining logged in since before the administrator 
enabled namespaces in the configuration, or any of the other possible methods 
then having a .inst directory with mode 000 will save you.

Also I believe that pam_namespace should offer as many benefits as possible to 
non-SE systems.  With the current code there is no protection against attack 
scenario 3.1.

> True. I agree that managing .inst won't be too much of a trouble.

I believe that in many situations a .inst directory would be less trouble than 
the alternative.

The current situation of having directories created for security purposes in a 
mode 1777 directory is far from optimal.  Having a .inst directory 
created/verified in single-user mode at boot time removes entire categories 
of race condition attacks from the threat list.

> >I'm not sure that you understood my previous messages.
> >
> >Root shell on non-SE system is game-over.  Root shell on SE system is a
> >situation we want to contain, and we can contain it.  In most cases with
> > the strict and MLS policies a root process will not have the ability to
> > umount anything and in some cases it won't have dac_override.
> >
> >We want to have very restrictive Unix permissions on accessing the PI
> >directories (I suggest making /tmp/.inst mode 000) so that a process must
> >have dac_override to even get started as well as having restrictive
> >permissions under the domain-type part of SE Linux.
> >
> >Incidentally we can probably reduce the number of daemons with
> > dac_override capability, in many cases such access was granted because
> > it's easier than redesigning the application in a better manner.
>
> Yes, but as long as the original polydir (/tmp for example) is writable
> by the
> attacking process, they can move .inst aside.

/tmp is owned by root so a root process can rename any object under Unix 
permissions.  Root on a non-SE system or as unconfined_t on a targeted system 
is game-over.  Root on a SE system running strict or mls policy will not be 
able to rename the .inst directory if we give it a suitable type and only 
permit the administrator and the login programs to have any access to it.

I think that this case is covered too.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
