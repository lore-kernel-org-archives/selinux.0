Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9HBDDrT015949
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 07:13:13 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9HBDC8B027435
	for <selinux@tycho.nsa.gov>; Sun, 17 Oct 2004 11:13:12 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sun, 17 Oct 2004 13:13:10 +0200
Date: Sun, 17 Oct 2004 13:13:46 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: petre rodan <kaiowas@gentoo.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: gentoo merge for postfix
Message-Id: <20041017111346.GA2537@jmh.mhn.de>
References: <417149C9.9010102@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
In-Reply-To: <417149C9.9010102@gentoo.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* petre rodan <kaiowas@gentoo.org> [2004-10-17 00:55]:
> can you please ifdef 'rhgb_domain(postfix_master_t)' since it's not part =
of=20
> some distros?

I disagree. rhgb_domain() is a no-op if you don't use rhgb.te. Using
additional ifdefs just makes the policy harder to read.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBclPqxWIrrrL0q+cRAkOEAKC3SYtomjEHfTzV2kz9xWSspxLuOwCfWIS4
0Hix+niOaTg4TLOsCTRfhgA=
=ulVy
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
