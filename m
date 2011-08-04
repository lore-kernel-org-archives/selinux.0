Message-ID: <4E3AA12C.9000704@cendio.se>
Date: Thu, 04 Aug 2011 15:39:56 +0200
From: Aaron Sowry <aaron@cendio.se>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov
Subject: Re: SELinux policy regarding LD_LIBRARY_PATH
References: <4E3A8D16.7060807@cendio.se> <1312463365.20973.21.camel@moss-pluto>
In-Reply-To: <1312463365.20973.21.camel@moss-pluto>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC8C4B5DF0E1381B78A5B94DD"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8C4B5DF0E1381B78A5B94DD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> However, the behavior you are seeing might not be related to SELinux, a=
s
> Linux also enables AT_SECURE if the uid or gid changes across execve (t=
o
> be precise, if the effective identity is not equal to the real identity=

> after the credential change, as this was the legacy logic from libc).

So if I understand correctly, SELinux expands on AT_SECURE to sanitize
environment variables across context changes instead of just
setgid/setuid. Makes sense; you live and learn.

In this case I believe it was SELinux performing the sanitization as
disabling it solved the problem, but this is helpful to know.

/Aaron


--------------enigC8C4B5DF0E1381B78A5B94DD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOOqEvAAoJECw8YUUfeQL9vtsH/3ZeCk4y4ECQV0fU6vRw8TUJ
oE93D0WeWttfV9nY+cUdrIS4M+OYHjTKXyu4YpNkOVRZLJrgjylbHJQyflOMNtJ3
rXiB/xYhXeEpZ7CRzvaAsN40XuStRiU7zk12kmgj2Cn4zjrs+9wsveDTHii4zlNA
vwt1kHBF05ajoA9KNxPvyTzQFsvRd0RkB++4NZzQX5zvKigINr1KNU5g8FCLaur/
lMBNUkxpS+/7rpju3ij1jwcegs5rtwnWNLu/zjVvBMrGDMt91WZsLy4DVx458h2+
vegFlWuultbWWOXgD5tzzVWORWymw9cJw1FY3VGG1nbywE17R0NhoyIry166ma8=
=qsJl
-----END PGP SIGNATURE-----

--------------enigC8C4B5DF0E1381B78A5B94DD--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
