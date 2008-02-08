Subject: Re: new user types
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1202479171.27371.320.camel@moss-spartans.epoch.ncsc.mil>
References: <1202426088.2801.500.camel@bluejay.goodinassociates.com>
	 <1202479171.27371.320.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MPwLB1q3EAbIcLzlsA2p"
Date: Fri, 08 Feb 2008 12:13:34 -0600
Message-Id: <1202494415.3577.18.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-MPwLB1q3EAbIcLzlsA2p
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-02-08 at 08:59 -0500, Stephen Smalley wrote:
> On Thu, 2008-02-07 at 17:14 -0600, Jeremiah Jahn wrote:
> > I can't seem to login as the right user, and I'm not sure what I missed=
.
> >=20
> > I added the following roles and users to my monetra.te file:
> >=20
> >=20
> > #admin roles
> > role monetra_admin_r types monetra_t;
> > role monetra_admin_r types monetra_lib_t;
>=20
> role-type statements are only required for domain types, not file types.
> Files use the generic object_r role.
thanx.


>=20
> > #client roles
> > role monetra_client_r types monetra_t;
> > role monetra_client_r types monetra_lib_t;
> > role monetra_client_r types monetra_client_t;
> >=20
> > #monetra users
> > user monetra_u roles { monetra_client_r monetra_admin_r } level s0 rang=
e s0 - s0;
> >=20
> >=20
> >=20
> >=20
> > I ran the add login command:
> > semanage login -a -s monetra_u bob
> >=20
> >=20
> >=20
> > I get the following output:
> > [root@xxx ~]# semanage login -l
> >=20
> > Login Name                SELinux User              MLS/MCS Range      =
     =20
> >=20
> > __default__               user_u                    s0                 =
     =20
> > root                      root                      s0-s0:c0.c255      =
     =20
> > system_u                  system_u                  s0-s0:c0.c255      =
     =20
> > bob                      monetra_u                 s0                  =
    =20
> >=20
> > [root@xxx ~]# semanage user -l
> >=20
> >                 Labeling   MLS/       MLS/                         =20
> > SELinux User    Prefix     MCS Level  MCS Range                      SE=
Linux Roles
> >=20
> >=20
> > monetra_u       user       s0         s0                             mo=
netra_admin_r monetra_client_r
> > root            sysadm     s0         s0-s0:c0.c255                  sy=
sadm_r staff_r
> > staff_u         staff      s0         s0-s0:c0.c255                  sy=
sadm_r staff_r
> > sysadm_u        sysadm     s0         s0-s0:c0.c255                  sy=
sadm_r
> > system_u        user       s0         s0-s0:c0.c255                  sy=
stem_r
> > unconfined_u    unconfined s0         s0-s0:c0.c255                  un=
confined_r
> > user_u          user       s0         s0                             us=
er_r
> >=20
> > yet when I login I get:
> > [bob@xxx ~]$ id -Z
> > system_u:system_r:unconfined_t:s0-s0:c0.c255
> >=20
> >=20
> > thanx for any help you can give.
>=20
> First, by login, I assume you mean a real login (via console login, gdm,
> or ssh), not just a su.  su doesn't change SELinux context in RHEL 5.
correct.

>=20
> Second, have you authorized a domain transition from the domain in which
> the login process is running to your new domain?
can you give me a quick pointer as to where to go to find an example of
this? userdomain.te didn't help, nor locallogin.te. I need to both do it
from the console, and from ssh. And one other dumb question, what the
heck are prefixes, and how do they apply to this?=20




>=20
Command, n.: Statement presented by a human and accepted by a computer
in such a manner as to make the human feel as if he is in control.

--=-MPwLB1q3EAbIcLzlsA2p
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHrJvK6caZY8jbHDkRAhNjAKCcapmTmWPOM+eybUBDrBwf3t4NQwCeNhYt
3qYqYN0EyoiPbkYvyQ4GHfQ=
=rob1
-----END PGP SIGNATURE-----

--=-MPwLB1q3EAbIcLzlsA2p--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
