Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA5GqLVu028707
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2012 11:52:21 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qA5GpgOd029816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2012 11:51:43 -0500
Received: from [10.16.60.53] (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id qA5GpfV3029815
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2012 11:51:42 -0500
Message-ID: <5097EE9C.6020104@redhat.com>
Date: Mon, 05 Nov 2012 11:51:40 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: With systemd taking care of starting services, is there any reason
 to continue to ship run_init?
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

systemctl start SERVICE

Will start the service cleanly as the correct context, I want to remove this
command from systemd enabled systems.  Any one know of a reason to not do this?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCX7pwACgkQrlYvE4MpobMLvACg5DapQVKzSyAJap3BhoZP5VCu
Ta0AoIezKMPvDphMb/GLgaEabk/wjQSq
=+LJG
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
