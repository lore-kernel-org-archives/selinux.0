Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9DAhgrT018640
	for <selinux@tycho.nsa.gov>; Wed, 13 Oct 2004 06:43:42 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9DAhchD013409
	for <selinux@tycho.nsa.gov>; Wed, 13 Oct 2004 10:43:39 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: More SELinux fixes.
Date: Wed, 13 Oct 2004 20:43:35 +1000
Cc: jwcart2@epoch.ncsc.mil, SELinux <selinux@tycho.nsa.gov>
References: <4165B9AA.8090803@redhat.com> <200410101736.25763.russell@coker.com.au> <416C288E.1010001@redhat.com>
In-Reply-To: <416C288E.1010001@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_XbQbBHUGWyEwgcZ"
Message-Id: <200410132043.35891.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_XbQbBHUGWyEwgcZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 13 Oct 2004 04:55, Daniel J Walsh <dwalsh@redhat.com> wrote:
> >dontaudit mount_t reserved_port_type:{tcp_socket udp_socket} name_bind;
> >
> >Why remove all the rules of that form?  Has something equivalent been
> > added to a macro?
>
> This is now defined in can_ypbind, but I guess for mount_t it should
> remain.  Some of these
> rules were proliferating because of yp.  If the app uses portmap, it
> will need this rule otherwise it
> can rely in the rule in can_ypbind.

Yes, I think that mount does some port access in the case of NFS mounts.

> >Also put it inside ifdef(`sendmail.te', only sendmail.te uses
> > mqueue_spool_t, so we should move the type declaration into sendmail.te.
> >
> >-file_type_auto_trans(snmpd_t, { usr_t var_t }, snmpd_var_lib_t, file)
> >+file_type_auto_trans(snmpd_t, usr_t, snmpd_var_lib_t, file)
> >+file_type_auto_trans(snmpd_t, var_t, snmpd_var_lib_t, file)
> >
> >What is the point of this change?
>
> I thought combining these caused problems.  I saw some avc messages with
> snmpd trying to write to var_t, which
> I thought might have been caused by a macro expansion problem.  When I
> changed to the above, the problem
> went away, could have been a red herring.

It's a red herring, please revert it.

> >+allow udev_t dev_fs:{ chr_file blk_file } { relabelfrom relabelto };
> >
> >The above is redundant, the below line covers it.
> >
> >allow udev_t { device_t device_type }:{ chr_file blk_file } { relabelfrom
> >relabelto create_file_perms };
>
> I think the problem came in because these files are not covered by the
> above command
> type sysadm_tty_device_t, file_type, sysadmfile, ttyfile, dev_fs;
> type user_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type,
> dev_fs;
> type staff_tty_device_t, file_type, sysadmfile, ttyfile, user_tty_type,
> dev_fs;
>
> If you stop and restart udev, you get lots of AVC's from these.

I've attached a patch to deal with this.  udev_t needs privowner if it's to 
work after being restarted.  Also it's not desirable for terminals with 
active sessions to be relabeled, so I've put in a dontaudit rule for that.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_XbQbBHUGWyEwgcZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="udev.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="udev.diff"

--- /usr/src/se/policy/domains/program/unused/udev.te	2004-10-11 03:50:38.000000000 +1000
+++ domains/program/unused/udev.te	2004-10-13 20:39:06.000000000 +1000
@@ -9,14 +9,14 @@
 #
 # udev_exec_t is the type of the udev executable.
 #
-daemon_domain(udev, `, nscd_client_domain, privmodule, privmem, fs_domain, privfd')
+daemon_domain(udev, `, nscd_client_domain, privmodule, privmem, fs_domain, privfd, privowner')
 
 general_domain_access(udev_t)
 
 etc_domain(udev)
 typealias udev_etc_t alias etc_udev_t;
 type udev_helper_exec_t, file_type, sysadmfile, exec_type;
-can_exec_any(udev_t)
+can_exec_any(udev_t)
 
 #
 # Rules used for udev
@@ -37,6 +37,9 @@
 allow udev_t tmpfs_t:lnk_file create_lnk_perms;
 allow udev_t tmpfs_t:{ chr_file blk_file } { relabelfrom relabelto create_file_perms };
 allow udev_t tmpfs_t:dir search;
+
+# for arping used for static IP addresses on PCMCIA ethernet
+domain_auto_trans(udev_t, netutils_exec_t, netutils_t)
 ')
 allow udev_t etc_t:file { getattr read };
 allow udev_t { bin_t sbin_t }:dir r_dir_perms;
@@ -51,7 +54,8 @@
 r_dir_file(udev_t, { selinux_config_t file_context_t default_context_t } )
 
 allow udev_t policy_config_t:dir { search };
-allow udev_t proc_t:file { read };
+allow udev_t proc_t:file { getattr read };
+allow udev_t proc_kcore_t:file getattr;
 
 # Get security policy decisions.
 can_getsecurity(udev_t)
@@ -71,10 +75,9 @@
 ifdef(`hide_broken_symptoms', `
 dontaudit restorecon_t udev_t:unix_dgram_socket { read write };
 ')
-allow udev_t devpts_t:dir { search };
+allow udev_t devpts_t:dir { getattr search };
 allow udev_t etc_runtime_t:file { getattr read };
 allow udev_t etc_t:file { ioctl };
-allow udev_t proc_t:file { getattr };
 ifdef(`xdm.te', `
 allow udev_t xdm_var_run_t:file { getattr read };
 ')
@@ -84,6 +87,9 @@
 ')
 allow udev_t var_log_t:dir { search };
 
+ifdef(`consoletype.te', `
+can_exec(udev_t, consoletype_exec_t)
+')
 ifdef(`pamconsole.te', `
 allow udev_t pam_var_console_t:dir search;
 allow udev_t pam_var_console_t:file { getattr read };
@@ -108,5 +114,6 @@
 allow udev_t sysctl_dev_t:dir { search };
 allow udev_t sysctl_dev_t:file { getattr read };
 allow udev_t sysctl_modprobe_t:file { getattr read };
-allow udev_t udev_t:rawip_socket create_socket_perms;
-dontaudit  udev_t domain:dir r_dir_perms;
+allow udev_t self:rawip_socket create_socket_perms;
+dontaudit udev_t domain:dir r_dir_perms;
+dontaudit udev_t ttyfile:chr_file unlink;

--Boundary-00=_XbQbBHUGWyEwgcZ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
