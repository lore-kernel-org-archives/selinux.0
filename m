Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAMJKCIi007125
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 14:20:12 -0500 (EST)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAMJKAOX022517
	for <selinux@tycho.nsa.gov>; Mon, 22 Nov 2004 19:20:15 GMT
Subject: Re: idea: setfiles to exclude specific type
From: Colin Walters <walters@verbum.org>
To: Yuichi Nakamura <himainu-ynakam@miomio.jp>
Cc: sds@epoch.ncsc.mil, dwalsh@redhat.com, selinux@tycho.nsa.gov
In-Reply-To: <200411221554.iAMFsPDM027086@mms-r01.iijmio.jp>
References: <200411221554.iAMFsPDM027086@mms-r01.iijmio.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EAayiOeJ+N5ZxERo5h5d"
Date: Mon, 22 Nov 2004 14:20:01 -0500
Message-Id: <1101151201.28164.28.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-EAayiOeJ+N5ZxERo5h5d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-11-22 at 10:54 -0500, Yuichi Nakamura wrote:
> Hello.
>=20
> I add setfiles "-x" option.
> I attach my idea in "setfiles.diff".
>=20
> -x option is used to exclude specified type.
>=20
> For example,
> # setfiles file_contexts /home -x httpd_user_rw_t
> setfiles skips relabeling files that have "httpd_user_rw_t".

I thought the conclusion from previous discussion on user-customizable
file contexts was that we were going to add notation to file_contexts
for groups of contexts, so that all of e.g.
system_u:object_r:httpd_sys_content_t,
system_u:object_r:httpd_sys_script_exec_t,=20
system_u:object_r:httpd_sys_script_rw_t,
etc. would be acceptable. =20

For example:

/var/www(/.*)?			system_u:object_r:httpd_sys_content_t system_u:object_r:ht=
tpd_sys_script_rw_t system_u:object_r:httpd_sys_script_exec_t ...



--=-EAayiOeJ+N5ZxERo5h5d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBojvhOIkJWWp2WGURAhYyAJ4xDns+JlNF+foTFWhipSN5hHjXJgCfe7MP
X8+iM8343sOEZoq4kiqAkSI=
=NysY
-----END PGP SIGNATURE-----

--=-EAayiOeJ+N5ZxERo5h5d--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
