Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GF9h0h019753
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 11:09:43 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GF9hXE029271
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 15:09:43 GMT
Message-ID: <487E0F35.6050304@redhat.com>
Date: Wed, 16 Jul 2008 11:09:41 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: I have just uploaded 166 patch files for each domain that has a difference
 between refpolicy and fedora policy.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

These represent most of the differences that make up a 36802 line patch
I apply to Ref Policy in Rawhide.

Chris and I can not manage the changes and we really need help from
people to go through the changes and Ack whether the change is valid or
needs more work.

A lot of these changes are no brainers,  but need to be split out from
the patches that we don't have agreement on.

A large amount of the changes will hopefully disappear when Chris drops
 prefix based homedir file context.

http://people.fedoraproject.org/~dwalsh/SELinux/Policy/

Other distributions are not getting advantage of the fixes in the Fedora
policy.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkh+DzQACgkQrlYvE4MpobOTvACg2lEAza7VTki+MOjN1Aq5sNri
aBQAoK3ghWILCaf3vaT9qQCFGdXKQynb
=G+M1
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
