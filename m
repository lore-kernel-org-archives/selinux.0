Subject: Re: Setools 1.0.1 released
From: Karl MacMillan <kmacmillan@tresys.com>
To: SELinux List <SELinux@tycho.nsa.gov>
In-Reply-To: <1067890582.1269.32.camel@colossus.columbia.tresys.com>
References: <1067890582.1269.32.camel@colossus.columbia.tresys.com>
Content-Type: multipart/mixed; boundary="=-F7TS2OF2mxJ/vilS++UV"
Message-Id: <1067953565.30051.3.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Tue, 04 Nov 2003 08:46:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-F7TS2OF2mxJ/vilS++UV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is the patch - I forgot to attach it yesterday.

Karl

On Mon, 2003-11-03 at 15:16, Karl MacMillan wrote:
> We have just released version 1.0.1 of setools. This is a minor update
> that fixes some bugs and synchronizes with the changes in the NSA and
> RedHat packages of setools. The most important update is to the seuser
> policy to make it compile correctly with the latest official SELinux
> policy. Source and binaries are available from our website:
> 
> http://www.tresys.com/selinux/
> 
> I have also attached a patch for the last NSA release of SELinux and
> updated the sourceforge cvs repository.
> 
> The next release, sometime in early December, will include improved
> information flow analysis, the ability to save and load complex queries
> in apol, the removal of Tcl/TK and X dependencies from the command-line
> tools, and a log file analysis tool that leverages libapol to help a
> policy developer or system administrator understand the audit message
> from SELinux.
> 
> Karl
-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
(410)290-1411x134

--=-F7TS2OF2mxJ/vilS++UV
Content-Disposition: attachment; filename=setools-nsa-1.0-to-1.0.1-patch
Content-Type: text/x-patch; name=setools-nsa-1.0-to-1.0.1-patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ruN selinux-usr-old/setools/apol/top.tcl selinux-usr/setools/apol/top.tcl
--- selinux-usr-old/setools/apol/top.tcl	2003-09-23 11:07:25.000000000 -0400
+++ selinux-usr/setools/apol/top.tcl	2003-11-01 03:40:53.871957792 -0500
@@ -15,7 +15,7 @@
 	variable filename 		""
 	variable policyConf_lineno	""
 	variable polstats 		""
-	variable gui_ver 		"1.0" 
+	variable gui_ver 		"1.0.1" 
 	variable copyright_date		"2001-2003"
 	variable recent_files
 	variable num_recent_files 	0
@@ -1122,9 +1122,9 @@
 	catch {destroy $w}
 	toplevel $w
 	
-	label $w.1 -justify left  -font {helvetica 10 bold}  \
+	label $w.1 -justify left \
 		-text "Policy Summary Statistics\n "
-	label $w.2 -justify left -font {helvetica 10} \
+	label $w.2 -justify left \
 		-text "\
 Policy Version: $polversion\n\n\
 Number of Classes and Permissions\n\
diff -ruN selinux-usr-old/setools/ChangeLog-setools selinux-usr/setools/ChangeLog-setools
--- selinux-usr-old/setools/ChangeLog-setools	2003-09-23 11:07:25.000000000 -0400
+++ selinux-usr/setools/ChangeLog-setools	2003-11-01 03:40:53.646991992 -0500
@@ -1,6 +1,21 @@
 CHANGE LOG, SE Linux TOOLS (setools)
 
 ========================================================
+October 30, 2003 SE Linux Tools, version 1.0.1
+
+Apol:
+	Update to default font configuration
+
+Sepcut:
+	Update to default font configuration
+
+Seuser:
+	Updated seuser .te file
+	Update seuser Makefile to use -Z option when installing seuser
+	Update to default font configuration
+
+
+========================================================
 September 22, 2003 SE Linux Tools, version 1.0
 
 Added BWidgets source under packages.
diff -ruN selinux-usr-old/setools/INSTALL selinux-usr/setools/INSTALL
--- selinux-usr-old/setools/INSTALL	2003-09-23 11:07:25.000000000 -0400
+++ selinux-usr/setools/INSTALL	2003-11-01 03:40:53.641992752 -0500
@@ -1,8 +1,8 @@
-SELinux Tools (setools), version 1.0
+SELinux Tools (setools), version 1.0.1
 by Tresys Technology, LLC
 (selinux@tresys.com, www.tresys.com/selinux)
 
-September 22, 2003
+October 30, 2003
 
 BUILDING AND INSTALLING NOTES AND WARNINGS
 
diff -ruN selinux-usr-old/setools/INSTALL-RPM selinux-usr/setools/INSTALL-RPM
--- selinux-usr-old/setools/INSTALL-RPM	2003-09-23 11:07:24.000000000 -0400
+++ selinux-usr/setools/INSTALL-RPM	2003-11-01 03:40:53.634993816 -0500
@@ -1,8 +1,8 @@
-SELinux Tools (setools), version 1.0
+SELinux Tools (setools), version 1.0.1
 by Tresys Technology, LLC
 (selinux@tresys.com, www.tresys.com/selinux)
 
-September 22, 2003
+October 30, 2003
 
 INSTALLATION NOTES FOR RPM
 
diff -ruN selinux-usr-old/setools/KNOWN-BUGS selinux-usr/setools/KNOWN-BUGS
--- selinux-usr-old/setools/KNOWN-BUGS	2003-09-23 11:07:25.000000000 -0400
+++ selinux-usr/setools/KNOWN-BUGS	2003-11-01 03:40:53.875957184 -0500
@@ -1,8 +1,8 @@
-SELinux Tools (setools), version 1.0
+SELinux Tools (setools), version 1.0.1
 by Tresys Technology, LLC
 (selinux@tresys.com, www.tresys.com/selinux)
 
-September 22, 2003
+October 30, 2003
 
 
 CURRENT BUGS AND ISSUES
diff -ruN selinux-usr-old/setools/policy/seuser.te selinux-usr/setools/policy/seuser.te
--- selinux-usr-old/setools/policy/seuser.te	2003-09-23 11:07:31.000000000 -0400
+++ selinux-usr/setools/policy/seuser.te	2003-11-01 03:40:54.219904896 -0500
@@ -21,7 +21,7 @@
 ##############################################
 
 # Defined seuser types
-type seuser_t, domain ;
+type seuser_t, domain, privhome  ;
 type seuser_conf_t, file_type, sysadmfile ;
 type seuser_exec_t, file_type, sysadmfile, exec_type ;
 type seuser_tmp_t, file_type, sysadmfile, tmpfile ;
@@ -38,7 +38,50 @@
 
 # Grant the new domain permissions to many common operations
 # FIX: Should be more resticted than this.
-every_domain(seuser_t)
+#every_domain(seuser_t)
+allow seuser_t self:process { fork sigchld };
+allow seuser_t self:fifo_file read;
+allow seuser_t self:unix_stream_socket {create connect};
+allow seuser_t self:dir {search};
+allow seuser_t self:file { read getattr };
+
+allow seuser_t etc_t:dir { search };
+allow seuser_t etc_t:{lnk_file file} { read getattr};
+allow seuser_t locale_t:file { getattr read};
+allow seuser_t locale_t:dir { search};
+allow seuser_t { var_run_t var_t}:dir search;
+
+allow seuser_t usr_t:dir { search };
+allow seuser_t shlib_t:file { read getattr execute};
+allow seuser_t shlib_t:lnk_file { read };
+allow seuser_t shlib_t:dir {search};
+allow seuser_t lib_t:dir { getattr search };
+allow seuser_t ld_so_cache_t:file { read getattr };
+allow seuser_t ld_so_t:lnk_file { read };
+allow seuser_t ld_so_t:file { read execute };
+
+allow seuser_t null_device_t:chr_file {read write} ;
+allow seuser_t device_t:dir search;
+allow seuser_t devtty_t:chr_file {read write };
+allow seuser_t proc_t:dir search;
+allow seuser_t proc_t:{lnk_file file} { getattr read };
+
+allow seuser_t root_t:dir { search };
+allow seuser_t staff_home_dir_t:dir {search };
+allow seuser_t home_root_t:dir { getattr search };
+allow seuser_t file_t:file read;
+allow seuser_t staff_home_dir_t:dir getattr;
+allow seuser_t file_t:file {read getattr};
+
+allow seuser_t bin_t:dir { getattr search read} ;
+allow seuser_t bin_t:lnk_file { read getattr };
+allow seuser_t sbin_t:dir search;
+allow seuser_t usr_t:dir getattr;
+
+# Inherit and use descriptors from login.
+allow seuser_t privfd:fd use;
+
+###############################################
 
 # Use capabilities to self
 allow seuser_t self:capability { dac_override setuid setgid } ;
@@ -94,20 +137,20 @@
 allow seuser_t policy_config_t:file stat_file_perms;
 
 
-ifdef(`xserver.te', `
+#ifdef(`xserver.te', `
 ############################################################
 # Xserver section - To support our GUI interface, 
 ############################################################
 # Permission to create files in /tmp/.X11-Unix
-allow seuser_t sysadm_xserver_tmp_t:dir { search } ;
-allow seuser_t sysadm_xserver_tmp_t:sock_file { write } ;
-allow seuser_t user_xserver_tmp_t:dir { search } ;
-allow seuser_t user_xserver_tmp_t:sock_file { write } ;
+#allow seuser_t sysadm_xserver_tmp_t:dir { search } ;
+#allow seuser_t sysadm_xserver_tmp_t:sock_file { write } ;
+#allow seuser_t user_xserver_tmp_t:dir { search } ;
+#allow seuser_t user_xserver_tmp_t:sock_file { write } ;
 
 # Permission to establish a Unix stream connection to X server
-can_unix_connect(seuser_t, user_xserver_t)
-can_unix_connect(seuser_t, sysadm_xserver_t)
-')
+#can_unix_connect(seuser_t, user_xserver_t)
+#can_unix_connect(seuser_t, sysadm_xserver_t)
+#')
 ifdef(`xdm.te', `
 can_unix_connect(seuser_t, xdm_xserver_t)
 ')
@@ -119,3 +162,8 @@
 allow seuser_t sysadm_tty_device_t:chr_file rw_file_perms ;
 allow seuser_t sysadm_devpts_t:chr_file rw_file_perms ;
 
+
+
+
+
+
diff -ruN selinux-usr-old/setools/README selinux-usr/setools/README
--- selinux-usr-old/setools/README	2003-09-23 11:07:25.000000000 -0400
+++ selinux-usr/setools/README	2003-11-01 03:40:53.879956576 -0500
@@ -1,8 +1,8 @@
-SELinux Tools (setools), version 1.0
+SELinux Tools (setools), version 1.0.1
 by Tresys Technology, LLC
 (selinux@tresys.com, www.tresys.com/selinux)
 
-September 22, 2003
+October 30, 2003
 
 
 OVERVIEW
diff -ruN selinux-usr-old/setools/sepct/top.tcl selinux-usr/setools/sepct/top.tcl
--- selinux-usr-old/setools/sepct/top.tcl	2003-09-23 11:07:31.000000000 -0400
+++ selinux-usr/setools/sepct/top.tcl	2003-11-01 03:40:54.245900944 -0500
@@ -14,7 +14,7 @@
 # ::Sepct (top-level namespace)
 ##############################################################
 namespace eval Sepct {
-	variable gui_ver		"0.3.2"
+	variable gui_ver		"0.3.3"
 	variable copyright_date		"2002-2003"
 	variable helpFilename		""
 	# Global variable to hold name of root directory
@@ -2031,8 +2031,9 @@
 	}
 		
 	# Add entries to the Tk option database 
-	option add *TitleFrame.l.font "Helvetica 10 bold italic"   
+	# First set all fonts in general; then we can change specific fonts
 	option add *Font "Helvetica 10"
+	option add *TitleFrame.l.font "Helvetica 10 bold italic"   
 	option add *Dialog*font "Helvetica 10" 
 	option add *text*font "Helvetica 10"
 	
diff -ruN selinux-usr-old/setools/setools.spec selinux-usr/setools/setools.spec
--- selinux-usr-old/setools/setools.spec	2003-09-23 11:07:25.000000000 -0400
+++ selinux-usr/setools/setools.spec	2003-11-01 03:40:53.881956272 -0500
@@ -1,13 +1,14 @@
 Summary: SELinux tools for managing policy
 Name: setools
-Version: 1.0
+Version: 1.0.1
 Release: 1
 License: GPL
 Group: System Environment/Base
-Source: http://www.tresys.com/Downloads/selinux-tools/setools-1.0.tgz
+Source: http://www.tresys.com/Downloads/selinux-tools/setools-1.0.1.tgz
 Prefix: %{_prefix}
 BuildRoot: %{_tmppath}/%{name}-buildroot
-Requires: checkpolicy, policycoreutils, policy, policy-sources, bwidget
+BuildRequires: perl, tcl
+Requires: tcl, tk, checkpolicy, policycoreutils, policy, policy-sources, bwidget
 BuildArch: i386
 
 %description
diff -ruN selinux-usr-old/setools/seuser/Makefile selinux-usr/setools/seuser/Makefile
--- selinux-usr-old/setools/seuser/Makefile	2003-09-26 11:01:01.000000000 -0400
+++ selinux-usr/setools/seuser/Makefile	2003-11-01 03:40:54.247900640 -0500
@@ -62,9 +62,13 @@
 	@if [ -e /etc/security/selinux/src/policy ]; then \
 		install -d $(TE_PROGS_DIR); \
 		install -d $(FC_PROGS_DIR); \
+		install -m 644 -Z system_u:object_r:policy_src_t ../policy/seuser.te $(TE_PROGS_DIR); \
+		install -m 644 -Z system_u:object_r:policy_src_t ../policy/seuser.fc $(FC_PROGS_DIR); \
+	else \
+		install -d $(TE_PROGS_DIR); \
+		install -d $(FC_PROGS_DIR); \
 		install -m 644 ../policy/seuser.te $(TE_PROGS_DIR); \
 		install -m 644 ../policy/seuser.fc $(FC_PROGS_DIR); \
-	else \
 		echo "ERROR: YOU MUST HAVE THE POLICY SOURCE INSTALLED TO $(POLICY_SRC_DIR)."; \
 		echo "	seuser did not install because the policy source was not"; \
 		echo "	found. type 'make install-src' from your policy directory,"; \
@@ -78,12 +82,16 @@
 	fi
 
 install: seuser policy-install se_user.tcl
+	install -d $(BINDIR); 
 	@if [ -e /etc/security/selinux/src/policy ]; then \
+		install -m 755 -Z system_u:object_r:seuser_exec_t seuser $(BINDIR); \
+		install -m 644 -Z system_u:object_r:seuser_conf_t $(SEUSER_CONF_FILE) $(INSTALL_LIBDIR); \
+	else \
 		install -m 755 seuser $(BINDIR); \
 		install -m 644 $(SEUSER_CONF_FILE) $(INSTALL_LIBDIR); \
-		install -m 755 $(SE_SHELL_SCRIPTS) $(BINDIR); \
-		install -m 644 se_user.tcl $(SEUSER_HELP_FILE) $(INSTALL_LIBDIR); \
 	fi
+	install -m 755 $(SE_SHELL_SCRIPTS) $(BINDIR)
+	install -m 644 se_user.tcl $(SEUSER_HELP_FILE) $(INSTALL_LIBDIR)
 
 clean:
 	rm -f *.o  core seuser *~ se_user.tcl tmp.tcl
diff -ruN selinux-usr-old/setools/seuser/seuser_help.txt selinux-usr/setools/seuser/seuser_help.txt
--- selinux-usr-old/setools/seuser/seuser_help.txt	2003-09-23 11:07:32.000000000 -0400
+++ selinux-usr/setools/seuser/seuser_help.txt	2003-11-01 03:40:54.266897752 -0500
@@ -1,7 +1,7 @@
 
 SELinux User Manager Help File
-seuser, Version 0.5.2
-September 15, 2003
+seuser, Version 0.5.3
+October 30, 2003
 selinux@tresys.com
 ----------------------------------
 
diff -ruN selinux-usr-old/setools/seuser/seuser_top.tcl selinux-usr/setools/seuser/seuser_top.tcl
--- selinux-usr-old/setools/seuser/seuser_top.tcl	2003-09-23 11:07:32.000000000 -0400
+++ selinux-usr/setools/seuser/seuser_top.tcl	2003-11-01 03:40:54.291893952 -0500
@@ -37,7 +37,7 @@
 	variable b_lbl_groups
 	
 	# Miscellaneous variables
-	variable gui_ver		"0.5.2"
+	variable gui_ver		"0.5.3"
 	variable copyright_date		"2003"
 	variable progressMsg 		""
 	variable delete_user_ans 
@@ -958,8 +958,9 @@
 		exit
 	}
 	
-	option add *TitleFrame.l.font "Helvetica 10 bold italic"
+	# First set all fonts in general; then we can change specific fonts 
 	option add *Font "Helvetica 10"
+	option add *TitleFrame.l.font "Helvetica 10 bold italic"
 	option add *Dialog*font "Helvetica 10"
 	option add *ListBox*font $SEUser_Top::text_font
 	option add *text*font $SEUser_Top::text_font
diff -ruN selinux-usr-old/setools/VERSION selinux-usr/setools/VERSION
--- selinux-usr-old/setools/VERSION	2003-09-23 11:07:25.000000000 -0400
+++ selinux-usr/setools/VERSION	2003-11-01 03:40:53.880956424 -0500
@@ -1 +1 @@
-1.0
+1.0.1

--=-F7TS2OF2mxJ/vilS++UV--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
