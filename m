Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RFot8P029428
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:50:55 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q2RFosQa027443
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 11:50:54 -0400
Message-ID: <4F71E1DD.4040803@redhat.com>
Date: Tue, 27 Mar 2012 11:50:53 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 43/73] libselinux: avc_netlink_recieve handle EINTR FIXME
Content-Type: multipart/mixed;
 boundary="------------010008060000000307090206"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010008060000000307090206
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


   This patch looks good to me. acked.

I think we should do this rather then have applications like dbus
randomly crash, and people not notice it for years.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9x4d0ACgkQrlYvE4MpobMo3QCgqaLM8fRuIgAu/4T6VgsZEppA
ipcAoKLspjezOWW4H2NT8mjcm2UbOuCg
=pAU/
-----END PGP SIGNATURE-----

--------------010008060000000307090206
Content-Type: text/x-patch;
 name="0043-libselinux-avc_netlink_recieve-handle-EINTR-FIXME.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0043-libselinux-avc_netlink_recieve-handle-EINTR-FIXME.patch"


--------------010008060000000307090206--
