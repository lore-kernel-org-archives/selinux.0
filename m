Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4V4DQgA029426
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 00:13:26 -0400 (EDT)
Received: from rwcrmhc12.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4V47FpZ016475
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 04:07:15 GMT
Subject: Re: gentoo/hardened
From: Chris PeBenito <pebenito@gentoo.org>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20050531005739.GH28006@lkcl.net>
References: <20050530013136.GA28006@lkcl.net>
	 <1117496766.1742.39.camel@chris.pebenito.net>
	 <20050531005739.GH28006@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UplrG2DN/049UXp2MP79"
Date: Tue, 31 May 2005 00:07:34 -0400
Message-Id: <1117512454.1742.101.camel@chris.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-UplrG2DN/049UXp2MP79
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-05-31 at 01:57 +0100, Luke Kenneth Casson Leighton wrote:
> On Mon, May 30, 2005 at 07:46:06PM -0400, Chris PeBenito wrote:
> > On Mon, 2005-05-30 at 02:31 +0100, Luke Kenneth Casson Leighton wrote:
> > > i've just installed gentoo/hardened on a laptop, and i wanted to run
> > > Xorg on it.
> > >=20
> > Gentoo users are willing to give up more functionality, especially
> > legacy support, for more security. =20
>=20
>  i'd like to be a gentoo user, and i'd like it to be _less
>  work_ to achieve more [see later on.  short: users' confusion and
>  bewilderment at complexity and divergence from the "standard"
>  is a recipe for LESS security not more].

The complexity of policy is created by the fact that Linux is a general
purpose OS.  The current policy is hard to understand, regardless.  This
is something that we are working on improving at Tresys with our
reference policy work.

http://tresys.com/Downloads/selinux_dev/reference-policy.pdf

> > We also don't want a bunch of dead
> > policy, since its wasteful, and leaves more possibility of unwanted
> > information flows. =20
>=20
>  okay - how about splitting what you classify as "dead policy"
>  [wrt gentoo] out into separate files, then submitting
>  a patch that then makes it easier for gentoo to "exclude"
>  those files... WITHOUT people like me having to wade through
>  a diff -ru to work out what you've deleted!

I think I had a poor choice of words.  Its not dead policy, its unused
policy.  For example, there is no need for a ntpd policy to be installed
on all systems, since not all systems have ntp.

> > So the 'base policy' is only the policy needed for
> > the core system packages. =20
>=20
> > As a user merges more packages, policy is
> > pulled in as a dependency as required. =20
>=20
>  yes, i noticed that - i thought that was a great idea.
> =20
>  it also means that people have to _explicitly_ install an
>  selinux policy package in order to allow the service to
>  actually... er... work!

No, as I said above, it is pulled in as a dependency.  So if you install
ntp, selinux-ntp (the ntpd policy package) is installed first.  It does
not have to be explicitly installed.

>  the debian install method - over 100 questions "do you want
>  package X" - yeurrk :)  try doing apt-get install on _that_!

Interactive ebuilds are disallowed in Gentoo.
=20
> > Configurability is a big thing
> > for Gentoo users, and thus they are willing to get down into the
> > details, so we definitely install the policy sources.  Most of the
> > tunable policy does not need to be toggled at runtime; therefore, I
> > reverted the conditional policy back to m4 ifdefs so there isn't extra
> > unneeded policy in memory.
>=20
>  hm... you're the second person to have raised this.
> =20
>  valdis just this week chopped a stack-load of [iirc
>  correctly: unused? ] macro stuff out and the memory usage
>  dropped dramatically.

I am not concerned about the size of the policy.conf, I'm concerned
about the size of the policy in kernel memory.  For example, the Fedora
policy is somewhere around 1280 types and 270,000 rules.  The strict
policy on my notebook is 598 types and 64,822 rules, including the X
policies.  I'm sure the difference in memory footprint for the policydb
is noticeable.

> > The main divergence is the conditional policy being switched back to m4
> > ifdefs.  This wouldn't be sanely handled with distro tunables.  Most
> > everything else is just the fact that I don't keep up with sourceforge
> > CVS religiously. =20
[cut]
>  but hell i _sure_ don't want to get involved with a "fork"
>  of selinux security policy - i _just_ don't have the time or
>  money to focus on it in enough paranoid detail, and - correct
>  me if i'm wrong - i doubt whether you do, either.

You used a scary word to describe the Gentoo policy.  It is most
certainly not a fork, it is a vendor branch.  I do sync up with the
latest changes, usually when there is a release by the NSA guys, or if
there is another need for an update.  This is a common practice.  For
example, I doubt that the Fedora coreutils package has the same patches
as the Debian coreutils package or the Gentoo coreutils package, etc.
The same can be said for each distro's kernels.

>  and that _sure_ as hell means that no sane gentoo admin
>  is going to have the time or inclination either - no matter
>  _how_ configurable gentoo is.  [i have an experienced sysadmin
>  friend - 15 years he's set up servers in secure environments.
>  he had to call ME in to implement up a customised bastion
>  selinux sftp server a few months back, after he explained to
>  his bosses that it would take him a MONTH to even BEGIN to
>  understand the issues involved in selinux policy, and even
>  then he wouldn't be sure where to start or even if he'd got
>  it right]

Again, this has nothing to do with the distribution or the changes I
make to the Gentoo policy.  See my above comments on the reference
policy and policy complexity.

>  ... there _are_ people however whose expertise you could ride with -
>  stephen, russell, tresys - but forking a separate gentoo/hardened
>  policy makes their expertise that _extra_ bit more remote.

I don't see how a little divergence makes their expertise remote.  BTW, I
also work on policy at Tresys if you didn't realize :)

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--=-UplrG2DN/049UXp2MP79
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCm+MGvI7kLeavkkMRAoW8AJsGb5ia4O7mXB6IKIjZWkXvtjGqYACeOhYz
T4wFcoDQbdHUzBTLdD/ymug=
=mAh5
-----END PGP SIGNATURE-----

--=-UplrG2DN/049UXp2MP79--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
