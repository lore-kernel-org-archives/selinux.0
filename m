Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4NLMVRb006900
	for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 17:22:32 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4NLMTAR012221
	for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 21:22:29 GMT
Received: from mailrelay2.lrz-muenchen.de (mailrelay2.lrz-muenchen.de [129.187.254.102])
        by jazzband.ncsc.mil  with ESMTP id i4NLMSHn012218 for <selinux@tycho.nsa.gov>; Sun, 23 May 2004 21:22:28 GMT
Received: from cobalt.jmh.mhn.de ([192.168.99.1] [192.168.99.1]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sun, 23 May 2004 23:22:27 +0200
Date: Sun, 23 May 2004 23:22:12 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: policy for suse
Message-Id: <20040523212212.GA6147@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Per request from Ed Street, I have made my SuSE policy available.
You can find it in my arch-archive tbleher@gmx.de--selinux,
branch policy--suse--0.
Most changes are either in suse.te or enclosed in ifdef(`suse.te', `')
for now so that it is clear which policy was modified.

Please note that this is not yet in a mergable form, but is published so
that others can use and improve it. I will post the different changes as
separate patches to the list.

Short instructions on fetching the policy:
$ tla register-archive http://www.cip.ifi.lmu.de/~bleher/arch/selinux/
$ tla get tbleher@gmx.de--selinux/policy--suse--0

To update (ala cvs up):
$ tla replay

See your local changes:
$ tla changes --diffs

See changes between fedora and suse-policy:
$ tla changes --diffs tbleher@gmx.de--selinux/policy--fedora--0

Patches welcome!

Thomas

PS:
For more infos on Arch, see http://wiki.gnuarch.org/

Browsable version of the policy:
http://www.cip.ifi.lmu.de/~bleher/cgi-bin/archzoom.cgi/tbleher%40gmx.de--se=
linux/policy--suse--0

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAsRYExWIrrrL0q+cRAgFZAJ4+g+yJJfYb7gt78cybagfh0q3smACaArXi
M3VDahEmyWG59o7/q8CFbag=
=FHjK
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
