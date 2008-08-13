Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7DJcUTM025554
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2008 15:38:30 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7DJcTaC021918
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2008 19:38:29 GMT
Message-ID: <48A337D3.40006@redhat.com>
Date: Wed, 13 Aug 2008 15:36:51 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: system_libraries.patch
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lots of fixes for textrel_shlib_t

Fixes for running ldconfig in post install scripts, kernel builds and
other random locations.

http://people.fedoraproject.org/~dwalsh/SELinux/F10/system_libraries.patch


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkijN9MACgkQrlYvE4MpobM4BwCfd93/0YnNDY1ht3RbmH2LD22C
hVgAoNMJWVbW3wkqxk4F7niqpsvqThUM
=De7X
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
