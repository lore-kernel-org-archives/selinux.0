Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9ODGVrb013170
 for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2016 09:16:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so9766629wma.2
 for <selinux@tycho.nsa.gov>; Mon, 24 Oct 2016 06:16:27 -0700 (PDT)
Received: from [192.168.1.21] (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id wn5sm19255654wjb.42.2016.10.24.06.16.25
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Oct 2016 06:16:26 -0700 (PDT)
Subject: Re: [RFC] Split up policycoreutils
To: selinux@tycho.nsa.gov
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <c9ef14f5-1062-21a5-e5ef-d6746a1868d8@ieee.org>
 <db994f8e-27d9-7554-56f5-beb217274d1b@tycho.nsa.gov>
From: Dominick Grift <dac.override@gmail.com>
Message-ID: <218ba91e-3c97-6896-9c0b-a214b9a047a1@gmail.com>
Date: Mon, 24 Oct 2016 15:16:16 +0200
MIME-Version: 1.0
In-Reply-To: <db994f8e-27d9-7554-56f5-beb217274d1b@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MG8TrfSN5AMUV3isMWOK6ML7vcRkFJhLF"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MG8TrfSN5AMUV3isMWOK6ML7vcRkFJhLF
Content-Type: multipart/mixed; boundary="kfUWTVaqSvSNxB0JlM8dHhsFo9flEKvH0";
 protected-headers="v1"
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <218ba91e-3c97-6896-9c0b-a214b9a047a1@gmail.com>
Subject: Re: [RFC] Split up policycoreutils
References: <4633f93f-9a5e-65e8-12d6-f11160be316f@tycho.nsa.gov>
 <c9ef14f5-1062-21a5-e5ef-d6746a1868d8@ieee.org>
 <db994f8e-27d9-7554-56f5-beb217274d1b@tycho.nsa.gov>
In-Reply-To: <db994f8e-27d9-7554-56f5-beb217274d1b@tycho.nsa.gov>

--kfUWTVaqSvSNxB0JlM8dHhsFo9flEKvH0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/24/2016 03:13 PM, Stephen Smalley wrote:
> On 10/22/2016 09:44 AM, Chris PeBenito wrote:
>> On 10/21/16 13:47, Stephen Smalley wrote:
>>> policycoreutils started life as a small set of utilities that were
>>> necessary or at least widely used in production on a SELinux system.
>>> Over time though it has grown to include many optional components, an=
d
>>> even within a given subdirectory (e.g. sepolicy) there seem to be a
>>> number of components that should be optional (e.g. the dbus service).=

>>> I'd like to propose that we move a number of components out of
>>> policycoreutils into their own top-level subdirectory (possibly group=
ing
>>> some of the related ones together).
>>
>> I'm not sure where the main part of sepolicy should go, but it would b=
e
>> nice to split it out since it depends on setools which has heavier
>> dependencies than a core system package should typically have IMO
>> (NetworkX, which pulls in scipy, numpy, matplotlib, etc.)
>=20
> I would be in favor of that too, but hesitated to do so because it woul=
d
> require moving audit2allow and semanage out of policycoreutils as well.=

> Fedora does package those as part of policycoreutils-python (along with=

> sepolgen).  Arguably audit2allow isn't necessary for production (but
> many users of SELinux in Linux distributions rely on it), but semanage
> is more fundamental these days.
>=20
> However, if people are open to moving sepolicy, audit2allow, and
> semanage, possibly combining them with sepolgen in a new
> subdirectory/package, then we could explore that.
>=20

Yes please. These aren't needed or feasible in a CIL only config

>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B0=
2
Dominick Grift


--kfUWTVaqSvSNxB0JlM8dHhsFo9flEKvH0--

--MG8TrfSN5AMUV3isMWOK6ML7vcRkFJhLF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCAAGBQJYDgmlAAoJECV0jlU3+UdpqyIL/0wxcUu+bXS7TKOp66fMaKqP
XtLr2WGjE3hbyy0JPfNhuIekgi2xhkeB+W0UaxW1WEL2YLAZysC85wTywSixl6ws
HysSwXTGvWP7+FiDaeMW98aZL76yL/bT2DkuKjxaa4cXL76gxJp38iEXBZ6tY8Rj
FXQae8A+KlEd0loAX9G4nMT8yTIrP/IRkQusdpCH/0izsD5Ur4wKCxNBVitziMw0
lmRzDc2RVIIV7aSoDwD9a8m1uJWLjXREVM9+2Qc0L8URRlmr9GN3FSo0hdFSNmiY
VVSTkNlrqj99qPI6JJRm1DDwgJs2xpuPs0B2erMeK7pTDfxff2zYF8KZw5jRrRkk
ykn8c+NaP07VqJs39mLHjtiSRj7bQ2etMm7sdNXqVfqWPeZOkRShR5yg+WvxA0jI
t08X6/qqUbHyRQh4dnulonHl4qcnqDoT17CeayU8AFSS61jhu9YRf5bhEYsbWT4S
WIcxWGLR8rouXAg61cJ4YSw5pneGYAYk/60yPcijTg==
=BbJu
-----END PGP SIGNATURE-----

--MG8TrfSN5AMUV3isMWOK6ML7vcRkFJhLF--
