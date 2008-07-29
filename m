Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6TElJn8008698
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 10:47:19 -0400
Received: from QMTA07.emeryville.ca.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6TElIXf002101
	for <selinux@tycho.nsa.gov>; Tue, 29 Jul 2008 14:47:18 GMT
Subject: Re: [refpolicy patch, second try] samba policy updates
From: Chris PeBenito <pebenito@gentoo.org>
To: Mike Edenfield <kutulu@kutulu.org>
Cc: SELinux Mailing List <selinux@tycho.nsa.gov>
In-Reply-To: <488DED3A.1030005@kutulu.org>
References: <488DED3A.1030005@kutulu.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xCyGZtigaigV1BHuD6bG"
Date: Tue, 29 Jul 2008 10:47:03 -0400
Message-Id: <1217342823.4934.42.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-xCyGZtigaigV1BHuD6bG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-07-28 at 12:00 -0400, Mike Edenfield wrote:
> +tunable_policy(`samba_create_home_dirs',`
> +	ifdef(`distro_redhat', `
> +		refpolicywarn(`Use of samba_create_home_dirs is discouraged.  Please u=
se pam_oddjob_mkhomedir instead.')
> +	', `
> +		unprivuser_create_home_dirs(smbd_t)
> +		allow smbd_t self:capability chown;
> +	')
> +')

I don't think this has the effect that you're trying to get.  The ifdef
is resolved during build time, and the tunable is resolved at runtime.
So the warning message won't do any good for most redhat users (and it
leaves them with a noop samba_create_home_dirs tunable).

> +interface(`unprivuser_create_home_dirs',`
> +       unprivuser_home_filetrans_home_dir($1)
> +       unprivuser_manage_home_dirs($1)
> +')

"Create" just means directory create, but you have the full manage
permission set, in addition to a filetrans.

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-xCyGZtigaigV1BHuD6bG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiPLWcACgkQvI7kLeavkkP9zgCdFs/9bwT/yEKlFWxsMNX9dioV
jpAAnjBD9C/HAnye0+SpL0e3PmumzM2R
=elzl
-----END PGP SIGNATURE-----

--=-xCyGZtigaigV1BHuD6bG--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
