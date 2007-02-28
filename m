Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SFSWaM015127
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 10:28:32 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1SFTs2d028760
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 15:29:55 GMT
Message-ID: <45E59FF1.9070306@redhat.com>
Date: Wed, 28 Feb 2007 10:29:53 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: sudo change in policy
Content-Type: multipart/mixed;
 boundary="------------040208030809020003000701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040208030809020003000701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

sudo should be able to getattr on all executables not just 
bin_t/sbin_t.  Confined executeables run from sudo need this.

sudo_exec_t needs to be marked as exec_type so prelink will work correctly.

sudo semanage should work

--------------040208030809020003000701
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_admin_sudo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_admin_sudo.patch"

--- nsaserefpolicy/policy/modules/admin/sudo.if	2007-02-19 11:32:54.000000000 -0500
+++ serefpolicy-2.5.5/policy/modules/admin/sudo.if	2007-02-28 10:25:17.000000000 -0500
@@ -37,7 +37,6 @@
 
 	gen_require(`
 		type sudo_exec_t;
-		bool secure_mode;
 	')
 
 	##############################
@@ -92,12 +91,10 @@
 	fs_getattr_xattr_fs($1_sudo_t)
 
 	auth_domtrans_chk_passwd($1_sudo_t)
-	# sudo stores a token in the pam_pid directory
 	auth_manage_pam_pid($1_sudo_t)
 
-	corecmd_getattr_bin_files($1_sudo_t)
 	corecmd_read_sbin_symlinks($1_sudo_t)
-	corecmd_getattr_sbin_files($1_sudo_t)
+	corecmd_getattr_all_executables($1_sudo_t)
 
 	domain_use_interactive_fds($1_sudo_t)
 	domain_sigchld_interactive_fds($1_sudo_t)
--- nsaserefpolicy/policy/modules/admin/sudo.te	2007-02-19 11:32:54.000000000 -0500
+++ serefpolicy-2.5.5/policy/modules/admin/sudo.te	2007-02-28 10:25:17.000000000 -0500
@@ -7,5 +7,6 @@
 
 type sudo_exec_t;
 files_type(sudo_exec_t)
+corecmd_executable_file(sudo_exec_t)
 
 # Remaining policy in per user domain template.

--------------040208030809020003000701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
