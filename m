Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i59GwArT020950
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 12:58:10 -0400 (EDT)
Received: from rwcrmhc12.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i59Gw3Qd003922
	for <selinux@tycho.nsa.gov>; Wed, 9 Jun 2004 12:58:08 -0400 (EDT)
Subject: too many sysadmfile?
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-y5++qA8vIyU+FdUQYJRq"
Message-Id: <1086800282.19414.26.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Wed, 09 Jun 2004 11:58:03 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-y5++qA8vIyU+FdUQYJRq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

One thing that hasn't sat well with me for a long time is that just
about all file_types are sysadmfile in the strict policy.  To me, this
sounds like an excessive amount of access for sysadm_t (with exception
of the unrestricted_admin tunable being on).

Its true that since sysadm_t can already relabel almost everything, it
makes this change moot from a security perspective, since it can relabel
a file to something it can modify.  However, by limiting normal access,
it affords some protection against accidental overwrites and deletions,
and from malicious programs a sysadmin might accidentally run.  In my
opinion, the packagers (rpm_t, etc) should be the only ones with access
all file_types.

I haven't looked into it much, but my idea is eliminate sysadmfile
except where its obviously warranted, such as in /etc/* types.  Then
change the sysadmfile policy in admin_domain to something like:

ifdef(`unrestricted_admin',`
create_dir_notdevfile($1_t,{ file_type -device_type -shadow_t })
',`
create_dir_notdevfile($1_t,sysadmfile)
')

Or maybe use a boolean could be used, instead of a tunable.  Then change
the relabeling rule to:

# Relabel all files except shadow_t.
allow $1_t { file_type -shadow_t }:dir { getattr read search relabelfrom re=
labelto };
allow $1_t { file_type -shadow_t }:file_class_set { getattr relabelfrom rel=
abelto };

Comments?

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-y5++qA8vIyU+FdUQYJRq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAx0GavI7kLeavkkMRAv6hAJ9foveelBrE2BIK9CQeiPLO3mNfRwCfbx5c
B5P7SAnM1jKkW/uzGDM3ioI=
=q1u4
-----END PGP SIGNATURE-----

--=-y5++qA8vIyU+FdUQYJRq--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
