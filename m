Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j21FFaDo001821
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2005 10:15:37 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j21F9ft4000115
	for <selinux@tycho.nsa.gov>; Tue, 1 Mar 2005 15:09:41 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 1 Mar 2005 16:12:05 +0100
Date: Tue, 1 Mar 2005 16:12:07 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
Subject: Re: Proposed policy feature: $1_domain attribute
Message-Id: <20050301151205.GC5243@thorium.jmh.mhn.de>
References: <1109685518.764.9.camel@cobra.ivg2.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
In-Reply-To: <1109685518.764.9.camel@cobra.ivg2.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Ivan Gyurdiev <ivg2@cornell.edu> [2005-03-01 15:30]:
> I'd like to mark all role-dependent domains with a new attribute
> $1_domain (analogous to $1_file_type), and then do the following in
> base_user_macros.te:
>=20
> can_ps($1, $1_domain)
> can_ptrace($1, $1_domain)
>=20
> Objections?

Yes. can_ps() might be OK, but can_ptrace() is too much. With ptrace,
users have complete control over derived domains. I do not think we want
that. An example: I'd like to have a version of gpg without
--export-secret-keys. Together with SELinux it then becomes very hard to
steal the secret key, even from a compromised program in user_t. Your
change would compromise this.
I'd be more OK with
 can_ps($1_t, $1_domain)
 allow $1_t $1_domain:process signal;
because the signal permission is very inconsistently used right now and
is sometimes needed to kill misbehaving programs.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCJIZFD9qpeVMU938RAuNnAJ9q+7+s6U/TF/Cg1zVARh9ITww1EACgi5Ht
3dmTknSjNGyJBmbPK7G6TLc=
=H8KJ
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
