Subject: Re: Latest diffs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
References: <1106940328.32737.120.camel@moss-spartans.epoch.ncsc.mil>
	 <41FA9717.2000609@redhat.com>
	 <1107283533.31281.8.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1107287300.26936.226.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 01 Feb 2005 14:48:20 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

After Jim's merge of some of your changes, I've committed the patch
below, which introduces an allow_execmem boolean for all execmem allow
rules, wraps some additional execmod allow rules with your boolean,
removes execmod permission to shlib_t entirely (should only be allowed
to texrel_shlib_t except for special domains for programs like java),
and assigns texrel_shlib_t to libGL.  Actually, some of the individual
execmod allow rules may now be redundant with the conditional rule you
put in uses_shlib.  I think that we may need to further break up these
booleans to allow certain programs to have these permissions without
granting them more widely.

Index: policy/domains/user.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/user.te,v
retrieving revision 1.31
diff -u -r1.31 user.te
--- policy/domains/user.te	1 Feb 2005 18:39:50 -0000	1.31
+++ policy/domains/user.te	1 Feb 2005 18:48:31 -0000
@@ -10,6 +10,9 @@
 # Support NFS home directories
 bool use_nfs_home_dirs false;
 
+# Allow execution of anonymous mappings, e.g. executable stack.
+bool allow_execmem false;
+
 # Support Share libraries with Text Relocation
 bool allow_execmod false;
 
Index: policy/domains/program/modutil.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/modutil.te,v
retrieving revision 1.30
diff -u -r1.30 modutil.te
--- policy/domains/program/modutil.te	21 Jan 2005 20:03:06 -0000	1.30
+++ policy/domains/program/modutil.te	1 Feb 2005 19:04:21 -0000
@@ -124,7 +124,7 @@
 allow insmod_t self:rawip_socket create_socket_perms;
 allow insmod_t self:capability { dac_override kill net_raw sys_module sys_tty_config };
 allow insmod_t domain:process signal;
-allow insmod_t self:process { fork signal_perms execmem };
+allow insmod_t self:process { fork signal_perms };
 allow insmod_t device_t:dir search;
 allow insmod_t etc_runtime_t:file { getattr read };
 
Index: policy/domains/program/unused/kudzu.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/kudzu.te,v
retrieving revision 1.21
diff -u -r1.21 kudzu.te
--- policy/domains/program/unused/kudzu.te	1 Feb 2005 18:39:51 -0000	1.21
+++ policy/domains/program/unused/kudzu.te	1 Feb 2005 19:03:36 -0000
@@ -11,7 +11,9 @@
 allow kudzu_t etc_runtime_t:file rw_file_perms;
 
 # for kmodule
+if (allow_execmem) {
 allow kudzu_t self:process execmem;
+}
 allow kudzu_t zero_device_t:chr_file rx_file_perms;
 allow kudzu_t memory_device_t:chr_file { read write execute };
 
Index: policy/domains/program/unused/prelink.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/prelink.te,v
retrieving revision 1.17
diff -u -r1.17 prelink.te
--- policy/domains/program/unused/prelink.te	1 Feb 2005 18:39:51 -0000	1.17
+++ policy/domains/program/unused/prelink.te	1 Feb 2005 18:46:21 -0000
@@ -11,8 +11,12 @@
 #
 daemon_base_domain(prelink, `, admin')
 
+if (allow_execmem) {
 allow prelink_t self:process execmem;
-allow prelink_t { texrel_shlib_t shlib_t }:file execmod;
+}
+if (allow_execmod) {
+allow prelink_t texrel_shlib_t:file execmod;
+}
 
 allow prelink_t fs_t:filesystem getattr;
 
Index: policy/domains/program/unused/udev.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/unused/udev.te,v
retrieving revision 1.38
diff -u -r1.38 udev.te
--- policy/domains/program/unused/udev.te	24 Jan 2005 19:00:42 -0000	1.38
+++ policy/domains/program/unused/udev.te	1 Feb 2005 19:03:20 -0000
@@ -13,8 +13,10 @@
 
 general_domain_access(udev_t)
 
+if (allow_execmem) {
 # for alsactl
 allow udev_t self:process execmem;
+}
 
 etc_domain(udev)
 typealias udev_etc_t alias etc_udev_t;
Index: policy/file_contexts/types.fc
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/file_contexts/types.fc,v
retrieving revision 1.70
diff -u -r1.70 types.fc
--- policy/file_contexts/types.fc	1 Feb 2005 18:39:51 -0000	1.70
+++ policy/file_contexts/types.fc	1 Feb 2005 18:45:11 -0000
@@ -356,6 +356,9 @@
 /usr(/.*)?/nvidia/.*\.so(\..*)?	-- system_u:object_r:texrel_shlib_t
 /usr/X11R6/lib/libXvMCNVIDIA\.so.* 	-- system_u:object_r:texrel_shlib_t
 
+# libGL
+/usr/X11R6/lib/libGL\.so.* 	-- system_u:object_r:texrel_shlib_t
+
 ifdef(`distro_debian', `
 /usr/share/selinux(/.*)?	system_u:object_r:policy_src_t
 ')
Index: policy/macros/base_user_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/base_user_macros.te,v
retrieving revision 1.44
diff -u -r1.44 base_user_macros.te
--- policy/macros/base_user_macros.te	1 Feb 2005 18:39:52 -0000	1.44
+++ policy/macros/base_user_macros.te	1 Feb 2005 18:49:51 -0000
@@ -39,12 +39,14 @@
 # Grant permissions within the domain.
 general_domain_access($1_t)
 
+if (allow_execmem) {
 # Allow loading DSOs that require executable stack.
 allow $1_t self:process execmem;
+}
 
 if (allow_execmod) {
 # Allow text relocations on system shared libraries, e.g. libGL.
-allow $1_t shlib_t:file execmod;
+allow $1_t texrel_shlib_t:file execmod;
 }
 
 #
Index: policy/macros/program/xserver_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/program/xserver_macros.te,v
retrieving revision 1.41
diff -u -r1.41 xserver_macros.te
--- policy/macros/program/xserver_macros.te	20 Dec 2004 21:26:20 -0000	1.41
+++ policy/macros/program/xserver_macros.te	1 Feb 2005 19:02:41 -0000
@@ -58,7 +58,9 @@
 # for access within the domain
 general_domain_access($1_xserver_t)
 
+if (allow_execmem) {
 allow $1_xserver_t self:process execmem;
+}
 
 allow $1_xserver_t etc_runtime_t:file { getattr read };
 
Index: policy/targeted/domains/unconfined.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/targeted/domains/unconfined.te,v
retrieving revision 1.25
diff -u -r1.25 unconfined.te
--- policy/targeted/domains/unconfined.te	1 Feb 2005 18:39:53 -0000	1.25
+++ policy/targeted/domains/unconfined.te	1 Feb 2005 18:47:44 -0000
@@ -44,6 +44,9 @@
 # Support NFS home directories
 bool use_nfs_home_dirs false;
 
+# Allow execution of anonymous mappings, e.g. executable stack.
+bool allow_execmem false;
+
 # Support Share libraries with Text Relocation
 bool allow_execmod false;
 

  
-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
