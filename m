Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBRLdwRg019100
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2007 16:39:58 -0500
Received: from DakotaMail.dakotacom.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBRLduRu014310
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2007 21:39:57 GMT
Received: from cerberus.pab (unverified [69.9.26.142]) by DakotaMail.dakotacom.net
  (Vircom SMTPRS 4.4.568.54) with ESMTP id <B0330926871@DakotaMail.dakotacom.net> for <selinux@tycho.nsa.gov>;
  Thu, 27 Dec 2007 14:40:00 -0700
Received: from euphrosyne.pab (euphrosyne.pab [192.168.67.10])
	by cerberus.pab (8.14.2/8.14.2) with ESMTP id lBRLdrqh031169
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2007 14:39:53 -0700
Received: from euphrosyne.pab (localhost.localdomain [127.0.0.1])
	by euphrosyne.pab (8.14.2/8.14.1) with ESMTP id lBRLdrQ8013292
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2007 14:39:53 -0700
Received: from localhost (pab@localhost)
	by euphrosyne.pab (8.14.2/8.14.1/Submit) with ESMTP id lBRLdrSj013289
	for <selinux@tycho.nsa.gov>; Thu, 27 Dec 2007 14:39:53 -0700
Date: Thu, 27 Dec 2007 14:39:53 -0700 (MST)
From: "Peter A. Bigot" <pab@dakotacom.net>
Reply-To: bigotp@acm.org
To: selinux@tycho.nsa.gov
Subject: run_init patch for Fedora 8
Message-ID: <Pine.LNX.4.64.0712271432030.13060@euphrosyne.pab>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch, or something like it, seems to be necessary to allow run_init to
execute in the sysadm_r role on a Fedora 8 system.  Without it I see:

type=SYSCALL msg=audit(12/27/2007 13:33:40.332:93) : arch=i386 syscall=execve success=yes exit=0 a0=2e3a18 a1=bfd2c31c a2=2e5408 a3=400 items=0 ppid=2123 pid=2126 auid=pab uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=pts0 comm=unix_update exe=/sbin/unix_update subj=staff_u:sysadm_r:run_init_t:s0-s15:c0.c255 key=(null) 
type=AVC msg=audit(12/27/2007 13:33:40.332:93) : avc:  denied  { execute_no_trans } for  pid=2126 comm=run_init path=/sbin/unix_update dev=sda2 ino=589945 scontext=staff_u:sysadm_r:run_init_t:s0-s15:c0.c255 tcontext=system_u:object_r:updpwd_exec_t:s0 tclass=file 
type=AVC msg=audit(12/27/2007 13:33:40.332:93) : avc:  denied  { read } for  pid=2126 comm=run_init name=unix_update dev=sda2 ino=589945 scontext=staff_u:sysadm_r:run_init_t:s0-s15:c0.c255 tcontext=system_u:object_r:updpwd_exec_t:s0 tclass=file 
type=AVC msg=audit(12/27/2007 13:33:40.332:93) : avc:  denied  { execute } for  pid=2126 comm=run_init name=unix_update dev=sda2 ino=589945 scontext=staff_u:sysadm_r:run_init_t:s0-s15:c0.c255 tcontext=system_u:object_r:updpwd_exec_t:s0 tclass=file

Peter

Index: policy/modules/system/selinuxutil.te
===================================================================
--- policy/modules/system/selinuxutil.te	(revision 2565)
+++ policy/modules/system/selinuxutil.te	(working copy)
@@ -388,6 +388,13 @@
  seutil_libselinux_linked(run_init_t)
  seutil_read_default_contexts(run_init_t)

+ifdef(`distro_redhat',`
+	gen_require(`
+		attribute admin_terminal;
+	')
+	auth_run_upd_passwd(run_init_t, sysadm_r, admin_terminal);
+')
+
  ifndef(`direct_sysadm_daemon',`
  	ifdef(`distro_gentoo',`
  		# Gentoo integrated run_init:

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
