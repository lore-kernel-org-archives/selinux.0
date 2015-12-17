Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tBHE6qTl012681
 for <selinux@tycho.nsa.gov>; Thu, 17 Dec 2015 09:06:52 -0500
Subject: Re: [PATCH] libselinux: Verify context input to funtions to make sure
 the context field is not null.
To: Steve Lawrence <slawrence@tresys.com>, selinux@tycho.nsa.gov
References: <1449694065-26728-1-git-send-email-plautrba@redhat.com>
 <5672BED4.6000802@tresys.com>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <5672C16C.8080201@redhat.com>
Date: Thu, 17 Dec 2015 15:06:36 +0100
MIME-Version: 1.0
In-Reply-To: <5672BED4.6000802@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KLOEFlj7KfqCHCWSgJlLMCh0UrXH3liBe"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KLOEFlj7KfqCHCWSgJlLMCh0UrXH3liBe
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 12/17/2015 02:55 PM, Steve Lawrence wrote:
> I believe this patch, or something similar, was sent to the list in the=

> past and was rejected. Passing in a NULL context is considered invalid
> use, similar to strdup/strcmp/etc. and is a bug in the calling process.=


I didn't know that, sorry.

I'll mark this patch as upstream rejected, Fedora downstream only; to
prevent future attempts to re-send it again.

Thanks,

Petr

>=20
> On 12/09/2015 03:47 PM, Petr Lautrbach wrote:
>> From: Dan Walsh <dwalsh@redhat.com>
>>
>> Return errno EINVAL, to prevent segfault.
>>
>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>> ---
>>  libselinux/src/avc_sidtab.c           | 5 +++++
>>  libselinux/src/canonicalize_context.c | 5 +++++
>>  libselinux/src/check_context.c        | 5 +++++
>>  libselinux/src/compute_av.c           | 5 +++++
>>  libselinux/src/compute_create.c       | 5 +++++
>>  libselinux/src/compute_member.c       | 5 +++++
>>  libselinux/src/compute_relabel.c      | 5 +++++
>>  libselinux/src/compute_user.c         | 5 +++++
>>  libselinux/src/fsetfilecon.c          | 8 ++++++--
>>  libselinux/src/lsetfilecon.c          | 9 +++++++--
>>  libselinux/src/setfilecon.c           | 8 ++++++--
>>  11 files changed, 59 insertions(+), 6 deletions(-)
>>
>> diff --git a/libselinux/src/avc_sidtab.c b/libselinux/src/avc_sidtab.c=

>> index 9669264..a46cfa7 100644
>> --- a/libselinux/src/avc_sidtab.c
>> +++ b/libselinux/src/avc_sidtab.c
>> @@ -81,6 +81,11 @@ sidtab_context_to_sid(struct sidtab *s,
>>  	int hvalue, rc =3D 0;
>>  	struct sidtab_node *cur;
>> =20
>> +	if (! ctx) {
>> +		errno =3D EINVAL;
>> +		return -1;
>> +	}
>> +
>>  	*sid =3D NULL;
>>  	hvalue =3D sidtab_hash(ctx);
>> =20
>> diff --git a/libselinux/src/canonicalize_context.c b/libselinux/src/ca=
nonicalize_context.c
>> index 7cf3139..9d8dc86 100644
>> --- a/libselinux/src/canonicalize_context.c
>> +++ b/libselinux/src/canonicalize_context.c
>> @@ -17,6 +17,11 @@ int security_canonicalize_context_raw(const char * =
con,
>>  	size_t size;
>>  	int fd, ret;
>> =20
>> +	if (! con) {
>> +		errno =3D EINVAL;
>> +		return -1;
>> +	}
>> +
>>  	if (!selinux_mnt) {
>>  		errno =3D ENOENT;
>>  		return -1;
>> diff --git a/libselinux/src/check_context.c b/libselinux/src/check_con=
text.c
>> index 52063fa..9637dd7 100644
>> --- a/libselinux/src/check_context.c
>> +++ b/libselinux/src/check_context.c
>> @@ -14,6 +14,11 @@ int security_check_context_raw(const char * con)
>>  	char path[PATH_MAX];
>>  	int fd, ret;
>> =20
>> +	if (! con) {
>> +		errno =3D EINVAL;
>> +		return -1;
>> +	}
>> +
>>  	if (!selinux_mnt) {
>>  		errno =3D ENOENT;
>>  		return -1;
>> diff --git a/libselinux/src/compute_av.c b/libselinux/src/compute_av.c=

>> index 937e5c3..e67b3d3 100644
>> --- a/libselinux/src/compute_av.c
>> +++ b/libselinux/src/compute_av.c
>> @@ -26,6 +26,11 @@ int security_compute_av_flags_raw(const char * scon=
,
>>  		return -1;
>>  	}
>> =20
>> +	if ((! scon) || (! tcon)) {
>> +		errno =3D EINVAL;
>> +		return -1;
>> +	}
>> +
>>  	snprintf(path, sizeof path, "%s/access", selinux_mnt);
>>  	fd =3D open(path, O_RDWR);
>>  	if (fd < 0)
>> diff --git a/libselinux/src/compute_create.c b/libselinux/src/compute_=
create.c
>> index 9559d42..7de721a 100644
>> --- a/libselinux/src/compute_create.c
>> +++ b/libselinux/src/compute_create.c
>> @@ -64,6 +64,11 @@ int security_compute_create_name_raw(const char * s=
con,
>>  		return -1;
>>  	}
>> =20
>> +	if ((! scon) || (! tcon)) {
>> +		errno =3D EINVAL;
>> +		return -1;
>> +	}
>> +
>>  	snprintf(path, sizeof path, "%s/create", selinux_mnt);
>>  	fd =3D open(path, O_RDWR);
>>  	if (fd < 0)
>> diff --git a/libselinux/src/compute_member.c b/libselinux/src/compute_=
member.c
>> index 1fc7e41..4ff2173 100644
>> --- a/libselinux/src/compute_member.c
>> +++ b/libselinux/src/compute_member.c
>> @@ -25,6 +25,11 @@ int security_compute_member_raw(const char * scon,
>>  		return -1;
>>  	}
>> =20
>> +	if ((! scon) || (! tcon)) {
>> +		errno =3D EINVAL;
>> +		return -1;
>> +	}
>> +
>>  	snprintf(path, sizeof path, "%s/member", selinux_mnt);
>>  	fd =3D open(path, O_RDWR);
>>  	if (fd < 0)
>> diff --git a/libselinux/src/compute_relabel.c b/libselinux/src/compute=
_relabel.c
>> index 4615aee..6a37acf 100644
>> --- a/libselinux/src/compute_relabel.c
>> +++ b/libselinux/src/compute_relabel.c
>> @@ -25,6 +25,11 @@ int security_compute_relabel_raw(const char * scon,=

>>  		return -1;
>>  	}
>> =20
>> +	if ((! scon) || (! tcon)) {
>> +		errno =3D EINVAL;
>> +		return -1;
>> +	}
>> +
>>  	snprintf(path, sizeof path, "%s/relabel", selinux_mnt);
>>  	fd =3D open(path, O_RDWR);
>>  	if (fd < 0)
>> diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_us=
er.c
>> index b37c5d3..3737c28 100644
>> --- a/libselinux/src/compute_user.c
>> +++ b/libselinux/src/compute_user.c
>> @@ -24,6 +24,11 @@ int security_compute_user_raw(const char * scon,
>>  		return -1;
>>  	}
>> =20
>> +	if (! scon) {
>> +		errno =3D EINVAL;
>> +		return -1;
>> +	}
>> +
>>  	snprintf(path, sizeof path, "%s/user", selinux_mnt);
>>  	fd =3D open(path, O_RDWR);
>>  	if (fd < 0)
>> diff --git a/libselinux/src/fsetfilecon.c b/libselinux/src/fsetfilecon=
=2Ec
>> index 52707d0..83c138e 100644
>> --- a/libselinux/src/fsetfilecon.c
>> +++ b/libselinux/src/fsetfilecon.c
>> @@ -9,8 +9,12 @@
>> =20
>>  int fsetfilecon_raw(int fd, const char * context)
>>  {
>> -	int rc =3D fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context=
) + 1,
>> -			 0);
>> +	int rc;
>> +	if (! context) {
>> +		errno =3D EINVAL;
>> +		return -1;
>> +	}
>> +	rc =3D fsetxattr(fd, XATTR_NAME_SELINUX, context, strlen(context) + =
1, 0);
>>  	if (rc < 0 && errno =3D=3D ENOTSUP) {
>>  		char * ccontext =3D NULL;
>>  		int err =3D errno;
>> diff --git a/libselinux/src/lsetfilecon.c b/libselinux/src/lsetfilecon=
=2Ec
>> index 1d3b28a..278e42a 100644
>> --- a/libselinux/src/lsetfilecon.c
>> +++ b/libselinux/src/lsetfilecon.c
>> @@ -9,8 +9,13 @@
>> =20
>>  int lsetfilecon_raw(const char *path, const char * context)
>>  {
>> -	int rc =3D lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(conte=
xt) + 1,
>> -			 0);
>> +	int rc;
>> +	if (! context) {
>> +		errno =3D EINVAL;
>> +		return -1;
>> +	}
>> +
>> +	rc =3D lsetxattr(path, XATTR_NAME_SELINUX, context, strlen(context) =
+ 1, 0);
>>  	if (rc < 0 && errno =3D=3D ENOTSUP) {
>>  		char * ccontext =3D NULL;
>>  		int err =3D errno;
>> diff --git a/libselinux/src/setfilecon.c b/libselinux/src/setfilecon.c=

>> index d05969c..dddce3c 100644
>> --- a/libselinux/src/setfilecon.c
>> +++ b/libselinux/src/setfilecon.c
>> @@ -9,8 +9,12 @@
>> =20
>>  int setfilecon_raw(const char *path, const char * context)
>>  {
>> -	int rc =3D setxattr(path, XATTR_NAME_SELINUX, context, strlen(contex=
t) + 1,
>> -			0);
>> +	int rc;
>> +	if (! context) {
>> +		errno =3D EINVAL;
>> +		return -1;
>> +	}
>> +	rc =3D setxattr(path, XATTR_NAME_SELINUX, context, strlen(context) +=
 1, 0);
>>  	if (rc < 0 && errno =3D=3D ENOTSUP) {
>>  		char * ccontext =3D NULL;
>>  		int err =3D errno;
>>
>=20





--KLOEFlj7KfqCHCWSgJlLMCh0UrXH3liBe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWcsFtAAoJEGOorUuYLENzCKMP/AqNPgIXUKasz60edgyTh0/y
eVDsTzz2Efgb9m83JAFt8xik2rMacebxLufBCBGUvvyGkmL9OjY9+/6AyTyt6/Wq
EAbgsWSEH49NGkmdnj5bHNwEJH+vAhb4woOcPOdvgl5E0UWXU2du41JPdZ+MlD18
aLPlcTFS4Hy0ib0mGCeJ4kFnMLcxKOoeRkXs5zYqSl/yeXU6+rKpzAXZmJx35hDT
35NlwY011kLLNaMVIPfAHluZFv5H8joYnSpPw9B5HfNXdEl81BVn0KqoBMfQXI+2
00eX2sYzbftTAe22f8splXYe7FqSr6o1gvv1nwZzdEggMqdWwNMC2iDDibG0iD2m
ydzfNgwLfgS+Cz6/uoR8MW1YwLk2nl6HbfwA5eXy8I3stb08e1UNZMHNJ4nXolKS
iEQujnHm+UWAQ7usuKjIMhWqcO8QAU9nCl8lojefGUoygIuIYZAmCewhiGzc4uiQ
gNFBTtKKqxI+Hdi1XA0PsBiq0gyey4ryFGcYFBMXdVUFTsnqe5A9XydOngHBbVkF
LxNKrimu4RjvDE/p9qpiYfnyhpUvTEOso62oehkx3YXcPcja1Un9b+bfhO7dKsQm
BRDrzMjNmv3DZtMJeyrk0NMSTtcTjCutl08qxiX7rhZzH8sw2KoAEHLNYF9heie8
P2mWd1vnplbHX/vJvcG2
=9ZJg
-----END PGP SIGNATURE-----

--KLOEFlj7KfqCHCWSgJlLMCh0UrXH3liBe--
