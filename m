Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EIp0fT004141
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 14:51:00 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7EIp0BU015271
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 18:51:00 GMT
Message-ID: <48A47E44.70400@redhat.com>
Date: Thu, 14 Aug 2008 14:49:40 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: services apcupsd.patch
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

http://people.fedoraproject.org/~dwalsh/SELinux/F10/services_apcupsd.patch

Talks to all terminals when the system is running low on power.

Send mail from tmpdir.

Fix name of cgi domtrans script
`apcupsd_cgi_script_domtrans
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkikfkQACgkQrlYvE4MpobMIIgCeJHqh+QzQ0w4A/xb0WS+TeFXC
M8EAn23DN9Pory8DNs1g2MLDROifKmaq
=ycHS
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
