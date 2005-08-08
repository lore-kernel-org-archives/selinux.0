Subject: Re: Category Translation patch for MCS/MLS Policy
From: Colin Walters <walters@verbum.org>
To: Daniel J Walsh <Dan-Walsh@comcast.net>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <42F38DA8.4090300@comcast.net>
References: <42F38DA8.4090300@comcast.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/OnwdduNv5XVMFJbFIQt"
Date: Mon, 08 Aug 2005 14:17:07 -0400
Message-Id: <1123525027.636.9.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/OnwdduNv5XVMFJbFIQt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-08-05 at 12:02 -0400, Daniel J Walsh wrote:
> I have written up a patch for libselinux to implement two functions, to=20
> translate the security level.

To namespace these a bit more strongly (and make them easier to read),
perhaps something like:

> getselevelbyname

selinux_get_level_by_name

> getselevelbysename

selinux_get_level_by_sename  (there may be a better name here, not sure)

> setransconlevel

selinux_translate_level

> typedef struct selevel {

Perhaps struct selinux_category/selinux_category_t?



--=-/OnwdduNv5XVMFJbFIQt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBC96GjOIkJWWp2WGURAq0xAJ9RHqPl5jBPWR5Wc8oiBX/IhtrxLwCeIML8
jnk2sSeGp2eNBs8PxV2Rhck=
=2d8o
-----END PGP SIGNATURE-----

--=-/OnwdduNv5XVMFJbFIQt--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
