Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6GF3CDA018512
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 11:03:12 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6GF3CXE027390
	for <selinux@tycho.nsa.gov>; Wed, 16 Jul 2008 15:03:12 GMT
Message-ID: <487E0DAE.6060003@redhat.com>
Date: Wed, 16 Jul 2008 11:03:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: corecommands file contexts and small change to chroot interface
Content-Type: multipart/mixed;
 boundary="------------090505050601040105030909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090505050601040105030909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------090505050601040105030909
Content-Type: text/plain;
 name="kernel_corecommands.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel_corecommands.patch"

Subject: [PATCH] refpolicy: kernel_corecommands changes
--text follows this line--
--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2008-07-10 11:38:44.000000000 -0400
+++ serefpolicy-3.5.1/policy/modules/kernel/corecommands.fc	2008-07-16 10:33:11.000000000 -0400
@@ -7,11 +7,11 @@
 /bin/d?ash			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/bash			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/bash2			--	gen_context(system_u:object_r:shell_exec_t,s0)
+/usr/bin/git-shell		--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/ksh.*			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/sash			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/tcsh			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /bin/zsh.*			--	gen_context(system_u:object_r:shell_exec_t,s0)
-
 #
 # /dev
 #
@@ -97,7 +97,6 @@
 
 /lib/udev/[^/]*			--	gen_context(system_u:object_r:bin_t,s0)
 /lib/udev/scsi_id		--	gen_context(system_u:object_r:bin_t,s0)
-/lib64/udev/[^/]*		--	gen_context(system_u:object_r:bin_t,s0)
 
 ifdef(`distro_gentoo',`
 /lib/rcscripts/addons(/.*)?		gen_context(system_u:object_r:bin_t,s0)
@@ -129,14 +128,14 @@
 /opt/vmware/workstation/lib/lib/wrapper-gtk24\.sh -- gen_context(system_u:object_r:bin_t,s0)
 ')
 
+/opt/gutenprint/cups/lib/filter(/.*)?		gen_context(system_u:object_r:bin_t,s0)
+
 #
 # /usr
 #
 /usr/(.*/)?Bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
-/usr/(.*/)?bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
-/usr/bin/git-shell		--	gen_context(system_u:object_r:shell_exec_t,s0)
-/usr/bin/scponly		--	gen_context(system_u:object_r:shell_exec_t,s0)
 
+/usr/(.*/)?bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(.*/)?bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 
 /usr/(.*/)?sbin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
@@ -190,6 +189,7 @@
 /usr/local/Printer/[^/]*/lpd(/.*)?     	gen_context(system_u:object_r:bin_t,s0)
 /usr/local/linuxprinter/filters(/.*)?   gen_context(system_u:object_r:bin_t,s0)
 
+/usr/bin/scponly		--	gen_context(system_u:object_r:shell_exec_t,s0)
 /usr/sbin/scponlyc		--	gen_context(system_u:object_r:shell_exec_t,s0)
 /usr/sbin/sesh			--	gen_context(system_u:object_r:shell_exec_t,s0)
 /usr/sbin/smrsh			--	gen_context(system_u:object_r:shell_exec_t,s0)
@@ -292,3 +292,13 @@
 ifdef(`distro_suse',`
 /var/lib/samba/bin/.+			gen_context(system_u:object_r:bin_t,s0)
 ')
+/usr/lib(64)?/nspluginwrapper/npconfig	gen_context(system_u:object_r:bin_t,s0)
+/usr/lib(64)?/nspluginwrapper/npviewer	gen_context(system_u:object_r:bin_t,s0)
+
+/usr/lib(64)?/ConsoleKit/scripts(/.*)?  gen_context(system_u:object_r:bin_t,s0)
+/usr/lib(64)?/ConsoleKit/run-session.d(/.*)?  gen_context(system_u:object_r:bin_t,s0)
+/etc/ConsoleKit/run-session.d(/.*)?  gen_context(system_u:object_r:bin_t,s0)
+
+/lib/security/pam_krb5/pam_krb5_storetmp -- gen_context(system_u:object_r:bin_t,s0)
+/lib64/security/pam_krb5/pam_krb5_storetmp -- gen_context(system_u:object_r:bin_t,s0)
+
--- nsaserefpolicy/policy/modules/kernel/corecommands.if	2008-06-12 23:25:03.000000000 -0400
+++ serefpolicy-3.5.1/policy/modules/kernel/corecommands.if	2008-07-16 10:33:11.000000000 -0400
@@ -894,6 +894,7 @@
 
 	read_lnk_files_pattern($1,bin_t,bin_t)
 	can_exec($1,chroot_exec_t)
+	allow $1 self:capability sys_chroot;
 ')
 
 ########################################

--------------090505050601040105030909
Content-Type: application/octet-stream;
 name="kernel_corecommands.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="kernel_corecommands.patch.sig"

iEYEABECAAYFAkh+Da0ACgkQrlYvE4MpobNzzQCeINh2yidz5LxLh0ror0OJrX2qsE4AniM5
1cjoCJr5ubcw3SXvupwah6UC
--------------090505050601040105030909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
