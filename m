Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6OJ7xrT017770
	for <selinux@tycho.nsa.gov>; Sat, 24 Jul 2004 15:07:59 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6OJ7u3o021320
	for <selinux@tycho.nsa.gov>; Sat, 24 Jul 2004 19:07:57 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 24 Jul 2004 21:07:56 +0200
Date: Sat, 24 Jul 2004 21:08:11 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Cc: russell@coker.com.au, krahmer@suse.com
Subject: Re: file_contexts patch
Message-Id: <20040724190811.GC2016@jmh.mhn.de>
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <200407181258.37018.russell@coker.com.au> <20040718150357.GA322@rom.cip.ifi.lmu.de> <200407190959.48713.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
In-Reply-To: <200407190959.48713.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Russell Coker <russell@coker.com.au> [2004-07-19 03:25]:
> On Mon, 19 Jul 2004 01:03, Thomas Bleher <bleher@informatik.uni-muenchen.=
de>=20
> wrote:
> > > unix_chkpwd has been around for years, I can't believe that it's
> > > something that they haven't got to it yet.
> >
> > unix_chkpwd is included in the PAM package, it's just that suse has
> > developed their own pam module (pam_unix2.so) which doesn't use
> > unix_chkpwd AFAIK.
>=20
> Why can't you just use pam_unix.so instead?

At the time I installed SELinux on the computers here my primary focus
was to get a working system without breaking too much so I didn't want
to muck around with pam config if possible.

After this mail exchange I looked at the code again. And indeed, the
patch Russell mentioned earlier (to make pam_unix use unix_chkpwd if it
can't access /etc/shadow) was missing. After adding this patch, pam now
runs fine without every login program needing the auth attribute.

So, for everyone who uses my packages, please update to the latest pam,
which you can get from my site. After that, replace every occurrence of
pam_unix.so or pam_unix2.so under /etc/pam.d with pam_unix_auth.so,
pam_unix_acct.so, pam_unix_passwd.so or pam_unix_session.so,
respectively.

Thomas

PS: Thanks to Russell for nudging me to this.

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBArObxWIrrrL0q+cRAosBAJ4p0ETAz++oB6EhWGAdBPuPfkMgXQCeL+i9
F1CrX7GATmJ/cvWseV8KCTM=
=Pm1i
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
