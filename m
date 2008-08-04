Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CkJ60014099
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:46:19 -0400
Received: from palpatine.hardeman.nu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CkI7E012646
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:46:19 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 02D2D5E2
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:46:17 +0200 (CEST)
Message-Id: <20080804123737.588838945@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:14 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 18/35] fsadm policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mostly to allow xen/cifs/nfs file management
Index: refpolicy/policy/modules/system/fstools.if
===================================================================
--- refpolicy.orig/policy/modules/system/fstools.if	2008-07-19 19:15:43.000000000 +0200
+++ refpolicy/policy/modules/system/fstools.if	2008-08-03 18:06:57.000000000 +0200
@@ -142,3 +142,21 @@
 
 	allow $1 swapfile_t:file getattr;
 ')
+
+########################################
+## <summary>
+##	Send signal to fsadm process
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`fstools_signal',`
+	gen_require(`
+		type fsadm_t;
+	')
+
+	allow $1 fsadm_t:process signal;
+')
Index: refpolicy/policy/modules/system/fstools.te
===================================================================
--- refpolicy.orig/policy/modules/system/fstools.te	2008-07-19 19:15:43.000000000 +0200
+++ refpolicy/policy/modules/system/fstools.te	2008-08-03 18:06:57.000000000 +0200
@@ -97,6 +97,10 @@
 fs_getattr_tmpfs_dirs(fsadm_t)
 fs_read_tmpfs_symlinks(fsadm_t)
 
+fs_manage_nfs_files(fsadm_t)
+
+fs_manage_cifs_files(fsadm_t)
+
 mls_file_read_all_levels(fsadm_t)
 mls_file_write_all_levels(fsadm_t)
 
@@ -184,4 +188,9 @@
 
 optional_policy(`
 	xen_append_log(fsadm_t)
+	xen_rw_image_files(fsadm_t)
+')
+
+optional_policy(`
+	unconfined_domain(fsadm_t)
 ')

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
