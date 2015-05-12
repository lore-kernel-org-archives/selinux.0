Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4CG0u2g015871
 for <selinux@tycho.nsa.gov>; Tue, 12 May 2015 12:00:57 -0400
Received: by widdi4 with SMTP id di4so160623514wid.0
 for <selinux@tycho.nsa.gov>; Tue, 12 May 2015 09:00:38 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id mv11sm3504102wic.23.2015.05.12.09.00.36
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 May 2015 09:00:37 -0700 (PDT)
Date: Tue, 12 May 2015 18:00:35 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux talk
Message-ID: <20150512160033.GB9693@x131e>
References: <CAEcA1_vvm7TEkrULWOxbC=BtuCyn+Tm0DMXLE3ScZe24Lktpjw@mail.gmail.com>
 <20150512151201.GA9693@x131e>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
In-Reply-To: <20150512151201.GA9693@x131e>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2015 at 05:12:01PM +0200, Dominick Grift wrote:
> Here is one i somehow find compelling:
>=20
> Centralized governed (MAC) versus De-centralized goverened (DAC) security
>=20
> Back in the days of 1997 the privilege of computer environments was prett=
y much limited to academic use.
>=20
> I think there was an filosophy of trust. Were all academics we know what =
we do and we're all good (we dont make mistakes)
>=20
> (Some still believe in that)
>=20
> To others, things changed since then.
>=20
> Computer environments are no longer limited to academics and everyone and=
 their mother are now wielding a computer with a 100 mbit+ uplink to the re=
st of the connected world.
>=20
> Also we're now pretty much all connected. That means that we can in theor=
y now all affect eachothers=B4 experience.
>=20
> For example some could in theory send your site into a black hole by pack=
eting it to death.
> (some user with access to your system may decide to use your assets to ru=
in the fun for someone else on the network by udp flooding or whatever)=20
>=20
> Also these days the stakes are much higher in general (some businesses de=
pend for their lively hood on computer environment)
>=20
> Those three changes are basically a pretty compelling reason to calibrate=
 the security model to the new requirements and threats.
>=20
> SELinux and MAC in general, allows the owner of a computer system or envi=
ronment to take control back into his own hands by overriding traditional D=
AC
>=20
> SELinux enables one to not necessarily trust individual processes and/or =
users on a system. It allows owners to enforce what
> indidivual processes and users can do thereby enforcing integrity
>=20
> Some other advantages of SELinux over other MAC systems are that SELinux =
is customizable, flexible and allows for finer-grained access control.
>=20

After this i will stop my ramble :)

Basically i would argue that DAC =3D=3D trust, versus MAC =3D=3D trust but =
verify

Also the above explanation focusses a bit too much on malicious intent.

But consider for example: now a lot of people write code that runs on other=
s systems. (consider php and your average php dev, or people like myself LO=
L)

So these people aren't necessarily malicious but instead maybe not as compe=
tent. You may end up with a buggy program that affects the functionality of=
 the remainder of the system or even the network.

By enforcing what the process can do exactly one can ensure a higher level =
of integrity.

The SELinux type enforcement security model is used to enforce integrity
The SElinux identity based access control security model is used by SELinux=
 to complement traditional DAC

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVUiOdAAoJENAR6kfG5xmcFRsL/1PtbcDt+tXqIHozKrvtGaSu
DKwYNKDwYrnKZUD3KnaNf82EKkM1+TZd+Kh3u7QpWv5R48dhDxR8qGuL1yfb1taG
zozFhDGnOlO0J23mpWHmX6XdagDYTsa0P4zKSCSf7AnS1+d4RwTQXipjHTztC0h8
CROoMjAULbyB0aeP9B0C0Br1QtxaLDKEAj+QvTssTqqVwHeYirKXJJdR16tedY37
f7kW0GddbxirwLhlvkkK5Gh2kl5v50dHICEpOsTqZKiWqL8wXRw/DFYmdkZBfEQG
/c3oMOAt5UcbWt8UyWgExVQwGGKCAVbCvi7A4Z8WBDOvEn94/18CjVqToG+EHZLX
71PaoSTXyeD1BaXmxuxCtbK9sgBSgldzwnNLLeytWr7GNsaePmtfM6KEmyk71SLc
5RAr0czQLh7nJhzqmEqrv1Lw1TIzorU80s3jrXYU1vgAEwOZlXEmoBBzLgVmZuvG
WapK9kNl6tZH3jAMRUT7SmIsQuaXbU+1KRf9DlHs/w==
=+CpO
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
