Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7101KHa006469
	for <selinux@tycho.nsa.gov>; Thu, 31 Jul 2003 20:01:20 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h7101JDW029766
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 00:01:19 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h7101EeN029757 for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 00:01:15 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 75AF6BF1D
	for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2003 10:01:13 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 08371-02
 for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2003 10:01:11 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 748E8BF1A
	for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2003 10:01:11 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id A10D992719
	for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2003 10:01:10 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 569FB7F04E
	for <selinux@tycho.nsa.gov>; Fri,  1 Aug 2003 10:01:05 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: new policy patch
Date: Fri, 1 Aug 2003 10:01:04 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_A3aK/tC5Tk5LYpG"
Message-Id: <200308011001.04418.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_A3aK/tC5Tk5LYpG
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch has some policy changes related to the change from 
sysadm_home_dir_t to staff_home_dir_t for the /root directory (incidentally, 
do we even need sysadm_home_dir_t any more?).

I've made significant changes to net_contexts and related files and made 
can_network() not permit binding to port_t.  I've got all the common daemons 
working well with this, but there may be some I've missed.

I've fixed the ftpd.te problem as previously discussed.

The new version of rpc.statd has slightly different functionality, I changed 
the policy to allow it to do what it needs to do.

I've made some changes to the rpm policy.  The old version would not work very 
well, my new version should be an improvement.  It would be good if someone 
could test this.

I've made a change to the watchdog policy that will allow it to work properly.

I've changed the file_contexts entries for postfix to deal with the Debian 
package creating the chroot directories and the startup scripts searching 
them and causing audit messages.

There are also many other minor changes.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_A3aK/tC5Tk5LYpG
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="diff"

diff -ru /tmp/policy/domains/misc/kernel.te policy/domains/misc/kernel.te
--- /tmp/policy/domains/misc/kernel.te	2003-07-31 13:20:08.000000000 +1000
+++ policy/domains/misc/kernel.te	2003-07-11 20:55:13.000000000 +1000
@@ -17,6 +17,7 @@
 general_proc_read_access(kernel_t)
 base_file_read_access(kernel_t)
 uses_shlib(kernel_t)
+can_exec(kernel_t, shell_exec_t)
 
 # Use capabilities.
 allow kernel_t self:capability *;
diff -ru /tmp/policy/domains/program/checkpolicy.te policy/domains/program/checkpolicy.te
--- /tmp/policy/domains/program/checkpolicy.te	2003-03-14 02:14:31.000000000 +1100
+++ policy/domains/program/checkpolicy.te	2003-07-16 11:11:33.000000000 +1000
@@ -44,12 +44,14 @@
 `allow checkpolicy_t sshd_devpts_t:dir r_dir_perms;')
 
 # Other access
-allow checkpolicy_t admin_tty_type:chr_file { read write ioctl getattr };
+allow checkpolicy_t { initrc_devpts_t admin_tty_type }:chr_file { read write ioctl getattr };
 uses_shlib(checkpolicy_t)
 allow checkpolicy_t self:capability dac_override;
 
 allow checkpolicy_t sysadm_tmp_t:file { getattr write } ;
 
+allow checkpolicy_t fs_t:filesystem getattr;
+
 ##########################
 # Allow users to execute checkpolicy without a domain transition
 # so it can be used without privilege to write real binary policy file
diff -ru /tmp/policy/domains/program/initrc.te policy/domains/program/initrc.te
--- /tmp/policy/domains/program/initrc.te	2003-07-31 13:20:15.000000000 +1000
+++ policy/domains/program/initrc.te	2003-07-12 20:38:43.000000000 +1000
@@ -20,6 +20,9 @@
 uses_shlib(initrc_t);
 type initrc_exec_t, file_type, sysadmfile, exec_type;
 
+# for halt to down interfaces
+allow initrc_t self:udp_socket create_socket_perms;
+
 # read files in /etc/init.d
 allow initrc_t etc_t:lnk_file r_file_perms;
 
diff -ru /tmp/policy/domains/program/logrotate.te policy/domains/program/logrotate.te
--- /tmp/policy/domains/program/logrotate.te	2003-07-31 13:20:16.000000000 +1000
+++ policy/domains/program/logrotate.te	2003-08-01 08:48:02.000000000 +1000
@@ -28,7 +28,7 @@
 allow logrotate_t etc_runtime_t:{ file lnk_file } r_file_perms;
 
 # it should not require this
-allow logrotate_t sysadm_home_dir_t:dir { read getattr search };
+allow logrotate_t staff_home_dir_t:dir { read getattr search };
 
 # create lock files
 rw_dir_create_file(logrotate_t, var_lock_t)
diff -ru /tmp/policy/domains/program/modutil.te policy/domains/program/modutil.te
--- /tmp/policy/domains/program/modutil.te	2003-07-31 13:20:16.000000000 +1000
+++ policy/domains/program/modutil.te	2003-08-01 09:03:28.000000000 +1000
@@ -55,8 +55,8 @@
 ifdef(`gnome-pty-helper.te', `allow depmod_t sysadm_gph_t:fd use;')
 
 # Read System.map from home directories.
-allow depmod_t { home_root_t user_home_dir_type sysadm_home_dir_t }:dir r_dir_perms;
-r_dir_file(depmod_t, { user_home_type sysadm_home_t })
+allow depmod_t { home_root_t staff_home_dir_t }:dir r_dir_perms;
+r_dir_file(depmod_t, staff_home_t)
 
 #################################
 #
@@ -154,7 +154,7 @@
 allow update_modules_t { console_device_t devtty_t }:chr_file rw_file_perms;
 allow update_modules_t { initrc_devpts_t admin_tty_type }:chr_file rw_file_perms;
 
-dontaudit update_modules_t sysadm_home_dir_t:dir search;
+dontaudit update_modules_t staff_home_dir_t:dir search;
 
 uses_shlib(update_modules_t)
 allow update_modules_t self:process { fork sigchld };
diff -ru /tmp/policy/domains/program/mount.te policy/domains/program/mount.te
--- /tmp/policy/domains/program/mount.te	2003-07-31 13:20:16.000000000 +1000
+++ policy/domains/program/mount.te	2003-07-12 19:59:50.000000000 +1000
@@ -34,11 +34,12 @@
 allow mount_t proc_t:dir mounton;
 allow mount_t root_t:dir mounton;
 allow mount_t home_root_t:dir mounton;
+allow mount_t tmp_t:dir mounton;
 # On some RedHat systems, /boot is a mount point
 allow mount_t boot_t:dir mounton;
 allow mount_t device_t:dir mounton;
 ifdef(`devfsd.te', `
-allow mount_t device_t:filesystem unmount;
+allow mount_t device_t:filesystem { mount unmount };
 ')
 allow mount_t root_t:filesystem unmount;
 
diff -ru /tmp/policy/domains/program/ssh.te policy/domains/program/ssh.te
--- /tmp/policy/domains/program/ssh.te	2003-07-31 13:20:16.000000000 +1000
+++ policy/domains/program/ssh.te	2003-07-31 05:31:18.000000000 +1000
@@ -38,11 +38,6 @@
 allow $1 etc_runtime_t:{ file lnk_file } r_file_perms;
 allow $1 resolv_conf_t:{ file lnk_file } r_file_perms;
 
-# Read the linker, shared library, and executable types.
-allow $1 ld_so_t:{ file lnk_file } r_file_perms;
-allow $1 shlib_t:{ file lnk_file } r_file_perms;
-allow $1 exec_type:{ file lnk_file } r_file_perms;
-
 # Read and write /dev/tty and /dev/null.
 allow $1 devtty_t:chr_file rw_file_perms;
 allow $1 { null_device_t zero_device_t }:chr_file rw_file_perms;
@@ -91,6 +86,10 @@
 # sshd_key_t is the type of the ssh private key files
 #
 sshd_program_domain(sshd_t)
+
+# for X forwarding
+allow sshd_t port_t:tcp_socket name_bind;
+
 type sshd_exec_t, file_type, exec_type, sysadmfile;
 
 ifdef(`inetd.te', `
diff -ru /tmp/policy/domains/program/unused/bootloader.te policy/domains/program/unused/bootloader.te
--- /tmp/policy/domains/program/unused/bootloader.te	2003-07-31 13:20:21.000000000 +1000
+++ policy/domains/program/unused/bootloader.te	2003-07-12 22:22:41.000000000 +1000
@@ -83,9 +83,10 @@
 
 allow bootloader_t fs_t:filesystem getattr;
 
-allow bootloader_t proc_t:dir r_dir_perms;
+allow bootloader_t proc_t:dir { getattr search };
 allow bootloader_t proc_t:file r_file_perms;
 allow bootloader_t proc_t:lnk_file read;
+allow bootloader_t self:dir { getattr search read };
 allow bootloader_t sysctl_kernel_t:dir search;
 allow bootloader_t sysctl_kernel_t:file { getattr read };
 allow bootloader_t etc_runtime_t:file r_file_perms;
diff -ru /tmp/policy/domains/program/unused/cups.te policy/domains/program/unused/cups.te
--- /tmp/policy/domains/program/unused/cups.te	2003-07-31 13:20:22.000000000 +1000
+++ policy/domains/program/unused/cups.te	2003-07-15 00:15:04.000000000 +1000
@@ -36,7 +36,7 @@
 allow cupsd_t proc_t:file r_file_perms;
 allow cupsd_t proc_t:dir r_dir_perms;
 allow cupsd_t { sysctl_t sysctl_kernel_t sysctl_dev_t }:dir search;
-allow cupsd_t sysctl_kernel_t:file { getattr read };
+allow cupsd_t { sysctl_kernel_t sysctl_dev_t }:file { getattr read };
 
 # allow cups to execute its backend scripts
 can_exec(cupsd_t, cupsd_exec_t)
@@ -57,7 +57,7 @@
 r_dir_file(cupsd_t, readable_t)
 
 # Bind to the cups/ipp port (631).
-allow cupsd_t ipp_port_t:tcp_socket name_bind;
+allow cupsd_t ipp_port_t:{ udp_socket tcp_socket } name_bind;
 
 can_tcp_connect(web_client_domain, cupsd_t)
 can_tcp_connect(cupsd_t, cupsd_t)
diff -ru /tmp/policy/domains/program/unused/devfsd.te policy/domains/program/unused/devfsd.te
--- /tmp/policy/domains/program/unused/devfsd.te	2003-07-31 13:20:22.000000000 +1000
+++ policy/domains/program/unused/devfsd.te	2003-07-11 00:03:18.000000000 +1000
@@ -9,7 +9,7 @@
 #
 type etc_devfsd_t, file_type, sysadmfile;
 
-allow kernel_t device_t:dir mounton;
+allow kernel_t { device_t root_t }:dir mounton;
 
 daemon_domain(devfsd)
 
diff -ru /tmp/policy/domains/program/unused/dhcpc.te policy/domains/program/unused/dhcpc.te
--- /tmp/policy/domains/program/unused/dhcpc.te	2003-07-31 13:20:22.000000000 +1000
+++ policy/domains/program/unused/dhcpc.te	2003-07-26 01:34:09.000000000 +1000
@@ -14,6 +14,8 @@
 # dhcpc_exec_t is the type of the dhcpcd executable.
 # The dhcpc_t can be used for other DHCPC related files as well.
 #
+type dhcpc_port_t, port_type;
+
 daemon_domain(dhcpc)
 can_network(dhcpc_t)
 allow dhcpc_t self:unix_dgram_socket create_socket_perms;
@@ -22,8 +24,14 @@
 
 ifdef(`cardmgr.te', `
 domain_auto_trans(cardmgr_t, dhcpc_exec_t, dhcpc_t)
+allow cardmgr_t dhcpc_var_run_t:file { getattr read };
 allow cardmgr_t dhcpc_t:process signal_perms;
 ')
+ifdef(`hotplug.te', `
+domain_auto_trans(hotplug_t, dhcpc_exec_t, dhcpc_t)
+allow hotplug_t dhcpc_t:process signal_perms;
+allow hotplug_t dhcpc_var_run_t:file { getattr read };
+')
 
 # for the dhcp client to run ping to check IP addresses
 ifdef(`ping.te', `
@@ -32,7 +40,13 @@
 dontaudit ping_t dhcpc_state_t:file read;
 dontaudit ping_t dhcpc_t:packet_socket { read write };
 dontaudit ping_t dhcpc_t:udp_socket { read write };
-')
+ifdef(`hotplug.te', `
+allow ping_t hotplug_t:fd use;
+') dnl end if hotplug
+ifdef(`cardmgr.te', `
+allow ping_t cardmgr_t:fd use;
+') dnl end if cardmgr
+') dnl end if ping
 
 ifdef(`dhcpd.te', `', `
 type dhcp_state_t, file_type, sysadmfile;
@@ -49,6 +63,9 @@
 # Use capabilities
 allow dhcpc_t self:capability { net_admin net_raw net_bind_service };
 
+# for udp port 68
+allow dhcpc_t dhcpc_port_t:udp_socket name_bind;
+
 # Allow read/write to /etc/resolv.conf. Note that any files in /etc 
 # created by dhcpcd will be labelled resolv_conf_t. As of RH 7.2, no
 # other files are accessed in the /etc dir, only in /etc/dhcpc dir.
diff -ru /tmp/policy/domains/program/unused/dhcpd.te policy/domains/program/unused/dhcpd.te
--- /tmp/policy/domains/program/unused/dhcpd.te	2003-07-31 13:20:22.000000000 +1000
+++ policy/domains/program/unused/dhcpd.te	2003-07-31 05:23:46.000000000 +1000
@@ -16,6 +16,10 @@
 #
 daemon_domain(dhcpd)
 
+# for UDP port 67
+type dhcpd_port_t, port_type;
+allow dhcpd_t dhcpd_port_t:udp_socket name_bind;
+
 type etc_dhcp_t alias { etc_dhcpc_t etc_dhcpd_t }, file_type, sysadmfile;
 
 # Use the network.
diff -ru /tmp/policy/domains/program/unused/dpkg.te policy/domains/program/unused/dpkg.te
--- /tmp/policy/domains/program/unused/dpkg.te	2003-07-31 13:20:22.000000000 +1000
+++ policy/domains/program/unused/dpkg.te	2003-08-01 08:46:54.000000000 +1000
@@ -130,8 +130,8 @@
 dontaudit apt_t var_run_t:dir search;
 
 # for rc files such as ~/.less
-r_dir_file(apt_t, sysadm_home_t)
-allow apt_t sysadm_home_dir_t:dir { search getattr };
+r_dir_file(apt_t, staff_home_t)
+allow apt_t staff_home_dir_t:dir { search getattr };
 
 allow apt_t bin_t:lnk_file r_file_perms;
 
@@ -293,7 +293,7 @@
 type debian_menu_t, file_type, sysadmfile;
 
 r_dir_file(userdomain, debian_menu_t)
-dontaudit install_menu_t sysadm_home_dir_t:dir search;
+dontaudit install_menu_t staff_home_dir_t:dir search;
 allow install_menu_t debian_menu_t:dir create_dir_perms;
 allow install_menu_t debian_menu_t:{ file lnk_file } create_file_perms;
 allow install_menu_t dpkg_lock_t:file { setattr rw_file_perms };
@@ -304,6 +304,9 @@
 allow install_menu_t { bin_t sbin_t }:dir search;
 allow install_menu_t bin_t:lnk_file read;
 
+# for menus
+allow install_menu_t usr_t:file r_file_perms;
+
 # for /etc/kde3/debian/kde-update-menu.sh
 can_exec(install_menu_t, etc_t)
 
diff -ru /tmp/policy/domains/program/unused/ftpd.te policy/domains/program/unused/ftpd.te
--- /tmp/policy/domains/program/unused/ftpd.te	2003-07-31 13:20:22.000000000 +1000
+++ policy/domains/program/unused/ftpd.te	2003-08-01 09:11:46.000000000 +1000
@@ -11,8 +11,6 @@
 type ftp_port_t, port_type;
 daemon_domain(ftpd, `, auth')
 type etc_ftpd_t, file_type, sysadmfile;
-ifdef(`inetd.te', `domain_auto_trans(inetd_t, ftpd_exec_t, ftpd_t)')
-ifdef(`tcpd.te', `domain_auto_trans(tcpd_t, ftpd_exec_t, ftpd_t)')
 
 can_network(ftpd_t)
 allow ftpd_t self:unix_dgram_socket create_socket_perms;
@@ -25,10 +23,19 @@
 ')
 
 ifdef(`ftpd_daemon', `
+ifdef(`inetd.te', `', `
+define(`ftpd_is_daemon', `')
+') dnl end inetd.te
+') dnl end ftpd_daemon
+
+ifdef(`ftpd_is_daemon', `
 rw_dir_create_file(ftpd_t, var_lock_t)
 allow ftpd_t ftp_port_t:tcp_socket name_bind;
 can_tcp_connect(userdomain, ftpd_t)
 ', `
+domain_auto_trans(inetd_t, ftpd_exec_t, ftpd_t)
+ifdef(`tcpd.te', `domain_auto_trans(tcpd_t, ftpd_exec_t, ftpd_t)')
+
 # Use sockets inherited from inetd.
 allow ftpd_t inetd_t:fd use;
 allow ftpd_t inetd_t:tcp_socket rw_stream_socket_perms;
diff -ru /tmp/policy/domains/program/unused/hotplug.te policy/domains/program/unused/hotplug.te
--- /tmp/policy/domains/program/unused/hotplug.te	2003-07-31 13:20:22.000000000 +1000
+++ policy/domains/program/unused/hotplug.te	2003-07-11 00:03:07.000000000 +1000
@@ -11,9 +11,6 @@
 #
 daemon_domain(hotplug)
 
-# allow kernel thread to run a shell to interpret the script
-allow kernel_t shell_exec_t:file execute;
-
 type etc_hotplug_t, file_type, sysadmfile;
 
 allow hotplug_t self:fifo_file { read write getattr ioctl };
diff -ru /tmp/policy/domains/program/unused/hwclock.te policy/domains/program/unused/hwclock.te
--- /tmp/policy/domains/program/unused/hwclock.te	2003-07-31 13:20:22.000000000 +1000
+++ policy/domains/program/unused/hwclock.te	2003-08-01 08:47:17.000000000 +1000
@@ -22,6 +22,8 @@
 domain_auto_trans(apmd_t, hwclock_exec_t, hwclock_t)
 ')
 
+allow hwclock_t fs_t:filesystem getattr;
+
 read_locale(hwclock_t)
 
 # Give hwclock the capabilities it requires.  dac_override is a surprise,
diff -ru /tmp/policy/domains/program/unused/inetd.te policy/domains/program/unused/inetd.te
--- /tmp/policy/domains/program/unused/inetd.te	2003-07-31 13:20:22.000000000 +1000
+++ policy/domains/program/unused/inetd.te	2003-07-12 11:57:50.000000000 +1000
@@ -14,6 +14,8 @@
 #
 # Rules for the inetd_t domain.
 #
+type inetd_port_t, port_type;
+
 daemon_domain(inetd)
 
 can_network(inetd_t)
@@ -45,6 +47,9 @@
 ifdef(`rlogind.te', `allow inetd_t rlogin_port_t:tcp_socket name_bind;')
 ifdef(`rshd.te', `allow inetd_t rsh_port_t:tcp_socket name_bind;')
 
+# allow to bind to chargen, echo, etc
+allow inetd_t inetd_port_t:{ tcp_socket udp_socket } name_bind;
+
 # Communicate with the portmapper.
 ifdef(`portmap.te', `can_udp_send(inetd_t, portmap_t)')
 
diff -ru /tmp/policy/domains/program/unused/ipsec.te policy/domains/program/unused/ipsec.te
--- /tmp/policy/domains/program/unused/ipsec.te	2003-07-31 13:20:22.000000000 +1000
+++ policy/domains/program/unused/ipsec.te	2003-08-01 08:56:50.000000000 +1000
@@ -200,7 +200,7 @@
 allow ipsec_t self:fifo_file { read getattr };
 
 # ideally it would not need this.  It wants to write to /root/.rnd
-file_type_auto_trans(ipsec_mgmt_t, sysadm_home_dir_t, sysadm_home_t, file)
+file_type_auto_trans(ipsec_mgmt_t, staff_home_dir_t, staff_home_t, file)
 
 allow ipsec_mgmt_t { initrc_devpts_t admin_tty_type }:chr_file { getattr read write ioctl };
 allow ipsec_t initrc_devpts_t:chr_file { getattr read write };
diff -ru /tmp/policy/domains/program/unused/named.te policy/domains/program/unused/named.te
--- /tmp/policy/domains/program/unused/named.te	2003-07-31 13:20:23.000000000 +1000
+++ policy/domains/program/unused/named.te	2003-08-01 08:48:48.000000000 +1000
@@ -128,5 +128,5 @@
 allow ndc_t named_var_run_t:file getattr;
 allow ndc_t named_zone_t:dir { read getattr };
 allow ndc_t named_zone_t:file getattr;
-dontaudit ndc_t sysadm_home_t:dir { getattr search read };
+dontaudit ndc_t staff_home_t:dir { getattr search read };
 ')
diff -ru /tmp/policy/domains/program/unused/pamconsole.te policy/domains/program/unused/pamconsole.te
--- /tmp/policy/domains/program/unused/pamconsole.te	2003-03-05 01:57:16.000000000 +1100
+++ policy/domains/program/unused/pamconsole.te	2003-04-22 20:01:53.000000000 +1000
@@ -4,7 +4,7 @@
 type pam_console_exec_t, file_type, sysadmfile, exec_type;
 type pam_console_t, domain;
 role system_r types pam_console_t;
-every_domain(pam_console_t)
+uses_shlib(pam_console_t)
 domain_auto_trans(initrc_t, pam_console_exec_t, pam_console_t)
 
 # Allow access to /dev/console through the fd:
diff -ru /tmp/policy/domains/program/unused/portmap.te policy/domains/program/unused/portmap.te
--- /tmp/policy/domains/program/unused/portmap.te	2003-07-31 13:20:25.000000000 +1000
+++ policy/domains/program/unused/portmap.te	2003-07-12 20:00:14.000000000 +1000
@@ -21,6 +21,9 @@
 
 allow portmap_t portmap_port_t:{ udp_socket tcp_socket } name_bind;
 
+# portmap binds to arbitary ports
+allow portmap_t port_t:{ udp_socket tcp_socket } name_bind;
+
 allow portmap_t etc_t:file { getattr read };
 
 # Send to ypbind, initrc, rpc.statd, xinetd.
@@ -39,6 +42,8 @@
 ')
 can_udp_send(portmap_t, kernel_t)
 can_udp_send(kernel_t, portmap_t)
+can_udp_send(sysadm_t, portmap_t)
+can_udp_send(portmap_t, sysadm_t)
 
 # Use capabilities
 allow portmap_t self:capability { net_bind_service setuid setgid };
diff -ru /tmp/policy/domains/program/unused/radius.te policy/domains/program/unused/radius.te
--- /tmp/policy/domains/program/unused/radius.te	2003-07-31 13:20:27.000000000 +1000
+++ policy/domains/program/unused/radius.te	2003-07-12 12:04:24.000000000 +1000
@@ -51,6 +51,10 @@
 
 can_network(radiusd_t)
 allow radiusd_t { radius_port_t radacct_port_t }:udp_socket name_bind;
+
+# for RADIUS proxy port
+allow radiusd_t port_t:udp_socket name_bind;
+
 ifdef(`snmpd.te', `
 can_tcp_connect(radiusd_t, snmpd_t)
 ')
diff -ru /tmp/policy/domains/program/unused/rpcd.te policy/domains/program/unused/rpcd.te
--- /tmp/policy/domains/program/unused/rpcd.te	2003-07-31 13:20:27.000000000 +1000
+++ policy/domains/program/unused/rpcd.te	2003-07-31 10:59:05.000000000 +1000
@@ -11,7 +11,7 @@
 # rpcd_t is the domain of rpc daemons.
 # rpcd_exec_t is the type of rpc daemon programs.
 #
-daemon_base_domain(rpcd)
+daemon_domain(rpcd)
 can_network(rpcd_t)
 allow rpcd_t resolv_conf_t:file { getattr read };
 can_udp_send({ init_t initrc_t }, rpcd_t)
@@ -23,6 +23,7 @@
 
 allow rpcd_t self:unix_dgram_socket create_socket_perms;
 allow rpcd_t self:unix_stream_socket create_socket_perms;
+allow rpcd_t self:fifo_file rw_file_perms;
 
 can_udp_send(rpcd_t, rpcd_t)
 can_udp_send(mount_t, rpcd_t)
@@ -41,6 +42,9 @@
 # Use capabilities.
 allow rpcd_t self:capability { net_bind_service dac_override setgid setuid };
 
+# bind to arbitary unused ports
+allow rpcd_t port_t:{ tcp_socket udp_socket } name_bind;
+
 # Access /var/lib/nfs.
 allow rpcd_t { var_t var_lib_t }:dir search;
 allow rpcd_t var_lib_nfs_t:dir rw_dir_perms;
diff -ru /tmp/policy/domains/program/unused/rpm.te policy/domains/program/unused/rpm.te
--- /tmp/policy/domains/program/unused/rpm.te	2003-03-05 01:57:20.000000000 +1100
+++ policy/domains/program/unused/rpm.te	2003-04-22 20:00:42.000000000 +1000
@@ -11,21 +11,21 @@
 #
 type rpm_t, domain, privlog;
 role system_r types rpm_t;
-role sysadm_r types rpm_t;
-every_domain(rpm_t)
+uses_shlib(rpm_t)
 type rpm_exec_t, file_type, sysadmfile, exec_type;
-domain_auto_trans(system_crond_t, rpm_exec_t, rpm_t)
+
+system_crond_entry(rpm_exec_t, rpm_t)
+#role sysadm_r types rpm_t;
 #domain_auto_trans(sysadm_t, rpm_exec_t, rpm_t)
 
 type rpm_file_t, file_type, sysadmfile;
 type var_lib_rpm_t, file_type, sysadmfile;
 
-type rpm_tmp_t, file_type, sysadmfile, tmpfile;
-file_type_auto_trans(rpm_t, tmp_t, rpm_tmp_t)
+tmp_domain(rpm)
 
-type rpm_tmpfs_t, file_type, sysadmfile, tmpfsfile;
-file_type_auto_trans(rpm_t, tmpfs_t, rpm_tmpfs_t)
-allow rpm_tmpfs_t tmpfs_t:filesystem associate;
+#type rpm_tmpfs_t, file_type, sysadmfile, tmpfsfile;
+#file_type_auto_trans(rpm_t, tmpfs_t, rpm_tmpfs_t)
+#allow rpm_tmpfs_t tmpfs_t:filesystem associate;
 
 type var_log_rpm_t, file_type, sysadmfile, logfile;
 file_type_auto_trans(rpm_t, var_log_t, var_log_rpm_t)
@@ -34,7 +34,7 @@
 can_exec_any(rpm_t)
 
 # Capabilties needed by rpm utils
-allow rpm_t rpm_t:capability { dac_override dac_read_search chown setuid setgid };
+allow rpm_t self:capability { dac_override dac_read_search chown setuid setgid };
 
 # Access /usr/lib files
 allow rpm_t lib_t:dir r_dir_perms;
@@ -44,15 +44,10 @@
 allow rpm_t var_lib_rpm_t:dir rw_dir_perms;
 allow rpm_t var_lib_rpm_t:file create_file_perms;
 
-# When the RPM updates are run from cron, inherit cron descriptors and 
-# read from the FIFO created by cron
-allow rpm_t crond_t:fd use;
-allow rpm_t crond_t:fifo_file r_file_perms;
-
 # Access terminals.
-allow rpm_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow rpm_t sysadm_devpts_t:chr_file rw_file_perms;
+allow rpm_t admin_tty_type:chr_file rw_file_perms;
 ifdef(`gnome-pty-helper.te', `allow rpm_t sysadm_gph_t:fd use;')
+allow rpm_t privfd:fd use;
 
 # Write to /usr/src.
 #allow rpm_t src_t:dir create_dir_perms;
@@ -60,9 +55,3 @@
 
 # Execute from /usr/src.
 #can_exec(rpm_t, src_t)
-
-# Execute helper programs.
-#can_exec_any(rpm_t)
-
-# Execute temporary files.
-#can_exec(rpm_t, rpm_tmp_t)
diff -ru /tmp/policy/domains/program/unused/squid.te policy/domains/program/unused/squid.te
--- /tmp/policy/domains/program/unused/squid.te	2003-07-31 13:20:28.000000000 +1000
+++ policy/domains/program/unused/squid.te	2003-07-11 20:56:29.000000000 +1000
@@ -60,8 +60,9 @@
 can_network(squid_t)
 can_tcp_connect(web_client_domain, squid_t)
 
-# port 8080 is http_cache_port_t (see net_contexts)
+# tcp port 8080 and udp port 3130 is http_cache_port_t (see net_contexts)
 allow squid_t http_cache_port_t:tcp_socket name_bind;
+allow squid_t http_cache_port_t:udp_socket name_bind;
 
 # to allow running programs from /usr/lib/squid (IE unlinkd)
 # also allow exec()ing itself
diff -ru /tmp/policy/domains/program/unused/sysstat.te policy/domains/program/unused/sysstat.te
--- /tmp/policy/domains/program/unused/sysstat.te	2003-07-31 13:20:28.000000000 +1000
+++ policy/domains/program/unused/sysstat.te	2003-08-01 08:49:27.000000000 +1000
@@ -29,7 +29,7 @@
 # for fstab
 allow sysstat_t etc_t:file { read getattr };
 
-dontaudit sysstat_t sysadm_home_dir_t:dir r_dir_perms;
+dontaudit sysstat_t staff_home_dir_t:dir r_dir_perms;
 
 allow sysstat_t self:fifo_file rw_file_perms;
 
diff -ru /tmp/policy/domains/program/unused/utempter.te policy/domains/program/unused/utempter.te
--- /tmp/policy/domains/program/unused/utempter.te	2003-03-05 01:57:27.000000000 +1100
+++ policy/domains/program/unused/utempter.te	2003-04-12 10:32:13.000000000 +1000
@@ -14,7 +14,7 @@
 type utempter_t, domain;
 in_user_role(utempter_t)
 role sysadm_r types utempter_t;
-every_domain(utempter_t)
+uses_shlib(utempter_t)
 type utempter_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(userdomain, utempter_exec_t, utempter_t)
 
diff -ru /tmp/policy/domains/program/unused/vmware.te policy/domains/program/unused/vmware.te
--- /tmp/policy/domains/program/unused/vmware.te	2003-07-31 13:20:29.000000000 +1000
+++ policy/domains/program/unused/vmware.te	2003-07-10 11:31:49.000000000 +1000
@@ -118,7 +118,7 @@
 # Access /proc
 r_dir_file(vmware_user_t, proc_t)
 
-# Access to some files in the home directory of the user
+# Access to some files in the user home directory
 r_dir_file(vmware_user_t, user_home_t)
 
 # Access to runtime files for user
diff -ru /tmp/policy/domains/program/unused/watchdog.te policy/domains/program/unused/watchdog.te
--- /tmp/policy/domains/program/unused/watchdog.te	2003-07-31 13:20:29.000000000 +1000
+++ policy/domains/program/unused/watchdog.te	2003-07-11 17:16:26.000000000 +1000
@@ -20,5 +20,13 @@
 allow watchdog_t proc_t:file r_file_perms;
 
 allow watchdog_t self:capability { ipc_lock sys_nice };
+allow watchdog_t self:fifo_file rw_file_perms;
+allow watchdog_t self:unix_stream_socket create_socket_perms;
+can_network(watchdog_t)
+allow watchdog_t resolv_conf_t:file { getattr read };
+allow watchdog_t self:udp_socket create_socket_perms;
+allow watchdog_t bin_t:dir search;
+allow watchdog_t init_t:process signal;
+allow watchdog_t kernel_t:process sigstop;
 
 allow watchdog_t watchdog_device_t:chr_file { getattr write };
diff -ru /tmp/policy/file_contexts/program/modutil.fc policy/file_contexts/program/modutil.fc
--- /tmp/policy/file_contexts/program/modutil.fc	2003-07-31 13:20:54.000000000 +1000
+++ policy/file_contexts/program/modutil.fc	2003-05-31 12:28:59.000000000 +1000
@@ -1,5 +1,6 @@
 # module utilities
 /etc/modules\.conf(.old)?	system_u:object_r:modules_conf_t
+/lib/modules/modprobe.conf	system_u:object_r:modules_conf_t
 /lib/modules(/.*)?		system_u:object_r:modules_object_t
 /lib/modules/[^/]+/modules\..+ system_u:object_r:modules_dep_t
 /lib/modules/modprobe\.conf.*	system_u:object_r:modules_conf_t
diff -ru /tmp/policy/file_contexts/program/nsd.fc policy/file_contexts/program/nsd.fc
--- /tmp/policy/file_contexts/program/nsd.fc	2003-07-31 13:20:56.000000000 +1000
+++ policy/file_contexts/program/nsd.fc	2003-07-26 01:34:33.000000000 +1000
@@ -3,7 +3,9 @@
 /etc/nsd/primary(/.*)?		system_u:object_r:nsd_zone_t
 /etc/nsd/secondary(/.*)?	system_u:object_r:nsd_zone_t
 /etc/nsd/nsd.db			system_u:object_r:nsd_zone_t
+/var/lib/nsd.db			system_u:object_r:nsd_zone_t
 /usr/sbin/nsd      		system_u:object_r:nsd_exec_t
 /usr/sbin/nsdc      		system_u:object_r:nsd_exec_t
 /usr/sbin/nsd-notify		system_u:object_r:nsd_exec_t
+/usr/sbin/zonec			system_u:object_r:nsd_exec_t
 /var/run/nsd\.pid		system_u:object_r:nsd_var_run_t
diff -ru /tmp/policy/file_contexts/program/postfix.fc policy/file_contexts/program/postfix.fc
--- /tmp/policy/file_contexts/program/postfix.fc	2003-07-31 13:20:57.000000000 +1000
+++ policy/file_contexts/program/postfix.fc	2003-08-01 08:50:14.000000000 +1000
@@ -37,9 +37,10 @@
 /var/spool/postfix/defer(red)?(/.*)? system_u:object_r:postfix_spool_t
 /var/spool/postfix/bounce(/.*)? system_u:object_r:postfix_spool_bounce_t
 /var/spool/postfix/flush(/.*)?	system_u:object_r:postfix_spool_flush_t
+/var/spool/postfix/etc(/.*)?	system_u:object_r:etc_t
 /var/spool/postfix/lib(/.*)?	system_u:object_r:lib_t
+/var/spool/postfix/usr(/.*)?	system_u:object_r:lib_t
 /var/spool/postfix/lib/ld.*\.so.* system_u:object_r:ld_so_t
 /var/spool/postfix/lib/lib.*\.so.* system_u:object_r:shlib_t
 /var/spool/postfix/lib/[^/]*/lib.*\.so.* system_u:object_r:shlib_t
 /var/spool/postfix/lib/devfsd/.*\.so.* system_u:object_r:shlib_t
-/var/spool/postfix/etc/services	system_u:object_r:etc_t
diff -ru /tmp/policy/file_contexts/program/rpcd.fc policy/file_contexts/program/rpcd.fc
--- /tmp/policy/file_contexts/program/rpcd.fc	2002-07-04 06:26:22.000000000 +1000
+++ policy/file_contexts/program/rpcd.fc	2003-07-31 10:59:27.000000000 +1000
@@ -2,3 +2,4 @@
 /sbin/rpc\..*			system_u:object_r:rpcd_exec_t
 /usr/sbin/rpc\..*		system_u:object_r:rpcd_exec_t
 /usr/sbin/exportfs		system_u:object_r:rpcd_exec_t
+/var/run/rpc.statd.pid		system_u:object_r:rpcd_var_run_t
diff -ru /tmp/policy/macros/global_macros.te policy/macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2003-07-31 13:21:04.000000000 +1000
+++ policy/macros/global_macros.te	2003-07-12 12:00:00.000000000 +1000
@@ -478,8 +481,8 @@
 # Bind to the default port type.
 # Other port types must be separately authorized.
 #
-allow $1 port_t:udp_socket name_bind;
-allow $1 port_t:tcp_socket name_bind;
+#allow $1 port_t:udp_socket name_bind;
+#allow $1 port_t:tcp_socket name_bind;
 ')
 
 #################################
diff -ru /tmp/policy/macros/program/mount_macros.te policy/macros/program/mount_macros.te
--- /tmp/policy/macros/program/mount_macros.te	2003-07-31 13:21:09.000000000 +1000
+++ policy/macros/program/mount_macros.te	2003-07-12 20:01:38.000000000 +1000
@@ -29,6 +29,7 @@
 domain_auto_trans($1_t, mount_exec_t, $2_t)
 
 allow $2_t proc_t:dir search;
+allow $2_t proc_t:file { getattr read };
 
 tmp_domain($2)
 
diff -ru /tmp/policy/macros/user_macros.te policy/macros/user_macros.te
--- /tmp/policy/macros/user_macros.te	2003-07-31 13:21:04.000000000 +1000
+++ policy/macros/user_macros.te	2003-07-12 20:02:20.000000000 +1000
@@ -92,6 +103,9 @@
 allow $1_t sshd_t:unix_stream_socket rw_stream_socket_perms;
 ')dnl end of ssh section
 
+# for ifconfig which is run all the time
+dontaudit $1_t sysctl_t:dir search;
+
 allow $1_t boot_t:dir { getattr search };
 dontaudit $1_t boot_t:dir read;
 dontaudit $1_t boot_t:lnk_file getattr;
@@ -172,8 +186,16 @@
 # Access other miscellaneous devices.
 allow $1_t misc_device_t:file_class_set rw_file_perms;
 
+ifdef(`apache.te', `
+ifelse(`$1', `sysadm', `', `
+dnl apache_domain($1)
+')
+')dnl end apache
+
 # Use the network.
 can_network($1_t)
+# allow port_t name binding for UDP because it is not very usable otherwise
+allow $1_t port_t:udp_socket name_bind;
 allow $1_t resolv_conf_t:file { getattr read };
 # for perl
 dontaudit $1_t resolv_conf_t:file ioctl;
diff -ru /tmp/policy/net_contexts policy/net_contexts
--- /tmp/policy/net_contexts	2003-07-31 13:20:03.000000000 +1000
+++ policy/net_contexts	2003-07-31 05:23:03.000000000 +1000
@@ -17,6 +17,18 @@
 # protocol number context
 # protocol low-high context
 #
+ifdef(`inetd.te', `
+portcon tcp 7 system_u:object_r:inetd_port_t
+portcon udp 7 system_u:object_r:inetd_port_t
+portcon tcp 9 system_u:object_r:inetd_port_t
+portcon udp 9 system_u:object_r:inetd_port_t
+portcon tcp 13 system_u:object_r:inetd_port_t
+portcon udp 13 system_u:object_r:inetd_port_t
+portcon tcp 37 system_u:object_r:inetd_port_t
+portcon udp 37 system_u:object_r:inetd_port_t
+portcon tcp 113 system_u:object_r:inetd_port_t
+portcon udp 517 system_u:object_r:inetd_port_t
+')
 ifdef(`courier.te', `define(`use_pop')')
 ifdef(`perdition.te', `define(`use_pop')')
 ifdef(`ftpd.te', `portcon tcp 21 system_u:object_r:ftp_port_t')
@@ -25,6 +37,8 @@
 ifdef(`mta.te', `portcon tcp 25 system_u:object_r:smtp_port_t')
 ifdef(`named.te', `portcon udp 53 system_u:object_r:named_port_t
 portcon tcp 53 system_u:object_r:named_port_t')
+ifdef(`dhcpd.te', `portcon udp 67  system_u:object_r:dhcpd_port_t')
+ifdef(`dhcpc.te', `portcon udp 68  system_u:object_r:dhcpc_port_t')
 ifdef(`tftpd.te', `portcon udp 69  system_u:object_r:tftp_port_t')
 ifdef(`fingerd.te', `portcon tcp 79  system_u:object_r:fingerd_port_t')
 ifdef(`apache.te', `portcon tcp 80  system_u:object_r:http_port_t')
@@ -37,7 +51,7 @@
 portcon udp 111 system_u:object_r:portmap_port_t
 portcon tcp 111 system_u:object_r:portmap_port_t
 ')
-ifdef(`ntp.te', `portcon udp 123 system_u:object_r:ntp_port_t')
+ifdef(`ntpd.te', `portcon udp 123 system_u:object_r:ntp_port_t')
 ifdef(`samba.te', `
 portcon tcp 137 system_u:object_r:smbd_port_t
 portcon udp 137 system_u:object_r:nmbd_port_t
@@ -57,7 +71,10 @@
 ifdef(`rlogind.te', `portcon tcp 513 system_u:object_r:rlogin_port_t')
 ifdef(`rshd.te', `portcon tcp 514 system_u:object_r:rsh_port_t')
 ifdef(`lpd.te', `portcon tcp 515 system_u:object_r:printer_port_t')
-ifdef(`cups.te', `portcon tcp 631 system_u:object_r:ipp_port_t')
+ifdef(`cups.te', `
+portcon tcp 631 system_u:object_r:ipp_port_t
+portcon udp 631 system_u:object_r:ipp_port_t
+')
 ifdef(`named.te', `portcon tcp 953 system_u:object_r:rndc_port_t')
 ifdef(`use_pop', `
 portcon tcp 993 system_u:object_r:pop_port_t
@@ -75,9 +92,18 @@
 portcon udp 5323 system_u:object_r:imaze_port_t
 ')
 ifdef(`ircd.te', `portcon tcp 6667 system_u:object_r:ircd_port_t')
+ifdef(`spamd.te', `portcon tcp 783 system_u:object_r:spamd_port_t')
+ifdef(`sound-server.te', `
+portcon tcp 8000 system_u:object_r:soundd_port_t
+# 9433 is for YIFF
+portcon tcp 9433 system_u:object_r:soundd_port_t
+')
 ifdef(`apache.te', `define(`use_http_cache')')
 ifdef(`squid.te', `define(`use_http_cache')')
-ifdef(`use_http_cache', `portcon tcp 8080  system_u:object_r:http_cache_port_t')
+ifdef(`use_http_cache', `
+portcon tcp 8080  system_u:object_r:http_cache_port_t
+portcon udp 3130  system_u:object_r:http_cache_port_t
+')
 ifdef(`transproxy.te', `portcon tcp 8081 system_u:object_r:transproxy_port_t')
 
 # Network interfaces (default = initial SID "netif" and "netmsg")

--Boundary-00=_A3aK/tC5Tk5LYpG--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
