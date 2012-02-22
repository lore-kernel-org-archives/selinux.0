Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1MJWS90029913
	for <selinux@tycho.nsa.gov>; Wed, 22 Feb 2012 14:32:28 -0500
Received: from f053034093.adsl.alicedsl.de ([78.53.34.93] helo=[192.168.178.43])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1S0HvS-0007vT-Bv
	for selinux@tycho.nsa.gov; Wed, 22 Feb 2012 19:32:30 +0000
Message-ID: <1329939142.3296.5.camel@mattotaupa>
Subject: No feedback when cloning `http://oss.tresys.com/git/selinux.git`
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: selinux@tycho.nsa.gov
Date: Wed, 22 Feb 2012 20:32:22 +0100
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-qDK0NGEBYfyfWGXwFN7j"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-qDK0NGEBYfyfWGXwFN7j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear SELinux folks,


trying to clone the SELinux user space programs [1] I issue


        $ git clone http://oss.tresys.com/git/selinux.git
        Cloning into 'selinux'...

but it just hangs there. So I thought it does not work. Letting it stay
for more than a minute it finished. Other Git repositories give some
kind of feedback. Are some hooks missing?


Thanks,

Paul


[1] http://userspace.selinuxproject.org/trac/wiki/Contributing

--=-qDK0NGEBYfyfWGXwFN7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk9FQsYACgkQPX1aK2wOHViMZgCfWar74jJODB0yJqHGGGpYG+Hf
HGgAniIRvHfMCvI6WKfsIQf/kBVMBtqF
=fuGF
-----END PGP SIGNATURE-----

--=-qDK0NGEBYfyfWGXwFN7j--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
