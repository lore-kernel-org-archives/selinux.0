Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q51J3GmW014775
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:03:20 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q51J3IC9028195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2012 15:03:18 -0400
Message-ID: <4FC911F6.8090806@redhat.com>
Date: Fri, 01 Jun 2012 15:03:18 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 17/90] libselinux: avc_netlink_recieve handle EINTR FIXME
Content-Type: multipart/mixed;
 boundary="------------080401070204030409040008"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080401070204030409040008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.


This was a major bug within dbus that was causing dbus to crash it was
discussed at the time whether this is a dbus bug or an libselinux bug, it was
decided that we should fix it within libselinux.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEUEARECAAYFAk/JEfUACgkQrlYvE4MpobNG/QCVFieKpp8JMXD9tdK/73i3d1i/
7ACeNooL9KhVL+c2ocxaFGJLXJ81Yr4=
=PmSa
-----END PGP SIGNATURE-----

--------------080401070204030409040008
Content-Type: text/x-patch;
 name="0017-libselinux-avc_netlink_recieve-handle-EINTR-FIXME.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0017-libselinux-avc_netlink_recieve-handle-EINTR-FIXME.patch"


--------------080401070204030409040008--
