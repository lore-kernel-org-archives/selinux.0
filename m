Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA15896
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 17:57:16 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA11948
	for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 22:55:21 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id WAA11944 for <selinux@tycho.nsa.gov>; Mon, 28 Oct 2002 22:55:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Stephen Smalley <sds@tislabs.com>
Subject: Re: run_init
Date: Mon, 28 Oct 2002 23:56:57 +0100
Cc: <selinux@tycho.nsa.gov>
References: <Pine.GSO.4.33.0210281537590.29887-100000@raven>
In-Reply-To: <Pine.GSO.4.33.0210281537590.29887-100000@raven>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_XQRPZLUL6HYIRRWRKK90"
Message-Id: <200210282356.57410.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_XQRPZLUL6HYIRRWRKK90
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

On Mon, 28 Oct 2002 21:56, Stephen Smalley wrote:
> I've merged the policy patch but I have not yet merged the modified
> run_init program (no harm caused by the policy changes) pending further
> review.  It might be preferable to not change SIDs until you execute the
> init script from open_init_pty (i.e. run_init does a normal exec of
> open_init_pty or open_init_pty is directly folded into run_init), and have
> the pty labeled run_init_devpts_t.

I've attached the latest open_init_pty that I'm using.  I decided to use this 
when I realised that I need input so I can also use run_init for running the 
Debian package management tools (and for some of the lamer daemons).  I also 
need basic terminal control (^C etc).  So that means quite a bit more coding 
than I did for my first cut of open_init_pty.

So because of this I decided to use a program that already exists to open 
pseudo-tty's and run programs - expect!

We can always change this decision later if we want.  But at the moment I've 
got better things to do than write what is basically a cut-down version of 
expect.

So with this current setup we are forced to have two programs, run_init and 
the program to open the pty.

As for your point about not using initrc_t for this, that would be easy to do 
and is worth doing.  We can easily change this with sed later on, if you'd 
like to pick a name and run sed on the policy tree that would be fine.  I'm 
not going to do this right now as I've got a bunch of little niggly issues 
with the current policy (when you make a change of this scale lots of little 
things will need to be changed).  I'll probably be tweaking this for another 
few weeks, but that will not be greatly impacted by any such name change you 
make.

I have attached two patches to this message, one for pty issues and one for a 
bunch of other little things.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_XQRPZLUL6HYIRRWRKK90
Content-Type: text/plain;
  charset="iso-8859-1";
  name="open_init_pty"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="open_init_pty"

#!/usr/bin/expect

eval spawn -noecho $argv
interact

--------------Boundary-00=_XQRPZLUL6HYIRRWRKK90
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru /tmp/policy/domains/program/bootloader.te policy/domains/program/bootloader.te
--- /tmp/policy/domains/program/bootloader.te	2002-09-27 22:27:37.000000000 +0200
+++ policy/domains/program/bootloader.te	2002-10-26 20:18:13.000000000 +0200
@@ -78,8 +78,7 @@
 allow bootloader_t etc_runtime_t:file r_file_perms;
 
 allow bootloader_t devtty_t:chr_file rw_file_perms;
-allow bootloader_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow bootloader_t sysadm_devpts_t:chr_file rw_file_perms;
+allow bootloader_t admin_tty_type:chr_file rw_file_perms;
 
 ifdef(`dpkg.te', `
 # for making an initrd
diff -ru /tmp/policy/domains/program/cardmgr.te policy/domains/program/cardmgr.te
--- /tmp/policy/domains/program/cardmgr.te	2002-09-26 13:37:04.000000000 +0200
+++ policy/domains/program/cardmgr.te	2002-10-28 15:56:06.000000000 +0100
@@ -26,16 +26,15 @@
 # for /etc/resolv.conf
 file_type_auto_trans(cardmgr_t, etc_t, resolv_conf_t)
 
-# allow cardmgr to write to the sysadm terminal (otherwise it will not start)
-allow cardmgr_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { read write };
+allow cardmgr_t initrc_devpts_t:chr_file { read write };
 
 # Create pid file and temporary block and character device nodes
 type cardmgr_var_run_t, file_type, sysadmfile, pidfile;
 file_type_auto_trans(cardmgr_t, { var_run_t device_t }, cardmgr_var_run_t, { blk_file chr_file file })
 
-# Create stab file.
+# Create stab file and device nodes.
 type cardmgr_var_lib_t, file_type, sysadmfile;
-file_type_auto_trans(cardmgr_t, var_lib_t, cardmgr_var_lib_t)
+file_type_auto_trans(cardmgr_t, var_lib_t, cardmgr_var_lib_t, { blk_file chr_file file })
 
 # Create device files in /tmp.
 type cardmgr_dev_t, file_type, sysadmfile, tmpfile;
diff -ru /tmp/policy/domains/program/checkpolicy.te policy/domains/program/checkpolicy.te
--- /tmp/policy/domains/program/checkpolicy.te	2002-08-26 18:50:43.000000000 +0200
+++ policy/domains/program/checkpolicy.te	2002-10-26 20:18:13.000000000 +0200
@@ -44,8 +44,7 @@
 `allow checkpolicy_t sshd_devpts_t:dir r_dir_perms;')
 
 # Other access
-allow checkpolicy_t sysadm_tty_device_t:chr_file { read write ioctl getattr };
-allow checkpolicy_t sysadm_devpts_t:chr_file { read write ioctl getattr };
+allow checkpolicy_t admin_tty_type:chr_file { read write ioctl getattr };
 uses_shlib(checkpolicy_t)
 allow checkpolicy_t self:capability dac_override;
 
diff -ru /tmp/policy/domains/program/dpkg.te policy/domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-10-28 22:55:52.000000000 +0100
+++ policy/domains/program/dpkg.te	2002-10-27 02:26:09.000000000 +0200
@@ -109,10 +109,6 @@
 # daemons are started in the correct context
 domain_auto_trans(dpkg_t, etc_t, initrc_t)
 
-# allow dpkg to run open_init_pty
-can_create_other_pty(dpkg, initrc)
-can_exec(dpkg_t, initrc_exec_t)
-
 ifdef(`bootloader.te',
 `domain_auto_trans(dpkg_t, bootloader_exec_t, bootloader_t)')
 
@@ -134,9 +130,9 @@
 can_exec(sysadm_t, etc_dpkg_t)
 
 # Inherit and use descriptors from any domain.
-allow { apt_t dpkg_t } privfd:fd use;
+allow { apt_t dpkg_t install_menu_t } initrc_t:fd use;
 allow { apt_t dpkg_t install_menu_t } devpts_t:dir search;
-allow { apt_t dpkg_t install_menu_t } { sysadm_tty_device_t sysadm_devpts_t }:chr_file rw_file_perms;
+allow { apt_t dpkg_t install_menu_t } initrc_devpts_t:chr_file rw_file_perms;
 
 allow ifconfig_t dpkg_t:fd use;
 allow ifconfig_t dpkg_t:fifo_file { read write };
@@ -271,5 +267,7 @@
 #
 # Rules for the run_deb_t domain.
 #
-run_program(sysadm_t, sysadm_r, deb, dpkg_exec_t, dpkg_t)
-domain_trans(run_deb_t, apt_exec_t, apt_t)
+#run_program(sysadm_t, sysadm_r, deb, dpkg_exec_t, dpkg_t)
+#domain_trans(run_deb_t, apt_exec_t, apt_t)
+domain_auto_trans(initrc_t, dpkg_exec_t, dpkg_t)
+domain_auto_trans(initrc_t, apt_exec_t, apt_t)
diff -ru /tmp/policy/domains/program/fsadm.te policy/domains/program/fsadm.te
--- /tmp/policy/domains/program/fsadm.te	2002-07-03 22:26:21.000000000 +0200
+++ policy/domains/program/fsadm.te	2002-10-26 20:18:13.000000000 +0200
@@ -63,6 +63,5 @@
 can_exec_any(fsadm_t)
 
 # Access terminals.
-allow fsadm_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow fsadm_t sysadm_devpts_t:chr_file rw_file_perms;
+allow fsadm_t admin_tty_type:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow fsadm_t sysadm_gph_t:fd use;')
diff -ru /tmp/policy/domains/program/ifconfig.te policy/domains/program/ifconfig.te
--- /tmp/policy/domains/program/ifconfig.te	2002-09-26 13:37:04.000000000 +0200
+++ policy/domains/program/ifconfig.te	2002-10-27 21:56:14.000000000 +0100
@@ -32,6 +32,5 @@
 allow ifconfig_t pump_t:fd use;')
 
 # Access terminals.
-allow ifconfig_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow ifconfig_t sysadm_devpts_t:chr_file rw_file_perms;
+allow ifconfig_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow ifconfig_t sysadm_gph_t:fd use;')
diff -ru /tmp/policy/domains/program/initrc.te policy/domains/program/initrc.te
--- /tmp/policy/domains/program/initrc.te	2002-10-28 22:55:53.000000000 +0100
+++ policy/domains/program/initrc.te	2002-10-26 20:18:13.000000000 +0200
@@ -180,8 +180,7 @@
 # Allow access to the sysadm TTYs. Note that this will give access to the 
 # TTYs to any process in the initrc_t domain. Therefore, daemons and such
 # started from init should be placed in their own domain.
-allow initrc_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow initrc_t sysadm_devpts_t:chr_file rw_file_perms;
+allow initrc_t admin_tty_type:chr_file rw_file_perms;
 
 # Access sound device and files.
 allow initrc_t sound_device_t:chr_file { setattr ioctl read write };
diff -ru /tmp/policy/domains/program/ipchains.te policy/domains/program/ipchains.te
--- /tmp/policy/domains/program/ipchains.te	2002-08-23 20:44:19.000000000 +0200
+++ policy/domains/program/ipchains.te	2002-10-26 20:18:13.000000000 +0200
@@ -31,6 +31,5 @@
 allow ipchains_t ipchains_t:rawip_socket create_socket_perms;
 
 # Access terminals.
-allow ipchains_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow ipchains_t sysadm_devpts_t:chr_file rw_file_perms;
+allow ipchains_t admin_tty_type:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow ipchains_t sysadm_gph_t:fd use;')
diff -ru /tmp/policy/domains/program/ipsec.te policy/domains/program/ipsec.te
--- /tmp/policy/domains/program/ipsec.te	2002-10-28 21:31:40.000000000 +0100
+++ policy/domains/program/ipsec.te	2002-10-27 21:56:14.000000000 +0100
@@ -195,11 +196,11 @@
 allow ipsec_mgmt_t ipsec_mgmt_t:udp_socket { create ioctl };
 
 #When running ipsec auto --up <conname>
-allow ipsec_t self:process fork;
+allow ipsec_t self:process { fork sigchld };
 allow ipsec_t self:fifo_file { read getattr };
 
 # ideally it would not need this.  It wants to write to /root/.rnd
 file_type_auto_trans(ipsec_mgmt_t, sysadm_home_dir_t, sysadm_home_t, file)
 
-allow ipsec_mgmt_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { getattr read write ioctl };
-allow ipsec_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { getattr read write };
+allow ipsec_mgmt_t { initrc_devpts_t admin_tty_type }:chr_file { getattr read write ioctl };
+allow ipsec_t initrc_devpts_t:chr_file { getattr read write };
diff -ru /tmp/policy/domains/program/klogd.te policy/domains/program/klogd.te
--- /tmp/policy/domains/program/klogd.te	2002-07-03 22:26:21.000000000 +0200
+++ policy/domains/program/klogd.te	2002-10-28 15:50:28.000000000 +0100
@@ -29,7 +29,7 @@
 allow klogd_t memory_device_t:chr_file r_file_perms;
 
 # Write to the console.
-allow klogd_t console_device_t:chr_file rw_file_perms;
+allow klogd_t { initrc_devpts_t console_device_t }:chr_file rw_file_perms;
 
 # Control syslog and console logging
 allow klogd_t kernel_t:system { syslog_mod syslog_console };
diff -ru /tmp/policy/domains/program/ldconfig.te policy/domains/program/ldconfig.te
--- /tmp/policy/domains/program/ldconfig.te	2002-10-17 00:01:10.000000000 +0200
+++ policy/domains/program/ldconfig.te	2002-10-27 02:26:52.000000000 +0200
@@ -14,7 +14,7 @@
 
 domain_auto_trans({ sysadm_t initrc_t ifdef(`dpkg.te', `dpkg_t') }, ldconfig_exec_t, ldconfig_t)
 dontaudit ldconfig_t device_t:dir search;
-allow ldconfig_t admin_tty_type:chr_file rw_file_perms;
+allow ldconfig_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 allow ldconfig_t privfd:fd use;
 
 uses_shlib(ldconfig_t)
diff -ru /tmp/policy/domains/program/load_policy.te policy/domains/program/load_policy.te
--- /tmp/policy/domains/program/load_policy.te	2002-09-09 19:54:12.000000000 +0200
+++ policy/domains/program/load_policy.te	2002-10-28 15:58:40.000000000 +0100
@@ -41,14 +41,11 @@
 
 # Read the devpts root directory (needed?)  
 allow load_policy_t devpts_t:dir r_dir_perms;
-ifdef(`sshd.te',
-`allow load_policy_t sshd_devpts_t:dir r_dir_perms;')
 
 # Other access
-allow load_policy_t sysadm_tty_device_t:chr_file { read write ioctl getattr };
-allow load_policy_t sysadm_devpts_t:chr_file { read write ioctl getattr };
+allow load_policy_t { initrc_devpts_t admin_tty_type }:chr_file { read write ioctl getattr };
 uses_shlib(load_policy_t)
 allow load_policy_t self:capability dac_override;
 
-allow load_policy_t privfd:fd use;
+allow load_policy_t { initrc_t privfd }:fd use;
 
diff -ru /tmp/policy/domains/program/logrotate.te policy/domains/program/logrotate.te
--- /tmp/policy/domains/program/logrotate.te	2002-10-28 21:31:40.000000000 +0100
+++ policy/domains/program/logrotate.te	2002-10-26 20:18:13.000000000 +0200
@@ -72,8 +72,7 @@
 allow logrotate_t var_spool_t:file { rename create setattr unlink };
 
 # Access terminals.
-allow logrotate_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow logrotate_t sysadm_devpts_t:chr_file rw_file_perms;
+allow logrotate_t admin_tty_type:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow logrotate_t sysadm_gph_t:fd use;')
 
 # for /var/backups on Debian
diff -ru /tmp/policy/domains/program/modutil.te policy/domains/program/modutil.te
--- /tmp/policy/domains/program/modutil.te	2002-10-23 21:38:18.000000000 +0200
+++ policy/domains/program/modutil.te	2002-10-28 15:51:03.000000000 +0100
@@ -38,8 +38,7 @@
 allow depmod_t modules_object_t:{ file lnk_file } r_file_perms;
 
 # Access terminals.
-allow depmod_t { console_device_t sysadm_tty_device_t }:chr_file rw_file_perms;
-allow depmod_t sysadm_devpts_t:chr_file rw_file_perms;
+allow depmod_t { console_device_t initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow depmod_t sysadm_gph_t:fd use;')
 
 # Read System.map from home directories.
@@ -93,7 +92,7 @@
 allow insmod_t ipsec_t:process signal;')
 
 # Access terminals.
-allow insmod_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file rw_file_perms;
+allow insmod_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow insmod_t sysadm_gph_t:fd use;')
 
 uses_shlib(insmod_t)
@@ -114,7 +113,7 @@
 
 allow update_modules_t device_t:dir search;
 allow update_modules_t { console_device_t devtty_t }:chr_file rw_file_perms;
-allow update_modules_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file rw_file_perms;
+allow update_modules_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 
 dontaudit update_modules_t sysadm_home_dir_t:dir search;
 
diff -ru /tmp/policy/domains/program/netutils.te policy/domains/program/netutils.te
--- /tmp/policy/domains/program/netutils.te	2002-07-03 22:26:21.000000000 +0200
+++ policy/domains/program/netutils.te	2002-10-26 20:18:13.000000000 +0200
@@ -29,8 +29,7 @@
 allow netutils_t self:packet_socket create_socket_perms;
 
 # Access terminals.
-allow netutils_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow netutils_t sysadm_devpts_t:chr_file rw_file_perms;
+allow netutils_t admin_tty_type:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow netutils_t sysadm_gph_t:fd use;')
 
 
diff -ru /tmp/policy/domains/program/ping.te policy/domains/program/ping.te
--- /tmp/policy/domains/program/ping.te	2002-07-03 22:26:21.000000000 +0200
+++ policy/domains/program/ping.te	2002-10-26 20:18:13.000000000 +0200
@@ -30,7 +30,6 @@
 allow ping_t ping_t:capability { net_raw setuid };
 
 # Access the terminal.
-allow ping_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow ping_t sysadm_devpts_t:chr_file rw_file_perms;
+allow ping_t admin_tty_type:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow ping_t sysadm_gph_t:fd use;')
 
diff -ru /tmp/policy/domains/program/quota.te policy/domains/program/quota.te
--- /tmp/policy/domains/program/quota.te	2002-10-23 21:38:18.000000000 +0200
+++ policy/domains/program/quota.te	2002-10-28 15:45:51.000000000 +0100
@@ -28,3 +29,5 @@
 allow quota_t fixed_disk_device_t:blk_file getattr;
 allow quota_t boot_t:dir r_dir_perms;
 allow quota_t sysctl_t:dir search;
+
+allow quota_t initrc_devpts_t:chr_file rw_file_perms;
diff -ru /tmp/policy/domains/program/setfiles.te policy/domains/program/setfiles.te
--- /tmp/policy/domains/program/setfiles.te	2002-09-09 19:54:15.000000000 +0200
+++ policy/domains/program/setfiles.te	2002-10-26 23:52:33.000000000 +0200
@@ -14,8 +14,8 @@
 role system_r types setfiles_t;
 role sysadm_r types setfiles_t;
 
-allow setfiles_t sysadm_tty_device_t:chr_file { read write ioctl };
-allow setfiles_t sysadm_devpts_t:chr_file { read write ioctl };
+allow setfiles_t initrc_devpts_t:chr_file { read write ioctl };
+allow setfiles_t admin_tty_type:chr_file { read write ioctl };
 
 domain_auto_trans({ initrc_t sysadm_t }, setfiles_exec_t, setfiles_t)
 allow setfiles_t init_t:fd use;
diff -ru /tmp/policy/domains/program/snmpd.te policy/domains/program/snmpd.te
--- /tmp/policy/domains/program/snmpd.te	2002-09-21 05:01:28.000000000 +0200
+++ policy/domains/program/snmpd.te	2002-10-26 23:47:41.000000000 +0200
@@ -14,9 +14,6 @@
 
 can_network(snmpd_t)
 
-dontaudit snmpd_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { read write };
-
-
 type snmp_port_t, port_type;
 allow snmpd_t snmp_port_t:{ udp_socket tcp_socket } name_bind;
 
diff -ru /tmp/policy/domains/program/syslogd.te policy/domains/program/syslogd.te
--- /tmp/policy/domains/program/syslogd.te	2002-09-09 19:54:15.000000000 +0200
+++ policy/domains/program/syslogd.te	2002-10-28 15:51:56.000000000 +0100
@@ -32,7 +32,7 @@
 
 # Inherit and use descriptors from init.
 allow syslogd_t init_t:fd use;
-allow syslogd_t console_device_t:chr_file { read write };
+allow syslogd_t { initrc_devpts_t console_device_t }:chr_file { read write };
 
 # Modify/create log files.
 create_append_log_file(syslogd_t, var_log_t)
diff -ru /tmp/policy/domains/program/traceroute.te policy/domains/program/traceroute.te
--- /tmp/policy/domains/program/traceroute.te	2002-08-23 20:44:20.000000000 +0200
+++ policy/domains/program/traceroute.te	2002-10-27 01:23:57.000000000 +0200
@@ -30,7 +32,6 @@
 allow traceroute_t any_socket_t:rawip_socket sendto;
 
 # Access the terminal.
-allow traceroute_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow traceroute_t sysadm_devpts_t:chr_file rw_file_perms;
+allow traceroute_t admin_tty_type:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow traceroute_t sysadm_gph_t:fd use;')
 
diff -ru /tmp/policy/file_contexts/program/dpkg.fc policy/file_contexts/program/dpkg.fc
--- /tmp/policy/file_contexts/program/dpkg.fc	2002-10-17 00:01:19.000000000 +0200
+++ policy/file_contexts/program/dpkg.fc	2002-10-26 20:18:41.000000000 +0200
@@ -29,6 +29,5 @@
 /etc/dpkg/.*			system_u:object_r:etc_dpkg_t
 /etc/menu-methods/.*		system_u:object_r:install_menu_exec_t
 /etc/kde2/.*\.sh		system_u:object_r:install_menu_exec_t
-# run_deb
-/usr/sbin/se_dpkg		system_u:object_r:run_deb_exec_t
+/usr/share/console/getkmapchoice.pl system_u:object_r:bin_t
 /var/run/update-menus.pid	system_u:object_r:install_menu_var_run_t
diff -ru /tmp/policy/macros/program/chroot_macros.te policy/macros/program/chroot_macros.te
--- /tmp/policy/macros/program/chroot_macros.te	2002-10-01 18:40:38.000000000 +0200
+++ policy/macros/program/chroot_macros.te	2002-10-26 20:19:15.000000000 +0200
@@ -7,7 +7,7 @@
 
 ifelse(`$1', `initrc', `
 define(`chroot_role', `system_r')
-define(`chroot_tty_device', `{ console_device_t sysadm_devpts_t sysadm_tty_device_t }')
+define(`chroot_tty_device', `{ console_device_t admin_tty_type }')
 define(`chroot_mount_domain', `mount_t')
 define(`chroot_fd_use', `{ privfd init_t }')
 ', `
diff -ru /tmp/policy/macros/program/run_program_macros.te policy/macros/program/run_program_macros.te
--- /tmp/policy/macros/program/run_program_macros.te	2002-09-11 20:20:55.000000000 +0200
+++ policy/macros/program/run_program_macros.te	2002-10-26 20:19:47.000000000 +0200
@@ -27,7 +27,7 @@
 
 # for utmp
 allow run_$3_t initrc_var_run_t:file rw_file_perms;
-allow run_$3_t { sysadm_devpts_t sysadm_tty_device_t }:chr_file rw_file_perms;
+allow run_$3_t admin_tty_type:chr_file rw_file_perms;
 
 # often the administrator runs such programs from a directory that is owned
 # by a different user or has restrictive SE permissions, do not want to audit

--------------Boundary-00=_XQRPZLUL6HYIRRWRKK90
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="other"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="other"

diff -ru /tmp/policy/domains/program/fingerd.te policy/domains/program/fingerd.te
--- /tmp/policy/domains/program/fingerd.te	2002-10-28 21:31:39.000000000 +0100
+++ policy/domains/program/fingerd.te	2002-10-27 10:58:50.000000000 +0100
@@ -76,3 +76,7 @@
 allow fingerd_t ptyfile:chr_file getattr;
 
 allow fingerd_t proc_t:file { read getattr };
+
+# for date command
+allow fingerd_t sysctl_kernel_t:dir search;
+allow fingerd_t sysctl_kernel_t:file { read getattr };
diff -ru /tmp/policy/domains/program/ftpd.te policy/domains/program/ftpd.te
--- /tmp/policy/domains/program/ftpd.te	2002-10-01 19:28:43.000000000 +0200
+++ policy/domains/program/ftpd.te	2002-10-27 10:58:50.000000000 +0100
@@ -18,6 +18,8 @@
 ifdef(`inetd.te', `domain_auto_trans(inetd_t, ftpd_exec_t, ftpd_t)')
 ifdef(`tcpd.te', `domain_auto_trans(tcpd_t, ftpd_exec_t, ftpd_t)')
 
+ifdef(`crond.te', `system_crond_entry(ftpd_exec_t, ftpd_t)')
+
 # Inherit and use descriptors from inetd.
 allow ftpd_t inetd_t:fd use;
 
diff -ru /tmp/policy/domains/program/ipsec.te policy/domains/program/ipsec.te
--- /tmp/policy/domains/program/ipsec.te	2002-10-28 21:31:40.000000000 +0100
+++ policy/domains/program/ipsec.te	2002-10-27 21:56:14.000000000 +0100
@@ -69,6 +69,7 @@
 allow ipsec_mgmt_t ipsec_mgmt_exec_t:lnk_file read;
 can_exec(ipsec_mgmt_t, shell_exec_t)
 can_exec(ipsec_t, shell_exec_t)
+can_exec(ipsec_t, ipsec_mgmt_exec_t)
 can_exec(ipsec_mgmt_t, ifconfig_exec_t)
 
 # now for a icky part...
diff -ru /tmp/policy/domains/program/mysqld.te policy/domains/program/mysqld.te
--- /tmp/policy/domains/program/mysqld.te	2002-10-01 19:28:44.000000000 +0200
+++ policy/domains/program/mysqld.te	2002-10-28 13:23:02.000000000 +0100
@@ -37,7 +37,7 @@
 allow mysqld_t var_lib_t:dir search;
 
 # read config files
-r_dir_file(mysqld_t, etc_mysqld_t)
+r_dir_file({ mysqld_t initrc_t }, etc_mysqld_t)
 allow mysqld_t { etc_t resolv_conf_t etc_runtime_t }:{ file lnk_file } { read getattr };
 
 allow mysqld_t etc_t:dir search;
diff -ru /tmp/policy/domains/program/named.te policy/domains/program/named.te
--- /tmp/policy/domains/program/named.te	2002-10-28 22:55:56.000000000 +0100
+++ policy/domains/program/named.te	2002-10-28 15:41:53.000000000 +0100
@@ -101,6 +101,7 @@
 allow ndc_t privfd:fd use;
 # seems to need read as well for some reason
 allow ndc_t admin_tty_type:chr_file { getattr read write };
+allow ndc_t fs_t:filesystem getattr;
 
 # Read sysctl kernel variables.
 allow ndc_t sysctl_t:dir r_dir_perms;
diff -ru /tmp/policy/domains/program/postfix.te policy/domains/program/postfix.te
--- /tmp/policy/domains/program/postfix.te	2002-10-28 22:55:56.000000000 +0100
+++ policy/domains/program/postfix.te	2002-10-28 15:51:34.000000000 +0100
@@ -177,6 +177,7 @@
 postfix_user_domain(postqueue)
 allow postfix_postqueue_t postfix_public_t:dir search;
 allow postfix_postqueue_t postfix_public_t:fifo_file getattr;
+allow postfix_postqueue_t self:udp_socket create;
 allow postfix_master_t postfix_postqueue_exec_t:file getattr;
 
 # to write the mailq output, it really should not need read access!
diff -ru /tmp/policy/domains/program/quota.te policy/domains/program/quota.te
--- /tmp/policy/domains/program/quota.te	2002-10-23 21:38:18.000000000 +0200
+++ policy/domains/program/quota.te	2002-10-28 15:45:51.000000000 +0100
@@ -20,6 +20,7 @@
 
 # for /quota.*
 allow quota_t quota_db_t:file { read write };
+dontaudit unpriv_userdomain quota_db_t:file getattr;
 
 # Read /etc/mtab.
 allow quota_t etc_runtime_t:file { read getattr };
diff -ru /tmp/policy/domains/program/syslogd.te policy/domains/program/syslogd.te
--- /tmp/policy/domains/program/syslogd.te	2002-09-09 19:54:15.000000000 +0200
+++ policy/domains/program/syslogd.te	2002-10-28 15:51:56.000000000 +0100
@@ -32,7 +32,7 @@
 
 # Inherit and use descriptors from init.
 allow syslogd_t init_t:fd use;
-allow syslogd_t console_device_t:chr_file { read write };
+allow syslogd_t { initrc_devpts_t console_device_t }:chr_file { read write };
 
 # Modify/create log files.
 create_append_log_file(syslogd_t, var_log_t)
diff -ru /tmp/policy/domains/program/traceroute.te policy/domains/program/traceroute.te
--- /tmp/policy/domains/program/traceroute.te	2002-08-23 20:44:20.000000000 +0200
+++ policy/domains/program/traceroute.te	2002-10-27 01:23:57.000000000 +0200
@@ -20,6 +20,8 @@
 domain_auto_trans(initrc_t, traceroute_exec_t, traceroute_t)
 domain_auto_trans(sysadm_t, traceroute_exec_t, traceroute_t)
 
+allow traceroute_t icmp_socket_t:rawip_socket recvfrom;
+
 # Let traceroute create raw ICMP packets.
 #allow traceroute_t traceroute_t:rawip_socket { create bind setopt getopt write read };
 
diff -ru /tmp/policy/file_contexts/program/ftpd.fc policy/file_contexts/program/ftpd.fc
--- /tmp/policy/file_contexts/program/ftpd.fc	2002-09-09 19:54:20.000000000 +0200
+++ policy/file_contexts/program/ftpd.fc	2002-10-27 10:59:07.000000000 +0100
@@ -7,3 +7,5 @@
 /var/run/proftpd/proftpd-inetd	system_u:object_r:ftpd_var_run_t
 /var/log/muddleftpd.log.*	system_u:object_r:xferlog_t
 /var/log/xferlog.*		system_u:object_r:xferlog_t
+/var/log/xferreport.*		system_u:object_r:xferlog_t
+/etc/cron.monthly/proftpd	system_u:object_r:ftpd_exec_t
diff -ru /tmp/policy/file_contexts/program/quota.fc policy/file_contexts/program/quota.fc
--- /tmp/policy/file_contexts/program/quota.fc	2002-10-23 21:38:23.000000000 +0200
+++ policy/file_contexts/program/quota.fc	2002-10-28 15:46:15.000000000 +0100
@@ -1,4 +1,4 @@
 # quota system
 /var/lib/quota(/.*)?		system_u:object_r:quota_flag_t
 /sbin/quota(check|on)		system_u:object_r:quota_exec_t
-/quota.(user|group)		system_u:object_r:quota_db_t
+/(|home/|var/)quota.(user|group) system_u:object_r:quota_db_t
diff -ru /tmp/policy/macros/program/gpg_macros.te policy/macros/program/gpg_macros.te
--- /tmp/policy/macros/program/gpg_macros.te	2002-10-01 19:28:52.000000000 +0200
+++ policy/macros/program/gpg_macros.te	2002-10-26 07:45:55.000000000 +0200
@@ -57,7 +57,8 @@
 
 uses_shlib($1_gpg_t)
 
-allow $1_gpg_t home_root_t:dir search;
+# should not need read access...
+allow $1_gpg_t home_root_t:dir { read search };
 
 # use $1_gpg_secret_t for files it creates
 # NB we are doing the type transition for directory creation only!

--------------Boundary-00=_XQRPZLUL6HYIRRWRKK90--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
