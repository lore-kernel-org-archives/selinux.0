Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OFD5Lu001144
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:13:05 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OFD37K021965
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 11:13:03 -0400
Message-ID: <526938FF.8030500@redhat.com>
Date: Thu, 24 Oct 2013 11:13:03 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 74/74] Make RANLIB variable overridable
Content-Type: multipart/mixed;
 boundary="------------010901050301080704010504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010901050301080704010504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpOP4ACgkQrlYvE4MpobM4dACdFXc+tPh2XkTpKyswWQP/2Y+2
yZMAoOF8ujRMIE/aIcM4wooGsud2lVZU
=FW/M
-----END PGP SIGNATURE-----

--------------010901050301080704010504
Content-Type: text/x-patch;
 name="0074-Make-RANLIB-variable-overridable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0074-Make-RANLIB-variable-overridable.patch"


--------------010901050301080704010504--
