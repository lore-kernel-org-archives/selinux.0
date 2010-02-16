Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o1GIqUbY011540
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 13:52:30 -0500
Received: from qw-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o1GIqGvF008680
	for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 18:52:16 GMT
Received: by qw-out-1920.google.com with SMTP id 14so662822qwa.30
        for <selinux@tycho.nsa.gov>; Tue, 16 Feb 2010 10:52:29 -0800 (PST)
Message-ID: <4B7AE961.7040907@gmail.com>
Date: Tue, 16 Feb 2010 19:52:17 +0100
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Alan Rouse <alan.rouse@ericsson.com>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: SELinux Policy in OpenSUSE 11.2
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se> <4B7AB835.5080008@gmail.com> <5A5E55DF96F73844AF7DFB0F48721F0F529A558718@EUSAACMS0703.eamcs.ericsson.se>
In-Reply-To: <5A5E55DF96F73844AF7DFB0F48721F0F529A558718@EUSAACMS0703.eamcs.ericsson.se>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig41E6176AAA703D3666AA0408"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41E6176AAA703D3666AA0408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/16/2010 07:04 PM, Alan Rouse wrote:
> Dominick, thanks for the reply.   These AVC messages occur during norma=
l bootup (not from a command line), so it is the boot process which is st=
arting these in the wrong context. =20
>=20
> OpenSuSE 11.2 is still using System V init startup, but Fedora 12 is us=
ing upstart.  Perhaps that explains why the recent refpolicy is not start=
ing OpenSuse processes in the right context.  Is the current refpolicy kn=
own to work in System V init -based systems?

Maybe this is related:

http://www.nsa.gov/research/selinux/list-archive/0807/26979.shtml


--------------enig41E6176AAA703D3666AA0408
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt66WgACgkQMlxVo39jgT/tQACgxX5c3XSfcPc7WYD57wkin8cW
HdUAoMcSEQRb0jFMsCr6ma2hmHcuypZB
=+f7l
-----END PGP SIGNATURE-----

--------------enig41E6176AAA703D3666AA0408--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
