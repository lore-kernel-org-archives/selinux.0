Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAJB6Ii022590
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 14:11:07 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAJ9Rwg017290
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 19:09:28 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Fri, 10 Dec 2004 20:11:07 +0100
Date: Fri, 10 Dec 2004 20:11:07 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
Subject: Re: can_network patch.
Message-Id: <20041210191107.GA5059@jmh.mhn.de>
References: <41741A2C.8040408@redhat.com> <1102698638.1628.148.camel@moss-spartans.epoch.ncsc.mil> <41B9E48A.8010204@redhat.com> <200412110511.12960.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
In-Reply-To: <200412110511.12960.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Russell Coker <russell@coker.com.au> [2004-12-10 20:04]:
> On Saturday 11 December 2004 05:01, Daniel J Walsh <dwalsh@redhat.com> wr=
ote:
> > Stephen Smalley wrote:
> > >On Fri, 2004-12-10 at 12:06, Daniel J Walsh wrote:
> > >>When installing a package within firefox, it attemps to exec
> > >>system-config-packages which blows up because
> > >>*-mozilla-t can not run userhelper apps.
> > >
> > >Installing a package within firefox?  If you are talking about somethi=
ng
> > >firefox downloaded, then why does it use system-config-packages?  And I
> > >would expect that you would end up installing any such packages local =
to
> > >the user's home directory at most (and even then only if policy allows
> > >writing to it), not on a system-wide basis.
> >
> > You can trigger it by executing
> >  firefox selinux-policy-strict-1.19.12-1.src.rpm
>=20
> We have mozilla running in it's own domain to limit the risk of exploits =
of=20
> mozilla taking over the rest of the system.  Allowing mozilla to install=
=20
> packages seems to directly contradict this aim.
>=20
> Maybe we should just remove the mozilla policy?

Or add a boolean to control the transition from the userdomain to
mozilla. Then we can have a locked down policy for people who just want
to securely browse the web. People who want all the bells and whistles
can turn the transition off at the cost of higher exposure.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBufTLxWIrrrL0q+cRAtZjAKCoIHCW5ShFa4WOKEvvm8Ux0CTWoQCeKTd/
2tnVL5shjlr8fOsCu0l+NCk=
=PT6b
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
