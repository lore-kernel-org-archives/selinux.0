Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k479SOAF027249
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 05:28:26 -0400
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k479SJiA001261
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 09:28:21 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Valdis.Kletnieks@vt.edu
Subject: Re: pam_namespace
Date: Sun, 7 May 2006 19:28:19 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200605051623.25533.russell@coker.com.au> <200605051914.24123.russell@coker.com.au> <200605051006.k45A6vNK024699@turing-police.cc.vt.edu>
In-Reply-To: <200605051006.k45A6vNK024699@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200605071928.22799.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 05 May 2006 20:06, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 05 May 2006 19:14:20 +1000, Russell Coker said:
> > Yes, which of course means that programs the user runs in different
> > domains will need modified policy to allow creation of temp files.  This
> > isn't impossible but does have other issues including the fact that such
> > programs will be able to create /tmp/dir/file where /tmp/dir is a
> > directory created by the user, this may not be desired.
> >
> > Setting a range on the per-user tmp directory that matches the range of
> > their login process makes some sense.  But using a type other than tmp_t
> > does not make sense to me.
>
> There's already code in there to support per-user, per-context, and even
> per-user-and-context-pair.  Adding ranges may make sense for some systems -
> the problems start when we have to allow for various policy types - strict,
> targeted, and each with MLS and MCS variants.  We need:

Why is it a problem?

We already have $USER and $HOME as variables that can be used by the namespace 
module, all we need to do is add $DOMAIN, $HIGH, and $LOW (so that the 
instance directory name can be based on the SE Linux domain of the process, 
the high end of the MLS range, or the low end of the MLS range).

For MCS we want the high end of the MLS range to be used as part of the 
directory name, for MLS we probably want the low end of the range to be used 
(but both would be an option).

> a) a way to specify what the system policy is - what's acceptable to me
> may not be to others, and vice versa.

Of course.  Adding suitable configuration options 
to /etc/security/namespace.conf will solve this.

> b) A check that we fail in a sane manner if the SELinux policy and the
> pam_namespace config aren't compatible.  This may be tricky - for a system
> that's in strict/MLS mode, failing to config may be grounds for failing
> totally in a noisy manner (refusing the logon, for instance) - while for
> targeted we may want to just ignore an attempt to specify MLS features..

In what way do the require_selinux and the ignore_config_error command-line 
options to the pam_namespace.so module not do what you desire in this regard?

> > Also we want the namespace feature to work on non-SE systems where the
> > option of a different SE Linux context is not available.
>
> See the above - I think we're in agreement here.  But I admit I don't know
> what "proper" behavior is if the threat model is "a non-SE system, and a
> 0wned uid=0 daemon getting into /tmp/$USER" - how do we stop that (ugly
> hacks like cd'ing into the directory, and then mount --bind an empty dir
> over it?)

On a non-SE system "0wned uid=0 daemon" is considered to be game-over.

However a uid>0 daemon on a non-SE system should not be able to interfere with 
regular users, but this is the case currently!

Also there's the potential situation of a UID=0 daemon on a SE Linux system 
that is permitted some access to user types.

Of course there's nothing stopping us from modifying a program such as runuser 
or run_init to set up a namespace for a daemon.  In fact we should probably 
make the default behavior of run_init and runuser be the creation of a 
namespace.  It would be easy to create a config file for runuser that allows 
excluding daemons on the basis of executable name, UID, or other factors.

> > Why do you object to the idea of using a sub-directory for this?
>
> I don't - I just want to be *really* sure that the sub-directory is set up
> right. ;)

It seems that we agree that there is a need for an intermediate directory and 
that the only area of uncertainty is regarding the context and mode of it.

> > > (and then hardlink the socket already open by GDM into that directory
> > > so the user's X session can find it).  This however still loses,
> > > because at this point we're already running in the user's SELinux
> > > context, so we probably can't do the chcon.  Janak was going to look at
> > > setexeccon() games so the script can do setup that the user can't....
> >
> > Why can't we have a script run in system context?
>
> That's the goal of the setexeccon() that Janak was going to look into.  The
> problem is that we're already in a user context - what happens if that
> context isn't *allowed* to setexeccon() to a system context?

How are we already in a user context?  sys_unshare() can only be called from a 
system context...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
