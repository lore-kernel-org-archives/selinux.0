Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i74D3KrT027955
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 09:03:20 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i74D3Jap016712
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 13:03:19 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i74D3Je1015684
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 09:03:20 -0400
Subject: Re: [patch] fix /var/run/console bits
From: Colin Walters <walters@redhat.com>
To: rcoker@redhat.com
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <200408042007.03512.rcoker@redhat.com>
References: <1091584911.8312.7.camel@nexus.verbum.private>
	 <200408042007.03512.rcoker@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IBqT0wxcBUgQm0y2Tbb/"
Date: Wed, 04 Aug 2004 09:03:35 -0400
Message-Id: <1091624615.9005.6.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-IBqT0wxcBUgQm0y2Tbb/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-08-04 at 20:07 +1000, Russell Coker wrote:
> On Wed, 4 Aug 2004 12:01, Colin Walters <walters@redhat.com> wrote:
> > Currently /var/run/console is labeled as xdm_var_run_t, which is totall=
y
> > wrong, since it's actually owned by pam_console.  I noticed this while =
I
> > was trying to work on the D-BUS policy, which recently gained console
> > user authentication.
> >
> > Attached is a patch which creates a new type for it, grants the
> > requisite permissions to login and xdm.  I still think we need a nicer
> > way of mapping the PAM permissions in policy.  The only reason that
> > login and xdm are granted these permissions is because they happen to
> > ship with pam_console in their PAM stack on Fedora, presumably.  (IIRC
> > Debian doesn't use pam_console).
>=20
> I think that perhaps the following would be good for the fc entry to keep=
 the=20
> convention:
> /var/run/console/(.*)?                     system_u:object_r:pam_var_cons=
ole_t

Sounds good.

> This is not what we want.  Ideally we will never have any files of type=20
> var_run_t.
> rw_dir_create_file(xdm_t, var_run_t)
> rw_dir_create_file($1_login_t, var_run_t)

I agree, but unfortunately pam_console creates a lockfile
named /var/run/console.lock.  We should probably fix that.

> I guess that the following code is to allow the xdm to check which login=20
> processes are active when searching for an unused virtual console. =20

Ok.  I just thought it was weird at first glance, and worthy of a
comment :)


--=-IBqT0wxcBUgQm0y2Tbb/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBEN6mOIkJWWp2WGURAiTpAJ9YynLgYMPNv/GFYD5AFlHQe5UbcACbB96Z
yXpz0V6geQrt2CDGDqM1B/c=
=V16t
-----END PGP SIGNATURE-----

--=-IBqT0wxcBUgQm0y2Tbb/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
