Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p51DfMfx012227
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 09:41:22 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p51DfLVT023282
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 13:41:22 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p51DfLJh013830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 09:41:21 -0400
Received: from localhost.localdomain (vpn-9-247.rdu.redhat.com [10.11.9.247])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p51DfK83014709
	for <selinux@tycho.nsa.gov>; Wed, 1 Jun 2011 09:41:20 -0400
Message-ID: <4DE64180.50302@redhat.com>
Date: Wed, 01 Jun 2011 09:41:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Can we eliminate or optimize nodups_specs within libselinux
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We are costing boot 1.5s

https://bugzilla.redhat.com/show_bug.cgi?id=709014
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3mQX8ACgkQrlYvE4MpobPXQQCeI/tBMC9RFJ1hH8/5hRoX2axs
NQAAmweIx78ux8VIa+/T4oX03MLJAhi1
=4Xh4
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
