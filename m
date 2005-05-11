Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4BFWCgA018608
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 11:32:13 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4BFTUiX000252
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 15:29:31 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4BFU4RH028706
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 11:30:04 -0400 (EDT)
Subject: [RFC]{Patch 5/5] Polyinstantation
From: Chad Sellers <cdselle@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-28C/aFyPwJtjEex2jyUz"
Date: Wed, 11 May 2005 11:30:51 -0400
Message-Id: <1115825451.28084.32.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-28C/aFyPwJtjEex2jyUz
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Attached is the patch to policy, as well as the example config file.



--=-28C/aFyPwJtjEex2jyUz
Content-Disposition: attachment; filename=policy.diff
Content-Type: text/x-patch; name=policy.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -urN --exclude=policy.conf policy.orig/attrib.te policy/attrib.te
--- policy.orig/attrib.te	2005-04-26 13:26:32.000000000 -0400
+++ policy/attrib.te	2005-05-05 13:47:50.000000000 -0400
@@ -438,3 +438,11 @@
 # of the file system.
 attribute customizable;
 
+# For labeling types that are to be polyinstantiated
+attribute polydir;
+# And for labeling the parent directories of those polyinstantiated directories
+# This is necessary for remounting the original in the parent to give
+# security aware apps access
+attribute polyparent;
+# And labeling for the member directories
+attribute polymember;
diff -urN --exclude=policy.conf policy.orig/domains/misc/test.te policy/domains/misc/test.te
--- policy.orig/domains/misc/test.te	1969-12-31 19:00:00.000000000 -0500
+++ policy/domains/misc/test.te	2005-05-05 14:01:48.000000000 -0400
@@ -0,0 +1,4 @@
+type_member user_t tmp_t:dir user_tmp_t;
+type_member user_t user_home_dir_t:dir user_home_t;
+type_member staff_t tmp_t:dir staff_tmp_t;
+type_member staff_t staff_home_dir_t:dir staff_home_t;
diff -urN --exclude=policy.conf policy.orig/domains/program/login.te policy/domains/program/login.te
--- policy.orig/domains/program/login.te	2005-04-26 13:26:32.000000000 -0400
+++ policy/domains/program/login.te	2005-05-05 13:57:44.000000000 -0400
@@ -130,6 +130,9 @@
 domain_auto_trans($1_login_t, shell_exec_t, unconfined_t)
 ')
 
+# Login can polyinstantiate
+polyinstantiater($1_login_t)
+
 ')dnl end login_domain macro
 #################################
 #
diff -urN --exclude=policy.conf policy.orig/domains/program/xdm.te policy/domains/program/xdm.te
--- policy.orig/domains/program/xdm.te	2005-04-26 13:26:32.000000000 -0400
+++ policy/domains/program/xdm.te	2005-05-05 13:57:37.000000000 -0400
@@ -344,3 +344,11 @@
 
 # Run telinit->init to shutdown.
 can_exec(xdm_t, init_exec_t)
+
+# xdm_t can polyinstantiate
+polyinstantiater(xdm_t)
+# xdm needs access for linking .X11-unix to poly /tmp
+allow xdm_t polymember:dir { add_name remove_name write };
+allow xdm_t polymember:lnk_file { create unlink };
+# xdm needs access for copying .Xauthority into new home
+allow xdm_t polymember:file { create getattr write };
diff -urN --exclude=policy.conf policy.orig/macros/global_macros.te policy/macros/global_macros.te
--- policy.orig/macros/global_macros.te	2005-04-26 13:26:33.000000000 -0400
+++ policy/macros/global_macros.te	2005-05-05 14:14:19.000000000 -0400
@@ -426,7 +426,7 @@
 # by default, only plain files and dirs may be stored there.
 # This can be overridden with a third parameter
 define(`tmp_domain', `
-type $1_tmp_t, file_type, sysadmfile, tmpfile $2;
+type $1_tmp_t, file_type, sysadmfile, polymember, tmpfile $2;
 ifelse($3, `',
 `file_type_auto_trans($1_t, tmp_t, $1_tmp_t, `{ file dir }')',
 `file_type_auto_trans($1_t, tmp_t, $1_tmp_t, `$3')')
@@ -744,3 +744,34 @@
 ')
 
 ')dnl end unconfined_domain
+
+# Allow domain to perform polyinstantiation functions
+# polyinstantiater(domain)
+define(`polyinstantiater', `
+
+# Need to give access to /selinux/member
+allow $1 security_t:security compute_member;
+
+# Need to give access to the directories to be polyinstantiated
+allow $1 polydir:dir { getattr mounton add_name create setattr write search };
+
+# Need to give access to the polyinstantiated subdirectories
+allow $1 polymember:dir {getattr search };
+
+# Need to give access to parent directories where original
+# is remounted for polyinstantiation aware programs (like gdm)
+allow $1 polyparent:dir { getattr mounton };
+
+# Need to give permission to create directories where applicable
+allow $1 polymember: dir { create setattr };
+allow $1 polydir: dir { write add_name };
+allow $1 self:process setfscreate;
+allow $1 polyparent:dir { write add_name };
+# Default type for mountpoints
+allow $1 poly_t:dir { create mounton };
+
+# Need sys_admin capability for mounting
+allow $1 self:capability sys_admin;
+
+')dnl end polyinstantiater
+
diff -urN --exclude=policy.conf policy.orig/macros/program/su_macros.te policy/macros/program/su_macros.te
--- policy.orig/macros/program/su_macros.te	2005-05-05 13:16:01.000000000 -0400
+++ policy/macros/program/su_macros.te	2005-05-05 14:25:29.000000000 -0400
@@ -23,7 +23,7 @@
 
 define(`su_restricted_domain', `
 # Derived domain based on the calling user domain and the program.
-type $1_su_t, domain, privlog, privrole, privuser, privowner, privfd, nscd_client_domain;
+type $1_su_t, domain, privlog, privrole, privuser, privowner, privfd, nscd_client_domain, mlsfileread, mlsfilewrite, mlsfileupgrade, mlsfiledowngrade, mlsprocsetsl;
 
 # for SSP
 allow $1_su_t urandom_device_t:chr_file { getattr read };
@@ -93,6 +93,14 @@
 allow $1_su_t self:netlink_audit_socket create_netlink_socket_perms;
 ')
 
+# Su can polyinstantiate
+polyinstantiater($1_su_t)
+# Su has to unmount polyinstantiated directories (like home)
+# that should not be polyinstantiated under the new user
+allow $1_su_t fs_t:filesystem unmount;
+# Su needs additional permission to mount over a previous mount
+allow $1_su_t polymember:dir mounton;
+
 ') dnl end su_restricted_domain
 
 define(`su_mini_domain', `
diff -urN --exclude=policy.conf policy.orig/macros/user_macros.te policy/macros/user_macros.te
--- policy.orig/macros/user_macros.te	2005-04-26 13:26:33.000000000 -0400
+++ policy/macros/user_macros.te	2005-05-05 14:05:54.000000000 -0400
@@ -18,8 +18,8 @@
 # Use capabilities
 
 # Type for home directory.
-type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type;
-type $1_home_t, file_type, sysadmfile, home_type, user_home_type, $1_file_type;
+type $1_home_dir_t, file_type, sysadmfile, home_dir_type, home_type, user_home_dir_type, polydir;
+type $1_home_t, file_type, sysadmfile, home_type, user_home_type, $1_file_type, polymember;
 
 tmp_domain($1, `, user_tmpfile, $1_file_type', `{ file lnk_file dir sock_file fifo_file }')
 
diff -urN --exclude=policy.conf policy.orig/types/file.te policy/types/file.te
--- policy.orig/types/file.te	2005-04-26 13:26:32.000000000 -0400
+++ policy/types/file.te	2005-05-05 14:06:57.000000000 -0400
@@ -43,7 +43,7 @@
 #
 # root_t is the type for the root directory.
 #
-type root_t, file_type, sysadmfile;
+type root_t, file_type, sysadmfile, polyparent;
 
 #
 # mnt_t is the type for mount points such as /mnt/cdrom
@@ -53,7 +53,7 @@
 # home_root_t is the type for the directory where user home directories
 # are created
 #
-type home_root_t, file_type, sysadmfile;
+type home_root_t, file_type, sysadmfile, polyparent;
 
 #
 # lost_found_t is the type for the lost+found directories.
@@ -77,7 +77,7 @@
 #
 # tmp_t is the type of /tmp and /var/tmp.
 #
-type tmp_t, file_type, sysadmfile, tmpfile;
+type tmp_t, file_type, sysadmfile, tmpfile, polydir;
 
 #
 # etc_t is the type of the system etc directories.

--=-28C/aFyPwJtjEex2jyUz
Content-Disposition: attachment; filename=polydirs
Content-Type: text/plain; name=polydirs; charset=UTF-8
Content-Transfer-Encoding: 7bit

system_u:object_r:poly_t:s0

/tmp
/home #No rules in test policy for this
$HOME


--=-28C/aFyPwJtjEex2jyUz--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
