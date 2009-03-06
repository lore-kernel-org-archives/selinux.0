Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n26Fofbu018709
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 10:50:41 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n26Fl2nl023371
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 15:47:03 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n26FoZKw005758
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 10:50:35 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n26FoZoe011079
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 10:50:35 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n26FoYx4031288
	for <selinux@tycho.nsa.gov>; Fri, 6 Mar 2009 10:50:34 -0500
Message-ID: <49B1464A.6020606@redhat.com>
Date: Fri, 06 Mar 2009 10:50:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: I have not used the selabel interface replacement for matchpathcon,
 that much
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Is there an equivalent to this?

The question we are getting is can we speed up the execution of
restorecon in boot.

restorecon /etc/resolv.conf

should only search prefix /etc.

Dan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkmxRkoACgkQrlYvE4MpobNXbgCgiSb4G0WbfIEmcJg0Je5gg6kE
qgsAn1pYASksoT1CZg9fK6l/XeND45cJ
=EF7P
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
