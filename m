Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j298pjDo022559
	for <selinux@tycho.nsa.gov>; Wed, 9 Mar 2005 03:51:45 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j298ksev025532
	for <selinux@tycho.nsa.gov>; Wed, 9 Mar 2005 08:46:54 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 9 Mar 2005 09:46:55 +0100
Date: Wed, 9 Mar 2005 09:46:56 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Kodungallur Varma <ramgwu@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: problems using setcon()
Message-Id: <20050309084655.GC5236@thorium.jmh.mhn.de>
References: <fa8ec5d80503082008161e5619@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
In-Reply-To: <fa8ec5d80503082008161e5619@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Kodungallur Varma <ramgwu@gmail.com> [2005-03-09 05:33]:
> Hi all,
>=20
>  I am trying to dynamically change the context of my program by
> using the setcon() function. I have a simple program that tries to do
> that but the setcon() function always returns -1 for the input in the
> program.
>=20
> #include <stdio.h>
> #include <selinux/selinux.h>
>=20
> int main()
> {
>    int i;
>    char str[100];
>    strcpy(str,"system_u:object_r:libselinux_test_t");
                 ^^^^^^^^^^^^^^^^^
Your Problem is here. object_r cannot be used for any domains. Further,
you can't change users (from user_u to system_u) unless you are
specifically authorized.
If you use "user_u:user_r:libselinux_test_t" you should be able to get
it to work (you'll need some additional permissions as dyntransition is
not covered by domain_auto_trans())

HTH,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCLrf/D9qpeVMU938RAp16AJ9RJHCZRudYS2UUWA8e2/3GMtbzqgCgog05
WvZQMFgJSfnzewmafSchbMw=
=Erta
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
