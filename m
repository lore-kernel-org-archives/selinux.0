Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0JKXKXf007338
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 15:33:21 -0500 (EST)
Received: from e2.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0JKWBgR022957
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 20:32:11 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k0JKXIEq022318
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 15:33:18 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.8) with ESMTP id k0JKXJ5d113498
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 15:33:19 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k0JKXJqZ031328
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 15:33:19 -0500
Received: from sergelap.hallyn.com ([9.49.204.186])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id k0JKXIAZ031308
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 15:33:18 -0500
Date: Thu, 19 Jan 2006 14:33:17 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: next try at refpolicy-gentoo patches
Message-ID: <20060119203317.GA27395@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The following set of patches lets me log in locally on a
gentoo system in enforcing mode.

First, label the serial ports as tty devices:

Index: refpolicy/policy/modules/kernel/terminal.fc
===================================================================
--- refpolicy.orig/policy/modules/kernel/terminal.fc
+++ refpolicy/policy/modules/kernel/terminal.fc
@@ -24,3 +24,6 @@
 /dev/vcs[^/]*		-c	gen_context(system_u:object_r:tty_device_t,s0)
 
 /dev/usb/tty.*		-c	gen_context(system_u:object_r:usbtty_device_t,s0)
+ifdef(`distro_gentoo', `
+/dev/tts/[0-9]*		-c	gen_context(system_u:object_r:tty_device_t,s0)
+')

Second, unix_chkpwd is under /usr/sbin/ under gentoo:

Index: refpolicy/policy/modules/system/authlogin.fc
===================================================================
--- refpolicy.orig/policy/modules/system/authlogin.fc
+++ refpolicy/policy/modules/system/authlogin.fc
@@ -12,6 +12,11 @@
 /sbin/pam_console_apply	 --	gen_context(system_u:object_r:pam_console_exec_t,s0)
 /sbin/pam_timestamp_check --	gen_context(system_u:object_r:pam_exec_t,s0)
 /sbin/unix_chkpwd	--	gen_context(system_u:object_r:chkpwd_exec_t,s0)
+
+ifdef(`distro_gentoo', `
+/usr/sbin/unix_chkpwd	--	gen_context(system_u:object_r:chkpwd_exec_t,s0)
+')
+
 /sbin/unix_verify	--	gen_context(system_u:object_r:chkpwd_exec_t,s0)
 ifdef(`distro_suse', `
 /sbin/unix2_chkpwd	--	gen_context(system_u:object_r:chkpwd_exec_t,s0)

Third, I need to send sighld from user_t to local_login_t on login,
else I get an endless series of error messages on console
(login: waitpid (6328, NULL, 0) failed: No child processes)
Is this really gentoo-specific?

Index: refpolicy/policy/modules/system/userdomain.if
===================================================================
--- refpolicy.orig/policy/modules/system/userdomain.if
+++ refpolicy/policy/modules/system/userdomain.if
@@ -33,6 +33,10 @@ template(`base_user_template',`
 	role $1_r types $1_t;
 	allow system_r $1_r;
 
+	ifdef(`distro_gentoo',`
+		allow $1_t local_login_t:process { sigchld };
+	')
+
 	# user pseudoterminal
 	type $1_devpts_t;
 	term_user_pty($1_t,$1_devpts_t)

Lastly, like with redhat, /dev is tmpfs, so user terminals need to be
able to associate with tmpfs.

Index: refpolicy/policy/modules/kernel/terminal.if
===================================================================
--- refpolicy.orig/policy/modules/kernel/terminal.if
+++ refpolicy/policy/modules/kernel/terminal.if
@@ -88,6 +88,9 @@ interface(`term_tty',`
 		type_change $1 ttynode:chr_file $2;
 	')
 
+	ifdef(`distro_gentoo',`
+		fs_associate_tmpfs($2)
+	')
 	ifdef(`distro_redhat',`
 		fs_associate_tmpfs($2)
 	')

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
