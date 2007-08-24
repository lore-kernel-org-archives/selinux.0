Message-ID: <46CED283.8060804@redhat.com>
Date: Fri, 24 Aug 2007 08:43:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: I am concerned about putting genhomedircon changes in libsemanage
 into Fedora 8.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I may hold off on this so we can get a full Rawhide cycle on it.
genhomedircon has many corner cases and do not want to risk blowing F-8
now that we are at Feature Freeze.
All the rest of the patches have been integrated.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFGztKCrlYvE4MpobMRAjjPAKCPcYgyrJRjqxx06ppqxLxxuWGqnwCeJOLU
eTMWKakqHN5ZNehfgn27tI8=
=3qy6
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
