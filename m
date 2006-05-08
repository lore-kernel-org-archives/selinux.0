Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4817lp2007237
	for <selinux@tycho.nsa.gov>; Sun, 7 May 2006 21:07:47 -0400
Received: from h80ad2474.async.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4817iiA025542
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 01:07:45 GMT
Message-Id: <200605080107.k4817awO007711@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: pam_namespace
In-Reply-To: Your message of "Sun, 07 May 2006 19:28:19 +1000."
             <200605071928.22799.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <200605051623.25533.russell@coker.com.au> <200605051914.24123.russell@coker.com.au> <200605051006.k45A6vNK024699@turing-police.cc.vt.edu>
            <200605071928.22799.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147050455_2578P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 07 May 2006 21:07:35 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1147050455_2578P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <7701.1147050455.1@turing-police.cc.vt.edu>

On Sun, 07 May 2006 19:28:19 +1000, Russell Coker said:

> > There's already code in there to support per-user, per-context, and even
> > per-user-and-context-pair.  Adding ranges may make sense for some systems -
> > the problems start when we have to allow for various policy types - strict,
> > targeted, and each with MLS and MCS variants.  We need:
> 
> Why is it a problem?

I didn't say it was a problem. I said it was needed additional functionality
if you want to support it.

> We already have $USER and $HOME as variables that can be used by the namespace 
> module, all we need to do is add $DOMAIN, $HIGH, and $LOW (so that the 
> instance directory name can be based on the SE Linux domain of the process, 
> the high end of the MLS range, or the low end of the MLS range).
> 
> For MCS we want the high end of the MLS range to be used as part of the 
> directory name, for MLS we probably want the low end of the range to be used 
> (but both would be an option).

More code, more options, more complexity...

> > a) a way to specify what the system policy is - what's acceptable to me
> > may not be to others, and vice versa.
> 
> Of course.  Adding suitable configuration options 
> to /etc/security/namespace.conf will solve this.

The trick is fining a set of options that cover all the bases, but
are still comprehensible to the average sysadmin..

> > b) A check that we fail in a sane manner if the SELinux policy and the
> > pam_namespace config aren't compatible.  This may be tricky - for a system
> > that's in strict/MLS mode, failing to config may be grounds for failing
> > totally in a noisy manner (refusing the logon, for instance) - while for
> > targeted we may want to just ignore an attempt to specify MLS features..
> 
> In what way do the require_selinux and the ignore_config_error command-line 
> options to the pam_namespace.so module not do what you desire in this regard?

ignore_config_error is only sufficient if there is no possibility of
any option misbehaving - in particular, we can't have an option 'both'
that works in MCS/MLS environments as well - we'll need to have a both_mcs
if the mcs label is to be included, and a both_no_mcs if it should behave
in the same way as the non-mcs 'both'.

> > > Also we want the namespace feature to work on non-SE systems where the
> > > option of a different SE Linux context is not available.
> >
> > See the above - I think we're in agreement here.  But I admit I don't know
> > what "proper" behavior is if the threat model is "a non-SE system, and a
> > 0wned uid=0 daemon getting into /tmp/$USER" - how do we stop that (ugly
> > hacks like cd'ing into the directory, and then mount --bind an empty dir
> > over it?)
> 
> On a non-SE system "0wned uid=0 daemon" is considered to be game-over.

So you're saying that on a non-SE system, namespaces are *not* in the
least expected to slow down a rogue daemon.  OK, as long as we make a
note of that..


> > > > (and then hardlink the socket already open by GDM into that directory
> > > > so the user's X session can find it).  This however still loses,
> > > > because at this point we're already running in the user's SELinux
> > > > context, so we probably can't do the chcon.  Janak was going to look at
> > > > setexeccon() games so the script can do setup that the user can't....
> > >
> > > Why can't we have a script run in system context?
> >
> > That's the goal of the setexeccon() that Janak was going to look into.  The
> > problem is that we're already in a user context - what happens if that
> > context isn't *allowed* to setexeccon() to a system context?
>
> How are we already in a user context?  sys_unshare() can only be called from a
> system context...

OK, you tell me what's going on here:

# head /etc/security/namespace.init
#!/bin/bash
logger -i -p authpriv.info "called with args $1 $2" `id`

produces:

May  7 21:03:57 turing-police login: pam_namespace(login:session): Inst context system_u:object_r:staff_tmp_t Orig context system_u:object_r:tmp_t
May  7 21:03:57 turing-police login: pam_namespace(login:session): instance_dir /tmp/tmp.system_u:object_r:staff_tmp_t_valdis
May  7 21:03:57 turing-police LOGIN[7584]: called with args /tmp /tmp/tmp.system_u:object_r:staff_tmp_t_valdis uid=0(root) gid=0(root) groups=10(wheel),967(valdis) context=valdis:staff_r:staff_t

The problem is that the pam_namespace is still running in a system context,
but since an earlier pam_selinux called setexeccon(), when namespace
does an exec, it gets parked in the user context that pam_selinux intended
to inflict on the actual user login....

--==_Exmh_1147050455_2578P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEXpnXcC3lWbTT17ARAqeGAKDu6MixFsxecPr0PBmOOa52xq/V9gCeIAaB
t5Xjgw9rA9yeHimqJbeyJCo=
=R3MT
-----END PGP SIGNATURE-----

--==_Exmh_1147050455_2578P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
