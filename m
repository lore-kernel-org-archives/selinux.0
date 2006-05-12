Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4CABuFI003057
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 06:11:56 -0400
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4CABt1i001511
	for <selinux@tycho.nsa.gov>; Fri, 12 May 2006 10:11:55 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 12 May 2006 12:11:53 +0200
Date: Fri, 12 May 2006 12:11:53 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Mario Fanelli <mario.fanelli@gmail.com>
Cc: SeLinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: Trouble with setexeccon/setcon
Message-Id: <20060512101152.GA7473@thorium.jmh.mhn.de>
References: <44643eb7.025ecbeb.7447.326d@mx.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <44643eb7.025ecbeb.7447.326d@mx.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Mario Fanelli <mario.fanelli@gmail.com> [2006-05-12 10:10]:
> Hello, my name is Mario and I have a trouble with selinux's api. My goal =
is
> to modify the suPhp apache module, but the function setcon and function
> setexeccon don't work.=20
>=20
> My apache process runs in dummy_t domain and suPhp file has a security
> context "user_u:object_r:dummy_exec_t"; in the policy file I write:
>=20
> "domain_trans(dummy_t,dummy_exec_t,dummy_change_context_t)"
>=20
> "domain_trans(dummy_t,dummy_exec_t,dummy_change1_context_t)"
>=20
> And before calling apr_create_process in mod_suphp, I use
> setexeccon("user_u:object_r:dummy_change_context_t") but the function ret=
urn
                     ^^^^^^^^
> always -1=20

You need user_r instead of object_r. I've never used this api so I can't
comment further, but at least you need to change this.

Thomas


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEZF9oD9qpeVMU938RAsrDAKCnqaYkaEBWowPYz1UV0/Ihnyzv7ACfQ63M
fcuLRgrA+nFyGsg2AsETZNQ=
=01Ea
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
