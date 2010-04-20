Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o3KELkKE026849
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 10:21:46 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o3KELEYa011880
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 14:21:14 GMT
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o3KELjMl008093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 10:21:45 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o3KELiQA012048
	for <selinux@tycho.nsa.gov>; Tue, 20 Apr 2010 10:21:44 -0400
Message-ID: <4BCDB877.10908@redhat.com>
Date: Tue, 20 Apr 2010 10:21:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Setting labels on a disabled SELinux box.
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Currently the kernel is blocking the setting of labels on a disabled
SELinux box.

We have made changes to livecd to be able to build a livecd image on a
disabled SELinux box, but the kernel is preventing the placing of labels.

We want this functionality so that Fedora Build machines can be allowed
to create different kinds of images and do not want to require all
machines to enable SELinux.

Currently these images are being built with SELinux disabled because of
this.

strace shows

lsetxattr("/root/whatever/", "security.selinux",
"system_u:object_r:root_t:s0", 28, 0) = -1 EOPNOTSUPP (Operation not
supported)


eparis says this code is causing the problem.

 static int cap_inode_setsecurity(struct inode *inode, const char *name,
                                  const void *value, size_t size, int flags)
 {
         return -EOPNOTSUPP;
 }

I think we should allow this if you have a capability like sys_admin or
dac_override.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvNuHcACgkQrlYvE4MpobO6pACgxMKs4oFogWstSyTdzLFsO1Ot
8DkAoKZswtvA17iC0HGDpssyNyUxDjNa
=lGy3
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
