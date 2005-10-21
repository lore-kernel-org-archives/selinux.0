Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9L21RNs008656
	for <selinux@tycho.nsa.gov>; Thu, 20 Oct 2005 22:01:32 -0400 (EDT)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9L1wPN7016659
	for <selinux@tycho.nsa.gov>; Fri, 21 Oct 2005 01:58:26 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 21 Oct 2005 03:58:25 +0200
Date: Fri, 21 Oct 2005 03:58:20 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: SuSE packages updated
Message-Id: <20051021015820.GB9199@thorium.jmh.mhn.de>
References: <20051019223634.GC9176@thorium.jmh.mhn.de> <20051020032342.GA18453@vnl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
In-Reply-To: <20051020032342.GA18453@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Dale Amon <amon@vnl.com> [2005-10-20 05:35]:
> On Thu, Oct 20, 2005 at 12:36:34AM +0200, Thomas Bleher wrote:
> > For those interested in SELinux on SuSE: I have rebased the packages to
> > openSUSE 10.0 (they were previously based on one of the beta releases).
> > They are available from the usual place:
> > http://www.cip.ifi.lmu.de/~bleher/selinux/suse/rpm-10.0/
> >=20
> > The policy on my site is quite dated; if you want the policy I'm
> > currently working on, just send me a mail.
>=20
> Do your packages and policy work on the Novell or=20
> SuSE SLES 9?

I don't know since I have no access to these distributions.
But it shouldn't be too difficult to port them:
While SUSE does not officially support SELinux, at least they include
the patches in some of their packages. The only packages I had to patch
were coreutils, cron, openssh, pam, pam-modules and sysvinit; sometimes
it just meant recompiling with SELinux support, sometimes adapting the
patches from Fedora. Assuming the packages are similar, just take the
patches and apply them to SLES; rpmdiff is your friend :-).

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDWEs8D9qpeVMU938RAooRAJ4mZgAX49JikOEpTtEWYj0e1Gx6fgCfde/9
A9iXO/HoRcy8l2rcGL0goF8=
=3rf4
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
