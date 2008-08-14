Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7EIQkbk031016
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 14:26:46 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7EIQkBU008200
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 18:26:46 GMT
Message-ID: <48A47896.3080109@redhat.com>
Date: Thu, 14 Aug 2008 14:25:26 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Missing interface for courier
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

http://people.fedoraproject.org/~dwalsh/SELinux/F10/services_courier.patch

New interface defines executables that are mailers and then
mta_send_mail will transition execs to system_mail_t

Snuck in changing mqueue_spool_t and mail_spool_t to mountpoints since
people tend to mount large disks on these mountpoints.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkikeJYACgkQrlYvE4MpobNqKwCfckhtF89FlI1en8dp7nmQtDw+
wdgAnRG8YixvIPuzKOikfsgCU6iW0W1M
=6CN9
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
