Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7SI7srT026791
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 14:07:54 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7SI76Hc012441
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 18:07:07 GMT
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id ACF99C0BF
	for <selinux@tycho.nsa.gov>; Sat, 28 Aug 2004 19:07:48 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1C17nB-00005S-GK
	for selinux@tycho.nsa.gov; Sat, 28 Aug 2004 19:19:09 +0100
Date: Sat, 28 Aug 2004 19:19:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: mount accessing /dev/cdrom as a symlink
Message-ID: <20040828181909.GF11546@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

i had to add this to the mount.te policy in order to allow mount
to actually succeed on a udev-automatically-created /dev/cdrom symlink
(to /dev/hdc which is my ide cdrom drive).

so, the question is: should udev have relabelled that symlink correctly,
or should mount be allowed to read device_t symlinks?

bearing in mind that it's the udev *SCRIPTS* in /etc/udev that
will be creating the symlink, NOT the udevd program, nor the udev
program, nor the udevsend program.

likely to have been /etc/udev/ide-devfs.sh that done it, 'guv.

l.


--- /usr/share/selinux/policy/default.1.14/domains/program/mount.te	2004-08-02 08:28:37.000000000 +0100
+++ domains/program/mount.te	2004-08-28 18:54:24.000000000 +0100
@@ -96,3 +97,6 @@
 allow mount_t mnt_t:dir { getattr };
 dontaudit mount_t { userdomain kernel_t}:fd use;
 can_exec(mount_t, { sbin_t bin_t })
+
+allow mount_t device_t:lnk_file { read };
+	#EXE=/bin/mount  NAME=cdrom   :  read

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
