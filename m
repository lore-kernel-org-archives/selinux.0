Date: Thu, 30 Sep 2004 22:22:39 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Out of curiosity looking for suid apps without special context on FC3
Message-Id: <20040930202239.GA2546@jmh.mhn.de>
References: <415C4E36.3020303@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
In-Reply-To: <415C4E36.3020303@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Daniel J Walsh <dwalsh@redhat.com> [2004-09-30 22:08]:
> These are the files that do not have special context associated with=20
> them but are suid on FC3.=20
>=20
> /usr/lib/mc/cons.saver->system_u:object_r:lib_t

This program is used to save output of previous run programs when
Midnight Commander is run in text mode on the Linux console (you can
toggle to it with C-o)
Nice functionality but not really essential. On Debian and strict SuSE
config the file has mode 0755.
Even though I use mc a lot I hadn't noticed till now so a case can
probably be made to remove the suid bit.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBXGsOxWIrrrL0q+cRAq9CAJ9nnTLagnSMvoN9uGdUD4gz21stNwCgqxEw
kV/ctC2GdJmXMyPrNqaCcDk=
=Dgne
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
