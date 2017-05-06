Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v46I0WT2003282
 for <selinux@tycho.nsa.gov>; Sat, 6 May 2017 14:00:32 -0400
Received: by mail-wm0-f49.google.com with SMTP id u65so47320077wmu.1
 for <selinux@tycho.nsa.gov>; Sat, 06 May 2017 11:00:27 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id q51sm2710610edd.24.2017.05.06.11.00.25
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 06 May 2017 11:00:25 -0700 (PDT)
Date: Sat, 6 May 2017 20:00:24 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Why does Python want to read /proc/meminfo
Message-ID: <20170506180024.GA12984@julius>
References: <72df5e72-55ac-5696-ceb6-f50f98a35ea5@gmail.com>
 <87tw4yfs82.fsf@handshake.de>
 <8b1d353c-7f98-5522-4f42-906a7082d47a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
In-Reply-To: <8b1d353c-7f98-5522-4f42-906a7082d47a@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 06, 2017 at 11:07:34AM -0500, Ian Pilcher wrote:
> On 05/06/2017 12:51 AM, dieter wrote:
> > Personally, I doubt that you will find a reference.
> > Instead, I assume that the reference comes from the C runtime library.
> > It might hepl optimize memory management to know about "meminfo" detail=
s.
>=20
> You're right.  Seems that it's glibc's qsort().
>=20
> So it seems that any service written in Python (or any other program
> that uses qsort) needs to be given read access to most of /proc or deal
> with the (unspecified) consequences of not allowing qsort() to determine
> the amount of memory in the system.
>=20
> Delightful.

For SELinux policy writers the above is a minor issue compared to pythons' =
shutil.copy2() implementation
shutil.copy2 behaves like `cp -a` and copies all of the security attriutes =
with the file.

This often causes us to give consumers of shutil.copy2() much broader acces=
s than strictly needed

This is also a problem with `cp -a` (so python is not alone in this). I am =
not sure how python handles shutil.copy2() but it would be much better for =
us if it would exclude the MAC security attributes when it copies

Sort of like shutil.copy2_except_MAC_security_attributes or `cp -a-minus-MA=
C-security-attributes`

Consider this:

some consumer of shutil.copy2 copies /etc/shadow to /tmp/myapp-XXXXX and ed=
its it there.

Because it copies the security context with /etc/shadow, it later needs to =
be granted to edit files with the security context for shadow files. Effect=
ively forcing us to allow the process to edit files with the shadow securit=
y context

Whereas if it would have excluded the MAC security contexts when it copied =
the file, we would have just been forced to allow the process to read file =
with the shadow file context, and not to write to it

The above is a little surrealistic example but it is a very common issue in=
 general

for example pip3 does this all the time and so pip3 processes need much bro=
ader access than strictly necessary

>=20
> --=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Ian Pilcher                                         arequipeno@gmail.com
> -------- "I grew up before Mark Zuckerberg invented friendship" --------
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkODzMACgkQJXSOVTf5
R2kUpAv/aj5aLTdzO6iK6SaFjrdGqkhkuxXMshes6/8fv3A470nI4FQLO3/7NdQx
keBN+OJ5f/8IaEFsSKgIYQCMpl+iZ83tpfDZVHBt/KZFEdeeVrLOk6JZPV6kpw+o
j0F8rnA6ZgNa0T/z/qG0QCkbffnN5SiWEFSaAoCh56vJDYgHN5HtuPk4XEvNG687
y5+MDnjFRLisbbVtjzUyyqif9K9oXY+4SJ8Yl8PMRY51y7gY2paWX9Tyj+IhYTeZ
q1gauA8BLTvnGpQxuniua7olV0PKGMbt7yMh3nVSK7fb4bs3Nqmlm2ruClCX8m66
pCeFtX14QtdkawrC8PzmP4FMBeeNl5PBut68B9y496VQMuTIG8Wimsy19PRY0mPL
4mYTojMNSbK7JedXWin+1NCFVxgfWLh0EoRFpF+aScVKJEdS2zDrnojl6LvLM6qn
58anXabWJ6SIh6MfoinktiQEkzSyu5aoQdDlVaMfJQVqk1f+Uq8VTaEIGa7glZMP
N5caXQbf
=3q15
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
