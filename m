Message-ID: <4B4CD3AB.9060507@gmail.com>
Date: Tue, 12 Jan 2010 20:55:23 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Hasan Rezaul-CHR010 <CHR010@motorola.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: SELinux questions...
References: <822A6B57FFD31647BB62F4676394C675033C6473@XMBTX131.northgrum.com> <1262873714.2821.1.camel@moss-pluto.epoch.ncsc.mil> <822A6B57FFD31647BB62F4676394C67503415902@XMBTX131.northgrum.com> <1263237846.5091.10.camel@moss-pluto.epoch.ncsc.mil> <D06FE0A2807BC145B0D38744789D4F5D07F0AA3D@de01exm68.ds.mot.com>
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D07F0AA3D@de01exm68.ds.mot.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig134C321C822CC19C2BB19E52"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig134C321C822CC19C2BB19E52
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/12/2010 08:37 PM, Hasan Rezaul-CHR010 wrote:
> Hi All,
>=20
> I have a few questions that I had asked in the past, so I apologize in
> advance for the repetition. I had a hard-drive crash recently and lost
> all my old emails  :-(
>=20
> 1. What was the SEMANAGE syntax to add selinux user mappings for a GROU=
P
> as opposed to creating selinux mappings to a specific Linux user ?

from man semanage:
$ semanage login -a -s user_u %clerks


> 2. What was the link to the "SELinux User Guide" document that a few
> people have been putting together ?

http://docs.fedoraproject.org/selinux-user-guide/f12/en-US/

> 3. Other than the document above, is there any other useful documents
> out there that describe the design details and framework for the latest=

> Refpolicy?

http://www.selinuxbyexample.com
http://selinuxproject.org
http://oss.tresys.com
http://docs.fedoraproject.org/selinux-managing-confined-services-guide/en=
-US/F11/html/
http://www.nsa.gov/research/selinux

> Thanks as always for your help...
>=20
>=20
> --
> This message was distributed to subscribers of the selinux mailing list=
=2E
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.go=
v with
> the words "unsubscribe selinux" without quotes as the message.



--------------enig134C321C822CC19C2BB19E52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAktM078ACgkQMlxVo39jgT81JACfcFnM268sckujeyCrc0205ynz
u2EAni2QCmYX+P3iQ11AgrRh7q6rLyPC
=qyt/
-----END PGP SIGNATURE-----

--------------enig134C321C822CC19C2BB19E52--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
