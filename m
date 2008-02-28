Subject: Re: [PATCH -v2] SELinux: create new open permission
From: James Antill <james.antill@redhat.com>
To: Eric Paris <eparis@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        selinux <selinux@tycho.nsa.gov>, sds@tycho.nsa.gov, jmorris@namei.org,
        Paul Moore <paul.moore@hp.com>
In-Reply-To: <1204225233.3206.120.camel@localhost.localdomain>
References: <1204221520.3206.86.camel@localhost.localdomain>
	 <1204224606.32061.218.camel@gorn>
	 <1204225233.3206.120.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wBqKAuxA/A+0VbxnGBR0"
Date: Thu, 28 Feb 2008 15:32:08 -0500
Message-Id: <1204230728.11268.261.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-wBqKAuxA/A+0VbxnGBR0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Thu, 2008-02-28 at 14:00 -0500, Eric Paris wrote:
> On Thu, 2008-02-28 at 13:50 -0500, Christopher J. PeBenito wrote:
> > On Thu, 2008-02-28 at 12:58 -0500, Eric Paris wrote:
> > > Adds a new open permission inside SELinux when 'opening' a file.  The
> > > idea is that opening a file and reading/writing to that file are not =
the
> > > same thing.  Its different if a program had its stdout redirected
> > > to /tmp/output than if the program tried to directly open /tmp/output=
.
> > > This should allow policy writers to more liberally give read/write
> > > permissions across the policy while still blocking many design and
> > > programing flaws SELinux is so good at catching today.
> > >=20
> > > Signed-off-by: Eric Paris <eparis@redhat.com>
> > >=20
> >=20
> > What does open on a dir mean?  Isn't that the same as the read perm?
>=20
> Admittedly there is very little distinction and I don't know the
> usefulness, but it is possible for a process to pass an open fd to a
> directory so I saw little reason to exclude it.

 Also we have the *at() and fchdir() calls, so this distinction (between
open and read on dirs) is useful.

--=20
James Antill <james.antill@redhat.com>
Red Hat

--=-wBqKAuxA/A+0VbxnGBR0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHxxpI11eXTEMrxtQRAuw3AKCbiSis4RgFEAUt8piKj/5NaVjqPQCgsaoT
/uXY93uK9ru5IYhU/rtEbLI=
=XLXQ
-----END PGP SIGNATURE-----

--=-wBqKAuxA/A+0VbxnGBR0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
