Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5TGvfL7021945
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2011 12:57:41 -0400
Received: from mail.gw90.de (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5TGvdSt004471
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2011 16:57:40 GMT
Received: from f053043156.adsl.alicedsl.de ([78.53.43.156] helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1Qby57-0000Ig-TP
	for selinux@tycho.nsa.gov; Wed, 29 Jun 2011 16:57:42 +0000
Subject: htpasswd file outside of standard Apache location
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-DI9e6JAt03iImxm9MMD7"
Date: Wed, 29 Jun 2011 18:57:37 +0200
Message-ID: <1309366657.4648.40.camel@mattotaupa>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-DI9e6JAt03iImxm9MMD7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear SELinux folks,


I am running Debian Squeeze with SELinux and Apache.

In Apache I configured a secured section using `AuthType Basic` with
`AuthUserFile /srv/site.htpasswd`. It works when the state of the system
is permissive. When in enforcing state the following error is logged.

        type=3DAVC msg=3Daudit(1308090063.174:17742): avc:  denied  { getat=
tr } for  pid=3D1412 comm=3D"apache2" path=3D"/srv/www/www.example.net/foo/=
bar.tar.gz" dev=3Dxvda ino=3D425775 scontext=3Dunconfined_u:system_r:httpd_=
t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:object_r:user_home_t:s0 tclass=3Df=
ile
        type=3DSYSCALL msg=3Daudit(1308090063.174:17742): arch=3Dc000003e s=
yscall=3D6 success=3Dno exit=3D-13 a0=3D7f9da985eb38 a1=3D7fff8da1e6f0 a2=
=3D7fff8da1e6f0 a3=3D1 items=3D0 ppid=3D29237 pid=3D1412 auid=3D4294967295 =
uid=3D33 gid=3D33 euid=3D33 suid=3D33 fsuid=3D33 egid=3D33 sgid=3D33 fsgid=
=3D33 tty=3D(none) ses=3D4294967295 comm=3D"apache2" exe=3D"/usr/lib/apache=
2/mpm-prefork/apache2" subj=3Dunconfined_u:system_r:httpd_t:s0-s0:c0.c1023 =
key=3D(null)

Is there a recommended location for these password files or a
recommended way what policies to set. Not being sure of the correct
search term for this I found plenty of sites regarding SELinux and
Apache but nothing related to my problem in the results. If you could
point me to some specific documentation that would be great too.


Thanks,

Paul

--=-DI9e6JAt03iImxm9MMD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4LWYEACgkQPX1aK2wOHVgs1ACeNt5vX8h0ujU1i143HBppafPR
ijEAni4Mmuk0UGN267vuAjfj33fsqZCb
=JJqe
-----END PGP SIGNATURE-----

--=-DI9e6JAt03iImxm9MMD7--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
