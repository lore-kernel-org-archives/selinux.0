Subject: [ PATCHES ] mozilla, gift, games, orbit, gconf, genhomedircon
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: dwalsh@redhat.com
Cc: russell@coker.com.au, SELinux <SELinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-Qc//SJlAsQQAvOyfo9Mx"
Date: Mon, 09 May 2005 03:52:08 -0400
Message-Id: <1115625128.7589.19.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Qc//SJlAsQQAvOyfo9Mx
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Please apply the attached patches, in the order specified.
(I really hope this works, because I'm not very good at working 
w/ patches, and I've created a mess yet again on my home machine - if
something won't apply please let me know and I'll get it fixed).

This breaks up some pieces of restrict_home4 for inclusion.

01-file_browse.diff - 
split up file_browse_domain into
three individual macros, and use each where appropriate, instead
of adding unnecessary dontaudit rules. Also contains fixes for
gmplayer.

02-mozilla_gift_misc.diff - 
miscellaneous fixes for gift and mozilla, reorganize mozilla a bit

03-genhomedircon-USER.diff - 
add handling for USER expansion by genhomedircon

03-Makefile-USER.diff -
change makefile to check for USER expansion

03-orbit.diff - 
introduce orbit types, and orbit macros,
and prevent applications from accessing ROLE_tmp_t
for ORBit sockets.

03-orbit-matchpatchcon.diff - 
patch libORBit-2 (CVS) to correctly set
the context of /tmp/orbit-* when it is created.

04-gconfd.diff - 
introduce policy for GConf, and a gnome
container domain that will be used to instantiate
a lot of stuff in the future

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-Qc//SJlAsQQAvOyfo9Mx
Content-Disposition: attachment; filename=01-file_browse.diff
Content-Type: text/x-patch; name=01-file_browse.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur policy.old/macros/base_user_macros.te policy.old2/macros/base_user_macros.te
--- policy.old/macros/base_user_macros.te	2005-04-29 12:20:50.000000000 -0400
+++ policy.old2/macros/base_user_macros.te	2005-05-07 21:31:06.000000000 -0400
@@ -68,7 +68,14 @@
 allow $1_t dri_device_t:chr_file getattr;
 dontaudit $1_t dri_device_t:chr_file rw_file_perms;
 
-file_browse_domain($1_t)
+# Supress ls denials:
+# getattr() - ls -l
+# search_dir() - symlink path resolution
+# read_dir() - deep ls: ls parent/...
+
+dontaudit_getattr($1_t)
+dontaudit_search_dir($1_t)
+dontaudit_read_dir($1_t)
 
 # allow ptrace
 can_ptrace($1_t, $1_t)
diff -aur policy.old/macros/global_macros.te policy.old2/macros/global_macros.te
--- policy.old/macros/global_macros.te	2005-05-07 18:59:33.000000000 -0400
+++ policy.old2/macros/global_macros.te	2005-05-07 21:25:35.000000000 -0400
@@ -156,7 +156,6 @@
 r_dir_file($1, locale_t)
 ')
 
-
 ###################################
 #
 # access_terminal(domain, typeprefix)
@@ -620,23 +619,25 @@
 allow $1_t etc_t:dir r_dir_perms;
 ')
 
-# Do not flood message log, if the user does a browse
-define(`file_browse_domain', `
+# Dontaudit macros to prevent flooding the log
 
-# Regular files/directories that are not security sensitive
+define(`dontaudit_getattr', `
 dontaudit $1 file_type - secure_file_type:dir_file_class_set getattr; 
-dontaudit $1 file_type - secure_file_type:dir { read search };
-
-# /dev
-dontaudit $1 dev_fs:dir_file_class_set getattr;
-dontaudit $1 dev_fs:dir { read search };
-
-# /proc
-dontaudit $1 sysctl_t:dir_file_class_set getattr;
-dontaudit $1 proc_fs:dir { read search };
-
-')dnl end file_browse_domain
-
+dontaudit $1 unlabeled_t:dir_file_class_set getattr;
+dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir_file_class_set getattr;
+')dnl end dontaudit_getattr 
+
+define(`dontaudit_search_dir', `
+dontaudit $1 file_type - secure_file_type:dir search;
+dontaudit $1 unlabeled_t:dir search;
+dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir search;
+')dnl end dontaudit_search_dir
+
+define(`dontaudit_read_dir', `
+dontaudit $1 file_type - secure_file_type:dir read;
+dontaudit $1 unlabeled_t:dir read;
+dontaudit $1 { fs_type proc_fs dev_fs sysctl_type }:dir read;
+')dnl end dontaudit_read_dir
 
 # Define legacy_domain  for legacy binaries (java)
 # "legacy" binary == lacks PT_GNU_STACK header, i.e. built with an old
diff -aur policy.old/macros/program/mozilla_macros.te policy.old2/macros/program/mozilla_macros.te
--- policy.old/macros/program/mozilla_macros.te	2005-04-23 20:25:40.000000000 -0400
+++ policy.old2/macros/program/mozilla_macros.te	2005-05-07 21:33:22.000000000 -0400
@@ -16,7 +16,7 @@
 # provided separately in domains/program/mozilla.te. 
 #
 define(`mozilla_domain',`
-type $1_mozilla_t, domain, web_client_domain, privlog;
+type $1_mozilla_t, domain, web_client_domain, nscd_client_domain, privlog;
 
 # Type transition
 if (! disable_mozilla_trans) {
@@ -28,8 +28,12 @@
 home_domain($1, mozilla)
 x_client_domain($1_mozilla, $1)
 
-# Browse files
-file_browse_domain($1_mozilla_t)
+# GNOME Open/Save As dialogs
+dontaudit_getattr($1_mozilla_t)
+dontaudit_search_dir($1_mozilla_t)
+
+# Look for plugins 
+allow $1_mozilla_t bin_t:dir { getattr read search };
 
 can_network_client($1_mozilla_t)
 allow $1_mozilla_t ftp_port_t:tcp_socket name_connect;
diff -aur policy.old/macros/program/mplayer_macros.te policy.old2/macros/program/mplayer_macros.te
--- policy.old/macros/program/mplayer_macros.te	2005-04-30 09:13:55.000000000 -0400
+++ policy.old2/macros/program/mplayer_macros.te	2005-05-07 21:38:54.000000000 -0400
@@ -6,9 +6,9 @@
 # mplayer_domains(user) declares domains for mplayer, gmplayer,
 # and mencoder
 
-##############################################
-#    mplayer_common(user, mplayer domain)    #
-##############################################
+#####################################################
+#    mplayer_common(role_prefix, mplayer_domain)    #
+#####################################################
 
 define(`mplayer_common',`
 
@@ -62,28 +62,28 @@
 }
 ')
 
-############################
-#  mplayer_domain(user)    #
-############################
+###################################
+#  mplayer_domain(role_prefix)    #
+###################################
 
 define(`mplayer_domain',`
 
-type $1_mplayer_t, domain;
+type $1_mplayer_t, domain, nscd_client_domain;
 
 # Type transition
 domain_auto_trans($1_t, mplayer_exec_t, $1_mplayer_t)
 role $1_r types $1_mplayer_t;
 
-# Home access, X access, Browse files
+# Home access, X access
 home_domain($1, mplayer)
 x_client_domain($1_mplayer, $1)
-file_browse_domain($1_mplayer_t)
 
 # Mplayer common stuff
 mplayer_common($1, mplayer)
 
 # Fork 
 allow $1_mplayer_t self:process { fork signal_perms getsched };
+allow $1_mplayer_t self:fifo_file rw_file_perms;
 
 # Audio, alsa.conf
 allow $1_mplayer_t sound_device_t:chr_file rw_file_perms;
@@ -101,11 +101,35 @@
 allow $1_mplayer_t $1_mplayer_tmpfs_t:file execute;
 }
 
+#======gmplayer gui==========#
+# File dialogs
+dontaudit_getattr($1_mplayer_t)
+dontaudit_read_dir($1_mplayer_t)
+dontaudit_search_dir($1_mplayer_t)
+
+# Unfortunately the ancient file dialog starts in /
+allow $1_mplayer_t home_root_t:dir read;
+
+# Read /etc/mtab
+allow $1_mplayer_t etc_runtime_t:file { read getattr };
+
+# Run bash/sed (??) 
+allow $1_mplayer_t bin_t:dir search;
+allow $1_mplayer_t bin_t:lnk_file read;
+can_exec($1_mplayer_t, bin_t)
+can_exec($1_mplayer_t, shell_exec_t)
+#============================#
+
 ') dnl end mplayer_domain
 
-############################
-#  mencoder_domain(user)   #
-############################
+###################################
+#  mencoder_domain(role_prefix)   #
+###################################
 
 define(`mencoder_domain',`
 
@@ -125,7 +149,7 @@
 ') dnl end mencoder_domain
 
 #############################
-#  mplayer_domains(user)    #
+#  mplayer_domains(role)    #
 #############################
 
 define(`mplayer_domains', `

--=-Qc//SJlAsQQAvOyfo9Mx
Content-Disposition: attachment; filename=02-mozilla_gift_misc.diff
Content-Type: text/x-patch; name=02-mozilla_gift_misc.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur policy.old2/macros/program/gift_macros.te policy.old3/macros/program/gift_macros.te
--- policy.old2/macros/program/gift_macros.te	2005-05-07 21:54:09.000000000 -0400
+++ policy.old3/macros/program/gift_macros.te	2005-05-07 21:56:48.000000000 -0400
@@ -17,9 +17,10 @@
 domain_auto_trans($1_t, gift_exec_t, $1_gift_t)
 role $1_r types $1_gift_t;
 
-# X access, Home files 
+# X access, Home files, /tmp
 x_client_domain($1_gift, $1)
 home_domain($1, gift)
+tmp_domain($1_gift)
 
 uses_shlib($1_gift_t)
 read_locale($1_gift_t)
@@ -32,6 +33,7 @@
 
 # Self permissions
 allow $1_gift_t self:process getsched;
+allow $1_gift_t self:fifo_file { read write };
 
 # Fonts, icons
 r_dir_file($1_gift_t, usr_t)
@@ -104,7 +106,7 @@
 home_domain_access($1_giftd_t, $1, gift)
 	
 # Allow networking
-allow $1_giftd_t port_t:tcp_socket name_bind;
+allow $1_giftd_t port_t:tcp_socket { name_bind name_connect };
 allow $1_giftd_t port_t:udp_socket name_bind;
 can_network_server($1_giftd_t)
 can_network_client($1_giftd_t)
diff -aur policy.old2/macros/program/mozilla_macros.te policy.old3/macros/program/mozilla_macros.te
--- policy.old2/macros/program/mozilla_macros.te	2005-05-07 21:33:22.000000000 -0400
+++ policy.old3/macros/program/mozilla_macros.te	2005-05-07 21:50:29.000000000 -0400
@@ -16,6 +16,7 @@
 # provided separately in domains/program/mozilla.te. 
 #
 define(`mozilla_domain',`
+
 type $1_mozilla_t, domain, web_client_domain, nscd_client_domain, privlog;
 
 # Type transition
@@ -58,6 +59,12 @@
 allow $1_mozilla_t self:process { fork signal_perms setrlimit setsched getsched };
 
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
+
+# Access /proc
+allow $1_mozilla_t proc_t:dir search;
+allow $1_mozilla_t proc_t:file { getattr read };
+allow $1_mozilla_t proc_t:lnk_file read;
+
 allow $1_mozilla_t var_lib_t:file { getattr read };
 allow $1_mozilla_t { random_device_t urandom_device_t }:chr_file { getattr ioctl read };
 allow $1_mozilla_t self:socket create_socket_perms;
@@ -70,8 +77,6 @@
 can_exec($1_mozilla_t, bin_t)
 allow $1_mozilla_t bin_t:lnk_file read;
 allow $1_mozilla_t device_t:dir r_dir_perms;
-allow $1_mozilla_t proc_t:file { getattr read };
-allow $1_mozilla_t proc_t:lnk_file read;
 allow $1_mozilla_t self:dir search;
 allow $1_mozilla_t self:lnk_file read;
 r_dir_file($1_mozilla_t, proc_net_t)
@@ -91,20 +96,6 @@
 # Execute downloaded programs.
 can_exec($1_mozilla_t, $1_mozilla_tmp_t)
 
-# Use printer
-ifdef(`lpr.te', `
-domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
-
-# Print document
-allow $1_lpr_t $1_mozilla_tmp_t:file rw_file_perms;
-
-# Suppress history.fop denial
-dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
-
-dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
-dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
-')
-
 # ORBit sockets
 file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_tmp_t)
 can_unix_connect($1_t, $1_mozilla_t)
@@ -148,6 +139,21 @@
 javaplugin_domain($1_mozilla, $1)
 ')
 
+
+# Use printer
+ifdef(`lpr.te', `
+domain_auto_trans($1_mozilla_t, lpr_exec_t, $1_lpr_t)
+
+# Print document
+allow $1_lpr_t $1_mozilla_tmp_t:file rw_file_perms;
+
+# Suppress history.fop denial
+dontaudit $1_lpr_t $1_mozilla_home_t:file { read write };
+
+dontaudit $1_lpr_t $1_mozilla_t:tcp_socket { read write };
+dontaudit $1_lpr_t $1_mozilla_t:unix_stream_socket { read write };
+')
+
 # Mplayer plugin
 ifdef(`mplayer.te', `
 domain_auto_trans($1_mozilla_t, mplayer_exec_t, $1_mplayer_t)
@@ -155,9 +161,10 @@
 # Read mozilla content in /tmp
 r_dir_file($1_mplayer_t, $1_mozilla_tmp_t);
 
-# FIXME: why does it need this?
+# Suppress history.fop denial
 dontaudit $1_mplayer_t $1_mozilla_home_t:file write;
-allow $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
+
+dontaudit $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
 ')dnl end if mplayer.te  
 
 if (allow_execmem) {
@@ -166,6 +173,7 @@
 if (allow_execmod) {
 allow $1_mozilla_t texrel_shlib_t:file execmod;
 }
+
 dbusd_client(system, $1_mozilla)
 ifdef(`apache.te', `
 ifelse($1, sysadm, `', `

--=-Qc//SJlAsQQAvOyfo9Mx
Content-Disposition: attachment; filename=03-genhomedircon-USER.diff
Content-Type: text/x-patch; name=03-genhomedircon-USER.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- genhomedircon.old	2005-04-27 15:26:47.000000000 -0400
+++ genhomedircon	2005-05-08 21:57:35.000000000 -0400
@@ -357,16 +357,22 @@
 		return udict
 
 	def getHomeDirContext(self, user, home, role):
-		ret="\n\n#\n# Context for user %s\n#\n\n" % user
+		ret="\n\n#\n# Home Context for user %s\n#\n\n" % user
 		rc=commands.getstatusoutput("grep '^HOME_DIR' %s | sed -e 's|HOME_DIR|%s|' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), home, role, user))
 		return ret + rc[1] + "\n"
 
+	def getUserContext(self, user, sel_user, role):
+		ret="\n\n#\n# Other Context for user %s\n#\n\n" % user
+		rc=commands.getstatusoutput("grep 'USER' %s | sed -e 's/USER/%s/' -e 's/ROLE/%s/' -e 's/system_u/%s/'" % (self.getHomeDirTemplate(), user, role, sel_user))
+		return ret + rc[1] + "\n"
+
 	def genHomeDirContext(self):
 		users = self.getUsers()
 		ret=""
 		# Fill in HOME and ROLE for users that are defined
 		for u in users.keys():
 			ret += self.getHomeDirContext (u, users[u]["home"], users[u]["role"])
+			ret += self.getUserContext (u, u, users[u]["role"])
 		return ret+"\n"
 
 	def checkExists(self, home):
@@ -428,6 +434,7 @@
 		ret= self.heading()
 		for h in self.getHomeDirs():
 			ret += self.getHomeDirContext ("user_u" , h+'/[^/]*', "user")
+			ret += self.getUserContext(".*", "user_u", "user") + "\n"
 			ret += self.getHomeRootContext(h)
 		ret += self.genHomeDirContext()
 		return ret

--=-Qc//SJlAsQQAvOyfo9Mx
Content-Disposition: attachment; filename=03-Makefile-USER.diff
Content-Type: text/x-patch; name=03-Makefile-USER.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- Makefile	2005-04-27 16:02:07.000000000 -0400
+++ Makefile.new	2005-04-27 16:02:50.000000000 -0400
@@ -221,7 +221,7 @@
 	@echo "Building file contexts files..."
 	@m4 $(M4PARAM) $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) > $@.tmp
 	@grep -v -e HOME -e ROLE $@.tmp > $@
-	@grep -e HOME -e ROLE $@.tmp  > $(HOMEDIR_TEMPLATE)
+	@grep -e HOME -e ROLE -e USER $@.tmp  > $(HOMEDIR_TEMPLATE)
 	@-rm $@.tmp
 
 # Create a tags-file for the policy:

--=-Qc//SJlAsQQAvOyfo9Mx
Content-Disposition: attachment; filename=03-orbit.diff
Content-Type: text/x-patch; name=03-orbit.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur policy.old3/domains/program/orbit.te policy.old4/domains/program/orbit.te
--- policy.old3/domains/program/orbit.te	2005-05-08 06:00:35.000000000 -0400
+++ policy.old4/domains/program/orbit.te	2005-05-07 21:21:27.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# ORBit related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Look in orbit_macros.te
diff -aur policy.old3/file_contexts/program/orbit.fc policy.old4/file_contexts/program/orbit.fc
--- policy.old3/file_contexts/program/orbit.fc	2005-05-08 06:28:33.000000000 -0400
+++ policy.old4/file_contexts/program/orbit.fc	2005-05-09 02:41:05.000000000 -0400
@@ -0,0 +1,3 @@
+/tmp/orbit-USER(-.*)?		-d      system_u:object_r:ROLE_orbit_tmp_t
+/tmp/orbit-USER(-.*)?/.*	--	<<none>>
+/tmp/orbit-USER/bonobo.*	--	system_u:object_r:ROLE_orbit_tmp_t
diff -aur policy.old3/macros/base_user_macros.te policy.old4/macros/base_user_macros.te
--- policy.old3/macros/base_user_macros.te	2005-05-07 22:07:04.000000000 -0400
+++ policy.old4/macros/base_user_macros.te	2005-05-08 06:11:49.000000000 -0400
@@ -198,6 +198,9 @@
 ifdef(`mplayer.te', `mplayer_domains($1)')
 ifdef(`gift.te', `gift_domains($1)')
 
+# ORBit
+orbit_domain($1, $1)
+
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
 
diff -aur policy.old3/macros/program/gift_macros.te policy.old4/macros/program/gift_macros.te
--- policy.old3/macros/program/gift_macros.te	2005-05-07 21:56:48.000000000 -0400
+++ policy.old4/macros/program/gift_macros.te	2005-05-08 07:11:57.000000000 -0400
@@ -55,15 +55,10 @@
 allow $1_gift_t etc_t:file { getattr read };
 allow $1_gift_t etc_runtime_t:file { getattr read };
 
-# Tmp/ORBit
-tmp_domain($1_gift)
-file_type_auto_trans($1_gift_t, $1_tmp_t, $1_gift_tmp_t)
-can_unix_connect($1_t, $1_gift_t)
-can_unix_connect($1_gift_t, $1_t)
-allow $1_t $1_gift_tmp_t:sock_file write;
-allow $1_gift_t $1_tmp_t:file { getattr read write lock };
-allow $1_gift_t $1_tmp_t:sock_file { read write };
-dontaudit $1_gift_t $1_tmp_t:dir setattr;
+# ORBit connection to ROLE_t
+# FIXME: restrict further
+orbit_domain($1_gift, $1)
+orbit_connect($1_gift, $1)
 
 # Access random device
 allow $1_gift_t urandom_device_t:chr_file { read getattr ioctl };
diff -aur policy.old3/macros/program/mozilla_macros.te policy.old4/macros/program/mozilla_macros.te
--- policy.old3/macros/program/mozilla_macros.te	2005-05-07 21:50:29.000000000 -0400
+++ policy.old4/macros/program/mozilla_macros.te	2005-05-08 06:08:53.000000000 -0400
@@ -58,6 +58,7 @@
 # Fork, set resource limits and scheduling info.
 allow $1_mozilla_t self:process { fork signal_perms setrlimit setsched getsched };
 
+# Fonts, icons
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
 
 # Access /proc
@@ -96,13 +97,10 @@
 # Execute downloaded programs.
 can_exec($1_mozilla_t, $1_mozilla_tmp_t)
 
-# ORBit sockets
-file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_tmp_t)
-can_unix_connect($1_t, $1_mozilla_t)
-allow $1_t $1_mozilla_tmp_t:sock_file write;
-allow $1_mozilla_t $1_tmp_t:file { read write lock };
-allow $1_mozilla_t $1_tmp_t:sock_file { read write };
-dontaudit $1_mozilla_t $1_tmp_t:dir setattr;
+# ORBit connection to ROLE_t
+# FIXME: restrict further
+orbit_domain($1_mozilla, $1)
+orbit_connect($1_mozilla, $1)
 
 # Allow mozilla to read user home content
 if (mozilla_readhome || mozilla_writehome) {
diff -aur policy.old3/macros/program/orbit_macros.te policy.old4/macros/program/orbit_macros.te
--- policy.old3/macros/program/orbit_macros.te	2005-05-08 06:04:47.000000000 -0400
+++ policy.old4/macros/program/orbit_macros.te	2005-05-09 03:20:08.000000000 -0400
@@ -0,0 +1,43 @@
+#
+# ORBit related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# orbit_domain(prefix, role) - create ORBit sockets
+# orbit_connect(type1, type2) - allow communication through ORBit sockets 
+
+define(`orbit_domain', `
+ifdef(`$1_orbit_tmp_t_defined',`', `
+define(`$1_orbit_tmp_t_defined')
+
+# Create the user orbit directory if necessary
+allow $1_t $2_orbit_tmp_t:dir create_dir_perms;
+
+# Set its type - libselinux integration
+can_setfscreate($1_t)
+can_getsecurity($1_t)
+r_dir_file($1_t, selinux_config_t)
+r_dir_file($1_t, file_context_t)
+allow $1_t default_context_t:dir search;
+
+# Type for ORBit sockets
+type $1_orbit_tmp_t, file_type, sysadmfile, tmpfile;
+file_type_auto_trans($1_t, $2_orbit_tmp_t, $1_orbit_tmp_t)
+
+# Create the sockets
+allow $1_t self:unix_stream_socket create_stream_socket_perms;
+allow $1_t self:unix_dgram_socket create_socket_perms;
+
+# Write to bonobo files
+allow $1_t $2_orbit_tmp_t:file { getattr read write lock };
+dontaudit $1_t $2_orbit_tmp_t:dir setattr;
+
+')
+')
+
+define(`orbit_connect', `
+can_unix_connect($1_t, $2_t)
+can_unix_connect($2_t, $1_t)
+allow $1_t $2_orbit_tmp_t:sock_file { read write };
+allow $2_t $1_orbit_tmp_t:sock_file { read write };
+')

--=-Qc//SJlAsQQAvOyfo9Mx
Content-Disposition: attachment; filename=03-orbit-matchpatchcon.diff
Content-Type: text/x-patch; name=03-orbit-matchpatchcon.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur ORBit2.old/configure.in ORBit2/configure.in
--- ORBit2.old/configure.in	2005-05-07 14:05:34.000000000 -0400
+++ ORBit2/configure.in	2005-05-07 15:02:25.000000000 -0400
@@ -293,6 +293,27 @@
         AC_DEFINE(HAVE_INET_PTON, 1, [Define if inet_pton() is available])
 fi
 
+# Checks for SELinux
+AC_MSG_CHECKING(for SELinux support)
+AC_ARG_ENABLE(selinux, AC_HELP_STRING([--enable-selinux], [enable SELinux support]),
+[
+	AC_MSG_RESULT(yes) 
+	AC_CHECK_LIB(selinux, is_selinux_enabled, 
+	[
+		AC_DEFINE(WITH_SELINUX, 1, [Define if you want ORBit to be compiled with selinux support])
+		SELINUX_CFLAGS="-I/usr/include/selinux"
+		SELINUX_LDFLAGS="-lselinux"
+	],
+	[
+		AC_MSG_WARN([libselinux not found, compiling without SELinux support])
+	])	
+],
+[ 
+	AC_MSG_RESULT(no)
+])
+AC_SUBST(SELINUX_LDFLAGS)
+AC_SUBST(SELINUX_CFLAGS)
+
 # AC_CHECK_TYPE doesn't work here.
 AC_MSG_CHECKING([for socklen_t])
 AC_TRY_COMPILE(
diff -aur ORBit2.old/src/orb/GIOP/giop.c ORBit2/src/orb/GIOP/giop.c
--- ORBit2.old/src/orb/GIOP/giop.c	2005-05-07 13:14:18.000000000 -0400
+++ ORBit2/src/orb/GIOP/giop.c	2005-05-07 17:46:18.000000000 -0400
@@ -17,6 +17,11 @@
 #include <orbit/util/orbit-genrand.h>
 #include <glib/gstdio.h>
 
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
+#endif
+
+
 /* FIXME: need to clean this up at shutdown */
 static int      corba_wakeup_fds[2];
 #define WAKEUP_POLL  corba_wakeup_fds [0]
@@ -115,10 +120,16 @@
 giop_tmpdir_init (void)
 {
 	const char *tmp_root;
-	char *dirname;
+	char *dirname, *fullname;
 	char *safe_dir = NULL;
 	long iteration = 0;
 	static gboolean inited = FALSE;
+#ifdef WITH_SELINUX 
+	security_context_t prev_ctx = NULL;
+	security_context_t tmp_ctx = NULL;
+	int selinux_enabled = (is_selinux_enabled() > 0);
+	int context_changed = 0;
+#endif
 
 	if (inited)
 		return;
@@ -127,6 +138,24 @@
 	tmp_root = g_get_tmp_dir ();
 	dirname = g_strdup_printf ("orbit-%s",
 				   g_get_user_name ());
+	fullname = g_build_filename(tmp_root, dirname, NULL);
+
+#ifdef WITH_SELINUX
+	if (selinux_enabled) {
+		if (getfscreatecon(&prev_ctx) < 0) {
+			g_error("libORBit: Cannot read current security context");
+			goto exit;
+		}
+
+		if (matchpathcon(fullname, 0700, &tmp_ctx) >= 0) {
+			if (setfscreatecon(tmp_ctx) < 0) {
+				g_error("libORBit: Cannot set new security context");
+				goto exit;
+			} else context_changed = 1;
+		}
+	}
+#endif
+
 	while (!safe_dir) {
 		char *newname;
 
@@ -138,7 +167,7 @@
 		}
 
 		if (iteration == 0)
-			newname = g_build_filename (tmp_root, dirname, NULL);
+			newname = fullname;
 		else {
 			struct {
 				guint32 a;
@@ -179,6 +208,7 @@
 				break;
 			}
 		}
+
 #if defined (HAVE_UTIME_H) && !defined (G_OS_WIN32)
 		/* This seems pretty useless, forget it on Win32 */
 
@@ -197,6 +227,17 @@
 			g_error ("Cannot find a safe socket path in '%s'", tmp_root);
 	}
 
+	exit:
+
+#ifdef WITH_SELINUX
+	if (selinux_enabled) {
+		if (context_changed && (setfscreatecon(prev_ctx) < 0))
+			g_error ("libORBit: Could not restore previous security context");
+		freecon(prev_ctx);
+		freecon(tmp_ctx);
+	}
+#endif
+
 	g_free (safe_dir);
 	g_free (dirname);
 }
diff -aur ORBit2.old/src/orb/GIOP/Makefile.am ORBit2/src/orb/GIOP/Makefile.am
--- ORBit2.old/src/orb/GIOP/Makefile.am	2005-05-07 14:48:33.000000000 -0400
+++ ORBit2/src/orb/GIOP/Makefile.am	2005-05-07 15:14:38.000000000 -0400
@@ -6,7 +6,8 @@
 	$(ORBIT_DEBUG_CFLAGS)		\
 	$(DISABLE_DEPRECATED_CFLAGS)	\
 	$(LOCAL_LINC_CFLAGS)		\
-	$(ORBIT_CFLAGS)
+	$(ORBIT_CFLAGS)			\
+	$(SELINUX_CFLAGS)
 
 noinst_LTLIBRARIES=libGIOP.la
 
diff -aur ORBit2.old/src/orb/Makefile.am ORBit2/src/orb/Makefile.am
--- ORBit2.old/src/orb/Makefile.am	2005-05-07 15:15:01.000000000 -0400
+++ ORBit2/src/orb/Makefile.am	2005-05-07 15:15:54.000000000 -0400
@@ -20,6 +20,7 @@
 	-version-info $(LT_VERSION)   \
 	-no-undefined		      \
 	$(ORBIT_LIBS)                 \
+	$(SELINUX_LDFLAGS)            \
 	-lpopt
 
 libORBit_2_la_LIBADD= \

--=-Qc//SJlAsQQAvOyfo9Mx
Content-Disposition: attachment; filename=04-gconfd.diff
Content-Type: text/x-patch; name=04-gconfd.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur policy.old4/domains/program/gconf.te policy.old5/domains/program/gconf.te
--- policy.old4/domains/program/gconf.te	2005-05-08 06:24:57.000000000 -0400
+++ policy.old5/domains/program/gconf.te	2005-05-08 06:56:46.000000000 -0400
@@ -0,0 +1,12 @@
+# DESC - GConf preference daemon
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Type for executable
+type gconfd_exec_t, file_type, exec_type, sysadmfile;
+
+# Type for /etc files
+type gconf_etc_t, file_type, sysadmfile;
+
+# Everything else is in macros/gconfd_macros.te
diff -aur policy.old4/domains/program/gnome.te policy.old5/domains/program/gnome.te
--- policy.old4/domains/program/gnome.te	2005-05-08 05:58:53.000000000 -0400
+++ policy.old5/domains/program/gnome.te	2005-05-08 07:21:37.000000000 -0400
@@ -0,0 +1,7 @@
+#
+# GNOME related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+# Look in gnome_macros.te
diff -aur policy.old4/file_contexts/program/gconf.fc policy.old5/file_contexts/program/gconf.fc
--- policy.old4/file_contexts/program/gconf.fc	2005-05-08 07:55:08.000000000 -0400
+++ policy.old5/file_contexts/program/gconf.fc	2005-05-09 00:39:02.000000000 -0400
@@ -0,0 +1,5 @@
+/usr/libexec/gconfd-2	--	system_u:object_r:gconfd_exec_t
+/etc/gconf(/.*)?		system_u:object_r:gconf_etc_t
+HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_gconfd_home_t
+HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_gconfd_home_t
+/tmp/gconfd-USER(/.*)?		system_u:object_r:ROLE_gconfd_tmp_t
diff -aur policy.old4/file_contexts/program/mozilla.fc policy.old5/file_contexts/program/mozilla.fc
--- policy.old4/file_contexts/program/mozilla.fc	2005-05-08 06:28:24.000000000 -0400
+++ policy.old5/file_contexts/program/mozilla.fc	2005-05-08 07:00:14.000000000 -0400
@@ -3,8 +3,6 @@
 HOME_DIR/\.netscape(/.*)?	system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/\.mozilla(/.*)?	system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/\.phoenix(/.*)?	system_u:object_r:ROLE_mozilla_home_t
-HOME_DIR/\.gconfd(/.*)?		system_u:object_r:ROLE_mozilla_home_t
-HOME_DIR/\.gconf(/.*)?		system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/\.gnome2/epiphany(/.*)? system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/My.Downloads(/.*)?	system_u:object_r:ROLE_mozilla_home_t
 HOME_DIR/\.java(/.*)?		system_u:object_r:ROLE_mozilla_home_t
diff -aur policy.old4/macros/base_user_macros.te policy.old5/macros/base_user_macros.te
--- policy.old4/macros/base_user_macros.te	2005-05-08 06:11:49.000000000 -0400
+++ policy.old5/macros/base_user_macros.te	2005-05-08 07:19:45.000000000 -0400
@@ -183,7 +183,6 @@
 ifdef(`tvtime.te', `tvtime_domain($1)')
 ifdef(`mozilla.te', `mozilla_domain($1)')
 ifdef(`samba.te', `samba_domain($1)')
-ifdef(`games.te', `games_domain($1)')
 ifdef(`gpg.te', `gpg_domain($1)')
 ifdef(`xauth.te', `xauth_domain($1)')
 ifdef(`startx.te', `xserver_domain($1)')
@@ -196,10 +195,13 @@
 ifdef(`uml.te', `uml_domain($1)')
 ifdef(`cdrecord.te', `cdrecord_domain($1)')
 ifdef(`mplayer.te', `mplayer_domains($1)')
-ifdef(`gift.te', `gift_domains($1)')
 
-# ORBit
-orbit_domain($1, $1)
+# GNOME
+ifdef(`gnome.te', `
+gnome_domain($1)
+ifdef(`games.te', `games_domain($1)')
+ifdef(`gift.te', `gift_domains($1)')
+')
 
 # Instantiate a derived domain for user cron jobs.
 ifdef(`crond.te', `crond_domain($1)')
diff -aur policy.old4/macros/program/games_domain.te policy.old5/macros/program/games_domain.te
--- policy.old4/macros/program/games_domain.te	2005-05-08 06:20:52.000000000 -0400
+++ policy.old5/macros/program/games_domain.te	2005-05-08 07:23:41.000000000 -0400
@@ -55,6 +55,9 @@
 allow $1_games_t $1_home_dir_t:dir { read getattr search };
 allow $1_games_t $1_home_t:dir { read getattr };
 
+# Connect to gconf
+gconf_client($1_games, $1)
+
 create_dir_file($1_games_t, $1_tmp_t)
 allow $1_games_t $1_tmp_t:sock_file create_file_perms;
 
diff -aur policy.old4/macros/program/gconf_macros.te policy.old5/macros/program/gconf_macros.te
--- policy.old4/macros/program/gconf_macros.te	2005-05-08 07:55:42.000000000 -0400
+++ policy.old5/macros/program/gconf_macros.te	2005-05-09 03:20:17.000000000 -0400
@@ -0,0 +1,64 @@
+#
+# GConfd daemon  
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+
+#######################################
+# gconfd_domain(role_prefix)
+#
+
+define(`gconfd_domain', `
+
+# Type for daemon
+type $1_gconfd_t, domain, nscd_client_domain, privlog;
+
+# Transition from user type
+domain_auto_trans($1_t, gconfd_exec_t, $1_gconfd_t)
+role $1_r types $1_gconfd_t;
+
+allow $1_gconfd_t self:process { signal getsched };
+
+uses_shlib($1_gconfd_t)
+read_locale($1_gconfd_t)
+read_sysctl($1_gconfd_t)
+
+# Access .gconfd and .gconf
+home_domain($1, gconfd)
+
+# Access /etc/gconf
+r_dir_file($1_gconfd_t, gconf_etc_t)
+
+# Access /etc/nsswitch.conf
+allow $1_gconfd_t etc_t:file { read getattr };
+
+# /tmp/gconfd-USER
+tmp_domain($1_gconfd)
+
+# ORBit - create domain, connect to self(???)
+orbit_domain($1_gconfd, $1)
+orbit_connect($1_gconfd, $1_gconfd)
+
+# Read random device
+allow $1_gconfd_t urandom_device_t:chr_file { read getattr ioctl };
+
+') dnl gconf_domain
+
+#####################################
+# gconf_client(prefix, role_prefix)
+#
+
+define(`gconf_client', `
+
+# Launch the gconf daemon if necessary
+domain_auto_trans($1_t, gconfd_exec_t, $2_gconfd_t)
+
+# ORBit connection
+orbit_domain($1, $2)
+orbit_connect($1, $2_gconfd)
+
+# Read lock/ior
+allow $1_t $2_gconfd_tmp_t:dir { getattr search };
+allow $1_t $2_gconfd_tmp_t:file { getattr read }; 
+
+') dnl gconf_client 
diff -aur policy.old4/macros/program/gift_macros.te policy.old5/macros/program/gift_macros.te
--- policy.old4/macros/program/gift_macros.te	2005-05-08 07:11:57.000000000 -0400
+++ policy.old5/macros/program/gift_macros.te	2005-05-08 07:12:18.000000000 -0400
@@ -38,6 +38,9 @@
 # Fonts, icons
 r_dir_file($1_gift_t, usr_t)
 
+# Connect to gconf
+gconf_client($1_gift, $1)
+
 # Launch gift daemon
 allow $1_gift_t bin_t:dir search;
 allow $1_gift_t self:process { fork signal_perms getsched };
@@ -55,11 +58,6 @@
 allow $1_gift_t etc_t:file { getattr read };
 allow $1_gift_t etc_runtime_t:file { getattr read };
 
-# ORBit connection to ROLE_t
-# FIXME: restrict further
-orbit_domain($1_gift, $1)
-orbit_connect($1_gift, $1)
-
 # Access random device
 allow $1_gift_t urandom_device_t:chr_file { read getattr ioctl };
 
@@ -99,6 +97,9 @@
 
 # Access home domain
 home_domain_access($1_giftd_t, $1, gift)
+
+# Allow gift to create untrusted content
+create_dir_file($1_giftd_t, $1_untrusted_content_t)
 	
 # Allow networking
 allow $1_giftd_t port_t:tcp_socket { name_bind name_connect };
diff -aur policy.old4/macros/program/gnome_macros.te policy.old5/macros/program/gnome_macros.te
--- policy.old4/macros/program/gnome_macros.te	2005-05-08 05:59:14.000000000 -0400
+++ policy.old5/macros/program/gnome_macros.te	2005-05-08 07:24:28.000000000 -0400
@@ -0,0 +1,17 @@
+#
+# GNOME related types 
+#
+# Author: Ivan Gyurdiev <ivg2@cornell.edu>
+#
+# gnome_domain(role_prefix) - create GNOME domain
+
+define(`gnome_domain', `
+
+# FIXME: more to be added..
+
+gconfd_domain($1)
+gconf_client($1, $1)
+
+orbit_domain($1)
+
+') dnl gnome_domain
diff -aur policy.old4/macros/program/mozilla_macros.te policy.old5/macros/program/mozilla_macros.te
--- policy.old4/macros/program/mozilla_macros.te	2005-05-08 06:08:53.000000000 -0400
+++ policy.old5/macros/program/mozilla_macros.te	2005-05-08 07:17:11.000000000 -0400
@@ -61,6 +61,17 @@
 # Fonts, icons
 allow $1_mozilla_t usr_t:{ lnk_file file } { getattr read };
 
+# GNOME integration
+ifdef(`gnome.te', `
+
+# ORBit connection to ROLE_t
+# FIXME: restrict further
+orbit_domain($1_mozilla, $1)
+orbit_connect($1_mozilla, $1)
+
+gconf_client($1_mozilla, $1)
+')
+
 # Access /proc
 allow $1_mozilla_t proc_t:dir search;
 allow $1_mozilla_t proc_t:file { getattr read };
@@ -97,11 +108,6 @@
 # Execute downloaded programs.
 can_exec($1_mozilla_t, $1_mozilla_tmp_t)
 
-# ORBit connection to ROLE_t
-# FIXME: restrict further
-orbit_domain($1_mozilla, $1)
-orbit_connect($1_mozilla, $1)
-
 # Allow mozilla to read user home content
 if (mozilla_readhome || mozilla_writehome) {
 r_dir_file($1_mozilla_t, $1_home_t)

--=-Qc//SJlAsQQAvOyfo9Mx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
