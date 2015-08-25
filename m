Subject: Re: [PATCH] libsepol: create new keys with copy of 'name' variable
To: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
References: <1440511529-30944-1-git-send-email-plautrba@redhat.com>
 <55DCB385.1090607@tycho.nsa.gov>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <55DCCF96.6010407@redhat.com>
Date: Tue, 25 Aug 2015 22:27:02 +0200
MIME-Version: 1.0
In-Reply-To: <55DCB385.1090607@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1eUIC84kvuap0ocGXglbHuhj20Btquo7c"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1eUIC84kvuap0ocGXglbHuhj20Btquo7c
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/25/2015 08:27 PM, James Carter wrote:
> On 08/25/2015 10:05 AM, Petr Lautrbach wrote:
>> --- a/libsepol/src/boolean_record.c
>> +++ b/libsepol/src/boolean_record.c
>> @@ -25,12 +25,14 @@ int sepol_bool_key_create(sepol_handle_t * handle,=

>>       sepol_bool_key_t *tmp_key =3D
>>           (sepol_bool_key_t *) malloc(sizeof(struct sepol_bool_key));
>>
>> -    if (!tmp_key) {
>> +    char *tmp_name =3D strdup(name);
>> +
>> +    if (!tmp_key || !tmp_name) {
>>           ERR(handle, "out of memory, " "could not create boolean key"=
);
>>           return STATUS_ERR;
>>       }
>>
>=20
> Need to free tmp_key if it is allocated, but the strdup for tmp_name
> fails. And vice versa.
>=20

The patch is apparently not ready yet. It can't be even compiled, see
bellow. Sorry for the noise.

cc -Werror -Wall -W -Wundef -Wshadow -Wmissing-format-attribute -O2 -I.
-I../include -D_GNU_SOURCE -I../cil/include -fPIC -c -o boolean_record.o
boolean_record.c
boolean_record.c: In function =91sepol_bool_key_free=92:
boolean_record.c:67:7: error: passing argument 1 of =91free=92 discards
=91const=92 qualifier from pointer target type [-Werror=3Ddiscarded-quali=
fiers]
  free(key->name);
       ^
In file included from boolean_record.c:2:0:
/usr/include/stdlib.h:483:13: note: expected =91void *=92 but argument is=
 of
type =91const char *=92
 extern void free (void *__ptr) __THROW;



--=20
Petr Lautrbach


--1eUIC84kvuap0ocGXglbHuhj20Btquo7c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV3M+WAAoJEGOorUuYLENzaVsQAL6RQMnw+eimIg3ANTttLfIx
VaI8dMbbGXxUr/pSEpWwpN6nJoqEmwy/RHb5iBXeTmvb+1wFHkGoAhigraGytME1
L3v8sw5ZX1fc7Clz7fs7XwJjBMBPD/no250SEQX6+LMTysPn2b/jK13gZav3Ixeg
z4K10bv7FC4cTYpxSUcaBXVnMrwLvww8faMnlGSk72PdRVmiciDF5qG4sg34ReAg
fJKRtH4dIYFPIP6KUXHd/m3NdD8Kn3aO7sXgwHQrGvQz93a0grgQPTErd0QhFdzM
T7dGEKTWK3xaNdPOVc5ii7nosrke1AVGWpzkEVuCK8wo0LeL6xEIYcsKHzbd9oFi
RYVfFdqEEzdnBgmz67zIfOANJj078Dsn9ycOS9l9hdHO6aiXG1DrqsfpwlYUUokr
8RcYn0RSLDuDoPg6nxbcg5yv/TiJw0QiZNXMl4pxCvI95S9phFRm//JRSdyIHEID
ieOcCSrMU4Yz84QpeA1LbDRMQNer3I0T98EAjzTLJDE27OsXpVPaAzRTnEdJ17Qo
nru1HC270Js2EKix83+bQDIlMPC6TJfDsYpgd00pgyEdUrr/5qbKSVcbgGZFHRTK
J/zg3/MA2cBlWLGkh8OIj1u6+xB40xMNGhQ3B9kxYmn59aj0D3yC/X87Nmbf7StO
dWVU3SuO4bfmbRNKBEVh
=vVsk
-----END PGP SIGNATURE-----

--1eUIC84kvuap0ocGXglbHuhj20Btquo7c--
