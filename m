Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2D5YODo016180
	for <selinux@tycho.nsa.gov>; Sun, 13 Mar 2005 00:34:24 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2D5QKj3010536
	for <selinux@tycho.nsa.gov>; Sun, 13 Mar 2005 05:26:20 GMT
Subject: user_trans/user_trans_boolean macro
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com
Content-Type: multipart/mixed; boundary="=-avykLzj+dOqVihodNSpo"
Date: Sun, 13 Mar 2005 00:33:36 -0500
Message-Id: <1110692016.29852.77.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-avykLzj+dOqVihodNSpo
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Is there anything wrong with this patch?

It continues to remove stuff from x_client_domain.
This time the type declaration is removed, along with 
the transboolean stuff. The transition stuff is placed
in new macros called user_trans and user_trans_boolean.

Points of interest:

- can_exec($1_$2_t, $2_exec_t)
I don't quite understand what this does, but I remember
domains needed it. It was also in the x_client rules.

- nscd_client_domain was removed for mplayer and mozilla.
I didn't see any problems. 

- tmp_domain for tvtime now allows for fifo_file. This
addresses a denial I noticed.

If there is nothing wrong with this patch, can I convert
other domains in macros/program to use this macro? 
Is it a problem if they don't have the above can_exec rule?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University

--=-avykLzj+dOqVihodNSpo
Content-Disposition: attachment; filename=user_trans_v0.diff
Content-Type: text/x-patch; name=user_trans_v0.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aur policy.old/macros/global_macros.te policy/macros/global_macros.te
--- policy.old/macros/global_macros.te	2005-03-11 21:55:06.000000000 -0500
+++ policy/macros/global_macros.te	2005-03-13 00:06:05.000000000 -0500
@@ -170,6 +170,37 @@
 allow $1 $2_devpts_t:chr_file { read write getattr ioctl };
 ') 
 
+##################################
+#
+# user_trans(user, target)
+#
+# Transition the user to the target domain
+#
+define(`user_trans', `
+domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
+can_exec($1_$2_t, $2_exec_t)
+role $1_r types $1_$2_t;
+')
+
+##################################
+#
+# user_trans_boolean(user, target)
+#
+# Transition the user to the target domain
+# For the user domain, do this conditional
+# on a boolean
+#
+define(`user_trans_boolean', `
+ifelse($1, user, `
+bool disable_user_$2 false;
+')
+role $1_r types $1_$2_t;
+if (! disable_user_$2) {
+domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
+can_exec($1_$2_t, $2_exec_t)
+}
+')
+
 #
 # general_proc_read_access(domain)
 #
diff -aur policy.old/macros/program/games_domain.te policy/macros/program/games_domain.te
--- policy.old/macros/program/games_domain.te	2005-03-10 14:32:25.000000000 -0500
+++ policy/macros/program/games_domain.te	2005-03-12 19:18:23.000000000 -0500
@@ -10,7 +10,14 @@
 #
 #
 define(`games_domain', `
-x_client_domain($1, `games', `, transitionbool')
+
+# Type transiton
+type $1_games_t, domain, nscd_client_domain;
+user_trans_boolean($1, games)
+
+# X access, Private tmp
+x_client_domain($1, games)
+tmp_domain($1_games)
 
 allow $1_games_t var_t:dir { search getattr };
 rw_dir_create_file($1_games_t, games_data_t)
@@ -29,7 +36,6 @@
 
 dontaudit $1_games_t sysctl_t:dir search;
 
-tmp_domain($1_games)
 allow $1_games_t urandom_device_t:chr_file { getattr ioctl read };
 ifdef(`xdm.te', `
 allow $1_games_t xdm_tmp_t:dir rw_dir_perms;
diff -aur policy.old/macros/program/gift_macros.te policy/macros/program/gift_macros.te
--- policy.old/macros/program/gift_macros.te	2005-03-11 21:34:13.000000000 -0500
+++ policy/macros/program/gift_macros.te	2005-03-13 00:21:22.000000000 -0500
@@ -12,20 +12,17 @@
 
 define(`gift_domain', `
 
-# Connect to X
-x_client_domain($1, gift, `')	
+# Type transition
+type $1_gift_t, domain, nscd_client_domain;
+user_trans($1, gift)
 
-# Transition
-domain_auto_trans($1_t, gift_exec_t, $1_gift_t)
-can_exec($1_gift_t, gift_exec_t)
-role $1_r types $1_gift_t;
+# X access, Home access
+x_client_domain($1, gift)
+home_domain($1, gift)
 
 # Self permissions
 allow $1_gift_t self:process getsched;
 
-# Home files
-home_domain($1, gift)
-
 # Fonts, icons
 r_dir_file($1_gift_t, usr_t)
 r_dir_file($1_gift_t, fonts_t)
diff -aur policy.old/macros/program/mozilla_macros.te policy/macros/program/mozilla_macros.te
--- policy.old/macros/program/mozilla_macros.te	2005-03-10 14:32:25.000000000 -0500
+++ policy/macros/program/mozilla_macros.te	2005-03-12 18:52:11.000000000 -0500
@@ -16,12 +16,11 @@
 # provided separately in domains/program/mozilla.te. 
 #
 define(`mozilla_domain',`
-x_client_domain($1, mozilla, `, web_client_domain, privlog, transitionbool')
+type $1_mozilla_t, domain, web_client_domain, privlog;
 
-# Configuration
+user_trans_boolean($1, mozilla)
 home_domain($1, mozilla)
-
-# Allow mozilla to browse files
+x_client_domain($1, mozilla)
 file_browse_domain($1_mozilla_t)
 
 allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;
diff -aur policy.old/macros/program/mplayer_macros.te policy/macros/program/mplayer_macros.te
--- policy.old/macros/program/mplayer_macros.te	2005-03-10 14:32:25.000000000 -0500
+++ policy/macros/program/mplayer_macros.te	2005-03-12 18:57:22.000000000 -0500
@@ -64,13 +64,13 @@
 
 define(`mplayer_domain',`
 
-# Derive from X client domain
-x_client_domain($1, `mplayer', `')
+# Type transition
+type $1_mplayer_t, domain;
+user_trans($1, mplayer)
 
-# Mplayer configuration here
+# Home access, X access, Browse files
 home_domain($1, mplayer)
-
-# Allow mplayer to browse files
+x_client_domain($1, mplayer)
 file_browse_domain($1_mplayer_t)
 
 # Mplayer common stuff
@@ -101,12 +101,8 @@
 # FIXME: privhome temporarily removed...
 type $1_mencoder_t, domain;
 
-# Transition
-domain_auto_trans($1_t, mencoder_exec_t, $1_mencoder_t)
-can_exec($1_mencoder_t, mencoder_exec_t)
-role $1_r types $1_mencoder_t;
-
-# Read home config
+# Transition, access mplayer home domain
+user_trans($1, mencoder)
 home_domain_access($1_mencoder_t, $1, mplayer)
 
 # Mplayer common stuff
diff -aur policy.old/macros/program/tvtime_macros.te policy/macros/program/tvtime_macros.te
--- policy.old/macros/program/tvtime_macros.te	2005-03-11 21:34:13.000000000 -0500
+++ policy/macros/program/tvtime_macros.te	2005-03-12 21:24:15.000000000 -0500
@@ -19,7 +19,13 @@
 ifdef(`tvtime.te', `
 define(`tvtime_domain',`
 
+# Type transition
+type $1_tvtime_t, domain, nscd_client_domain;
+user_trans($1, tvtime)
+
+# Home access, X access
 home_domain($1, tvtime)
+tmp_domain($1_tvtime, `', `{ file dir fifo_file }')
 x_client_domain($1, tvtime)
 
 allow $1_tvtime_t urandom_device_t:chr_file read;
@@ -28,7 +34,6 @@
 allow $1_tvtime_t sound_device_t:chr_file read;
 allow $1_tvtime_t $1_home_t:dir { getattr read search };
 allow $1_tvtime_t $1_home_t:file { getattr read };
-tmp_domain($1_tvtime)
 allow $1_tvtime_t self:capability { setuid sys_nice sys_resource };
 allow $1_tvtime_t self:process setsched;
 allow $1_tvtime_t usr_t:file { getattr read };
diff -aur policy.old/macros/program/x_client_macros.te policy/macros/program/x_client_macros.te
--- policy.old/macros/program/x_client_macros.te	2005-03-10 14:32:25.000000000 -0500
+++ policy/macros/program/x_client_macros.te	2005-03-12 18:45:53.000000000 -0500
@@ -37,39 +37,11 @@
 ')
 
 #
-# x_client_domain(domain_prefix)
+# x_client_domain(user, app)
 #
-# Define a derived domain for an X program when executed by
-# a user domain.  
-#
-# The type declaration for the executable type for this program ($2_exec_t)
-# must be provided separately!
-#
-# The first parameter is the base name for the domain/role (EG user or sysadm)
-# The second parameter is the program name (EG $2)
-# The third parameter is the attributes for the domain (if any)
+# Defines common X access rules for the user_app_t domain
 #
 define(`x_client_domain',`
-# Derived domain based on the calling user domain and the program.
-type $1_$2_t, domain, nscd_client_domain $3;
-
-ifelse(index(`$3', `transitionbool'), -1, `
-domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
-can_exec($1_$2_t, $2_exec_t)
-', `
-ifelse($1, user, `
-bool disable_$2 false;
-')
-# Transition from the user domain to the derived domain.
-if (! disable_$2) {
-domain_auto_trans($1_t, $2_exec_t, $1_$2_t)
-can_exec($1_$2_t, $2_exec_t)
-}
-')
-
-# The user role is authorized for this domain.
-role $1_r types $1_$2_t;
 
 # This domain is granted permissions common to most domains (including can_net)
 can_network($1_$2_t)

--=-avykLzj+dOqVihodNSpo--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
