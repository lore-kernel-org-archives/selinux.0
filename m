Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9IL8nrT025288
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 17:08:49 -0400 (EDT)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9IL7YYb000596
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 21:07:35 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Mon, 18 Oct 2004 23:08:47 +0200
Date: Mon, 18 Oct 2004 23:09:23 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Erich Schubert <erich@debian.org>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: kernel oops
Message-Id: <20041018210923.GC2536@jmh.mhn.de>
References: <20041017120245.GB2537@jmh.mhn.de> <1098017948.28183.18.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
In-Reply-To: <1098017948.28183.18.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Erich,

* Erich Schubert <erich@debian.org> [2004-10-17 17:47]:
> > happened on a system with loaded nvidia binary driver. Nevertheless,
>=20
> > Call Trace:
=20
> >  [<c0108899>] handle_IRQ_event+0x49/0x80
> >  [<c0108cfa>] do_IRQ+0xea/0x1a0
> >  [<c0106d48>] common_interrupt+0x18/0x20
> >  [<c0277f92>] __copy_from_user_ll+0x42/0x80
>=20
> Does it happen frequently? If so, try without preempt enabled.

No, it only happened once so far, of at least one hundred policy reloads
on systems with loaded nvidia driver. So it is not a very big issue for
me; I wanted to post it so people know about it.
I am very happy with the stability of my SELinux systems. :-)

> P.S. we should to exchange GPG keys

Good idea. I'll mail you separately about this.

Thanks,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBdDEDxWIrrrL0q+cRAvPiAKDD68+pIAVN4gNfLtlCHoT+Gn0umACfdl8b
kC/bITm7569OHaZ7yBie48Q=
=Ar3N
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
