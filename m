Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBR3IARb006491
	for <selinux@tycho.nsa.gov>; Fri, 26 Dec 2003 22:18:10 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBR3I97m008381
	for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2003 03:18:09 GMT
Received: from chris.pebenito.dhs.org (c-24-15-24-15.client.comcast.net [24.15.24.15])
        by jazzband.ncsc.mil  with ESMTP id hBR3I8LC008378 for <selinux@tycho.nsa.gov>; Sat, 27 Dec 2003 03:18:08 GMT
Subject: [patch] etc type naming
From: Chris PeBenito <pebenito@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: Russell Coker <russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nGn4z1auIb0PxVRsUQjr"
Message-Id: <1072495081.4439.9.camel@chris.pebenito.net>
Mime-Version: 1.0
Date: Fri, 26 Dec 2003 21:18:02 -0600
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-nGn4z1auIb0PxVRsUQjr
Content-Type: multipart/mixed; boundary="=-3cvq04mIlHstx0TJDpIZ"


--=-3cvq04mIlHstx0TJDpIZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Attached is a hefty patch to change almost all of the etc type names to
be consistent with the rest of the policy naming.  Namely, the
daemon/program is prefixed.

ex: etc_cupsd_t -> cupsd_etc_t

I have successfully compiled the entire example policy after applying
the patch, but it probably should be doublechecked.  I left a few types
as is, since they're generic:

etc_aliases_t
etc_mail_t
etc_runtime_t

Openca has a pair of weird types that should probably be changed, but I
left them for now:

openca_etc_in_t
openca_etc_writeable_t


 domains/program/getty.te             |    4 ++--
 domains/program/unused/authbind.te   |    6 +++---
 domains/program/unused/bootloader.te |    6 +++---
 domains/program/unused/courier.te    |    8 ++++----
 domains/program/unused/cups.te       |   16 ++++++++--------
 domains/program/unused/ddt-client.te |    4 ++--
 domains/program/unused/devfsd.te     |    6 +++---
 domains/program/unused/dhcpc.te      |    6 +++---
 domains/program/unused/dhcpd.te      |    6 +++---
 domains/program/unused/dictd.te      |    4 ++--
 domains/program/unused/dpkg.te       |   20 ++++++++++----------
 domains/program/unused/fingerd.te    |    4 ++--
 domains/program/unused/ftpd.te       |    4 ++--
 domains/program/unused/gatekeeper.te |    4 ++--
 domains/program/unused/hotplug.te    |    8 ++++----
 domains/program/unused/ircd.te       |    4 ++--
 domains/program/unused/mrtg.te       |   10 +++++-----
 domains/program/unused/mysqld.te     |    6 +++---
 domains/program/unused/nessusd.te    |    4 ++--
 domains/program/unused/netsaint.te   |   12 ++++++------
 domains/program/unused/ntpd.te       |    6 +++---
 domains/program/unused/perdition.te  |    6 +++---
 domains/program/unused/postfix.te    |   10 +++++-----
 domains/program/unused/postgresql.te |    4 ++--
 domains/program/unused/pppd.te       |    4 ++--
 domains/program/unused/qmail.te      |   10 +++++-----
 domains/program/unused/radius.te     |    6 +++---
 domains/program/unused/radvd.te      |    4 ++--
 domains/program/unused/slapd.te      |    6 +++---
 domains/program/unused/snmpd.te      |    4 ++--
 domains/program/unused/usbmodules.te |    2 +-
 domains/program/unused/xdm.te        |    8 ++++----
 file_contexts/program/authbind.fc    |    2 +-
 file_contexts/program/bootloader.fc  |    2 +-
 file_contexts/program/courier.fc     |    4 ++--
 file_contexts/program/cups.fc        |   18 +++++++++---------
 file_contexts/program/ddt-client.fc  |    2 +-
 file_contexts/program/devfsd.fc      |    2 +-
 file_contexts/program/dhcpc.fc       |    6 +++---
 file_contexts/program/dhcpd.fc       |    4 ++--
 file_contexts/program/dictd.fc       |    2 +-
 file_contexts/program/dpkg.fc        |    6 +++---
 file_contexts/program/fingerd.fc     |    2 +-
 file_contexts/program/ftpd.fc        |    2 +-
 file_contexts/program/gatekeeper.fc  |    2 +-
 file_contexts/program/getty.fc       |    2 +-
 file_contexts/program/hotplug.fc     |    2 +-
 file_contexts/program/ircd.fc        |    2 +-
 file_contexts/program/mrtg.fc        |    2 +-
 file_contexts/program/mysqld.fc      |    4 ++--
 file_contexts/program/nessusd.fc     |    2 +-
 file_contexts/program/netsaint.fc    |    2 +-
 file_contexts/program/ntpd.fc        |    2 +-
 file_contexts/program/perdition.fc   |    2 +-
 file_contexts/program/postfix.fc     |    2 +-
 file_contexts/program/postgresql.fc  |    2 +-
 file_contexts/program/qmail.fc       |    4 ++--
 file_contexts/program/radius.fc      |    2 +-
 file_contexts/program/radvd.fc       |    2 +-
 file_contexts/program/slapd.fc       |    2 +-
 file_contexts/program/snmpd.fc       |    2 +-
 file_contexts/program/xdm.fc         |    2 +-
 macros/program/lpr_macros.te         |    2 +-
 macros/program/mta_macros.te         |    4 ++--
 macros/user_macros.te                |    2 +-
 65 files changed, 156 insertions(+), 156 deletions(-)

c5593874ff9319c4a626c792cd5a463d  policy-1.4-etc_t_name_consistency.diff.gz

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

--=-3cvq04mIlHstx0TJDpIZ
Content-Disposition: attachment; filename=policy-1.4-etc_t_name_consistency.diff.gz
Content-Type: application/x-gzip; name=policy-1.4-etc_t_name_consistency.diff.gz
Content-Transfer-Encoding: base64

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

--=-3cvq04mIlHstx0TJDpIZ--

--=-nGn4z1auIb0PxVRsUQjr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/7PnpvI7kLeavkkMRAqcIAJ0f+eTlZkRkVAfRMbkJijetUi84pACfRT/E
ATAJmzqR+C99fuoCxfuu34E=
=ZVBO
-----END PGP SIGNATURE-----

--=-nGn4z1auIb0PxVRsUQjr--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
