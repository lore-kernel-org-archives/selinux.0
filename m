Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2OMJGRb011581
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 17:19:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2OMJFFV028124
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 22:19:15 GMT
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
        by jazzband.ncsc.mil  with ESMTP id i2OMJF36028120 for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 22:19:15 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i2OMJFWA031336
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 17:19:15 -0500
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.64.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id i2OMJEj28521
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 17:19:14 -0500
Received: from nexus.verbum.private (nexus.boston.redhat.com [172.16.67.53])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id i2OMJEhP029361
	for <selinux@tycho.nsa.gov>; Wed, 24 Mar 2004 17:19:14 -0500
Subject: minor logwatch avc denial fix
From: Colin Walters <walters@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vPSfvA09na3ZDH4sc7JG"
Message-Id: <1080166618.19992.80.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Wed, 24 Mar 2004 17:16:58 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vPSfvA09na3ZDH4sc7JG
Content-Type: multipart/mixed; boundary="=-RjML8QYK+FubqPPX5OyX"


--=-RjML8QYK+FubqPPX5OyX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Saw this avc message in dmesg:

audit(1080814317.301:0): avc:  denied  { getattr } for  pid=3D1874 exe=3D/b=
in/df name=3D/ dev=3D ino=3D2025 scontext=3Dsystem_u:system_r:system_crond_=
t tcontext=3Dsystem_u:object_r:rpc_pipefs_t tclass=3Dfilesystem

Looks like this came from /etc/cron.d/00-logwatch.  This patch should
fix it.

--=-RjML8QYK+FubqPPX5OyX
Content-Disposition: attachment; filename=crond-macros.patch
Content-Type: text/x-patch; name=crond-macros.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHBvbGljeS0xLjkvbWFjcm9zL3Byb2dyYW0vY3JvbmRfbWFjcm9zLnRlfgkyMDA0LTAzLTI0
IDE1OjQyOjA0Ljk4ODI2ODk3NiAtMDUwMA0KKysrIHBvbGljeS0xLjkvbWFjcm9zL3Byb2dyYW0v
Y3JvbmRfbWFjcm9zLnRlCTIwMDQtMDMtMjQgMTU6NDg6NTEuNDgyNDcyNDY0IC0wNTAwDQpAQCAt
NzgsNyArNzgsNyBAQA0KIGFsbG93ICQxX2Nyb25kX3QgeyBzeXNjdGxfdCBzeXNjdGxfa2VybmVs
X3QgfTpkaXIgc2VhcmNoOw0KIGFsbG93ICQxX2Nyb25kX3Qgc3lzY3RsX2tlcm5lbF90OmZpbGUg
eyBnZXRhdHRyIHJlYWQgfTsNCiBhbGxvdyAkMV9jcm9uZF90IHZhcl9zcG9vbF90OmRpciBzZWFy
Y2g7DQotYWxsb3cgJDFfY3JvbmRfdCBmc190OmZpbGVzeXN0ZW0gZ2V0YXR0cjsNCithbGxvdyAk
MV9jcm9uZF90IGZzX3R5cGU6ZmlsZXN5c3RlbSBnZXRhdHRyOw0KIA0KIGFsbG93ICQxX2Nyb25k
X3QgeyBpbml0cmNfZGV2cHRzX3QgZGV2dHR5X3R9OmNocl9maWxlIHsgcmVhZCB3cml0ZSB9Ow0K
IGFsbG93ICQxX2Nyb25kX3QgdmFyX3Q6ZGlyIHsgZ2V0YXR0ciBzZWFyY2ggfTsNCg==

--=-RjML8QYK+FubqPPX5OyX--

--=-vPSfvA09na3ZDH4sc7JG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAYgjaOIkJWWp2WGURAu2HAJ4hE/AAaTrJWCSjO+EYq+CeuSK7FgCeOP7c
HkY9kU8tjz66apx9icvjOyI=
=VZ/v
-----END PGP SIGNATURE-----

--=-vPSfvA09na3ZDH4sc7JG--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
