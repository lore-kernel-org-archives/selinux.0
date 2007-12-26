Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBQN1ZK5026725
	for <selinux@tycho.nsa.gov>; Wed, 26 Dec 2007 18:01:35 -0500
Received: from DakotaMail.dakotacom.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBQN1XoG018169
	for <selinux@tycho.nsa.gov>; Wed, 26 Dec 2007 23:01:34 GMT
Received: from cerberus.pab (unverified [69.9.26.142]) by DakotaMail.dakotacom.net
  (Vircom SMTPRS 4.4.568.54) with ESMTP id <B0330762434@DakotaMail.dakotacom.net> for <selinux@tycho.nsa.gov>;
  Wed, 26 Dec 2007 16:01:39 -0700
Received: from euphrosyne.pab (euphrosyne.pab [192.168.67.10])
	by cerberus.pab (8.14.2/8.14.2) with ESMTP id lBQN1UAd014175
	for <selinux@tycho.nsa.gov>; Wed, 26 Dec 2007 16:01:30 -0700
Received: from euphrosyne.pab (localhost.localdomain [127.0.0.1])
	by euphrosyne.pab (8.14.2/8.14.1) with ESMTP id lBQN1Uco027542
	for <selinux@tycho.nsa.gov>; Wed, 26 Dec 2007 16:01:30 -0700
Received: from localhost (pab@localhost)
	by euphrosyne.pab (8.14.2/8.14.1/Submit) with ESMTP id lBQN1Ucc027539
	for <selinux@tycho.nsa.gov>; Wed, 26 Dec 2007 16:01:30 -0700
Date: Wed, 26 Dec 2007 16:01:28 -0700 (MST)
From: "Peter A. Bigot" <pab@dakotacom.net>
Reply-To: bigotp@acm.org
To: selinux@tycho.nsa.gov
Subject: locallogin patch for Fedora 8
Message-ID: <Pine.LNX.4.64.0712261559160.27141@euphrosyne.pab>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch appears necessary to get the reference policy to run on Fedora
8.  Without it attempts to login on the console get:

type=SYSCALL msg=audit(12/26/2007 15:03:13.840:126) : arch=i386 syscall=write success=no exit=-1(Operation not permitted) a0=4 a1=bff0a630 a2=1 a3=1 items=0 ppid=1 pid=2221 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=tty2 comm=login exe=/bin/login subj=system_u:system_r:local_login_t:s0-s15:c0.c255 key=(null) 
type=AVC msg=audit(12/26/2007 15:03:13.840:126) : avc:  denied  { audit_control } for  pid=2221 comm=login capability=audit_control scontext=system_u:system_r:local_login_t:s0-s15:c0.c255 tcontext=system_u:system_r:local_login_t:s0-s15:c0.c255 tclass=capability

The basic fix was previously submitted by Dan Walsh to the SELinux mailing
list on 14 Apr 2005, noting that pam_loginuid required this capability.  If
subsequently another way to work around this was preferred, please let me
know; I'm extremely new to SELinux and am still fumbling.

(My configuration uses TYPE=mls, DISTRO=redhat, MONOLITHIC=n, and removes
the unconfined module, and anaconda and firstboot which depend on it, in an
attempt to be a "strict" policy.  This may also have some effect on why the
original didn't work for me.)

Peter

Index: policy/modules/system/locallogin.te
===================================================================
--- policy/modules/system/locallogin.te	(revision 2565)
+++ policy/modules/system/locallogin.te	(working copy)
@@ -34,6 +34,9 @@
  #

  allow local_login_t self:capability { dac_override chown fowner fsetid kill setgid setuid sys_nice sys_resource sys_tty_config };
+ifdef(`distro_redhat', `
+allow local_login_t self:capability { audit_control };
+')
  allow local_login_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
  allow local_login_t self:process { setrlimit setexec };
  allow local_login_t self:fd use;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
