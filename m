Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0DH1VRb020149
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 12:01:31 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0DH1UiV019109
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 17:01:30 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i0DH1T06019103 for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 17:01:29 GMT
Subject: Eliminating run_init
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>, Russell Coker <russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-yp/QTsQTemN+XPUPxSjO"
Message-Id: <1074013276.13586.76.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Tue, 13 Jan 2004 12:01:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-yp/QTsQTemN+XPUPxSjO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

In their work in integrating SELinux into Fedora, the RedHat folks have
encountered problems with cleanly and transparently integrating
run_init, and they are also concerned about the impact on end users
(admins) and third party apps, which are used to directly executing init
scripts and even daemon programs.

Pending the development of a fully transparent solution, which may take
some time, we are looking into reviving automatic role transitions, and
configuring the policy so that 1) sysadm_r:sysadm_t can directly
transition to system_r:initrc_t upon executing /etc/init.d scripts (as
previously done via run_init), and 2) sysadm_r:sysadm_t can directly
transition to system_r:{daemon domain} upon executing daemon executables
(not previously handled; admins were expected to use run_init
/etc/init.d/foo start rather than directly running /usr/sbin/foo in the
past).

I've attached a pair of patches, one to checkpolicy to un-deprecate
automatic role transitions, and one to the policy to add role and domain
transitions for running init scripts and daemons directly from
sysadm_r:sysadm_t.  Note that the patched policy will yield two warnings
when compiled regarding type transition conflicts (if you have enabled
the games and sendmail .te files), due to the fact that a couple of
domains (games and sendmail) already have transitions from sysadm_t
because a single program is used both for a daemon and a regular app; we
can eliminate these warnings by re-writing those two domains to use a
new variant of daemon_domain that omits the changes, and require admins
to use the init scripts when starting/restarting those particular cases.

Note that this change presently requires authorizing admin users for the
system_r role, as there is no support for automatic user identity
transitions (i.e. to system_u upon executing init scripts or daemons). 
The retention of the admin user's user identity on the daemon process
should be harmless, as the role and domain will be correct and will
govern any subsequent transitions by the daemon.   Nonetheless, if we
make this change to the policy, we should likely investigate adding
support for automatic user identity transitions as well and migrate to
it when possible in order to avoid directly authorizing the admin users
for the system_r role.

Comments?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-yp/QTsQTemN+XPUPxSjO
Content-Disposition: attachment; filename=checkpolicy-roletrans.patch
Content-Type: text/x-patch; name=checkpolicy-roletrans.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: checkpolicy/policy_parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.9
diff -u -r1.9 policy_parse.y
--- checkpolicy/policy_parse.y	17 Dec 2003 16:52:20 -0000	1.9
+++ checkpolicy/policy_parse.y	7 Jan 2004 13:19:04 -0000
@@ -2339,8 +2339,6 @@
 		return 0;
 	}
 
-	yywarn("Role transition rules are DEPRECATED, use domain transitions.");
-
 	ebitmap_init(&roles);
 	ebitmap_init(&types);
 

--=-yp/QTsQTemN+XPUPxSjO
Content-Disposition: attachment; filename=policy-roletrans.patch
Content-Type: text/x-patch; name=policy-roletrans.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: policy/users
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/users,v
retrieving revision 1.2
diff -u -r1.2 users
--- policy/users	3 Jul 2003 13:01:24 -0000	1.2
+++ policy/users	7 Jan 2004 13:28:52 -0000
@@ -39,8 +39,8 @@
 # not in the sysadm_r.
 #
 
-user root roles { staff_r sysadm_r };
+user root roles { staff_r sysadm_r system_r };
 
-user jadmin roles { staff_r sysadm_r };
+user jadmin roles { staff_r sysadm_r system_r };
 
 user jdoe roles { user_r };
Index: policy/domains/admin.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/admin.te,v
retrieving revision 1.5
diff -u -r1.5 admin.te
--- policy/domains/admin.te	20 Nov 2003 20:41:33 -0000	1.5
+++ policy/domains/admin.te	7 Jan 2004 13:26:04 -0000
@@ -3,7 +3,7 @@
 #################################
 
 # sysadm_t is the system administrator domain.
-type sysadm_t, domain, privlog, privowner, admin, userdomain, web_client_domain, privhome, etc_writer, privmodule;
+type sysadm_t, domain, privrole, privlog, privowner, admin, userdomain, web_client_domain, privhome, etc_writer, privmodule;
 allow privhome home_root_t:dir search;
 
 # system_r is authorized for sysadm_t for single-user mode.
Index: policy/domains/program/ssh.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/ssh.te,v
retrieving revision 1.14
diff -u -r1.14 ssh.te
--- policy/domains/program/ssh.te	25 Nov 2003 14:43:00 -0000	1.14
+++ policy/domains/program/ssh.te	7 Jan 2004 13:08:35 -0000
@@ -166,6 +166,10 @@
 var_run_domain(sshd_extern)
 ')
 
+# Direct execution by sysadm_r.
+domain_auto_trans(sysadm_t, sshd_exec_t, sshd_t)
+role_transition sysadm_r sshd_exec_t system_r;
+
 undefine(`sshd_program_domain')
 
 # so a tunnel can point to another ssh tunnel...
Index: policy/macros/global_macros.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/macros/global_macros.te,v
retrieving revision 1.20
diff -u -r1.20 global_macros.te
--- policy/macros/global_macros.te	1 Dec 2003 15:27:50 -0000	1.20
+++ policy/macros/global_macros.te	7 Jan 2004 13:07:20 -0000
@@ -228,6 +228,7 @@
 type $1_exec_t, file_type, sysadmfile, exec_type;
 
 role system_r types $1_t;
+role_transition sysadm_r $1_exec_t system_r;
 
 # Inherit and use descriptors from init.
 allow $1_t init_t:fd use;
@@ -270,7 +271,7 @@
 define(`daemon_base_domain', `
 daemon_core_rules($1, `$2')
 
-domain_auto_trans(initrc_t, $1_exec_t, $1_t)
+domain_auto_trans({ sysadm_t initrc_t }, $1_exec_t, $1_t)
 allow $1_t privfd:fd use;
 ifdef(`newrole.te', `allow $1_t newrole_t:process sigchld;')
 allow $1_t initrc_devpts_t:chr_file rw_file_perms;
Index: policy/domains/program/initrc.te
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policy/domains/program/initrc.te,v
retrieving revision 1.10
diff -u -r1.10 initrc.te
--- policy/domains/program/initrc.te	20 Nov 2003 20:41:33 -0000	1.10
+++ policy/domains/program/initrc.te	12 Jan 2004 13:29:16 -0000
@@ -257,3 +257,8 @@
 #
 run_program(sysadm_t, sysadm_r, init, initrc_exec_t, initrc_t)
 allow initrc_t privfd:fd use;
+
+# Transition to system_r:initrc_t upon executing init scripts.
+role_transition sysadm_r initrc_exec_t system_r;
+domain_auto_trans(sysadm_t, initrc_exec_t, initrc_t)
+

--=-yp/QTsQTemN+XPUPxSjO--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
