Subject: Re: Re:
From: kayo <kayo@pyra.ca>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <200302172106.05892.russell@coker.com.au>
References: <1045508773.3e5132a538d6e@webmail.crazylinux.net>
	 <200302172106.05892.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-il9t3zMECZszevrGU0BW"
Message-Id: <1045513919.3407.13.camel@smeagol>
Mime-Version: 1.0
Date: 17 Feb 2003 14:31:59 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-il9t3zMECZszevrGU0BW
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

wow, so maybe we should try another cpu arch? i dont think it is
possible in the way we think now but could a group of gifted individuals
make it possible. let's even say the attacker had no physical access
think about it... nothing is impossible=20



On Mon, 2003-02-17 at 14:06, Russell Coker wrote:
> On Mon, 17 Feb 2003 20:06, dlambrou@crazylinux.net wrote:
> > Kayo you could use the CryptoAPI for linux.www.kerneli.org
> > I think is into 2.5 now as well.
>=20
> Yes.  Encrypted block devices on Linux means CryptoAPI.
>=20
> > With CryptoAPI though ,if we assume you use the hash of your
> > passphrase as the symmetric key, noone can guarantee that
> > a some sort of crypto attack will not reveal the plaindata.
> > It really depends for how long you data is valuable :-)
>=20
> There are some attacks on it.  One involves moving blocks if you get acce=
ss to=20
> the hard drive when the machine is off.  Also if you can determine the bl=
ock=20
> numbers for some files then you would have a good advantage (getting read=
=20
> access to the files lilo puts under /boot would help).
>=20
> > Russell said:
> > "Of course a trojan in a flash BIOS could still get past this, but it w=
ould
> > be a lot more difficult.  TCPA is supposed to address these issues (if =
you
> > trust TCPA).  Also the LinuxBIOS people are working on similar schemes =
but
> > their work in this regard was classified last time I checked their web
> > site. "
> >
> > Russell would you trust TCPA if the core root of trust for measurement
> > was Open Source ?
>=20
> To a certain extent.  However you have to consider that a modern CPU is m=
uch=20
> more complex than a complete computer system was 10 years ago.  A second =
CPU=20
> with some flash memory could fit inside a modern CPU module.  Flash memor=
y=20
> could be detected, but a CPU with a small amount of RAM and ROM might not=
 be. =20
> Do you trust Intel?
>=20
> OpenCores is an interesting project...

--=-il9t3zMECZszevrGU0BW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+UUa/+2nlubU9QZIRAj0pAJ4lrup8w41hsG42YH+SHN564BSiPACbBf/N
jhvIFJTASx9dEly1SE2v9LI=
=CI8p
-----END PGP SIGNATURE-----

--=-il9t3zMECZszevrGU0BW--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
