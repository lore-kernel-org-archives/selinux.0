Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i81Hm9rT022966
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 13:48:09 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i81HlJY2018273
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 17:47:19 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i81HmebO027319
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 13:48:40 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i81Hmep3027318
	for selinux@tycho.nsa.gov; Wed, 1 Sep 2004 13:48:40 -0400
Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i812CZrT017581
	for <selinux@tycho.nsa.gov>; Tue, 31 Aug 2004 22:12:35 -0400 (EDT)
Received: from mailgate.netsplit.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i812CXS3017802
	for <selinux@tycho.nsa.gov>; Wed, 1 Sep 2004 02:12:33 GMT
Subject: Re: dpkg and selinux
From: Scott James Remnant <scott@netsplit.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Dpkg Development <debian-dpkg@lists.debian.org>,
   Debian Developers <debian-devel@lists.debian.org>
In-Reply-To: <20040831234115.GZ4375@lkcl.net>
References: <20040831234115.GZ4375@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4QcaC3praRSFO1U8ZtTI"
Date: Wed, 01 Sep 2004 03:12:42 +0100
Message-Id: <1094004762.6901.68.camel@descent.netsplit.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-4QcaC3praRSFO1U8ZtTI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-01 at 00:41 +0100, Luke Kenneth Casson Leighton wrote:

> the way that russell's "postinst.d" patch works is that for every
> package, exactly at the end of its postinst script, the scripts in
> postinst.d are run - with the name of the package as an argument.
>=20
> this is subtly different from dpkg triggers, and the differences are
> due to the different requirements of selinux.  YES it is necessary
> to run the selinux postinst.d script on EVERY package.  YES it
> is necessary to run it after every package's postinst script.
>=20
This is the bit I still have trouble believing; I could claim that it is
necessary for ldconfig or scrollkeeper-update to run on EVERY page...
but that's just not true.

Why is it necessary for the selinux update to complete before the
processing of the next package is begun?

If it's really true, isn't it going to be also true that sometimes you
need to do the selinux processing before certain actions in the postinst
(like starting the daemon) are performed?

Or does it not matter that the daemon is started before selinux
privileges/permissions are applied to its binary?

If that doesn't matter I don't see why it matters that the processing is
deferred until the end of the run.

> for example, a few months ago i genuinely believed that
> it would be a great idea for all package maintainers to be
> responsible for selinux policy (such that it would be okay to
> move selinux policy into debian packages): now i know that there
> are targetted and strict policies, and that writing selinux
> policy is sufficiently complex and inter-dependent for it to
> require significant expert knowledge - something that package
> maintainers DON'T NEED and DON'T even NEED TO KNOW ABOUT.
>=20
Package maintainers don't need, and don't even need to know about
debconf templates, translations, debian policy, etc.  Let's separate
those out into separate packages too!

> i am endeavouring to either convince him otherwise, or to make
> some suggestions which would allow the present or an equivalent
> of the present /etc/dpkg/postinst.d/selinux script running
> under russell's patched dpkg to successfully be replaced by
> a dpkg "trigger".
>=20
I believe triggers really will work for what you want; if they don't
then here's two problems with postinst.d:

1) is there actually another use case for it that isn't solved by
   triggers?

2) if not, then it's a selinux-specific feature and actually worse than
   simply embedding knowledge of selinux into dpkg.

   And here we lead on to another fairy-tale story of "classes", a
   feature of Solaris' packaging system I quite admire.  The selinux
   support packages could implement replacement class handling that
   performed the required selinux voodoo as it installed files.

   (This is one of my ideas for generic conffile handling, btw.)

> dpkg "triggers" will ONLY work for selinux under these circumstances,
> and i REALLY mean "only".
>=20
> a) if the selinux dpkg "trigger" could guarantee to ALWAYS be run, not
>    just be called from one or a few packages.  reason: ALL files
>    installed by ALL packages must have their file contexts revamped,
>    NOT just some.
>   =20
>    all files, in fact, that are listed by dpkg -L <packagename>
>=20
Another use case for this "always run" functionality is prelinking
binaries, or updating the updatedb/locate database.

> b) i think i am right in saying that debian "Pre-Depends"
>    groupings will have to be respected: namely that it would be
>    necessary AT THE LEAST to have the selinux dpkg "trigger" run
>    on groups of packages separated at "Pre-Depends" boundaries.
>=20
Why?

If there really is this "policy must be in place before FOO" problem,
surely that (potentially) exists *inside* a single postinst.

In which case we're back to changing postinst of every package again
(which is actually largely just a change-debhelper problem, anyway).

>    i also believe that i am right in saying that this would=20
>    probably have to be done for all dpkg triggers _anyway_ - NOT
>    just the proposed selinux dpkg trigger.
>=20
>    otherwise, you could end up with awful screw-ups where
>    update-modules might not get run, and a "Pre-Dependent"
>    package was _really_ relying on a particular module or
>    module options being set, that sort of thing.
>=20
You've made the very common mistake of mis-understanding how Pre-Depends
work, and how they differ for maintainer scripts compared to ordinary
Depends.  (postinst do run in Depends order, even without Pre-Depends).

Triggers are intended for the kind of postinst activity that can be run
en-masse at the end of the run because it isn't important for depending
packages.

Where importance is placed by depending packages, triggers are not
appropriate and using them would be an abuse (subject to note below).

>    or, scrollkeeper-update might not get run, such
>    that a "Pre-Dependent" package which really needed
>    scrollkeeper-update to succeed prior to moving on.... you
>    get the picture.
>=20
This would never happen; scrollkeeper-update updates the database used
by the user's help browser.  Depending packages never care about it,
thus it's a perfect candidate for triggers.

The exception is where *usually* it's an en-masse activity, but there's
a special requirement that it be run for this package.  Your update-
modules example would be one, except that's deprecated anyway (module-
init-tools' modprobe reads /etc/modprobe.d anyway) -- the package would
ensure that any update-modules runs had been completed.  I actually
can't honestly think of use cases for this now, but there might be some.

> c) if the dpkg "triggers" could receive the complete list of all package
> names, then it is conceivable that this list of names could be
> amalgamated by the dpkg trigger /usr/lib/dpkg/triggers/selinux...
> something like this:
>=20
I certainly don't see a problem with this.  We're wandering to classes
with this behaviour though <g>

What happens to those files the package's postinst creates?  Such as
debconf-maintained configuration files, symlinks, etc.  How do those get
selinux policy?

Aren't you going to need to modify the postinst to add policy for them
too?


> *1 is there an absolute requirement that the present
>   /etc/dpkg/postinst.d/selinux script BE RUN at the
>   end and ONLY IMMEDIATELY AT THE END of EVERY
>   postinst script of EVERY package being installed?
>=20
If there is this requirement, I maintain there is probably a requirement
that it be run before the end of an individual postinst ... requiring
changes to the postinst.

Use case:  Mail server, started as per-policy in postinst.

Do you need to have the selinux policies for its queue and spool
directories in place before it starts?  If so you need to modify that
postinst to do the work before the invoke-rc.d call.

> *2 is it sufficient, is it the case that it's okay, to
>   just wait until the end of a dpkg run (respecting
>   "Pre-Depends" groupings of course), to wait until ALL
>   postinst scripts (of one or more "Pre-Depends" groups
>   of course) are run and THEN to do the above [proposed]
>   /usr/lib/dpkg/triggers/selinux script (more than once if there
>   is more than one "Pre-Depends" grouping of course), receiving
>   the list of all names of all packages just newly installed
>   (in each "Pre-Depends" group of course)?
>=20
I don't believe you need this pre-depends grouping (see above).

> and if it's _not_ okay, then unfortunately we must continue to insist
> that dpkg have the postinst.d system.
>=20
Which would have an entire feature for one particular subset of users,
leaving that feature open to abuse by the others; which I massively
dislike.

> or continue to maintain a fork of dpkg.
>=20
> or request the ftp masters to accept the creation of an se-dpkg package
> containing the forked version of dpkg.
>=20
These are the same thing, and there's no need to involve the ftpmasters.
I'm reasonably sure that anybody is free to upload competing package
managers, provided they don't stamp on the dpkg namespace (dpkg.*).

> my concern with the latter (*2) is that there would be dependency
> problems due to file contexts not having been updated yet,
> that are completely avoided by the /etc/dpkg/postinst.d/selinux
> approach [run just after the package's postinst script is run].
>=20
Why would there be this problem?

> ... or is the problem i envisage avoided by the selinux domain
> in which dpkg is run (and by breaking things down into "Pre-Depends"
> groups).
>=20
Why do we need to do this breaking-things-into-groups?

> for those people not familiar with dpkg, "Pre-Depends" is a system which
> forces a COMPLETE install of all "Pre-Depends" packages prior to
> proceeding with the installation of a package with a "Pre-Depends"
> requirement.
>=20
> if you specify "Depends:" then what you are saying is that
> dpkg can just run all the unpacks of all packages and all
> dependencies (in any order), then run all postinsts of all
> packages and all dependencies (basically in any order it likes).
>=20
*BZZZT* wrong!

Utterly, utterly, incorrect my friend.

Pre-Depends does require complete installation of a package has been
performed before the pre-depending package.  This means that the pre-
depended package will have been unpacked and configured (including
postinst) before the pre-depending package is even unpacked.

Depends requires that depended packages have been unpacked and
configured before depending packages are configured.  This means that
the packages may be unpacked in a reasonably random order, BUT THAT
CONFIGURATION HAPPENS *IN ORDER* (not "any order it likes").

To simplify:

  X Pre-Depends Y means that X.preinst happens *after* Y.postinst.

  X Depends Y means that X.postinst happens *after* Y.postinst.
  (but X.preinst might happen before Y.postinst).

> you so totally can't have circular "Pre-Depends" but you _can_ have two
> packages "Depend" on _each other_
>=20
Actually this has more to do with the fact dpkg will break dependency
cycles introduced by Depend, but not by Pre-Depend.

> of course, you need to ensure that
> the postinst scripts of the inter-dependent cross-"Dependent" packages
> are _really_ okay with that, such that it doesn't matter what order
> their postinst scripts are run in.
>=20
postinst are run in depend order; where there's a cycle that is still
true, they are run in the order they are depended on -- starting at a
given "sensible" point in the cycle.

descent foo% dpkg-deb -f test1_1_i386.deb | grep test
Package: test1
Depends: test2
descent foo% dpkg-deb -f test2_1_i386.deb | grep test
Package: test2

descent foo% sudo dpkg -i test1_1_i386.deb test2_1_i386.deb
Selecting previously deselected package test1.
(Reading database ... 144342 files and directories currently installed.)
Unpacking test1 (from test1_1_i386.deb) ...
Selecting previously deselected package test2.
Unpacking test2 (from test2_1_i386.deb) ...
Setting up test2 (1) ...
Setting up test1 (1) ...

The packages were unpacked in the order given, but the configuration was
done in the order required by the dependencies.


> my concern with selinux is that if the file contexts haven't been set
> up yet under such circumstances... well, you can imagine what might
> happen: you end up with "access denied" errors to files and directories
> that haven't had their permissions correctly set...
>=20
Then I'm convinced this can happen within a given postinst; see my mail
server use case.

Scott
--=20
Have you ever, ever felt like this?
Had strange things happen?  Are you going round the twist?

--=-4QcaC3praRSFO1U8ZtTI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBNTAaIexP3IStZ2wRAg5MAKCepzx47dP/AWc7kVMHOz8OfgxG5ACgkyFU
JvXx5MgiZxuCnuQLFhTs4bI=
=ihKL
-----END PGP SIGNATURE-----

--=-4QcaC3praRSFO1U8ZtTI--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
