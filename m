Subject: Re: ps aux output under sysadm context in refpolicy
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1203692479.2804.54.camel@moss-spartans.epoch.ncsc.mil>
References: <1203628966.3669.820.camel@bluejay.goodinassociates.com>
	 <1203690930.2804.33.camel@moss-spartans.epoch.ncsc.mil>
	 <1203692165.3669.910.camel@bluejay.goodinassociates.com>
	 <1203692479.2804.54.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sA8LJQgHa5zShZ3c/DNn"
Date: Fri, 22 Feb 2008 09:19:19 -0600
Message-Id: <1203693559.3669.915.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-sA8LJQgHa5zShZ3c/DNn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

okay, done, apparently I have some attribute set some place, but apol
only shows it a @ttr2718 Is there some way I can get this to translate
to English? I'm not that familiar with apol.

On Fri, 2008-02-22 at 10:01 -0500, Stephen Smalley wrote:
> On Fri, 2008-02-22 at 08:56 -0600, Jeremiah Jahn wrote:
> > I wonder if I'm using apol incorrectly. I have:
> > Analysis type =3D Doman Transition
> > Direction =3D Forward
> > source domain =3D sysadm_t
> > use access filters =3D checked
> > included object types =3D mysecure_t
> > included object classes =3D dir & file
> > permission for dir =3D getattr & read & search
> > permissions for file =3D getattr & read
> >=20
> > results tree =3D sysadm_t & nothing else, no possible expansions.
> >=20
> > I read this as, there is no possible path from sysadm_t to mysecure_t
> >=20
> > yet, I get the following output from pas auxZ
> > system_u:system_r:mysecure_t:s0  mysecure   3531  0.0  0.0 139276  2396=
 ?        Sl   Feb14   0:00 /usr/local/mysecure/bin/mysecure -Umysecure
> >=20
> > I'm stumped :)
>=20
> Domain transitions are process transitions, i.e. can sysadm_t transition
> to mysecure_t.  Not can it read from it.
>=20
> You can use the rule searching facilities to look for direct read rules,
> or can use the information flow analysis to see if there is any path by
> which mysecure_t can flow to sysadm_t, but the latter is likely less
> useful because there is almost always at least one indirect path by
> which information can flow.
>=20
> >=20
> > On Fri, 2008-02-22 at 09:35 -0500, Stephen Smalley wrote:
> > > On Thu, 2008-02-21 at 15:22 -0600, Jeremiah Jahn wrote:
> > > > I'm having a heck of a time limiting the ps aux output to show only=
 what
> > > > I think sysadm should be able to see.
> > > >=20
> > > > I have a number of types that are running and I get a ptrace denied=
, but
> > > > sysadm can still see the process. I'm really not sure why this is t=
he
> > > > case. I've set all the build options correctly, ie left the default=
s,
> > > > the booleans are set to no. Somewhere there is something going on t=
hat
> > > > lets sysadm see all of this stuff, and I just can't find it.
> > > >=20
> > > > According to apol there is not way for me to read the proc files as
> > > > sysadm. What Am I missing, or where should I look.
> > >=20
> > > Access to the basic /proc/pid information is allowed by:
> > > 	# search the /proc/pid directory for the target domain
> > > 	allow <source domain> <target domain>:dir search;
> > > 	# read public information about the target domain
> > > 	allow <source domain> <target domain>:file read;
> > > since the /proc/pid files are labeled with the domain of the associat=
ed
> > > process.
> > >=20
> > > Certain /proc/pid nodes are further limited by ptrace since they reve=
al
> > > what should be private information to the process.
> > >=20
> > > >=20
> > > > thanx,
> > > > -jj-
> > > >=20
> > > >=20
> > > >=20
> > > > He thought he saw an albatross That fluttered 'round the lamp. He l=
ooked
> > > > again and saw it was A penny postage stamp. "You'd best be getting
> > > > home," he said, "The nights are rather damp."
> > Political T.V. commercials prove one thing: some candidates can tell al=
l
> > their good points and qualifications in just 30 seconds.
With every passing hour our solar system comes forty-three thousand
miles closer to globular cluster M13 in the constellation Hercules, and
still there are some misfits who continue to insist that there is no
such thing as progress. -- Ransom K. Ferm

--=-sA8LJQgHa5zShZ3c/DNn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHvuf36caZY8jbHDkRApL4AKCkzg8ZAVA6TvdpNNsOZYUy1W5ixwCeOitZ
zrY550IxCUt9X98ognYmLKk=
=PHx6
-----END PGP SIGNATURE-----

--=-sA8LJQgHa5zShZ3c/DNn--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
