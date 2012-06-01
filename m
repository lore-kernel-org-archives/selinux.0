Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51J7QW6015105
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:07:26 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51J7OxR022010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:07:24 -0400
Message-ID: <4FC912EC.1070303@redhat.com>
Date: Fri, 01 Jun 2012 15:07:24 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 42/90] policycoreutils: FIXME add .tx to gitignore
Content-Type: multipart/mixed;
 boundary="------------080800020403060407080400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080800020403060407080400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

.tx is the transifex configuration directory which is used to pull the latest
translations from the transifex web site.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/JEuwACgkQrlYvE4MpobNHuACgnG5GYfCyf8oFvSkqP3Rt1vOs
vKkAnRkhDlOfaXJhGc2AXIq2UPk3ln/9
=+OVl
-----END PGP SIGNATURE-----

--------------080800020403060407080400
Content-Type: text/x-patch;
 name="0042-policycoreutils-FIXME-add-.tx-to-gitignore.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0042-policycoreutils-FIXME-add-.tx-to-gitignore.patch"


--------------080800020403060407080400--
