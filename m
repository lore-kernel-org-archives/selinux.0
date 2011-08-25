Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7PG0Bcm016825
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 12:00:16 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p7PG0FPm024191
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 16:00:16 GMT
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p7PG0Fvo026256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 12:00:15 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p7PG0Eip025709
	for <selinux@tycho.nsa.gov>; Thu, 25 Aug 2011 12:00:15 -0400
Message-ID: <4E56718E.5040305@redhat.com>
Date: Thu, 25 Aug 2011 12:00:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: We have an interesting problem with pam_namespace on mls boxes
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

We want to be able to create a new directory at different levels when
a user logs in.  The first time  user logs in at s2 on an mls box
without a namespaced homedir, pam_namespace would create the s2
directory and mount it over ~/.  Currently we also execute a script to
copy the files from /etc/skell onto the newly created homedir and then
run restorecon on the content to make sure everything has the correct
types.  BUT this hammers the MLS Levels and sets everything as s0.
Not what we want.

1 We can either turn the restorecon off for mls boxes, which will
create files with the wrong types,

2 Not copy /etc/skel, which will eliminate functionality.

3 Change restorecon to not change the Level unless you specify -F.
Meaning restorecon will only change the USER/ROLE/TYPE.

4 Hack up the script to use matchpatcon/secon/chcon -t to fix the
types of files created.

Any way we go we still end up with a potential problem in that a user
admin running restorecon on a file could lower the level of the data
to s0, accidentally.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5WcY4ACgkQrlYvE4MpobMTlwCeNDyvfpV8GO8TAODiTLfT0hbi
g4QAnjwlCzkQlvjzXXf85EhU58o78h96
=egdc
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
