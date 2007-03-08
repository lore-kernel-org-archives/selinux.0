Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28FKRlD006528
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 10:20:27 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28FKPwk016004
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 15:20:26 GMT
Message-ID: <45F0299F.1010909@redhat.com>
Date: Thu, 08 Mar 2007 10:19:59 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: sudo patch
Content-Type: multipart/mixed;
 boundary="------------000308060807010000080101"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000308060807010000080101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

sudo needs to be able to getattr on all executables and secure_mode is 
not used in interface.

--------------000308060807010000080101
Content-Type: text/x-patch;
 name="sudo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sudo.patch"

--- nsaserefpolicy/policy/modules/admin/sudo.if	2007-02-19 11:32:54.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/admin/sudo.if	2007-03-08 08:42:36.000000000 -0500
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

--------------000308060807010000080101--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
