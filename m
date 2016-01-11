Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0BBYZMO015099
 for <selinux@tycho.nsa.gov>; Mon, 11 Jan 2016 06:34:35 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 by mx1.redhat.com (Postfix) with ESMTPS id E541E57
 for <selinux@tycho.nsa.gov>; Mon, 11 Jan 2016 11:34:32 +0000 (UTC)
Received: from [10.40.2.150] (dhcp-10-40-2-150.brq.redhat.com [10.40.2.150])
 by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u0BBYVf0008747
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
 for <selinux@tycho.nsa.gov>; Mon, 11 Jan 2016 06:34:32 -0500
Subject: Re: ANN: SELinux Userspace Release 20160107-rc1
To: selinux@tycho.nsa.gov
References: <568E8AA5.5030501@tresys.com>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <56939346.90402@redhat.com>
Date: Mon, 11 Jan 2016 12:34:30 +0100
MIME-Version: 1.0
In-Reply-To: <568E8AA5.5030501@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="luW5QIdnqLHT4qVAEDJx5WbhofKPfugT3"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--luW5QIdnqLHT4qVAEDJx5WbhofKPfugT3
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 01/07/2016 04:56 PM, Steve Lawrence wrote:
> A release candidate for SELinux Userspace is now available at:
>=20
> https://github.com/SELinuxProject/selinux/wiki/Releases
>=20
> This has been tagged as 20160107-rc1 in the git repository.
>=20
> Please give at a test and let us know if there are any issues.
>=20

I've built two testing set of packages for Fedora and both looks good so
far.


* http://copr.fedoraproject.org/coprs/plautrba/selinux-master/

It's built from SELinuxProject/selinux tree without any Fedora
modifications.


* http://copr.fedoraproject.org/coprs/plautrba/selinux/

Builds are based on 20160107-rc1 release with Fedora modifications
tracked in fedora-selinux/selinux repository. The modifications are
above all:

 * python scripts defaults to /usr/bin/python3
 * sepolicy is patched to be usable with python 3
 * other changes not-accepted by upstream

I'm going to push this one to Fedora Rawhide during this week.


Feel free to use and test both sets.

Petr
--=20
Petr Lautrbach



--luW5QIdnqLHT4qVAEDJx5WbhofKPfugT3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWk5NGAAoJEGOorUuYLENzcUQP/j3othwqtjj42AeXAVP5g8cs
UPW7QqgGV32SEUqQNz6cFxliNaqntj1TNHvtYGDT8z97xHPywa5csok8SK9GZGml
7lKEn6KCxjtybJGKqnKwS2qSDsR5ewTg/Jo7RqJ2L2mjYFLxLXSTSwQIPDN5nM3t
5CxSTIUvFMD8XdXSsh3voUgdQv5HdbldM34TrwF6XFzL28z9kCf8wztNKdnpuTkz
ssXHhUCsLHrhZVTRXhF4e6sObg13t7kMXOSdsOgXoL7QalkxadE8KT6DPUkNupgs
NDyVc+wC3GcQZU9XqPZkxSW1Jd3cCYBHz1xOhq8kIpPtCabko2X+v7x5tN+qV3i9
b8klUFAiwDwl589yk4nxPzsN00PADQ2d1QYpFx3A27swXZWOJBykNGGnZxzbUCqz
YoaHPvrxUt7hDdhRO0jjKTHvtIOqIUUP181S87XeqVypQAk6XH0fMFvQ0bZ+SS+n
9WqPVrBOinjWLflp7diOb00u1E0751mDIU0IwtJxWWUhbiYEm4BlhTsf1o1OqBoo
zhwGRlZ0TrypgDN1ObzxNWpceOX4QmLpQxrcn8wraEHj12/wnFqM/MA93TWiwy5g
QTNdtDxVyUbAMeASgXy0WQpe6XPAZ1rHE4/mxczo1j852rV+bM3bPUBvoKP5tRJw
rz2gRT/IdOdTPnt77HMB
=4BLO
-----END PGP SIGNATURE-----

--luW5QIdnqLHT4qVAEDJx5WbhofKPfugT3--
