Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2DMuFj6005812
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 18:56:15 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2DMuE3k008191
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 22:56:14 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m2DMtPEL025617
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 18:55:25 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m2DMtOlg029612
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 18:55:24 -0400
Received: from localhost.localdomain (dhcp-10-12-34-104.boston.devel.redhat.com [10.12.34.104])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m2DMtOXk014216
	for <selinux@tycho.nsa.gov>; Thu, 13 Mar 2008 18:55:24 -0400
Message-ID: <47D9B0DB.90308@redhat.com>
Date: Thu, 13 Mar 2008 18:55:23 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux/matchpathcon has a memory leak
Content-Type: multipart/mixed;
 boundary="------------040707060306020809060501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040707060306020809060501
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Looks like the selabel stuff is leaking.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfZsNoACgkQrlYvE4MpobOFMgCfeZLFY2nmV+AmYWCkf64pWU60
M9MAoOenkWW6cjXuhP3dgJHzCWX7kKLg
=9INA
-----END PGP SIGNATURE-----

--------------040707060306020809060501
Content-Type: text/plain;
 name="out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="out"

valgrind --leak-check=full matchpathcon /etc/security/access.conf /etc/security/chroot.conf /etc/security/console.apps /etc/security/console.handlers /etc/security/console.perms /etc/security/console.perms.d /etc/security/group.conf /etc/security/group.conf.rpmnew /etc/security/limits.conf /etc/security/limits.conf.rpmnew /etc/security/limits.d /etc/security/namespace.conf /etc/security/namespace.d /etc/security/namespace.init /etc/security/opasswd /etc/security/pam_env.conf /etc/security/pam_mount.conf.xml /etc/security/pam_winbind.conf /etc/security/sepermit.conf /etc/security/sepermit.conf.rpmnew /etc/security/time.conf
==22135== Memcheck, a memory error detector.
==22135== Copyright (C) 2002-2007, and GNU GPL'd, by Julian Seward et al.
==22135== Using LibVEX rev 1804, a library for dynamic binary translation.
==22135== Copyright (C) 2004-2007, and GNU GPL'd, by OpenWorks LLP.
==22135== Using valgrind-3.3.0, a dynamic binary instrumentation framework.
==22135== Copyright (C) 2000-2007, and GNU GPL'd, by Julian Seward et al.
==22135== For more details, rerun with: -v
==22135== 
/etc/security/access.conf	system_u:object_r:etc_t
/etc/security/chroot.conf	system_u:object_r:etc_t
/etc/security/console.apps	system_u:object_r:userhelper_conf_t
/etc/security/console.handlers	system_u:object_r:etc_t
/etc/security/console.perms	system_u:object_r:etc_t
/etc/security/console.perms.d	system_u:object_r:etc_t
/etc/security/group.conf	system_u:object_r:etc_t
/etc/security/group.conf.rpmnew	system_u:object_r:etc_t
/etc/security/limits.conf	system_u:object_r:etc_t
/etc/security/limits.conf.rpmnew	system_u:object_r:etc_t
/etc/security/limits.d	system_u:object_r:etc_t
/etc/security/namespace.conf	system_u:object_r:etc_t
/etc/security/namespace.d	system_u:object_r:etc_t
/etc/security/namespace.init	system_u:object_r:bin_t
/etc/security/opasswd	system_u:object_r:etc_t
/etc/security/pam_env.conf	system_u:object_r:etc_t
/etc/security/pam_mount.conf.xml	system_u:object_r:etc_t
/etc/security/pam_winbind.conf	system_u:object_r:etc_t
/etc/security/sepermit.conf	system_u:object_r:etc_t
/etc/security/sepermit.conf.rpmnew	system_u:object_r:etc_t
/etc/security/time.conf	system_u:object_r:etc_t
==22135== 
==22135== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 4 from 1)
==22135== malloc/free: in use at exit: 464 bytes in 19 blocks.
==22135== malloc/free: 62,395 allocs, 62,376 frees, 7,306,530 bytes allocated.
==22135== For counts of detected errors, rerun with: -v
==22135== searching for pointers to 19 not-freed blocks.
==22135== checked 78,424 bytes.
==22135== 
==22135== 32 bytes in 1 blocks are definitely lost in loss record 1 of 3
==22135==    at 0x4A0739E: malloc (vg_replace_malloc.c:207)
==22135==    by 0x3457E0DA34: (within /lib64/libselinux.so.1)
==22135==    by 0x3457E0C928: selabel_open (in /lib64/libselinux.so.1)
==22135==    by 0x3457E105A6: matchpathcon_init_prefix (in /lib64/libselinux.so.1)
==22135==    by 0x3457E1067E: matchpathcon (in /lib64/libselinux.so.1)
==22135==    by 0x400BE6: (within /usr/sbin/matchpathcon)
==22135==    by 0x400E95: (within /usr/sbin/matchpathcon)
==22135==    by 0x3456E1E479: (below main) (in /lib64/libc-2.7.90.so)
==22135== 
==22135== 
==22135== 72 bytes in 3 blocks are definitely lost in loss record 2 of 3
==22135==    at 0x4A0739E: malloc (vg_replace_malloc.c:207)
==22135==    by 0x3457E12453: (within /lib64/libselinux.so.1)
==22135==    by 0x3457E12943: selinux_raw_to_trans_context (in /lib64/libselinux.so.1)
==22135==    by 0x3457E0C7E9: (within /lib64/libselinux.so.1)
==22135==    by 0x3457E0C84D: selabel_lookup (in /lib64/libselinux.so.1)
==22135==    by 0x400BE6: (within /usr/sbin/matchpathcon)
==22135==    by 0x400E95: (within /usr/sbin/matchpathcon)
==22135==    by 0x3456E1E479: (below main) (in /lib64/libc-2.7.90.so)
==22135== 
==22135== 
==22135== 360 bytes in 15 blocks are definitely lost in loss record 3 of 3
==22135==    at 0x4A0739E: malloc (vg_replace_malloc.c:207)
==22135==    by 0x3456E822C1: strdup (in /lib64/libc-2.7.90.so)
==22135==    by 0x3457E12923: selinux_raw_to_trans_context (in /lib64/libselinux.so.1)
==22135==    by 0x3457E0C7E9: (within /lib64/libselinux.so.1)
==22135==    by 0x3457E0C84D: selabel_lookup (in /lib64/libselinux.so.1)
==22135==    by 0x400BE6: (within /usr/sbin/matchpathcon)
==22135==    by 0x400E95: (within /usr/sbin/matchpathcon)
==22135==    by 0x3456E1E479: (below main) (in /lib64/libc-2.7.90.so)
==22135== 
==22135== LEAK SUMMARY:
==22135==    definitely lost: 464 bytes in 19 blocks.
==22135==      possibly lost: 0 bytes in 0 blocks.
==22135==    still reachable: 0 bytes in 0 blocks.
==22135==         suppressed: 0 bytes in 0 blocks.

--------------040707060306020809060501
Content-Type: application/pgp-signature;
 name="out.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="out.sig"

iEYEABECAAYFAkfZsNoACgkQrlYvE4MpobN/3QCfZZijEcT02HYTn5Yuf6rOER65PpgAoN1q
QH3oBmdoUMjBN4xp8wlXXIl2
--------------040707060306020809060501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
