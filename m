Subject: Re: ps aux output under sysadm context in refpolicy
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1203690930.2804.33.camel@moss-spartans.epoch.ncsc.mil>
References: <1203628966.3669.820.camel@bluejay.goodinassociates.com>
	 <1203690930.2804.33.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Pn9WFKbs+NGHQU/PEbjr"
Date: Fri, 22 Feb 2008 08:56:05 -0600
Message-Id: <1203692165.3669.910.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Pn9WFKbs+NGHQU/PEbjr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I wonder if I'm using apol incorrectly. I have:
Analysis type =3D Doman Transition
Direction =3D Forward
source domain =3D sysadm_t
use access filters =3D checked
included object types =3D mysecure_t
included object classes =3D dir & file
permission for dir =3D getattr & read & search
permissions for file =3D getattr & read

results tree =3D sysadm_t & nothing else, no possible expansions.

I read this as, there is no possible path from sysadm_t to mysecure_t

yet, I get the following output from pas auxZ
system_u:system_r:mysecure_t:s0  mysecure   3531  0.0  0.0 139276  2396 ?  =
      Sl   Feb14   0:00 /usr/local/mysecure/bin/mysecure -Umysecure

I'm stumped :)

On Fri, 2008-02-22 at 09:35 -0500, Stephen Smalley wrote:
> On Thu, 2008-02-21 at 15:22 -0600, Jeremiah Jahn wrote:
> > I'm having a heck of a time limiting the ps aux output to show only wha=
t
> > I think sysadm should be able to see.
> >=20
> > I have a number of types that are running and I get a ptrace denied, bu=
t
> > sysadm can still see the process. I'm really not sure why this is the
> > case. I've set all the build options correctly, ie left the defaults,
> > the booleans are set to no. Somewhere there is something going on that
> > lets sysadm see all of this stuff, and I just can't find it.
> >=20
> > According to apol there is not way for me to read the proc files as
> > sysadm. What Am I missing, or where should I look.
>=20
> Access to the basic /proc/pid information is allowed by:
> 	# search the /proc/pid directory for the target domain
> 	allow <source domain> <target domain>:dir search;
> 	# read public information about the target domain
> 	allow <source domain> <target domain>:file read;
> since the /proc/pid files are labeled with the domain of the associated
> process.
>=20
> Certain /proc/pid nodes are further limited by ptrace since they reveal
> what should be private information to the process.
>=20
> >=20
> > thanx,
> > -jj-
> >=20
> >=20
> >=20
> > He thought he saw an albatross That fluttered 'round the lamp. He looke=
d
> > again and saw it was A penny postage stamp. "You'd best be getting
> > home," he said, "The nights are rather damp."
Political T.V. commercials prove one thing: some candidates can tell all
their good points and qualifications in just 30 seconds.

--=-Pn9WFKbs+NGHQU/PEbjr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHvuKF6caZY8jbHDkRArIqAJ49BKuDy6BMq/URDgEYYMoxDN9UzwCggKQM
AmDeDRSWU4321ayhbPo5eX0=
=GAkF
-----END PGP SIGNATURE-----

--=-Pn9WFKbs+NGHQU/PEbjr--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
