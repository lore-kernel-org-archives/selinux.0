Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0I7pNS2016924
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 02:51:23 -0500
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0I7pM1a020328
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2008 07:51:22 GMT
To: selinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Subject: 2.6.24-rc8-mm1 and SELinux MLS - not playing nice....
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1200642661_2998P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 18 Jan 2008 02:51:01 -0500
Message-ID: <15439.1200642661@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1200642661_2998P
Content-Type: text/plain; charset=us-ascii

Posting to both lists because I'm not sure who's at fault here....

System is a Dell Latitude D820, x86_64 kernel, userspace is basically
Fedora Rawhide as of earlier today, in particular selinux-policy-mls-3.2.5-12.fc9

Trying to boot a 2.6.24-rc8-mm1 kernel gets me these msgs:

security:  5 users, 8 roles, 2043 types, 102 bools, 16 sens, 1024 cats
security:  67 classes, 164754 rules
security:  class peer not defined in policy
security:  permission recvfrom in class node not defined in policy
security:  permission sendto in class node not defined in policy
security:  permission ingress in class netif not defined in policy
security:  permission egress in class netif not defined in policy
security:  permission forward_in in class packet not found in policy, bad policy
security:  the definition of a class is incorrect

2.6.24-rc6-mm1 said this instead:

security:  class peer not defined in policy
security:  permission recvfrom in class node not defined in policy
security:  permission sendto in class node not defined in policy
security:  permission ingress in class netif not defined in policy
security:  permission egress in class netif not defined in policy
SELinux: policy loaded with handle_unknown=deny

and then proceeded to work OK.

(I suspect this may be the same thing Andrew Morton hit, but I can't be sure).

Anybody got hints on how to move forward?  Or is a fixed policy already in the
Rawhide pipe?


--==_Exmh_1200642661_2998P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFHkFplcC3lWbTT17ARApd+AJwL3s9qYABWRvxwVYQWc8wumLga9QCeNZZF
QrwwXkZgovIsIiBuq0KwBwk=
=qX86
-----END PGP SIGNATURE-----

--==_Exmh_1200642661_2998P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
