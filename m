Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m49DmQM8004086
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 09:48:26 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m49DmPBH007184
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 13:48:26 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m49DmQ89025103
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 09:48:26 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m49DmPlA031700
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 09:48:25 -0400
Received: from localhost.localdomain (vpn-14-235.rdu.redhat.com [10.11.14.235])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m49DmNPe007565
	for <selinux@tycho.nsa.gov>; Fri, 9 May 2008 09:48:24 -0400
Message-ID: <4824560E.8060500@redhat.com>
Date: Fri, 09 May 2008 09:47:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: I think this is a bug in the kernel
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

https://bugzilla.redhat.com/show_bug.cgi?id=445709	

libvirtd is clearly not ptracing the unconfined_t domain.  It is
problably looking under /proc for some information about the app that is
communicating with it.  It might be reading unconfined_t environment.  I
am not sure, but we generate a ptrace and stop the app from working.  My
only choice is to allow virtd to ptrace unconfined_t processes which is
not a good idea.  This has to be fixes in the kernel.

Dan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgkVg4ACgkQrlYvE4MpobPCvwCfa/iBjD3h2dFnEDvB39c8db0a
ITAAn1ktC480Tvx6lgx01ufjPNeQGOxC
=7O2c
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
