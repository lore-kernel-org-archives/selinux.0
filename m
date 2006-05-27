Date: Sat, 27 May 2006 19:57:49 +0300
From: Petre Rodan <kaiowas@gentoo.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov, Chris PeBenito <cpebenito@tresys.com>
Subject: Re: nepenthes policy
Message-ID: <20060527165749.GE6721@peter.sunspire.org>
References: <20060526170318.GA10733@peter.sunspire.org> <200605272136.43846.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
In-Reply-To: <200605272136.43846.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Russell,

On Sat, May 27, 2006 at 10:36:39PM +1000, Russell Coker wrote:
> > "Nepenthes is a low interaction honeypot like honeyd or mwcollect.
> > Low Interaction Honeypots emulate known vulnerabilities to collect
> > information about potential attacks. Nepenthes is designed to emulate
> > vulnerabilties worms use to spread, and to capture these worms."
> >                                              http://nepenthes.sf.net
>=20
> Why not use honeypot_t?
>=20
> Having one set of policy for all honeypot programs should work reasonably=
=20
> well.
>  When we get the MCS changes as recently discussed merged it will be=20
> possible to isolate multiple instances of a single honeypot program (or=
=20
> multiple programs that perform the honeypot function) by categories.

I almost agree with your idea, but I think it be wiser to wait for another =
honeypot policy and decide at that point if it makes sense merging them int=
o honeypot_t. for the time being I do not see another honeypot-related poli=
cy in cvs. specialized honeypots (ie spam traps) would need far less privil=
eges then what we have now for nepenthes.

cheers,
peter

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)

iD8DBQFEeIUNGSBEIeh4AEYRAls8AJ44+ysmtFSc3Zm0V8Oj8S5zRsvf4gCeJgm1
PXfPpNi/ykPbjyXpHFkqvtc=
=NJvx
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
