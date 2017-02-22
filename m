Subject: Re: [PATCH] libsemanage: Perform access check using euid instead of
 uid
To: Stephen Smalley <sds@tycho.nsa.gov>, Vit Mojzis <vmojzis@redhat.com>,
 selinux@tycho.nsa.gov
References: <20170214131448.22837-1-vmojzis@redhat.com>
 <1487085107.29417.4.camel@tycho.nsa.gov>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <79b80f16-2d28-ab87-31e7-eaf052ed9d7a@redhat.com>
Date: Wed, 22 Feb 2017 16:47:09 +0100
MIME-Version: 1.0
In-Reply-To: <1487085107.29417.4.camel@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="t524p5iIcIPjEIGP48QrGTtO13jG1E9WO"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t524p5iIcIPjEIGP48QrGTtO13jG1E9WO
Content-Type: multipart/mixed; boundary="SOmOS6CD09wnn5KC5ALdWUvxW3kQ68O5D";
 protected-headers="v1"
From: Petr Lautrbach <plautrba@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Vit Mojzis <vmojzis@redhat.com>,
 selinux@tycho.nsa.gov
Message-ID: <79b80f16-2d28-ab87-31e7-eaf052ed9d7a@redhat.com>
Subject: Re: [PATCH] libsemanage: Perform access check using euid instead of
 uid
References: <20170214131448.22837-1-vmojzis@redhat.com>
 <1487085107.29417.4.camel@tycho.nsa.gov>
In-Reply-To: <1487085107.29417.4.camel@tycho.nsa.gov>

--SOmOS6CD09wnn5KC5ALdWUvxW3kQ68O5D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/14/2017 04:11 PM, Stephen Smalley wrote:
> On Tue, 2017-02-14 at 14:14 +0100, Vit Mojzis wrote:
>> Use faccessat() with AT_EACCESS instead of accesss() in order to
>> check
>> permissions of effective user. access() calls checking existence of
>> a file (F_OK) were left untouched since they work correctly.
>>
>> This enables setuid programs to use libsemanage.
>=20
> Not sure we want setuid programs using libsemanage.  Is there a use
> case for that?  I wouldn't warrant it to be safe.

The motivation is described in the response from the original reporter
in the bug:

---
I think the reason why I filed the bug back then was
https://fedorahosted.org/sssd/ticket/2564

In general I don't think the bug is a big deal to us and if upstream is
reluctant to this change, just close the bug. I just found it odd to
check if a file exists before acting on it instead of just trying to
work with the file and failing on errors..the current approach seems a
bit racy to me.

About the question in the thread that asks why do we use the selinux
libraries in a setuid library..the reason is that in order to pass
certain certifications, no code in SSSD that deals with network
connections should run as root. Therefore, the SSSD itself runs as a
nonprivileged user and for actions that require root privileges (like
setting a selinux context for a user) we fork our a setgid helper that
actually does the work.
---

I think it's about situations when a process can create e.g.
/var/lib/selinux/targeted/semanage.read.LOCK001 using fopen(), but
libsemanage denies to work as it thinks it can't access the store.

Petr

>=20
> AT_EACCESS is not implemented by the kernel, so this seems to rely on
> some libc magic to support?  Is that done in a safe way?
>=20
> libsemanage usage of access() is not for security purposes; it is just
> to test for existence/location of various files and to confirm that the=

> policy store is writable by the caller before beginning any real work.
>  So arguments about access() being insecure are not relevant here.
>=20
>>
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1186431
>>
>> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>> ---
>>  libsemanage/src/conf-parse.y     |  7 ++++---
>>  libsemanage/src/semanage_store.c | 18 +++++++++---------
>>  2 files changed, 13 insertions(+), 12 deletions(-)
>>
>> diff --git a/libsemanage/src/conf-parse.y b/libsemanage/src/conf-
>> parse.y
>> index b527e89..d72a0c2 100644
>> --- a/libsemanage/src/conf-parse.y
>> +++ b/libsemanage/src/conf-parse.y
>> @@ -30,6 +30,7 @@
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <string.h>
>> +#include <fcntl.h>
>> =20
>>  extern int semanage_lex(void);                /* defined in conf-
>> scan.c */
>>  extern int semanage_lex_destroy(void);        /* defined in conf-
>> scan.c */
>> @@ -361,7 +362,7 @@ static int semanage_conf_init(semanage_conf_t *
>> conf)
>>  		return -1;
>>  	}
>> =20
>> -	if (access("/sbin/load_policy", X_OK) =3D=3D 0) {
>> +	if (faccessat(AT_FDCWD, "/sbin/load_policy", X_OK,
>> AT_EACCESS) =3D=3D 0) {
>>  		conf->load_policy->path =3D
>> strdup("/sbin/load_policy");
>>  	} else {
>>  		conf->load_policy->path =3D
>> strdup("/usr/sbin/load_policy");
>> @@ -375,7 +376,7 @@ static int semanage_conf_init(semanage_conf_t *
>> conf)
>>  	     calloc(1, sizeof(*(current_conf->setfiles)))) =3D=3D NULL)
>> {
>>  		return -1;
>>  	}
>> -	if (access("/sbin/setfiles", X_OK) =3D=3D 0) {
>> +	if (faccessat(AT_FDCWD, "/sbin/setfiles", X_OK, AT_EACCESS)
>> =3D=3D 0) {
>>  		conf->setfiles->path =3D strdup("/sbin/setfiles");
>>  	} else {
>>  		conf->setfiles->path =3D strdup("/usr/sbin/setfiles");
>> @@ -389,7 +390,7 @@ static int semanage_conf_init(semanage_conf_t *
>> conf)
>>  	     calloc(1, sizeof(*(current_conf->sefcontext_compile))))=20
>> =3D=3D NULL) {
>>  		return -1;
>>  	}
>> -	if (access("/sbin/sefcontext_compile", X_OK) =3D=3D 0) {
>> +	if (faccessat(AT_FDCWD, "/sbin/sefcontext_compile", X_OK,
>> AT_EACCESS) =3D=3D 0) {
>>  		conf->sefcontext_compile->path =3D
>> strdup("/sbin/sefcontext_compile");
>>  	} else {
>>  		conf->sefcontext_compile->path =3D
>> strdup("/usr/sbin/sefcontext_compile");
>> diff --git a/libsemanage/src/semanage_store.c
>> b/libsemanage/src/semanage_store.c
>> index f468fab..805bd60 100644
>> --- a/libsemanage/src/semanage_store.c
>> +++ b/libsemanage/src/semanage_store.c
>> @@ -517,7 +517,7 @@ char *semanage_conf_path(void)
>>  	snprintf(semanage_conf, len + 1, "%s%s%s", semanage_root(),
>> selinux_path(),
>>  		 SEMANAGE_CONF_FILE);
>> =20
>> -	if (access(semanage_conf, R_OK) !=3D 0) {
>> +	if (faccessat(AT_FDCWD, semanage_conf, R_OK, AT_EACCESS) !=3D
>> 0) {
>>  		snprintf(semanage_conf, len + 1, "%s%s",
>> selinux_path(), SEMANAGE_CONF_FILE);
>>  	}
>> =20
>> @@ -552,7 +552,7 @@ int semanage_create_store(semanage_handle_t * sh,
>> int create)
>>  			return -1;
>>  		}
>>  	} else {
>> -		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask)
>> =3D=3D -1) {
>> +		if (!S_ISDIR(sb.st_mode) || faccessat(AT_FDCWD,
>> path, mode_mask, AT_EACCESS) =3D=3D -1) {
>>  			ERR(sh,
>>  			    "Could not access module store at %s, or
>> it is not a directory.",
>>  			    path);
>> @@ -575,7 +575,7 @@ int semanage_create_store(semanage_handle_t * sh,
>> int create)
>>  			return -1;
>>  		}
>>  	} else {
>> -		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask)
>> =3D=3D -1) {
>> +		if (!S_ISDIR(sb.st_mode) || faccessat(AT_FDCWD,
>> path, mode_mask, AT_EACCESS) =3D=3D -1) {
>>  			ERR(sh,
>>  			    "Could not access module store active
>> subdirectory at %s, or it is not a directory.",
>>  			    path);
>> @@ -598,7 +598,7 @@ int semanage_create_store(semanage_handle_t * sh,
>> int create)
>>  			return -1;
>>  		}
>>  	} else {
>> -		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask)
>> =3D=3D -1) {
>> +		if (!S_ISDIR(sb.st_mode) || faccessat(AT_FDCWD,
>> path, mode_mask, AT_EACCESS) =3D=3D -1) {
>>  			ERR(sh,
>>  			    "Could not access module store active
>> modules subdirectory at %s, or it is not a directory.",
>>  			    path);
>> @@ -619,7 +619,7 @@ int semanage_create_store(semanage_handle_t * sh,
>> int create)
>>  			return -1;
>>  		}
>>  	} else {
>> -		if (!S_ISREG(sb.st_mode) || access(path, R_OK |
>> W_OK) =3D=3D -1) {
>> +		if (!S_ISREG(sb.st_mode) || faccessat(AT_FDCWD,
>> path, R_OK | W_OK, AT_EACCESS) =3D=3D -1) {
>>  			ERR(sh, "Could not access lock file at %s.",
>> path);
>>  			return -1;
>>  		}
>> @@ -639,7 +639,7 @@ int semanage_store_access_check(void)
>> =20
>>  	/* read access on active store */
>>  	path =3D semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);
>> -	if (access(path, R_OK | X_OK) !=3D 0)
>> +	if (faccessat(AT_FDCWD, path, R_OK | X_OK, AT_EACCESS) !=3D 0)
>>  		goto out;
>> =20
>>  	/* we can read the active store meaning it is managed
>> @@ -650,13 +650,13 @@ int semanage_store_access_check(void)
>>  	 * write access necessary if the lock file does not exist
>>  	 */
>>  	path =3D semanage_files[SEMANAGE_READ_LOCK];
>> -	if (access(path, R_OK) !=3D 0) {
>> +	if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS) !=3D 0) {
>>  		if (access(path, F_OK) =3D=3D 0) {
>>  			goto out;
>>  		}
>> =20
>>  		path =3D semanage_files[SEMANAGE_ROOT];
>> -		if (access(path, R_OK | W_OK | X_OK) !=3D 0) {
>> +		if (faccessat(AT_FDCWD, path, R_OK | W_OK | X_OK,
>> AT_EACCESS) !=3D 0) {
>>  			goto out;
>>  		}
>>  	}
>> @@ -666,7 +666,7 @@ int semanage_store_access_check(void)
>> =20
>>  	/* check the modules directory */
>>  	path =3D semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);
>> -	if (access(path, R_OK | W_OK | X_OK) !=3D 0)
>> +	if (faccessat(AT_FDCWD, path, R_OK | W_OK | X_OK,
>> AT_EACCESS) !=3D 0)
>>  		goto out;
>> =20
>>  	rc =3D SEMANAGE_CAN_WRITE;
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20


--=20
Petr Lautrbach



--SOmOS6CD09wnn5KC5ALdWUvxW3kQ68O5D--

--t524p5iIcIPjEIGP48QrGTtO13jG1E9WO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6FPBhIsBhc9Chk3zY6itS5gsQ3MFAlitsoMACgkQY6itS5gs
Q3PW0A/8DvAuUVuGnKiZptqOdjTUrqOi39YtPyC5ZF0Mr4f/Ah2n8vkXkRjeUh0b
BRysHJNRzOoYCN7O/nDTLkV3zTTMWDhNBiuoE/4EBY9AaY+5mJ4BDxKdd/qyrcmc
8q244qeNVh+cVN0nkXuHhpEgkMZwJpCuAEN53m86xUPlGDO9EEbDj4upNrwGQV2E
R7OwjPZhncUp7TVafMFyBHUayx/HuZKe36ZqsfT/1V9zHRuuL0/f4JaQWf30AAHc
qM0YS9/L4QOngz5Mw6t9E169ioHKZ90mk+ajwLB3p8H7+JpDthpnFPPtm3SmPwCT
yurYFdV44O5hzfJ0wrW8rQV7rU/psx7bvWcYuTS2gsAQKXxZErWu1wVwI0rpZOaR
It6rXtkAzuVWYhFJnnD24hJML4zN8iIn4kmNPVg1NKTUOVZOmV8A+5kAL/p/7HaV
I3k2C6hXrE+G6UjJJan7fWZucvZS1rCu3/OQ5MnD+TbjF2KNCXRBpZtdk7E1weaN
hunms4Wp1XHRcjbhqLACMNpyBoveS/w6KIq9KZ9hLSj7XBMZHVovQzECkCOQJNfO
cfnZ7jFo89Wyc6aSDO8gJNNa1wT2jic9apRDMbDkJPJg8wzVyL09Lx3xX8JTyvVE
4BPiSgtYqdk5XJh12a1SudQA/JNmerZ4V3biyRrJb7bUyXHLWhA=
=T59R
-----END PGP SIGNATURE-----

--t524p5iIcIPjEIGP48QrGTtO13jG1E9WO--
