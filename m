Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KDoErT017570
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 09:50:15 -0400 (EDT)
Received: from oe-im1.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8KDoET2028276
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 13:50:14 GMT
Subject: Re: [PATCH] Gentoo-specific initrc
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1095636681.735.70.camel@gorn.pebenito.net>
References: <1095381586.735.30.camel@gorn.pebenito.net>
	 <200409191801.05094.russell@coker.com.au>
	 <1095599331.735.62.camel@gorn.pebenito.net>
	 <200409200704.46291.russell@coker.com.au>
	 <1095636681.735.70.camel@gorn.pebenito.net>
Content-Type: multipart/mixed; boundary="=-quXlmhRD0ustd6wSvJ2I"
Message-Id: <1095688302.8397.132.camel@selinux>
Mime-Version: 1.0
Date: Mon, 20 Sep 2004 09:51:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-quXlmhRD0ustd6wSvJ2I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2004-09-19 at 19:31, Chris PeBenito wrote:
> > What is the purpose of a etc_runtime_t directory?  Currently any process that 
> > can create files as etc_runtime_t can write to a directory labelled as etc_t.  
> 
> Good point, I'll send an updated patch when sourceforge cvs starts
> responding again for me.  I guess I got a little overzealous on the
> labeling.

Here's the updated patch, against CVS.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--=-quXlmhRD0ustd6wSvJ2I
Content-Disposition: attachment; filename=initrc.diff
Content-Type: text/x-patch; name=initrc.diff; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: domains/program/initrc.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/domains/program/initrc.te,v
retrieving revision 1.28
diff -u -r1.28 initrc.te
--- domains/program/initrc.te	10 Sep 2004 14:45:48 -0000	1.28
+++ domains/program/initrc.te	20 Sep 2004 13:46:01 -0000
@@ -319,3 +319,12 @@
 ifdef(`dbusd.te', `
 allow initrc_t system_dbusd_t:dbus { send_msg acquire_svc };
 ')
+
+# init script state
+type initrc_state_t, file_type, sysadmfile;
+create_dir_file(initrc_t,initrc_state_t)
+
+ifdef(`distro_gentoo', `
+# Gentoo integrated run_init+open_init_pty-runscript:
+domain_auto_trans(sysadm_t,initrc_exec_t,run_init_t)
+')
Index: file_contexts/program/initrc.fc
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/file_contexts/program/initrc.fc,v
retrieving revision 1.7
diff -u -r1.7 initrc.fc
--- file_contexts/program/initrc.fc	30 Aug 2004 20:13:29 -0000	1.7
+++ file_contexts/program/initrc.fc	20 Sep 2004 13:46:02 -0000
@@ -11,6 +11,14 @@
 /var/run/runlevel\.dir		system_u:object_r:initrc_var_run_t
 /var/run/random-seed	--	system_u:object_r:initrc_var_run_t
 /var/run/setmixer_flag	--	system_u:object_r:initrc_var_run_t
+
+ifdef(`distro_gentoo', `
+/sbin/rc		--	system_u:object_r:initrc_exec_t
+/sbin/runscript		--      system_u:object_r:initrc_exec_t
+/sbin/runscript.sh	--	system_u:object_r:initrc_exec_t
+/var/lib/init.d(/.*)?		system_u:object_r:initrc_state_t
+')
+
 # run_init
 /usr/sbin/run_init	--	system_u:object_r:run_init_exec_t
 ifdef(`distro_debian', `
@@ -19,6 +27,6 @@
 /etc/nologin.*		--	system_u:object_r:etc_runtime_t
 /etc/nohotplug		--	system_u:object_r:etc_runtime_t
 ifdef(`distro_redhat', `
-/halt                   --      system_u:object_r:etc_runtime_t
-/\.autofsck             --      system_u:object_r:etc_runtime_t
+/halt			--	system_u:object_r:etc_runtime_t
+/\.autofsck		--	system_u:object_r:etc_runtime_t
 ')

--=-quXlmhRD0ustd6wSvJ2I--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
