Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p0CIalAv016630
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2011 13:36:47 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p0CIako0001721
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2011 18:36:46 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id p0CIaj6X016939
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2011 13:36:45 -0500
Received: from localhost.localdomain (vpn-11-132.rdu.redhat.com [10.11.11.132])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0CIaiLG015056
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2011 13:36:45 -0500
Message-ID: <4D2DF4BC.1030004@redhat.com>
Date: Wed, 12 Jan 2011 13:36:44 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: SELinux Policy compiler doesn't like leading numbers in fs names
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

https://bugzilla.redhat.com/show_bug.cgi?id=668871

Is there any logical reason for this or is this just a bug?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0t9LwACgkQrlYvE4MpobOnqACg4Hj22Ioqgopb96HTvJ0ZkrmO
02gAnAlpIDBLjSTQkoOvah/S535YePCM
=65GT
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
