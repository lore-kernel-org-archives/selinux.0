From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: disable setenforce
Date: Sat, 17 Sep 2005 22:53:05 +1000
Cc: fedora-selinux-list@redhat.com, SELinux List <SELinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
References: <1126283594.20003.17.camel@hive.ccit.arizona.edu> <1126537235.2999.88.camel@moss-spartans.epoch.ncsc.mil> <200509172235.40550.russell@coker.com.au>
In-Reply-To: <200509172235.40550.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_8GBLD4zyUcjIgg5"
Message-Id: <200509172253.16022.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_8GBLD4zyUcjIgg5
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 17 September 2005 22:35, Russell Coker <russell@coker.com.au> 
wrote:
> > Did you attach the wrong patch?  The one you sent doesn't define new
> > booleans; it just wraps additional rules with the existing secure_mode
> > boolean.
>
> I attached the patch, re-worked it, and then forgot to attach the new
> patch.
>
> The correct patch is attached to this message.

I hate doing this.

Just after I sent the previous patch I discovered a minor bug.  When building 
a policy with ypbind.te included the nested booleans break the compile.  The 
attached patch fixes this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_8GBLD4zyUcjIgg5
Content-Type: text/x-diff;
  charset="utf-8";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- macros/global_macros.te.orig	2005-09-12 16:22:12.000000000 +1000
+++ macros/global_macros.te	2005-09-12 16:23:37.000000000 +1000
@@ -699,8 +699,10 @@
 allow $1 domain:msg  { send receive };
 
 # Access the security API.
+if (!secure_mode_policyload) {
 allow $1 security_t:security *;
 auditallow $1 security_t:security { load_policy setenforce setbool };
+}dnl end if !secure_mode_policyload
 
 # Perform certain system operations that lacked individual capabilities.
 allow $1 kernel_t:system *;
--- macros/core_macros.te.orig	2005-09-12 16:14:59.000000000 +1000
+++ macros/core_macros.te	2005-09-12 16:33:15.000000000 +1000
@@ -306,8 +306,10 @@
 # Access selinuxfs.
 allow $1 security_t:dir { read search getattr };
 allow $1 security_t:file { getattr read write };
+if (!secure_mode_policyload) {
 allow $1 security_t:security setenforce;
 auditallow $1 security_t:security setenforce;
+}dnl end if !secure_mode_policyload
 ')
 
 ##################################
@@ -326,8 +328,10 @@
 # Access selinuxfs.
 allow $1 security_t:dir { read search getattr };
 allow $1 security_t:file { getattr read write };
+if (!secure_mode_policyload) {
 allow $1 security_t:security setbool;
 auditallow $1 security_t:security setbool;
+}dnl end if !secure_mode_policyload
 ')
 
 ##################################
@@ -367,8 +371,10 @@
 # Access selinuxfs.
 allow $1 security_t:dir { read search getattr };
 allow $1 security_t:file { getattr read write };
+if (!secure_mode_policyload) {
 allow $1 security_t:security load_policy;
 auditallow $1 security_t:security load_policy;
+}dnl end if !secure_mode_policyload
 ')
 
 #################################
--- domains/program/load_policy.te.orig	2005-09-12 16:38:10.000000000 +1000
+++ domains/program/load_policy.te	2005-09-12 16:39:59.000000000 +1000
@@ -8,6 +8,10 @@
 # load_policy_t is the domain type for load_policy 
 # load_policy_exec_t is the file type for the executable
 
+# boolean to determine whether the system permits loading policy, setting
+# enforcing mode, and changing boolean values.  Set this to true and you
+# have to reboot to set it back
+bool secure_mode_policyload false;
 
 type load_policy_t, domain;
 role sysadm_r types load_policy_t;
--- domains/program/modutil.te.orig	2005-09-12 16:41:56.000000000 +1000
+++ domains/program/modutil.te	2005-09-17 22:45:03.000000000 +1000
@@ -77,11 +77,16 @@
 ;
 role system_r types insmod_t;
 role sysadm_r types insmod_t;
+type insmod_exec_t, file_type, exec_type, sysadmfile;
+
+bool secure_mode_insmod false;
+
+can_ypbind(insmod_t)
+if (!secure_mode_insmod) {
 
 ifdef(`unlimitedUtils', `
 unconfined_domain(insmod_t) 
 ')
-can_ypbind(insmod_t)
 uses_shlib(insmod_t)
 read_locale(insmod_t)
 
@@ -161,7 +166,6 @@
 allow insmod_t device_t:dir read;
 allow insmod_t devpts_t:dir { getattr search };
 
-type insmod_exec_t, file_type, exec_type, sysadmfile;
 domain_auto_trans(privmodule, insmod_exec_t, insmod_t)
 can_exec(insmod_t, { insmod_exec_t shell_exec_t bin_t sbin_t etc_t })
 allow insmod_t devtty_t:chr_file rw_file_perms;
@@ -177,6 +181,7 @@
 
 # for nscd
 dontaudit insmod_t var_run_t:dir search;
+}dnl end if !secure_mode_insmod
 
 ifdef(`crond.te', `
 rw_dir_create_file(system_crond_t, var_log_ksyms_t)

--Boundary-00=_8GBLD4zyUcjIgg5--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
