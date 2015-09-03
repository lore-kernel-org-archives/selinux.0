Date: Thu, 3 Sep 2015 15:20:42 +0200
From: Dominick Grift <dac.override@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: secilc: in segfault
Message-ID: <20150903132041.GD2118@x250>
References: <20150903094844.GA18832@x250>
 <55E83A89.5010208@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
In-Reply-To: <55E83A89.5010208@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2015 at 08:18:17AM -0400, James Carter wrote:
> On 09/03/2015 05:48 AM, Dominick Grift wrote:
> >Anyone tried "secilc test/in_test.cil" lately? It dumps core here.
> >
> >$ secilc test/in_test.cil
> >Segmentation fault (core dumped)
> >
> >
>=20
> It works for me for the current master branch of SELinux userspace instal=
led
> locally. What version are you using?
>=20
> Jim
>=20

Ok so that turns out to be a bug in Fedora. However.

I can still get secilc to segfault on "in". I wonder if the following is
or should be supported:

The scenario is: I want to simplify my macros by using
blockabstracts/inherits to provide a single point of failure

As a matter of test i made these two changes:

https://github.com/DefenSec/dssp/commit/85ba6f1848118e16b5544052dc5764663b2=
72262
https://github.com/DefenSec/dssp-contrib/commit/77442e1e4658df99d1ce7473233=
8a9c4ad80a6a3

However this makes secilc segfault, and i do not see why.

I first thought it was because i was using "ARG1" in the blockabstract
(see first commit). However that seems to not be the case.

I am left wondering: what am i doing wrong here (obviously secilc should
not segfault nevertheless)

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV6EklAAoJENAR6kfG5xmcGW4L/iRREYTdydm/yX0xPIkaKn/l
1BG4Z/dkkEKiWBHv+dldYbec4DGwrBtjjVjynntDHjscerxvdvOwEyfZWiEFHqky
anMl/JAVpcxMsPs9xH1odPMBMu30XMB/ZYDw9gm3c5FRAOwEBY8fOe39uLSkGChm
0xu/R8kND0nK9loLI9tHUVDcQGVWAbjeZ/VEzhKd6Wa7AIu+rWt95JMM4QcqcT3c
L3q0yj2POjrpVSzG4M7QxoXfFN3TsJdJgXtAB5s7D+Nm2CtePSc7KFQByu6RZZqs
Naow4sab429cEUo7z8d3rNbc42wFR3xwkScVY8ZvEomnLu6IAhnjrL0+4jurrsnd
YvmQRtb8IAf9lZGhGjHuPuxOA7XU+ExI+5uTE9af3CVsALqfkKBgdUf3U9ISFU0A
r25XYBE4seAN2jO1jxH9lF8DEhcTQY2SXH7YMxptnXIe976hJDmErPRvJ1rjBd3a
A6Is5fJCWKk6MeNeRIEG6x/FWDCFnObYXlER42JGLg==
=rv1c
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
