Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m21Et8gZ026696
	for <selinux@tycho.nsa.gov>; Sat, 1 Mar 2008 09:55:08 -0500
Received: from ppsw-7.csi.cam.ac.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m21Et5xT011408
	for <selinux@tycho.nsa.gov>; Sat, 1 Mar 2008 14:55:06 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:32992)
	by ppsw-7.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.137]:25)
	with esmtp id 1JVT77-0007NV-Oa (Exim 4.67) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Sat, 01 Mar 2008 14:55:01 +0000
Message-ID: <47C96E41.7020602@martinorr.name>
Date: Sat, 01 Mar 2008 14:54:57 +0000
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_caligula-13793-1204383301-0001-2"
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: [DSE-Dev] refpolicy: patch for ldconfig from glibc 2.7,	new	patch
References: <20080222152703.GA4163@bobek.pm.i.cz>	<1203703539.32061.22.camel@gorn> <20080229072116.GA13364@bobek.pm.i.cz>	<1204292761.32061.230.camel@gorn>  <47C824BE.5040001@martinorr.name> <1204302749.32061.241.camel@gorn>
In-Reply-To: <1204302749.32061.241.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_caligula-13793-1204383301-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

On 29/02/08 16:32, Christopher J. PeBenito wrote:
> On Fri, 2008-02-29 at 15:29 +0000, Martin Orr wrote:
>> The attached patch is what I am using to deal with this.  (I'm not sure if
>> it should be apt_dontaudit_use_fds(ldconfig_t) or apt_use_fds(ldconfig_t)
>> but dontaudit is what the Debian policy package uses.)
> 
> You probably want to allow it otherwise ldconfig won't inherit the fds
> that point to the apt pty.  By denying the inheritance on an enforcing
> system, fd 0,1,2 will be closed and reopened to /dev/null, so you lose
> any ldconfig output.

Here's an updated patch, with apt_use_fds(ldconfig_t).  This also lets
dpkg_t and dpkg_script_t use initrc ptys, so that se_dpkg works.

Best wishes,

-- 
Martin Orr

--=_caligula-13793-1204383301-0001-2
Content-Type: text/plain; name="101_apt_dpkg_ptys"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="101_apt_dpkg_ptys"

Written by: Martin Orr
with bits from:
srivasta@debian.org--lenny/refpolicy--debian--0.0--patch-12
srivasta@debian.org--lenny/refpolicy--debian--0.0--patch-13

Combines 501_apt_create_pty 365_apt_fixes

Cope with apt creating a new pty to run dpkg
Also let dpkg use initrc ptys for se_dpkg

Index: policy/modules/admin/apt.fc
===================================================================
--- policy/modules/admin/apt.fc.orig	2008-03-01 13:38:13.000000000 +0000
+++ policy/modules/admin/apt.fc	2008-03-01 13:38:16.000000000 +0000
@@ -11,3 +11,6 @@
 # package list repository
 /var/lib/apt(/.*)?			gen_context(system_u:object_r:apt_var_lib_t,s0)
 /var/lib/aptitude(/.*)?		gen_context(system_u:object_r:apt_var_lib_t,s0)
+
+# dpkg terminal log
+/var/log/apt(/.*)?			gen_context(system_u:object_r:apt_var_log_t,s0)
Index: policy/modules/admin/apt.if
===================================================================
--- policy/modules/admin/apt.if.orig	2008-03-01 13:38:13.000000000 +0000
+++ policy/modules/admin/apt.if	2008-03-01 13:38:16.000000000 +0000
@@ -111,6 +111,24 @@
 
 ########################################
 ## <summary>
+##	Read from and write to apt ptys.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apt_use_ptys',`
+	gen_require(`
+		type apt_devpts_t;
+	')
+
+	allow $1 apt_devpts_t:chr_file rw_term_perms;
+')
+
+########################################
+## <summary>
 ##	Read the apt package database.
 ## </summary>
 ## <param name="domain">
Index: policy/modules/admin/apt.te
===================================================================
--- policy/modules/admin/apt.te.orig	2008-03-01 13:38:13.000000000 +0000
+++ policy/modules/admin/apt.te	2008-03-01 14:53:50.000000000 +0000
@@ -1,5 +1,5 @@
 
-policy_module(apt,1.3.0)
+policy_module(apt,1.3.1)
 
 ########################################
 #
@@ -26,6 +26,13 @@
 type apt_var_cache_t alias var_cache_apt_t;
 files_type(apt_var_cache_t)
 
+type apt_var_log_t alias var_log_apt_t;
+logging_log_file(apt_var_log_t)
+
+# pseudo terminal for running dpkg
+type apt_devpts_t;
+term_pty(apt_devpts_t)
+
 ########################################
 #
 # apt Local policy
@@ -97,6 +104,7 @@
 
 fs_getattr_all_fs(apt_t)
 
+term_create_pty(apt_t, apt_devpts_t)
 term_list_ptys(apt_t)
 term_use_all_terms(apt_t)
 
Index: policy/modules/admin/dpkg.te
===================================================================
--- policy/modules/admin/dpkg.te.orig	2008-03-01 13:38:13.000000000 +0000
+++ policy/modules/admin/dpkg.te	2008-03-01 14:53:48.000000000 +0000
@@ -150,6 +150,7 @@
 files_exec_etc_files(dpkg_t)
 
 init_domtrans_script(dpkg_t)
+init_use_script_ptys(dpkg_t)
 
 libs_use_ld_so(dpkg_t)
 libs_use_shared_libs(dpkg_t)
@@ -172,6 +173,10 @@
 # since the scripts aren't labeled correctly yet...
 allow dpkg_t dpkg_var_lib_t:file execute;
 
+optional_policy(`
+	apt_use_ptys(dpkg_t)
+')
+
 # TODO: allow?
 #optional_policy(`
 #	cron_system_entry(dpkg_t,dpkg_exec_t)
@@ -290,6 +295,7 @@
 auth_manage_all_files_except_shadow(dpkg_script_t)
 
 init_domtrans_script(dpkg_script_t)
+init_use_script_fds(dpkg_script_t)
 
 libs_use_ld_so(dpkg_script_t)
 libs_use_shared_libs(dpkg_script_t)
@@ -314,6 +320,11 @@
 ')
 
 optional_policy(`
+	apt_rw_pipes(dpkg_script_t)
+	apt_use_fds(dpkg_script_t)
+')
+
+optional_policy(`
 	bootloader_domtrans(dpkg_script_t)
 ')
 
Index: policy/modules/system/libraries.te
===================================================================
--- policy/modules/system/libraries.te.orig	2008-03-01 13:38:13.000000000 +0000
+++ policy/modules/system/libraries.te	2008-03-01 14:48:40.000000000 +0000
@@ -98,6 +98,12 @@
 ')
 
 optional_policy(`
+	apt_rw_pipes(ldconfig_t)
+	apt_use_fds(ldconfig_t)
+	apt_use_ptys(ldconfig_t)
+')
+
+optional_policy(`
 	# When you install a kernel the postinstall builds a initrd image in tmp 
 	# and executes ldconfig on it.  If you dont allow this kernel installs 
 	# blow up.

--=_caligula-13793-1204383301-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
