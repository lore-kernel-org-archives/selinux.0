Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k45A7CAZ013276
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 06:07:12 -0400
Received: from h80ad24b9.async.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k45A7AU3026130
	for <selinux@tycho.nsa.gov>; Fri, 5 May 2006 10:07:10 GMT
Message-Id: <200605051006.k45A6vNK024699@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: pam_namespace
In-Reply-To: Your message of "Fri, 05 May 2006 19:14:20 +1000."
             <200605051914.24123.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <200605051623.25533.russell@coker.com.au> <200605050750.k457oPp6014607@turing-police.cc.vt.edu>
            <200605051914.24123.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1146823616_2521P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 05 May 2006 06:06:56 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1146823616_2521P
Content-Type: text/plain; charset=us-ascii

On Fri, 05 May 2006 19:14:20 +1000, Russell Coker said:
> Yes, which of course means that programs the user runs in different domains
> will need modified policy to allow creation of temp files.  This isn't
> impossible but does have other issues including the fact that such programs
> will be able to create /tmp/dir/file where /tmp/dir is a directory created by
> the user, this may not be desired.
> 
> Setting a range on the per-user tmp directory that matches the range of their
> login process makes some sense.  But using a type other than tmp_t does not
> make sense to me.

There's already code in there to support per-user, per-context, and even
per-user-and-context-pair.  Adding ranges may make sense for some systems -
the problems start when we have to allow for various policy types - strict,
targeted, and each with MLS and MCS variants.  We need:

a) a way to specify what the system policy is - what's acceptable to me
may not be to others, and vice versa.

b) A check that we fail in a sane manner if the SELinux policy and the
pam_namespace config aren't compatible.  This may be tricky - for a system
that's in strict/MLS mode, failing to config may be grounds for failing totally
in a noisy manner (refusing the logon, for instance) - while for targeted
we may want to just ignore an attempt to specify MLS features..

> Also we want the namespace feature to work on non-SE systems where the option 
> of a different SE Linux context is not available.

See the above - I think we're in agreement here.  But I admit I don't know what
"proper" behavior is if the threat model is "a non-SE system, and a 0wned
uid=0 daemon getting into /tmp/$USER" - how do we stop that (ugly hacks like
cd'ing into the directory, and then mount --bind an empty dir over it?)

> Why do you object to the idea of using a sub-directory for this?

I don't - I just want to be *really* sure that the sub-directory is set up right. ;)

> > (and then hardlink the socket already open by GDM into that directory so
> > the user's X session can find it).  This however still loses, because at
> > this point we're already running in the user's SELinux context, so we
> > probably can't do the chcon.  Janak was going to look at setexeccon() games
> > so the script can do setup that the user can't....
> 
> Why can't we have a script run in system context?

That's the goal of the setexeccon() that Janak was going to look into.  The
problem is that we're already in a user context - what happens if that context
isn't *allowed* to setexeccon() to a system context?



--==_Exmh_1146823616_2521P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEWyPAcC3lWbTT17ARAvaBAJ0WIcoh4nZnQ2elpOBvfnnhVAoCNACgtQyc
jinaZOd/RmRi/ttgFcNMkOo=
=UJq3
-----END PGP SIGNATURE-----

--==_Exmh_1146823616_2521P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
