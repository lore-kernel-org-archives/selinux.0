Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9772drT012102
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 03:02:39 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9772aov017599
	for <selinux@tycho.nsa.gov>; Thu, 7 Oct 2004 07:02:37 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: petre rodan <kaiowas@gentoo.org>
Subject: Re: gentoo diff for ntpd
Date: Thu, 7 Oct 2004 17:02:33 +1000
Cc: Joshua Brindle <method@gentoo.org>, selinux@tycho.nsa.gov
References: <41625A62.7080609@gentoo.org> <41629E45.8050107@gentoo.org> <4163CDD3.3@gentoo.org>
In-Reply-To: <4163CDD3.3@gentoo.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JoOZBKslCnkiT9S"
Message-Id: <200410071702.33618.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_JoOZBKslCnkiT9S
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 6 Oct 2004 20:49, petre rodan <kaiowas@gentoo.org> wrote:
> this is a new diff with distro_gentoo ifdefs dropped.
> also, logrotate is not part of the gentoo base-policy and it shouldn't be a
> dependency for ntpd, so I'm also ifdef-ing that.

Having daemon binaries in /usr/bin instead of /usr/sbin is a bug.

ntpd and ntpdate can not be used by regular users, they can only be used by 
the administrator.  Therefore any distribution that follows the LSB (or the 
FHS which the LSB is based on) will put them in /usr/sbin.  Here is the 
relevant section of the FHS:

4.6 /usr/sbin : Non-essential standard system binaries

This directory contains any non-essential binaries used exclusively by the
system administrator. System administration programs that are required for
system repair, system recovery, mounting /usr, or other essential functions
should be placed in /sbin instead.


Those .fc entries for /usr/bin can go in under ifdef(`distro_gentoo' if Gentoo 
does not follow the FHS.  Otherwise it's best to file a bug in the Gentoo bug 
system requesting that the files be moved.

I've attached a patch which has the changes I think belong in the CVS at this 
time.  Note that I changed the order of the capabilities so that they match 
the order of capability.h .

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_JoOZBKslCnkiT9S
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ntpd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ntpd.diff"

--- /usr/src/se/policy/domains/program/unused/ntpd.te	2004-09-29 00:49:58.000000000 +1000
+++ domains/program/unused/ntpd.te	2004-10-07 16:59:59.000000000 +1000
@@ -22,7 +22,7 @@
 # for SSP
 allow ntpd_t urandom_device_t:chr_file read;
 
-allow ntpd_t self:capability { setgid setuid sys_time net_bind_service ipc_lock };
+allow ntpd_t self:capability { kill setgid setuid sys_time net_bind_service ipc_lock sys_chroot };
 allow ntpd_t self:process { setcap setsched };
 # ntpdate wants sys_nice
 dontaudit ntpd_t self:capability { fsetid sys_nice };
@@ -50,7 +50,7 @@
 can_exec(ntpd_t, initrc_exec_t)
 allow ntpd_t self:fifo_file { read write getattr };
 allow ntpd_t etc_runtime_t:file r_file_perms;
-can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t logrotate_exec_t ntpd_exec_t })
+can_exec(ntpd_t, { bin_t shell_exec_t sbin_t ls_exec_t ntpd_exec_t })
 allow ntpd_t { sbin_t bin_t }:dir search;
 allow ntpd_t bin_t:lnk_file read;
 allow ntpd_t sysctl_kernel_t:dir search;
@@ -59,6 +59,7 @@
 allow ntpd_t sysadm_home_dir_t:dir r_dir_perms;
 allow ntpd_t self:file { getattr read };
 dontaudit ntpd_t domain:dir search;
+ifdef(`logrotate.te', `can_exec(ntpd_t, logrotate_exec_t)')
 ')
 
 allow ntpd_t devtty_t:chr_file rw_file_perms;
--- /usr/src/se/policy/file_contexts/program/ntpd.fc	2004-06-17 15:10:43.000000000 +1000
+++ file_contexts/program/ntpd.fc	2004-10-07 17:00:11.000000000 +1000
@@ -1,6 +1,6 @@
 /var/lib/ntp(/.*)?			system_u:object_r:ntp_drift_t
 /etc/ntp/data(/.*)?			system_u:object_r:ntp_drift_t
-/etc/ntp\.conf			--	system_u:object_r:net_conf_t
+/etc/ntp(d)?\.conf		--	system_u:object_r:net_conf_t
 /etc/ntp/step-tickers		--	system_u:object_r:net_conf_t
 /usr/sbin/ntpd			--	system_u:object_r:ntpd_exec_t
 /usr/sbin/ntpdate		--	system_u:object_r:ntpd_exec_t

--Boundary-00=_JoOZBKslCnkiT9S--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
