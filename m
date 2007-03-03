Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l23N7G7p020184
	for <selinux@tycho.nsa.gov>; Sat, 3 Mar 2007 18:07:16 -0500
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l23N8eVa008726
	for <selinux@tycho.nsa.gov>; Sat, 3 Mar 2007 23:08:41 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: SELinux List <selinux@tycho.nsa.gov>
Message-Id: <44406275-10D4-4C48-A050-D8ECA4127216@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-2--764903415
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Changes to apt policy
Date: Sun, 4 Mar 2007 00:08:28 +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-2--764903415
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

Hi,

to get aptitude working quite nice a logfile and a lockfile have to  
be created. The patches attached should allow this. Also aptitude  
writes to the home directory $HOME/.aptitude where configfiles etc.  
are in. I tried to learn from the gpg and screen policy files how to  
handle such a situation (per_role_template) but please look at it and  
correct any mistakes ;-)

cheers,
Stefan


--Apple-Mail-2--764903415
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=apt.fc.patch
Content-Disposition: attachment;
	filename=apt.fc.patch

--- /usr/src/refpolicy-20061212/policy/modules/admin/apt.fc	2006-07-12 22:32:27.000000000 +0200
+++ policy/modules/admin/apt.fc	2007-03-03 23:59:41.000000000 +0100
@@ -11,3 +11,11 @@
 # package list repository
 /var/lib/apt(/.*)?			gen_context(system_u:object_r:apt_var_lib_t,s0)
 /var/lib/aptitude(/.*)?		gen_context(system_u:object_r:apt_var_lib_t,s0)
+
+# aptitude logfile
+/var/log/aptitude		--	gen_context(system_u:object_r:apt_log_t,s0)
+
+# /home
+ifdef(`strict_policy',`
+HOME_DIR/\.aptitude(/.*)?		gen_context(system_u:object_r:ROLE_home_apt_t,s0)
+')

--Apple-Mail-2--764903415
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=apt.if.patch
Content-Disposition: attachment;
	filename=apt.if.patch

--- /usr/src/refpolicy-20061212/policy/modules/admin/apt.if	2006-12-12 21:08:08.000000000 +0100
+++ policy/modules/admin/apt.if	2007-03-03 23:39:11.000000000 +0100
@@ -1,5 +1,67 @@
 ## <summary>APT advanced package toll.</summary>
 
+#######################################
+## <summary>
+##      The per role template for aptitude.
+## </summary>
+## <desc>
+##      <p>
+##      This template creates the types and rules for
+##	aptitude. This protects the configuration files
+##	for aptitude.
+##      </p>
+##      <p>
+##      This is invoked automatically for each user and
+##      generally does not need to be invoked directly
+##      by policy writers.
+##      </p>
+## </desc>
+## <param name="userdomain_prefix">
+##      <summary>
+##      The prefix of the user domain (e.g., user
+##      is the prefix for user_t).
+##      </summary>
+## </param>
+## <param name="userdomain">
+##      <summary>
+##      The user domain.
+##      </summary>
+## </param>
+## <param name="role">
+##      <summary>
+##      The role associated with the user.
+##      </summary>
+## </param>
+#
+template(`apt_per_role_template',`
+        gen_require(`
+                type apt_t, apt_exec_t, $1_home_dir_t;
+        ')
+
+	########################################
+	#
+	# Declarations
+	#
+
+        type $1_apt_t;
+        domain_type($1_apt_t)
+        domain_entry_file($1_apt_t,apt_exec_t)
+	role $3 types $1_apt_t;
+
+	type $1_home_apt_t;
+	files_type($1_home_apt_t)
+
+	########################################
+	#
+	# APT local policy
+	#
+
+	manage_dirs_pattern(apt_t,$1_home_apt_t,$1_home_apt_t)
+	manage_files_pattern(apt_t,$1_home_apt_t,$1_home_apt_t)
+
+	allow apt_t $1_home_dir_t:dir search;
+')
+
 ########################################
 ## <summary>
 ##	Execute apt programs in the apt domain.

--Apple-Mail-2--764903415
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=apt.te.patch
Content-Disposition: attachment;
	filename=apt.te.patch

--- /usr/src/refpolicy-20061212/policy/modules/admin/apt.te	2006-12-12 21:08:08.000000000 +0100
+++ policy/modules/admin/apt.te	2007-02-24 21:26:25.000000000 +0100
@@ -1,6 +1,10 @@
 
 policy_module(apt,1.1.0)
 
+gen_require(`
+	type var_log_t;
+')
+
 ########################################
 #
 # Declarations
@@ -26,6 +30,14 @@
 type apt_var_cache_t alias var_cache_apt_t;
 files_type(apt_var_cache_t)
 
+# lock file
+type apt_lock_t;
+files_lock_file(apt_lock_t)
+
+# logfile
+type apt_log_t;
+logging_log_file(apt_log_t)
+
 ########################################
 #
 # apt Local policy
@@ -46,6 +58,14 @@
 allow apt_t self:msgq create_msgq_perms;
 allow apt_t self:msg { send receive };
 
+# lock file access
+allow apt_t apt_lock_t:file { create_file_perms lock rw_file_perms };
+files_lock_filetrans(apt_t,apt_lock_t,file)
+
+# append to logfile
+allow apt_t var_log_t:dir search;
+append_files_pattern(apt_t,apt_log_t,apt_log_t)
+
 # Access /var/cache/apt files
 manage_files_pattern(apt_t,apt_var_cache_t,apt_var_cache_t)
 files_var_filetrans(apt_t,apt_var_cache_t,dir)

--Apple-Mail-2--764903415--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
