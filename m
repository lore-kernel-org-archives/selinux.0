Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFNXov026437
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:23:33 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFNWt9006418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:23:33 -0400
Message-ID: <4F71DB74.8040708@redhat.com>
Date: Tue, 27 Mar 2012 11:23:32 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 37/73] policycoreutils: scripts: Don't syslog setfiles
Content-Type: multipart/mixed;
 boundary="------------010903030700080401060003"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010903030700080401060003
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.


Fixfiles restore is called by auditrelabel, and was happening early in
the boot process, before the syslog system was up and running.  A bug
in systemd was causing relabels to take forever, while it waited for
the syslog's to complete.  This was fixed, but I still see no reason
to write thousands/millions of lines to syslog on a badly mislabled
machine and wanted this featured turned off.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x23QACgkQrlYvE4MpobPeRACcCIiLS39ofYOpGkVIFGNVCd8w
QMEAn2s7OKGHzTfwHXeBdvmCVvbvvonN
=J6K0
-----END PGP SIGNATURE-----

--------------010903030700080401060003
Content-Type: text/x-patch;
 name="0037-policycoreutils-scripts-Don-t-syslog-setfiles-change.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0037-policycoreutils-scripts-Don-t-syslog-setfiles-change.pa";
 filename*1="tch"


--------------010903030700080401060003--
