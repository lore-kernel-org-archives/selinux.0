Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t3LCm9gU029300
 for <selinux@tycho.nsa.gov>; Tue, 21 Apr 2015 08:48:09 -0400
Message-ID: <553646FC.9050304@redhat.com>
Date: Tue, 21 Apr 2015 14:47:56 +0200
From: Petr Lautrbach <plautrba@redhat.com>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: selinux.py - use os.walk() instead of
 os.path.walk()
References: <1429616809-5417-1-git-send-email-plautrba@redhat.com>
 <55364103.30004@tresys.com>
In-Reply-To: <55364103.30004@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9bePLLiPCJw8nF49uAdEU7R0AQeSIFDhw"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9bePLLiPCJw8nF49uAdEU7R0AQeSIFDhw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/21/2015 02:22 PM, Steve Lawrence wrote:
> On 04/21/2015 07:46 AM, Petr Lautrbach wrote:
>> From: Miro Hron=C4=8Dok <mhroncok@redhat.com>
>>
>> os.path.walk() function is deprecated and has been removed in Python 3=

>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> Acked-by: Steve Lawrence <slawrence@tresys.com>
>=20
> Thanks!

Might it be that you've accidentally edited a wrong ChangeLog?

Update libselinux ChangeLog

--- a/libsemanage/ChangeLog
+++ b/libsemanage/ChangeLog
@@ -1,3 +1,5 @@
+       * Use os.walk() instead of the deprecated os.path.walk(), from Pe=
tr
+         Lautrbach & Miro Hron=C4=8Dok



Petr

>=20
>> ---
>>
>> A simple fix which allows to use same construction in Python 2 and Pyt=
hon 3.
>> It's reported and proposed in https://bugzilla.redhat.com/show_bug.cgi=
?id=3D1195004
>>
>>
>>  libselinux/src/selinuxswig_python.i | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/libselinux/src/selinuxswig_python.i b/libselinux/src/seli=
nuxswig_python.i
>> index ae72246..c9a2341 100644
>> --- a/libselinux/src/selinuxswig_python.i
>> +++ b/libselinux/src/selinuxswig_python.i
>> @@ -31,9 +31,9 @@ def restorecon(path, recursive=3DFalse):
>>              lsetfilecon(path, context)
>> =20
>>          if recursive:
>> -            os.path.walk(path, lambda arg, dirname, fnames:
>> -                             map(restorecon, [os.path.join(dirname, f=
name)
>> -                                              for fname in fnames]), =
None)
>> +            for root, dirs, files in os.walk(path):
>> +                for name in files + dirs:
>> +                   restorecon(os.path.join(root, name))
>> =20
>>  def chcon(path, context, recursive=3DFalse):
>>      """ Set the SELinux context on a given path """
>>
>=20


--=20
Petr Lautrbach



--9bePLLiPCJw8nF49uAdEU7R0AQeSIFDhw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVNkb8AAoJEGOorUuYLENz2MIP/0lrnTll/DGurJ6buz+A4wCD
T4gygtv9sTBI7kJrdSYODF+9hNfVsyouAYOV0T7XnsmYT8vkkOUCIqJIB1jTufhw
GTYj1VHfNSzjH++LsMx5zJF7OoyqUCOEp6MREG9lOyurTbwDQcGdnnENiIvlalwE
b9JjknVzLWypAl3l5z+muey6qAKmxHir18ILPBNZ5RN1jAfbA1qsRfZqz8icQcpa
J1zwLDP5FRCN8Qm09JoWSww3elWnEJJwYMLnGcpTK21lBNi63CR7y4NRAPIbBGoe
8F4qZo7oQk0Qweoccfv5esVI0hjUsUPQ74nx7dizmY8zOQsVip3EFejVqseEHuyq
EKEHs5zgL30xZItQVZ7ndWC6PQNUsxFejCQmWw7J6LyyZkl1Hrgkgvw0zGnsx3CM
RTprz0PPMbSeXBGAEnVD/hzA9eRCZwgmpNbXsrA0BT8hG+rVS0riSjWGMz007EcZ
b5CmfO6SvCuusVE4TR2ujL/hKNzyZ0kz6SxGjJti9Ye9lWooJp2q6secWF9ki8Wn
AbyZ/Hv7G62PMHy8wX4CKfeoyjclT+3Mm+po+WPQx4rBgvxwakvR+0Y3OIuxY4Og
ADmmPjoc1j1XqAdClWNme6opSQgjz0ORLdjpurnGpoqzNNC0lEJBT213OQi8vYeW
TRd5fF+3GjzuuY9obb94
=ijBR
-----END PGP SIGNATURE-----

--9bePLLiPCJw8nF49uAdEU7R0AQeSIFDhw--
