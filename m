Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t83Crvri013686
 for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2015 08:53:57 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id CD4CD8E3E9
 for <selinux@tycho.nsa.gov>; Thu,  3 Sep 2015 12:53:54 +0000 (UTC)
Received: from hulk.w.lan (dhcp-10-40-3-171.brq.redhat.com [10.40.3.171])
 by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 t83Crrnk026494
 (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Thu, 3 Sep 2015 08:53:54 -0400
Subject: Re: secilc: in segfault
To: selinux@tycho.nsa.gov
References: <20150903094844.GA18832@x250> <55E83A89.5010208@tycho.nsa.gov>
 <20150903124013.GB2118@x250>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <55E842DD.3080408@redhat.com>
Date: Thu, 3 Sep 2015 14:53:49 +0200
MIME-Version: 1.0
In-Reply-To: <20150903124013.GB2118@x250>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2aSxfE7Hf796ipF2olctqVkXGwAfrEUER"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2aSxfE7Hf796ipF2olctqVkXGwAfrEUER
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/03/2015 02:40 PM, Dominick Grift wrote:
> On Thu, Sep 03, 2015 at 08:18:17AM -0400, James Carter wrote:
>> On 09/03/2015 05:48 AM, Dominick Grift wrote:
>>> Anyone tried "secilc test/in_test.cil" lately? It dumps core here.
>>>
>>> $ secilc test/in_test.cil
>>> Segmentation fault (core dumped)

Confirmed on Fedora 23, thanks for the report.

https://bugzilla.redhat.com/show_bug.cgi?id=3D1259730


> It may just be my incompetence but i can't get current master branch
> selinux user space to build on Fedora rawhide manually like so:
>=20
> # cd selinux
> # make LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64
>=20
> I have installed all the build dependencies i believe
>=20
> This is what it is failing with here:
>=20
> cc1: all warnings being treated as errors
> Makefile:113: recipe for target 'direct_api.o' failed
> make[2]: *** [direct_api.o] Error 1
> make[2]: Leaving directory
> '/home/kcinimod/Workspace/selinux/libsemanage/src'
> Makefile:2: recipe for target 'all' failed
> make[1]: *** [all] Error 2
> make[1]: Leaving directory
> '/home/kcinimod/Workspace/selinux/libsemanage'
> Makefile:11: recipe for target 'all' failed
> make: *** [all] Error 1
>=20

This report seems to be little stripped so the important messages are
missing. Nevertheless, according to README you should use install
target. The following command works for me on Fedora 23:

make DESTDIR=3D/home/plautrba/devel/build/selinux  install

Petr
--=20
Petr Lautrbach



--2aSxfE7Hf796ipF2olctqVkXGwAfrEUER
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV6ELgAAoJEGOorUuYLENzaiwQAJoP5SgZQnlwgidiivdf5dnW
QzkjBxCcyvYF5ofbryKNx8WKY8rm3tXErG4/ga4IJznqOGRnGy9WzrqqraR0yhkc
FVwlAnLku1jgPZ14h1CHZs5XNCYNmT/aG97kuN0Kh6XyEL+qn1Dxehf8L3fBP/Kl
Zjd54AsXScevlLvi1zVp/C9R65tz9VenB/VWSwcuJmp7iuZpX5GG/QpyJjL3evqD
VtDQMS2UYOUue2l6zjT2G845ZDo4bpZ0jt6q8r9qb8FCBQhirkX7Iy5AAs7mQ39d
3tFAnetN9IyTtFXnO2r3B+n2kS1hVo3tOFXlsKOUhKyGfYZaZlq0P093WhZSRogw
UQqc79z7LcHCMerF51YXptRnnoa3IaOr58ay3+G979Qr2BFR4y5jrR1SSrveen7p
cTi3k842RNZunoCnMlEpvtzRFtnVHD8Aa00VIzTh9lPNCE2mmzPeYcPmVfQBbdNP
kOnbNNIVYqQreFCOkEIFIijeOwwk6YB99+EEajrqxd+bDNPHikMepkSxesRzq9Qs
PXN7PQMsMJHBHEaKWhVQbvFfsW0sD6Hj/GPcCtHk6ISi4zrYGG+NPLRx9GvCVzdL
hJO0i6b1ye835aUNXmAZa8Rja6YzG6StnD+E8ywcHSU35v12UO5N/sYFtNM8Ct9U
Ugr3ng5ejcFzxT6HlvHD
=uyu3
-----END PGP SIGNATURE-----

--2aSxfE7Hf796ipF2olctqVkXGwAfrEUER--
