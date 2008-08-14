Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EKGLNT026886
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 16:16:21 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7EKGLkh016268
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 20:16:21 GMT
Message-ID: <48A49244.4040909@redhat.com>
Date: Thu, 14 Aug 2008 16:15:00 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Fixes to services_ppp
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

http://people.fedoraproject.org/~dwalsh/SELinux/F10/services_ppp.patch


ppp now uses dbus


Needs to rw net sysctls

Calls kill


Emails ppp_etc_t and ppp_etc_rw_t

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkikkkQACgkQrlYvE4MpobP/ygCfWv+bMopKRNh6vMMs5pGbo5OD
FKkAoMqZi8OEU+FcX8BbukeLFG0UwxRW
=ROPh
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
