Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81HmArT022971
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 13:48:11 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81Hm9eu011208
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 17:48:09 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i81HmgST027325
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 13:48:42 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i81HmgVN027324
	for selinux@tycho.nsa.gov; Wed, 1 Sep 2004 13:48:42 -0400
Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81DTqrT020855
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 09:29:53 -0400 (EDT)
Received: from mailgate.netsplit.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81DT2Y2028218
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 13:29:03 GMT
Subject: Re: dpkg and selinux
From: Scott James Remnant <scott@netsplit.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Dpkg Development <debian-dpkg@lists.debian.org>,
   Debian Developers <debian-devel@lists.debian.org>
In-Reply-To: <20040901101921.GC5882@lkcl.net>
References: <20040831234115.GZ4375@lkcl.net>
	 <1094004762.6901.68.camel@descent.netsplit.com>
	 <20040901101921.GC5882@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wbyMOsdWDgf/UnGdjkgE"
Date: Wed, 01 Sep 2004 14:30:03 +0100
Message-Id: <1094045403.6901.112.camel@descent.netsplit.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wbyMOsdWDgf/UnGdjkgE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-01 at 11:19 +0100, Luke Kenneth Casson Leighton wrote:

> On Wed, Sep 01, 2004 at 03:12:42AM +0100, Scott James Remnant wrote:
> > On Wed, 2004-09-01 at 00:41 +0100, Luke Kenneth Casson Leighton wrote:
> >=20
> > > the way that russell's "postinst.d" patch works is that for every
> > > package, exactly at the end of its postinst script, the scripts in
> > > postinst.d are run - with the name of the package as an argument.
>=20
So we've ascertained that this statement was wrong and that Russell's
patch actually runs postinst.d scripts *before* the package's postinst
script.
=09
> the analogy is to imagine that chmod, chgrp and chown were a new
> concept that had to be retrofitted onto a system where the default
> permissions were noaccess, noaccess, 0000, with no members in the
> group "noaccess".
>=20
It's an interesting one, certainly I'd suggest the right solution would
be to do such commands in postinst until such time as it was the default
and the tar format could carry this information.  It would then become
policy that it would be carried inside the tar file, just as chmod/
chgrp/chown are carried today.

> you'd have to specify a file with unix_contexts in it which
> had:
>=20
>  	/bin(/.*)?		root,root,0755
> 	/bin/ping		root,root,1755 (...or is it 3755 for setuid?)
>=20
> etc, with THOUSANDS of entries...
>=20
The thing that worries me about this file is that it contains policy for
things I don't have installed on my system; and doesn't seem to cope
well with differing policy for (e.g.) two binaries called 'ssh' which
may have different requirements.

SELinux's seems to suffer the same problem, it assumes what you have
installed on your system.

Ordinary system administrators don't want this file, they want a
sensible chown/chgrp/chmod setup when they install packages -- how many
of our users really use dpkg-statoverride?

> it might not actually be the case... but the example you give below
> tends to suggest that it might be worse than suspected, and
> that the source code of dpkg might need to be patched instead,
> in the same way that rpm has been patched (and cron, and ssh,
> and udev)
>=20
Indeed, I'm leaning towards agreeing with you.  The postinst solution
has always smelled of rotten fish, it needs to be done properly --
either inside dpkg or inside the package postinsts.

However I'm loath to embed specific selinux support into dpkg if it
introduces extra dependencies, or causes problems for those not using
it.

The fact that RPM does it isn't actually relevant; RPM has a history of
doing things at install-time ... e.g. library/file dependencies.  We've
always taken a build-time attitude to it, with the packaging format and
manager as (relatively) simple as possible.

> am i correct in thinking that the tarobject function is responsible
> for doing the dpkg unpacking?
>=20
Vaguely, files are unpacked in a temporary place then moved into the
right place (inside process_archive).

> > If it's really true, isn't it going to be also true that sometimes you
> > need to do the selinux processing before certain actions in the postins=
t
> > (like starting the daemon) are performed?
> =20
> ... you know, i think you could be right.
>=20
I knew I wasn't crazy :o)

> i think only stephen, russell, dan or colin are in a position to
> answer that.
>=20
Sadly they've stopped answering my calls <g>

> > > for example, a few months ago i genuinely believed that
> > > it would be a great idea for all package maintainers to be
> > > responsible for selinux policy (such that it would be okay to
> > > move selinux policy into debian packages): now i know that there
> > > are targetted and strict policies, and that writing selinux
> > > policy is sufficiently complex and inter-dependent for it to
> > > require significant expert knowledge - something that package
> > > maintainers DON'T NEED and DON'T even NEED TO KNOW ABOUT.
> > >=20
> > Package maintainers don't need, and don't even need to know about
> > debconf templates, translations, debian policy, etc.  Let's separate
> > those out into separate packages too!
>=20
> i know you mean that in a sarcastic way
>=20
Actually that was irony, I could try for sarcasm if you like <g>

> okay... an analogy that may help you to understand: how many versions
> of the debian policy document are there?
> there's only one, isn't there?  everyone stick to it (hmmm, please
> don't correct me if that's wrong :)
>=20
>  ... what if there was more than one debian policy document?
>=20
>  what if SITE ADMINISTRATORS could decide which debian policy document
>  should be applied to their system?
>=20
>  as a concept, it doesn't work, does it?
>=20
Actually, it rather does.  Site admins could specify where man pages
went on their system, how shared libraries were installed, etc.

> >    And here we lead on to another fairy-tale story of "classes", a
> >    feature of Solaris' packaging system I quite admire.  The selinux
> >    support packages could implement replacement class handling that
> >    performed the required selinux voodoo as it installed files.
> >=20
> >    (This is one of my ideas for generic conffile handling, btw.)
>=20
> ooooo.
>=20
> well, replacement, no, but "wrapping" yes.
>=20
> in other words, the selinux support packaging system would run and then b=
e
> responsible for calling the "default" packaging system.
>=20
Yeah.  The basic theory of a class is that it's a function responsible
for taking an unpacked item (if it exists) and placing it on the
filesystem in the right place (with diverts taken into account).
conffiles would just be files with a different class to ordinary files
that offered a chance to choose which file won.

You could then specify alternate handlers for a class, dropping in
(e.g.) a debconfish or ucf replacement for the default configuration
handling, one that did a 3diff, etc.

SELinux could replace the default class handler with one that applied
contexts after the default was run.

But as I said, this is fairy-land at the moment -- it's a feature of
Solaris' packaging system I admire, and would certainly make some of the
code more generic and less twisty.

> > Another use case for this "always run" functionality is prelinking
> > binaries, or updating the updatedb/locate database.
>=20
> yes.
>=20
Notably though these are "always run at the end of an installation run",
so aren't compatible with the stuff you've asked for.

> > In which case we're back to changing postinst of every package again
> > (which is actually largely just a change-debhelper problem, anyway).
>=20
> well, if the same effect can be achieved by doing the equivalent in
> debhelper, then great.
>=20
Certainly, debhelper writes the stuff to postinst for a large percentage
of our packages.  It's a build-time solution to the problem, and
relatively elegant.

> > What happens to those files the package's postinst creates? =20
>=20
> > Such as
> > debconf-maintained configuration files, symlinks, etc.  How do those ge=
t
> > selinux policy?
>=20
>  to be honest, i don't rightly know.
>=20
>  _hopefully_ they are mentioned in the dpkg -L <packagename> listing
>  such that they can be managed.
>=20
Nope.  Policy, in fact, demands that they aren't mentioned -- files
written during package maintainer scripts *cannot* be dpkg managed
conffiles.  (They get into a bit of a fight).

>  i assume that if they're not listed in the dpkg -L <packagename>
>  listing that that's a bug in the package, because when the time
>  comes for that package to be purged, symlinks would be left behind.
>=20
>  .... or, is there something that's been missed?
>=20
The symlinks, files, etc. get removed in prerm.

> does dpkg -L not include debconf-maintained configuration files?
>=20
Yup, they're utterly missing from it.

descent scott% dpkg -S /etc/X11/XF86Config-4
dpkg: /etc/X11/XF86Config-4 not found.


Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?

--=-wbyMOsdWDgf/UnGdjkgE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBNc7bIexP3IStZ2wRAmqJAKCRAh4P3n22wviZodorWbPn6Mwx3gCggVYr
HhMR9+k3B2YwPSuAXh/StRU=
=Rx31
-----END PGP SIGNATURE-----

--=-wbyMOsdWDgf/UnGdjkgE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
