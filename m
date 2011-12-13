Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pBDKbjsn017198
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2011 15:37:49 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id pBDKbmRx010655
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2011 20:37:48 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBDKblrq019902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2011 15:37:47 -0500
Received: from [10.16.62.208] (dhcp-10-16-62-208.boston.devel.redhat.com [10.16.62.208])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id pBDKbko7008693
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2011 15:37:47 -0500
Message-ID: <4EE7B79A.7000101@redhat.com>
Date: Tue, 13 Dec 2011 15:37:46 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: We are seeing more and more programs accessing sysfs_t.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Every domain is now reading /sys/devices/system/cpu/online because of
changes to glibc.

We are also seeing domains that need write access.

For example

> https://bugzilla.redhat.com/show_bug.cgi?id=685096
> 
> for https://bugzilla.redhat.com/show_bug.cgi?id=685096 (IP over 
> Infiniband support for NetworkManager), NM needs to be able to 
> write to /sys/class/net/ib*/mode. audit2allow says:
> 
> allow NetworkManager_t sysfs_t:file write;

It seems we need a better way of labeling files under /sys.

genfscon only seems to work at the top level.

Allowing all domains to read sysfs_t does not seem like the correct
solution, and allow NetworkManager to write anywhere on /sys is
probably not good either.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7nt5oACgkQrlYvE4MpobOyfwCfav6hMLyB5kPcAJvW81zhqC7o
s30AoJv2aI8RmLi8gDq2gGMjadiyLziP
=PVUp
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
