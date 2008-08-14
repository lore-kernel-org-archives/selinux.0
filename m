Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EIfetw001973
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 14:41:40 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7EIfP3C001576
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 18:41:25 GMT
Message-ID: <48A47C08.9020205@redhat.com>
Date: Thu, 14 Aug 2008 14:40:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Updated fail2ban patch
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

http://people.fedoraproject.org/~dwalsh/SELinux/F10/services_fail2ban.patch

File context change for server name, now uses sock file

Connects to the whois port,

Uses nsswitch

Sends mail

execs gamin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkikfAgACgkQrlYvE4MpobNXXgCgiZ8yF+fQvqXRwdJkPDVCizSn
FOgAn2yQ1yPw9Z4NTyUZQo6zvDzR/n6y
=8gER
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
