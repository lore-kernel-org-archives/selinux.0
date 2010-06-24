Message-ID: <4C238465.60104@gmail.com>
Date: Thu, 24 Jun 2010 18:14:29 +0200
From: Dominick Grift <domg472@gmail.com>
MIME-Version: 1.0
To: Alice Mynona <alice_mynona@bian-fu.net>
CC: SELinux@tycho.nsa.gov
Subject: Re: Developing a SELinux policy for antivirus - Activating a boolean
 variable when another has been actived
References: <4C237345.2010200@bian-fu.net>
In-Reply-To: <4C237345.2010200@bian-fu.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFFFC48FA0F0B299469FEB8E1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFFFC48FA0F0B299469FEB8E1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/24/2010 05:01 PM, Alice Mynona wrote:
> I have also taken a look at "file_contexts" (cd
/etc/selinux/targeted/modules/active && grep antivirus_t
file_contexts*), but there's no "antivirus_t" anymore.

antivirus_t is defined a domain type so you wont find it in the list of
file contexts because those are file types.

does sesearch --allow -s antivirus_t return anything or sesearch --allow
-t antivirus_t?

and:

semanage fcontext -l | grep antivirus

and

semodule -l | grep antivirus


--------------enigFFFC48FA0F0B299469FEB8E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkwjhGsACgkQMlxVo39jgT+FBQCfXLCrY7Xqrhz3IFIpdvO9gre+
ddgAoIHw0VpC+eicjMoJZ76d9B9nhPPN
=SX4z
-----END PGP SIGNATURE-----

--------------enigFFFC48FA0F0B299469FEB8E1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
