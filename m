Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4CKiaXu001837
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 16:44:36 -0400
Received: from mail-ww0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o4CKjllx015735
	for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 20:45:47 GMT
Received: by wwb39 with SMTP id 39so370101wwb.12
        for <selinux@tycho.nsa.gov>; Wed, 12 May 2010 13:44:34 -0700 (PDT)
Message-ID: <4BEB132F.4040002@gmail.com>
Date: Wed, 12 May 2010 22:44:31 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Restorecond and .xsession-errors
References: <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBDC84@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F52E5DBDC84@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3A3E7B555FD8A02A10C3F391"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A3E7B555FD8A02A10C3F391
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 05/12/2010 09:10 PM, Alan Rouse wrote:
> I'm down to one AVC left booting to a desktop in OpenSUSE 11.3 mileston=
e 6.
>=20
> type=3DAVC msg=3Daudit(127369094.093:8): avc: denied { relabelfrom } fo=
r pid=3D3089 comm=3D"restorecond" name=3D".xsession-errors" dev=3Dsda3 in=
o=3D127759 scontext=3Duser_u:user_r:user_t:s0 tcontext=3Dsystem_u:object_=
r:xauth_home_t:s0 tclass=3Dfile
>=20
> It looks to me like somewhere late in the boot, a windowing error occur=
s and it attempts to log it to .xsession-errors.  For some reason at that=
 point in time it attempts to relabel that file and is denied.
>=20
> The file context on .xsession-errors in the unprivileged user's home di=
rectory is user_u:object_r:user_home_t:s0
>=20
> However, when I run audit2allow on that avc, it says "This avc is a con=
straint violation.  You will need to add an attribute to either the sourc=
e or target type to make it work."
>=20
> Should I relabel .xsession-errors?  If so, to what?
>=20
>=20

Here in Fedora that file is xdm_home_t but nonetheless both should have
the user_home_type attribute and $1_usertype (attribute for user
domains) should be able to relabelto and relabelfrom user_home_types.

In other words the user should be able to relabel the file.

However, since the audit2allow say's that it is a constraint violation,
i am guessing that UBAC is enabled.

That would mean the the user_u SELinux identity cannot interact with the
system_u SELinux identity of the files label.

In that case, either deal with UBAC or disable UBAC.


--------------enig3A3E7B555FD8A02A10C3F391
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvrEy8ACgkQMlxVo39jgT9F1QCeLleK24RvkrEYfrC3cI947Qpm
ndgAn0U946kqBpIfIgPbebKu2e2CELR+
=TR5H
-----END PGP SIGNATURE-----

--------------enig3A3E7B555FD8A02A10C3F391--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
