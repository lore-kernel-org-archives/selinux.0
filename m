Date: Sun, 28 May 2006 23:25:52 +0300
From: Petre Rodan <kaiowas@gentoo.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov, Chris PeBenito <cpebenito@tresys.com>
Subject: Re: nepenthes policy
Message-ID: <20060528202552.GA13472@peter.sunspire.org>
References: <20060526170318.GA10733@peter.sunspire.org> <200605272136.43846.russell@coker.com.au> <20060527165749.GE6721@peter.sunspire.org> <200605280907.40813.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
In-Reply-To: <200605280907.40813.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Russell,

On Sun, May 28, 2006 at 10:07:36AM +1000, Russell Coker wrote:
> Honeyd is almost synonymous with the term honeypot, it would be best=20
> to have a policy that supports nepenthes and honeyd and then for every ne=
w=20
> honeypot a decision would be made as to whether it should run in the same=
=20
> domain or a different one.
>=20
> Why do you think that another honeypot policy won't be written?  Surely i=
t's=20
> inevitable that the most popular program which provides this service (hon=
eyd)=20
> will get policy support.

I said that a comparable policy is not on the horizon just yet, so I'm not =
sure it's a good thing to assume that future policies will look like what w=
e have for nepenthes now. I'll have a look at honeyd maybe I can come up wi=
th a generic policy that would support both.

thanks for the feedback.

cheers,
peter

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)

iD8DBQFEegdQGSBEIeh4AEYRAtxHAJ9CVR62SaUfcHBw+eGY6dJs5ESOKQCfaObA
oYDdEkaxnnBt/oHQastPs14=
=zIiz
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
