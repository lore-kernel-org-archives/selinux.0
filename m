Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA22982
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 15:45:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA03312
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 19:44:16 GMT
Received: from mail.tresys.com (mail.tresys.com [66.22.20.205])
	by jazzswing.ncsc.mil  with ESMTP id TAA03307
	for <selinux@tycho.nsa.gov>; Thu, 1 Aug 2002 19:44:16 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "NSA Selinux Mailinglist" <selinux@tycho.nsa.gov>
Subject: RE: proposed patch: policy management
Date: Thu, 1 Aug 2002 15:47:54 -0400
Message-ID: <ACEHIKGIGFEDAIKEMMMIEEBKKFAA.mayerf@tresys.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0003_01C23972.CCCA7330"
In-Reply-To: <Pine.GSO.4.33.0207301607550.14015-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0003_01C23972.CCCA7330
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Ok attached is a new proposed policy management patches that (I hope)
addresses comments received.  I've made the diff from the latest sourceforge
head as suggest.  NOTE: I failed to generate a diff using cvs diff...which
seems to want me to cvs add my new files before including them in the patch
file using the -N option.  I can't do cvs add, even without committing the
changes, since the sourceforge site doesn't permit me access (as it should
not).  Probably my inexperience with CVS; I would welcome a private pointer
on what I was doing wrong.

The summary of changes are listed below.  Frank

==========================================

/attrib.te:
	1. add login_context attrib; not used in default policy but provided
	to allow tools to grant access to all files associated with initial
	contexts

./types/security.te
	1, removed sysadmfile from policy_src_t and policy_config_t;
	admin_marco.te will provide "temporary" access to policy_src_t as
	an interim measure.
	2. added default_context_t, with sysadmfile and new login_contexts
	attributes (left sysadmfile since it's reasonable for an administrator
	in default installations to edit these file with an editor).

./domain/programs/login.te
	1. Gave local_login_t and remote_login_t read access to
	default_context_t

./domains/program/crond.te
	1. add new login_contexts attribute to cron_context

./domains/programs/sshd.te
 	1. Gave sshd_t and sshd_login_t read access to default_context_t

./macros/admin_macro.te
	1. As temporary measure to allow sysadm_t the same current
	ability	to change policy src files, add the following rules

	allow $1_t policy_src_t:notdevfile_class_set create_file_perms;
	allow $1_t policy_src_t:dir create_dir_perms;

	2. Removed security_t:security load_policy access from macro;
	only load_policy_t needs this.

./domains/programs/checkpolicy.te (new)
	1. added types checkpolicy_t and checkpolicy_exec_t
	2. added checkpolicy rules

./domains/programs/load_policy.te (new)
	1. added types load_policy_t and load_policy_exec_t
	2. added load_policy rules


changes to filecontexts:
	1. added checkpolicy.fc (new)
	2. added load_policy.fc (new)
	3. within types.fc, added labels for following:
		/etc/security/selinux/src/
		/etc/security/default_context

./Makefile
	0. Did nothing with initrd stuff!
	1. Fixed policy.conf target to make tmp a dependent target.
	2. Install target invokes checkpolicy directly, and puts
	the results in the install dir (without gzip).
	3. New install-src target added to install policy source
	directory

Needed:
1. A new system installation procedure is probably needed to include
make install-src on initial system build.

2. zlib library built into checkpolicy

3. -o -g -m options in checkpolicy?



------=_NextPart_000_0003_01C23972.CCCA7330
Content-Type: application/octet-stream;
	name="policy.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="policy.patch"

diff -ruN ./Makefile ../new/Makefile=0A=
--- ./Makefile	Mon Jul 29 13:02:31 2002=0A=
+++ ../new/Makefile	Mon Jul 29 12:51:42 2002=0A=
@@ -3,10 +3,12 @@=0A=
 #=0A=
 # Targets:=0A=
 # =0A=
-# policy  - compile the policy configuration.=0A=
-# install - compile and install the policy configuration.=0A=
-# load    - compile, install, and load the policy configuration.=0A=
-# reload  - compile, install, and load/reload the policy configuration.=0A=
+# policy  - compile and install all policy configurations.=0A=
+# policy.conf - compile and install only the text policy configuration.=0A=
+# testpolicy - compile a test version of the test and binary policy =
configurations.=0A=
+# install - synonymous with policy.=0A=
+# load    - compile, install, and load all policy configurations.=0A=
+# reload  - compile, install, and load/reload all policy configuration.=0A=
 # relabel - relabel filesystems based on the file contexts =
configuration.=0A=
 #=0A=
 # The default target is 'policy'.=0A=
@@ -24,6 +26,9 @@=0A=
 INSTALLDIR =3D /etc/security/selinux=0A=
 LOADPATH =3D $(INSTALLDIR)/$(POLICYVER)=0A=
 INITRDLOADPATH =3D $(INSTALLDIR)/initrd-$(POLICYVER)=0A=
+SRCINSTALLDIR =3D $(INSTALLDIR)/src=0A=
+POLICYCONF =3D $(SRCINSTALLDIR)/policy.conf=0A=
+=0A=
 =0A=
 POLICYFILES =3D $(addprefix /usr/local/selinux/flask/,security_classes =
initial_sids access_vectors)=0A=
 ifeq ($(MLS),y)=0A=
@@ -39,11 +44,19 @@=0A=
 FCFILES=3Dfile_contexts/types.fc $(patsubst =
domains/program/%.te,file_contexts/program/%.fc, $(wildcard =
domains/program/*.te))=0A=
 =0A=
 =0A=
-policy: $(POLICYVER)=0A=
+policy: $(LOADPATH) =0A=
 =0A=
-$(POLICYVER):  tmp policy.conf $(CHECKPOLICY)=0A=
-	$(CHECKPOLICY) -o tmp/$@ policy.conf=0A=
-	gzip -c tmp/$@ > $@=0A=
+=0A=
+$(POLICYCONF): policy.conf=0A=
+	=0A=
+	=0A=
+$(SRCINSTALLDIR):=0A=
+	mkdir -p  $@ =0A=
+	=0A=
+=0A=
+testpolicy: policy.conf $(CHECKPOLICY)=0A=
+	$(CHECKPOLICY) -o tmp/$(POLICYVER) policy.conf=0A=
+	gzip -c tmp/$(POLICYVER)> $(POLICYVER)	=0A=
 =0A=
 tmp:=0A=
 	mkdir tmp=0A=
@@ -58,9 +71,11 @@=0A=
 =0A=
 install-initrd: $(INITRDLOADPATH)=0A=
 =0A=
-$(LOADPATH): $(POLICYVER)=0A=
+$(LOADPATH):  $(POLICYCONF) $(CHECKPOLICY)=0A=
 	mkdir -p $(INSTALLDIR)=0A=
-	install -m 644 -o root -g root $(POLICYVER) $(LOADPATH)=0A=
+	$(CHECKPOLICY) -o $@ $(POLICYCONF)=0A=
+# Note: Can't use install, so not sure how to deal with mode, user, and =
group=0A=
+#	other than by default.=0A=
 =0A=
 $(INITRDLOADPATH): initrd-$(POLICYVER)=0A=
 	mkdir -p $(INSTALLDIR)=0A=
@@ -72,8 +87,14 @@=0A=
 =0A=
 load: tmp/load=0A=
 =0A=
-policy.conf: $(POLICYFILES) =0A=
+install-src: =0A=
+	mkdir -p $(SRCINSTALLDIR)/policy=0A=
+	cp -R . $(SRCINSTALLDIR)/policy=0A=
+=0A=
+policy.conf: tmp $(POLICYFILES) $(SRCINSTALLDIR)=0A=
 	m4 -Imacros -s $(POLICYFILES) > policy.conf=0A=
+	install -m 644 -o root -g root policy.conf $(POLICYCONF)=0A=
+=0A=
 =0A=
 initrd-policy.conf: $(INITRDPOLICYFILES) =0A=
 	m4 -Imacros -s $(INITRDPOLICYFILES) > initrd-policy.conf=0A=
diff -ruN ./attrib.te ../new/attrib.te=0A=
--- ./attrib.te	Mon Jul 29 13:02:31 2002=0A=
+++ ../new/attrib.te	Mon Jul 29 12:51:41 2002=0A=
@@ -211,3 +211,16 @@=0A=
 # traffic sent to or received from the node.=0A=
 attribute node_type;=0A=
 =0A=
+=0A=
+##############################=0A=
+# Attributes for security policy types:=0A=
+#=0A=
+=0A=
+# The login_contexts attribute idenitifies the files used=0A=
+# to define default contexts for login and cron.=0A=
+attribute login_contexts;=0A=
+=0A=
+# The policyfiles attribute idenitified the files that are=0A=
+# used to build, modify, manage, and implement the SE Linux=0A=
+# security policy.=0A=
+attribute policyfiles;=0A=
diff -ruN ./domains/program/checkpolicy.te =
../new/domains/program/checkpolicy.te=0A=
--- ./domains/program/checkpolicy.te	Wed Dec 31 19:00:00 1969=0A=
+++ ../new/domains/program/checkpolicy.te	Mon Jul 29 12:51:41 2002=0A=
@@ -0,0 +1,62 @@=0A=
+#=0A=
+# Authors:  Frank Mayer, mayerf@tresys.com=0A=
+#=0A=
+=0A=
+###########################=0A=
+# =0A=
+# checkpolicy_t is the domain type for checkpolicy=0A=
+# checkpolicy_exec_t if file type for the executable=0A=
+=0A=
+type checkpolicy_t, domain;=0A=
+role sysadm_r types checkpolicy_t;=0A=
+=0A=
+type checkpolicy_exec_t, file_type, exec_type;=0A=
+=0A=
+##########################=0A=
+# =0A=
+# Rules=0A=
+=0A=
+domain_auto_trans(sysadm_t, checkpolicy_exec_t, checkpolicy_t)=0A=
+=0A=
+# able to create and modify binary policy files=0A=
+allow checkpolicy_t policy_config_t:dir rw_dir_perms;=0A=
+allow checkpolicy_t policy_config_t:notdevfile_class_set =
create_file_perms;=0A=
+=0A=
+###########################=0A=
+# constrain what checkpolicy can use as source files (i.e., no =0A=
+# every_domain macro)=0A=
+#=0A=
+=0A=
+# only allow read of policy source files=0A=
+allow checkpolicy_t policy_src_t:dir r_dir_perms;=0A=
+allow checkpolicy_t policy_src_t:notdevfile_class_set r_file_perms;=0A=
+=0A=
+# directory search permissions for path to source and binary policy =
files=0A=
+allow checkpolicy_t root_t:dir search;=0A=
+allow checkpolicy_t etc_t:dir search;=0A=
+=0A=
+# Read the devpts root directory.  =0A=
+allow checkpolicy_t devpts_t:dir r_dir_perms;=0A=
+ifdef(`sshd.te',=0A=
+`allow checkpolicy_t sshd_devpts_t:dir r_dir_perms;')=0A=
+=0A=
+# Other access=0A=
+allow checkpolicy_t sysadm_tty_device_t:chr_file { read write ioctl =
getattr };=0A=
+allow checkpolicy_t sysadm_devpts_t:chr_file { read write ioctl getattr =
};=0A=
+uses_shlib(checkpolicy_t)=0A=
+allow checkpolicy_t self:capability dac_override;=0A=
+=0A=
+# general_domain_access(checkpolicy_t)=0A=
+# general_proc_read_access(checkpolicy_t)=0A=
+=0A=
+=0A=
+############################=0A=
+# only checkpolicy_t should be able to modify binary policies=0A=
+#allow checkpolicy_t policy_config_t:dir rw_dir_perms;=0A=
+#allow checkpolicy_t policy_config_t:file rw_file_perms;=0A=
+=0A=
+=0A=
+##########################=0A=
+# Allow others to execute checkpolicy without a domain transition=0A=
+# so it can be used without privilege to write real binary policy file=0A=
+can_exec(user_t, checkpolicy_exec_t)=0A=
diff -ruN ./domains/program/crond.te ../new/domains/program/crond.te=0A=
--- ./domains/program/crond.te	Mon Jul 29 13:02:31 2002=0A=
+++ ../new/domains/program/crond.te	Mon Jul 29 12:51:41 2002=0A=
@@ -28,8 +28,6 @@=0A=
 # Type for the anacron executable.=0A=
 type anacron_exec_t, file_type, sysadmfile, exec_type;=0A=
 =0A=
-# Type for the /etc/security/cron_context file.=0A=
-type cron_context_t, file_type, sysadmfile;=0A=
 =0A=
 # Type for temporary files.=0A=
 type crond_tmp_t, file_type, sysadmfile, tmpfile;=0A=
diff -ruN ./domains/program/initrc.te ../new/domains/program/initrc.te=0A=
--- ./domains/program/initrc.te	Mon Jul 29 13:02:31 2002=0A=
+++ ../new/domains/program/initrc.te	Mon Jul 29 12:51:41 2002=0A=
@@ -46,6 +46,9 @@=0A=
 # Read conf.modules.=0A=
 allow initrc_t modules_conf_t:file r_file_perms;=0A=
 =0A=
+# Read login context files in /etc/security=0A=
+allow initrc_t login_contexts:file r_file_perms;=0A=
+=0A=
 # Run other rc scripts in the initrc_t domain.=0A=
 can_exec(initrc_t, initrc_exec_t)=0A=
 =0A=
diff -ruN ./domains/program/load_policy.te =
../new/domains/program/load_policy.te=0A=
--- ./domains/program/load_policy.te	Wed Dec 31 19:00:00 1969=0A=
+++ ../new/domains/program/load_policy.te	Mon Jul 29 12:51:41 2002=0A=
@@ -0,0 +1,51 @@=0A=
+#=0A=
+# Authors:  Frank Mayer, mayerf@tresys.com=0A=
+#=0A=
+=0A=
+###########################=0A=
+# load_policy_t is the domain type for load_policy =0A=
+# load_policy_exec_t is the file type for the executable=0A=
+=0A=
+=0A=
+type load_policy_t, domain;=0A=
+role sysadm_r types load_policy_t;=0A=
+=0A=
+type load_policy_exec_t, file_type, exec_type;=0A=
+=0A=
+##########################=0A=
+# =0A=
+# Rules=0A=
+=0A=
+domain_auto_trans(sysadm_t, load_policy_exec_t, load_policy_t)=0A=
+=0A=
+# Reload the policy configuration (sysadm_t no longer has this ability)=0A=
+allow load_policy_t security_t:security load_policy;=0A=
+=0A=
+=0A=
+###########################=0A=
+# constrain from where load_policy can load a policy, specifically =0A=
+# policy_config_t files (which also means no every_domain() macro)=0A=
+#=0A=
+=0A=
+# only allow read of policy config files=0A=
+allow load_policy_t policy_config_t:dir r_dir_perms;=0A=
+allow load_policy_t policy_config_t:notdevfile_class_set r_file_perms;=0A=
+=0A=
+# directory search permissions for path to binary policy files=0A=
+allow load_policy_t root_t:dir search;=0A=
+allow load_policy_t etc_t:dir search;=0A=
+=0A=
+# Read the devpts root directory (needed?)  =0A=
+allow load_policy_t devpts_t:dir r_dir_perms;=0A=
+ifdef(`sshd.te',=0A=
+`allow load_policy_t sshd_devpts_t:dir r_dir_perms;')=0A=
+=0A=
+# Other access=0A=
+allow load_policy_t sysadm_tty_device_t:chr_file { read write ioctl =
getattr };=0A=
+allow load_policy_t sysadm_devpts_t:chr_file { read write ioctl getattr =
};=0A=
+uses_shlib(load_policy_t)=0A=
+allow load_policy_t self:capability dac_override;=0A=
+=0A=
+=0A=
+=0A=
+                                                                        =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                                                         =
                                          =0A=
\ No newline at end of file=0A=
diff -ruN ./domains/program/login.te ../new/domains/program/login.te=0A=
--- ./domains/program/login.te	Mon Jul 29 13:02:31 2002=0A=
+++ ../new/domains/program/login.te	Mon Jul 29 12:51:41 2002=0A=
@@ -92,6 +92,9 @@=0A=
 allow local_login_t var_run_t:dir rw_dir_perms;=0A=
 allow local_login_t var_run_t:file create_file_perms;=0A=
 =0A=
+# allow read access to login contexts in /etc/security=0A=
+allow local_login_t login_contexts:file r_file_perms;=0A=
+=0A=
 =0A=
 #################################=0A=
 #=0A=
@@ -142,3 +145,6 @@=0A=
 ifdef(`rlogind.te',=0A=
 `allow remote_login_t rlogind_devpts_t:chr_file { relabelfrom relabelto =
};')=0A=
 allow remote_login_t ptyfile:chr_file { getattr relabelfrom relabelto };=0A=
+=0A=
+# allow read access to login contexts in /etc/security=0A=
+allow remote_login_t login_contexts:file r_file_perms;=0A=
diff -ruN ./domains/program/sshd.te ../new/domains/program/sshd.te=0A=
--- ./domains/program/sshd.te	Mon Jul 29 13:02:31 2002=0A=
+++ ../new/domains/program/sshd.te	Mon Jul 29 12:51:41 2002=0A=
@@ -132,3 +132,7 @@=0A=
 allow sshd_t mail_spool_t:dir search;=0A=
 allow sshd_t mail_spool_t:lnk_file read;=0A=
 allow sshd_t mail_spool_t:file getattr;=0A=
+=0A=
+# Allow read access to login context=0A=
+allow sshd_login_t login_contexts:file r_file_perms;=0A=
+=0A=
diff -ruN ./file_contexts/program/checkpolicy.fc =
../new/file_contexts/program/checkpolicy.fc=0A=
--- ./file_contexts/program/checkpolicy.fc	Wed Dec 31 19:00:00 1969=0A=
+++ ../new/file_contexts/program/checkpolicy.fc	Mon Jul 29 12:51:42 2002=0A=
@@ -0,0 +1,3 @@=0A=
+# checkpolicy=0A=
+/usr/local/selinux/bin/checkpolicy	system_u:object_r:checkpolicy_exec_t=0A=
+/usr/local/bin/checkpolicy		system_u:object_r:checkpolicy_exec_t=0A=
diff -ruN ./file_contexts/program/crond.fc =
../new/file_contexts/program/crond.fc=0A=
--- ./file_contexts/program/crond.fc	Mon Jul 29 13:02:31 2002=0A=
+++ ../new/file_contexts/program/crond.fc	Mon Jul 29 12:51:41 2002=0A=
@@ -1,7 +1,6 @@=0A=
 # crond=0A=
 /etc/crontab			system_u:object_r:system_crond_script_t=0A=
 /etc/cron.d(|/.*)		system_u:object_r:system_crond_script_t=0A=
-/etc/security/cron_context.*	system_u:object_r:cron_context_t=0A=
 /usr/sbin/cron(|d)		system_u:object_r:crond_exec_t=0A=
 /usr/sbin/anacron		system_u:object_r:anacron_exec_t=0A=
 /usr/sbin/fcron			system_u:object_r:anacron_exec_t=0A=
diff -ruN ./file_contexts/program/load_policy.fc =
../new/file_contexts/program/load_policy.fc=0A=
--- ./file_contexts/program/load_policy.fc	Wed Dec 31 19:00:00 1969=0A=
+++ ../new/file_contexts/program/load_policy.fc	Mon Jul 29 12:51:42 2002=0A=
@@ -0,0 +1,3 @@=0A=
+# load_policy=0A=
+/usr/local/selinux/bin/load_policy	system_u:object_r:load_policy_exec_t=0A=
+/usr/local/bin/load_policy		system_u:object_r:load_policy_exec_t=0A=
diff -ruN ./file_contexts/types.fc ../new/file_contexts/types.fc=0A=
--- ./file_contexts/types.fc	Mon Jul 29 13:02:31 2002=0A=
+++ ../new/file_contexts/types.fc	Mon Jul 29 12:51:42 2002=0A=
@@ -143,6 +143,9 @@=0A=
 /etc/mrtg(|/.*)			system_u:object_r:etc_mrtg_t=0A=
 /etc/selinux(|/.*)		system_u:object_r:policy_src_t=0A=
 /etc/security/selinux(|/.*)	system_u:object_r:policy_config_t	=0A=
+/etc/security/selinux/src(|/.*)	system_u:object_r:policy_src_t=0A=
+/etc/security/cron_context.*	system_u:object_r:cron_context_t=0A=
+/etc/security/default_context.*	system_u:object_r:default_context_t=0A=
 =0A=
 #=0A=
 # /lib=0A=
diff -ruN ./macros/admin_macros.te ../new/macros/admin_macros.te=0A=
--- ./macros/admin_macros.te	Mon Jul 29 13:02:31 2002=0A=
+++ ../new/macros/admin_macros.te	Mon Jul 29 12:51:42 2002=0A=
@@ -63,8 +63,15 @@=0A=
 # Run admin programs that require different permissions in their own =
domain.=0A=
 # These rules were moved into the appropriate program domain file.=0A=
 =0A=
-# Reload the policy configuration.=0A=
-allow $1_t security_t:security load_policy;=0A=
+# added by mayerf@tresys.com=0A=
+#=0A=
+# The following rules are temporary until such time that a complete=0A=
+# policy management infrastructure is in place so that an administrator=0A=
+# cannot directly manipulate policy files with arbitrary programs.=0A=
+#=0A=
+allow $1_t policyfiles:notdevfile_class_set create_file_perms;=0A=
+allow $1_t policyfiles:dir create_dir_perms;=0A=
+=0A=
 =0A=
 # Relabel all files.=0A=
 allow $1_t file_type:dir { getattr read search relabelfrom relabelto };=0A=
@@ -134,3 +141,4 @@=0A=
 allow $1_t console_device_t:chr_file rw_file_perms;=0A=
 =0A=
 ')=0A=
+=0A=
diff -ruN ./types/security.te ../new/types/security.te=0A=
--- ./types/security.te	Mon Jul 29 13:02:31 2002=0A=
+++ ../new/types/security.te	Mon Jul 29 12:51:42 2002=0A=
@@ -21,13 +21,25 @@=0A=
 # policy_config_t is the type of /ss_policy,=0A=
 # the security server policy configuration.=0A=
 #=0A=
-type policy_config_t, file_type, sysadmfile;=0A=
+type policy_config_t, file_type;=0A=
 =0A=
 #=0A=
 # policy_src_t is the type of the policy source=0A=
 # files.=0A=
 #=0A=
-type policy_src_t, file_type, sysadmfile;=0A=
+type policy_src_t, file_type, policyfiles;=0A=
+=0A=
+#=0A=
+# default_context_t is the type applied to =0A=
+# /etc/security/default_context=0A=
+#=0A=
+type default_context_t, file_type, login_contexts, policyfiles;=0A=
+=0A=
+#=0A=
+# Type for the /etc/security/cron_context file.=0A=
+# (previously defined in cron.te=0A=
+#=0A=
+type cron_context_t, file_type, login_contexts, policyfiles;=0A=
 =0A=
 #=0A=
 # file_labels_t is the type of the persistent=0A=

------=_NextPart_000_0003_01C23972.CCCA7330--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
