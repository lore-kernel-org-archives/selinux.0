Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9B8sCrT004900
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 04:54:13 -0400 (EDT)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9B8sBWH017713
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 08:54:11 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Mon, 11 Oct 2004 10:54:10 +0200
Date: Mon, 11 Oct 2004 10:54:50 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: cleanup: domain self references
Message-Id: <20041011085450.GA15844@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--OwLcNYc0lM97+oe1
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just did a global search and replace to clean up rules of the form
        allow some_domain_t some_domain_t:capability setuid;
This makes the policy easier to read.

Please apply.
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="self_cleanup.patch"
Content-Transfer-Encoding: quoted-printable

diff -urN orig/domains/program/getty.te mod/domains/program/getty.te
--- orig/domains/program/getty.te	2004-10-11 10:03:20.000000000 +0200
+++ mod/domains/program/getty.te	2004-10-11 10:32:22.000000000 +0200
@@ -34,7 +34,7 @@
 allow getty_t self:capability { dac_override chown sys_resource sys_tty_co=
nfig };
=20
 # fbgetty needs fsetid for some reason
-#allow getty_t getty_t:capability fsetid;
+#allow getty_t self:capability fsetid;
=20
 read_locale(getty_t)
=20
diff -urN orig/domains/program/initrc.te mod/domains/program/initrc.te
--- orig/domains/program/initrc.te	2004-10-11 10:03:20.000000000 +0200
+++ mod/domains/program/initrc.te	2004-10-11 10:32:22.000000000 +0200
@@ -309,7 +309,7 @@
 #
 allow initrc_t device_t:dir rw_dir_perms;
 allow initrc_t device_t:lnk_file { unlink };
-allow initrc_t initrc_t:process { getsched };
+allow initrc_t self:process { getsched };
=20
 r_dir_file(initrc_t,selinux_config_t)
=20
diff -urN orig/domains/program/init.te mod/domains/program/init.te
--- orig/domains/program/init.te	2004-09-15 19:01:05.000000000 +0200
+++ mod/domains/program/init.te	2004-10-11 10:32:22.000000000 +0200
@@ -29,7 +29,7 @@
 allow init_t file_t:dir search;
=20
 # Use capabilities.
-allow init_t init_t:capability ~sys_module;
+allow init_t self:capability ~sys_module;
=20
 # Run /etc/rc.sysinit, /etc/rc, /etc/rc.local in the initrc_t domain.
 domain_auto_trans(init_t, initrc_exec_t, initrc_t)
diff -urN orig/domains/program/unused/dhcpd.te mod/domains/program/unused/d=
hcpd.te
--- orig/domains/program/unused/dhcpd.te	2004-09-11 14:31:46.000000000 +0200
+++ mod/domains/program/unused/dhcpd.te	2004-10-11 10:32:22.000000000 +0200
@@ -39,7 +39,7 @@
 allow dhcpd_t devtty_t:chr_file { read write };
=20
 # Use capabilities
-allow dhcpd_t dhcpd_t:capability { net_raw net_bind_service };
+allow dhcpd_t self:capability { net_raw net_bind_service };
=20
 # Allow access to the dhcpd file types
 type dhcp_state_t, file_type, sysadmfile;
diff -urN orig/domains/program/unused/firstboot.te mod/domains/program/unus=
ed/firstboot.te
--- orig/domains/program/unused/firstboot.te	2004-09-25 19:52:49.000000000 =
+0200
+++ mod/domains/program/unused/firstboot.te	2004-10-11 10:32:22.000000000 +=
0200
@@ -36,9 +36,9 @@
=20
 allow firstboot_t firstboot_rw_t:dir create_dir_perms;
 allow firstboot_t firstboot_rw_t:file create_file_perms;
-allow firstboot_t firstboot_t:fifo_file { getattr read write };
-allow firstboot_t firstboot_t:process { fork sigchld };
-allow firstboot_t firstboot_t:unix_stream_socket { connect create };
+allow firstboot_t self:fifo_file { getattr read write };
+allow firstboot_t self:process { fork sigchld };
+allow firstboot_t self:unix_stream_socket { connect create };
 allow firstboot_t initrc_exec_t:file { getattr read };
 allow firstboot_t initrc_var_run_t:file r_file_perms;
 allow firstboot_t lib_t:file { getattr read };
@@ -82,10 +82,10 @@
=20
 allow firstboot_t etc_t:{ file lnk_file } create_file_perms;
=20
-allow firstboot_t firstboot_t:capability { dac_override setgid };
-allow firstboot_t firstboot_t:dir { search };
-allow firstboot_t firstboot_t:file { read write };
-allow firstboot_t firstboot_t:lnk_file read;
+allow firstboot_t self:capability { dac_override setgid };
+allow firstboot_t self:dir { search };
+allow firstboot_t self:file { read write };
+allow firstboot_t self:lnk_file read;
 can_setfscreate(firstboot_t)
 allow firstboot_t krb5_conf_t:file rw_file_perms;
=20
diff -urN orig/domains/program/unused/hald.te mod/domains/program/unused/ha=
ld.te
--- orig/domains/program/unused/hald.te	2004-10-11 10:03:21.000000000 +0200
+++ mod/domains/program/unused/hald.te	2004-10-11 10:32:22.000000000 +0200
@@ -26,7 +26,7 @@
 allow hald_t { self proc_t }:file { getattr read };
=20
 allow hald_t { bin_t sbin_t }:dir search;
-allow hald_t hald_t:fifo_file rw_file_perms;
+allow hald_t self:fifo_file rw_file_perms;
 allow hald_t usr_t:file { getattr read };
=20
 allow hald_t bin_t:file { getattr };
diff -urN orig/domains/program/unused/inetd.te mod/domains/program/unused/i=
netd.te
--- orig/domains/program/unused/inetd.te	2004-10-11 10:03:21.000000000 +0200
+++ mod/domains/program/unused/inetd.te	2004-10-11 10:32:22.000000000 +0200
@@ -25,7 +25,7 @@
 allow inetd_t self:unix_stream_socket create_socket_perms;
 allow inetd_t self:fifo_file rw_file_perms;
 allow inetd_t etc_t:file { getattr read ioctl };
-allow inetd_t inetd_t:process setsched;
+allow inetd_t self:process setsched;
=20
 log_domain(inetd)
 tmp_domain(inetd)
diff -urN orig/domains/program/unused/ipsec.te mod/domains/program/unused/i=
psec.te
--- orig/domains/program/unused/ipsec.te	2004-09-15 19:01:06.000000000 +0200
+++ mod/domains/program/unused/ipsec.te	2004-10-11 10:32:22.000000000 +0200
@@ -63,7 +63,7 @@
 # it in its own domain?)
 can_exec(ipsec_mgmt_t, bin_t)
 # logger, running in ipsec_mgmt_t needs to use sockets
-allow ipsec_mgmt_t ipsec_mgmt_t:unix_dgram_socket { create connect write };
+allow ipsec_mgmt_t self:unix_dgram_socket { create connect write };
 allow ipsec_mgmt_t ipsec_t:unix_dgram_socket { create connect write };
=20
 # also need to run things like whack and shell scripts
@@ -168,12 +168,12 @@
 allow ipsec_mgmt_t self:process { sigchld signal setrlimit };
=20
 # Allow read/write access to /var/run/pluto.ctl
-allow ipsec_t ipsec_t:unix_stream_socket {create setopt bind listen accept=
 read write };
+allow ipsec_t self:unix_stream_socket {create setopt bind listen accept re=
ad write };
=20
 # Pluto needs network access
 can_network(ipsec_t)
 can_ypbind(ipsec_t)
-allow ipsec_t ipsec_t:unix_dgram_socket { create connect write };
+allow ipsec_t self:unix_dgram_socket { create connect write };
=20
 # for sleep
 allow ipsec_mgmt_t fs_t:filesystem getattr;
@@ -194,7 +194,7 @@
 allow ipsec_mgmt_t var_lock_t:file create_file_perms;
=20
 # allow tncfg to create sockets
-allow ipsec_mgmt_t ipsec_mgmt_t:udp_socket { create ioctl };
+allow ipsec_mgmt_t self:udp_socket { create ioctl };
=20
 #When running ipsec auto --up <conname>
 allow ipsec_t self:process { fork sigchld };
diff -urN orig/domains/program/unused/iptables.te mod/domains/program/unuse=
d/iptables.te
--- orig/domains/program/unused/iptables.te	2004-09-28 09:34:16.000000000 +=
0200
+++ mod/domains/program/unused/iptables.te	2004-10-11 10:32:22.000000000 +0=
200
@@ -40,8 +40,8 @@
=20
 allow iptables_t bin_t:file { execute execute_no_trans };
 allow iptables_t iptables_exec_t:file { execute_no_trans };
-allow iptables_t iptables_t:capability { net_admin net_raw };
-allow iptables_t iptables_t:rawip_socket create_socket_perms;
+allow iptables_t self:capability { net_admin net_raw };
+allow iptables_t self:rawip_socket create_socket_perms;
=20
 allow iptables_t etc_t:file { getattr read };
=20
diff -urN orig/domains/program/unused/kerberos.te mod/domains/program/unuse=
d/kerberos.te
--- orig/domains/program/unused/kerberos.te	2004-10-11 10:03:21.000000000 +=
0200
+++ mod/domains/program/unused/kerberos.te	2004-10-11 10:32:22.000000000 +0=
200
@@ -75,7 +75,7 @@
=20
 #
 # Rules for Kerberos5 Kadmin daemon
-allow kadmind_t kadmind_t:unix_dgram_socket { connect create write };
+allow kadmind_t self:unix_dgram_socket { connect create write };
 allow kadmind_t krb5kdc_conf_t:dir { search };
 allow kadmind_t krb5kdc_conf_t:file r_file_perms;
 allow kadmind_t krb5kdc_principal_t:file { getattr lock read write setattr=
 };
diff -urN orig/domains/program/unused/portslave.te mod/domains/program/unus=
ed/portslave.te
--- orig/domains/program/unused/portslave.te	2004-09-11 14:31:47.000000000 =
+0200
+++ mod/domains/program/unused/portslave.te	2004-10-11 10:32:22.000000000 +=
0200
@@ -53,7 +53,7 @@
 ifdef(`sshd.te', `can_tcp_connect(portslave_t, sshd_t)')
=20
 # for pppd
-allow portslave_t portslave_t:capability { setuid setgid net_admin fsetid =
};
+allow portslave_t self:capability { setuid setgid net_admin fsetid };
 allow portslave_t ppp_device_t:chr_file rw_file_perms;
=20
 # for ~/.ppprc - if it actually exists then you need some policy to read it
diff -urN orig/domains/program/unused/postfix.te mod/domains/program/unused=
/postfix.te
--- orig/domains/program/unused/postfix.te	2004-10-11 10:03:22.000000000 +0=
200
+++ mod/domains/program/unused/postfix.te	2004-10-11 10:32:22.000000000 +02=
00
@@ -322,7 +322,7 @@
 postfix_public_domain(pipe)
 allow postfix_pipe_t postfix_spool_t:dir search;
 allow postfix_pipe_t postfix_spool_t:file rw_file_perms;
-allow postfix_pipe_t postfix_pipe_t:fifo_file { read write };
+allow postfix_pipe_t self:fifo_file { read write };
 allow postfix_pipe_t postfix_private_t:dir search;
 allow postfix_pipe_t postfix_private_t:sock_file write;
 ifdef(`procmail.te', `
diff -urN orig/domains/program/unused/pppd.te mod/domains/program/unused/pp=
pd.te
--- orig/domains/program/unused/pppd.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/domains/program/unused/pppd.te	2004-10-11 10:32:22.000000000 +0200
@@ -92,7 +92,7 @@
 can_create_pty(pppd)
 allow pppd_t self:file { read getattr };
 allow pppd_t self:capability { fowner net_raw };
-allow pppd_t pppd_t:packet_socket create_socket_perms;
+allow pppd_t self:packet_socket create_socket_perms;
=20
 file_type_auto_trans(pppd_t, etc_t, net_conf_t, file)
 tmp_domain(pppd)
diff -urN orig/domains/program/unused/qmail.te mod/domains/program/unused/q=
mail.te
--- orig/domains/program/unused/qmail.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/domains/program/unused/qmail.te	2004-10-11 10:32:22.000000000 +0200
@@ -46,7 +46,7 @@
 allow qmail_start_t qmail_etc_t:dir search;
 allow qmail_start_t qmail_etc_t:file { getattr read };
 can_exec(qmail_start_t, qmail_start_exec_t)
-allow qmail_start_t qmail_start_t:fifo_file { getattr read write };
+allow qmail_start_t self:fifo_file { getattr read write };
=20
 qmail_daemon_domain(lspawn, `, mta_delivery_agent')
 allow qmail_lspawn_t self:fifo_file { read write };
diff -urN orig/domains/program/unused/rlogind.te mod/domains/program/unused=
/rlogind.te
--- orig/domains/program/unused/rlogind.te	2004-10-11 10:03:23.000000000 +0=
200
+++ mod/domains/program/unused/rlogind.te	2004-10-11 10:32:22.000000000 +02=
00
@@ -32,7 +32,7 @@
 allow rlogind_t inetd_t:tcp_socket rw_stream_socket_perms;
=20
 # Use capabilities.
-allow rlogind_t rlogind_t:capability { net_bind_service setuid setgid fown=
er fsetid chown dac_override };
+allow rlogind_t self:capability { net_bind_service setuid setgid fowner fs=
etid chown dac_override };
=20
 # so telnetd can start a child process for the login
 allow rlogind_t self:process { fork signal_perms };
diff -urN orig/domains/program/unused/slocate.te mod/domains/program/unused=
/slocate.te
--- orig/domains/program/unused/slocate.te	2004-05-04 21:35:53.000000000 +0=
200
+++ mod/domains/program/unused/slocate.te	2004-10-11 10:32:22.000000000 +02=
00
@@ -61,7 +61,7 @@
 # Read nsswitch file
 #
 allow locate_t etc_t:file { getattr read };
-dontaudit locate_t locate_t:capability dac_override;
+dontaudit locate_t self:capability dac_override;
 allow locate_t self:capability dac_read_search;
=20
 # sysadm_t runs locate in his own domain.
diff -urN orig/domains/program/unused/squid.te mod/domains/program/unused/s=
quid.te
--- orig/domains/program/unused/squid.te	2004-09-16 15:07:09.000000000 +0200
+++ mod/domains/program/unused/squid.te	2004-10-11 10:32:22.000000000 +0200
@@ -27,7 +27,7 @@
 # type for /var/cache/squid
 type squid_cache_t, file_type, sysadmfile;
=20
-allow squid_t squid_t:capability { setgid setuid };
+allow squid_t self:capability { setgid setuid };
 allow squid_t { etc_t etc_runtime_t }:file r_file_perms;
 allow squid_t etc_t:lnk_file read;
 allow squid_t self:unix_stream_socket create_socket_perms;
diff -urN orig/domains/program/unused/udev.te mod/domains/program/unused/ud=
ev.te
--- orig/domains/program/unused/udev.te	2004-10-11 10:03:24.000000000 +0200
+++ mod/domains/program/unused/udev.te	2004-10-11 10:32:22.000000000 +0200
@@ -108,5 +108,5 @@
 allow udev_t sysctl_dev_t:dir { search };
 allow udev_t sysctl_dev_t:file { getattr read };
 allow udev_t sysctl_modprobe_t:file { getattr read };
-allow udev_t udev_t:rawip_socket create_socket_perms;
+allow udev_t self:rawip_socket create_socket_perms;
 dontaudit  udev_t domain:dir r_dir_perms;
diff -urN orig/domains/program/unused/utempter.te mod/domains/program/unuse=
d/utempter.te
--- orig/domains/program/unused/utempter.te	2004-06-19 10:31:43.000000000 +=
0200
+++ mod/domains/program/unused/utempter.te	2004-10-11 10:32:22.000000000 +0=
200
@@ -20,7 +20,7 @@
 domain_auto_trans(userdomain, utempter_exec_t, utempter_t)
=20
 # Use capabilities.
-allow utempter_t utempter_t:capability { setgid };
+allow utempter_t self:capability { setgid };
=20
 allow utempter_t etc_t:file { getattr read };
=20
diff -urN orig/domains/program/unused/vpnc.te mod/domains/program/unused/vp=
nc.te
--- orig/domains/program/unused/vpnc.te	2004-10-05 20:52:36.000000000 +0200
+++ mod/domains/program/unused/vpnc.te	2004-10-11 10:32:22.000000000 +0200
@@ -24,7 +24,7 @@
 allow vpnc_t devpts_t:dir search;
 allow vpnc_t etc_t:file { getattr read };
 allow vpnc_t tun_tap_device_t:chr_file { ioctl read write };
-allow vpnc_t vpnc_t:rawip_socket create_socket_perms;
-allow vpnc_t vpnc_t:unix_dgram_socket create_socket_perms;
-allow vpnc_t vpnc_t:unix_stream_socket create_socket_perms;
+allow vpnc_t self:rawip_socket create_socket_perms;
+allow vpnc_t self:unix_dgram_socket create_socket_perms;
+allow vpnc_t self:unix_stream_socket create_socket_perms;
 allow vpnc_t admin_tty_type:chr_file rw_file_perms;
diff -urN orig/domains/program/unused/watchdog.te mod/domains/program/unuse=
d/watchdog.te
--- orig/domains/program/unused/watchdog.te	2004-09-23 11:38:29.000000000 +=
0200
+++ mod/domains/program/unused/watchdog.te	2004-10-11 10:32:22.000000000 +0=
200
@@ -36,7 +36,7 @@
 # for orderly shutdown
 can_exec(watchdog_t, shell_exec_t)
 allow watchdog_t domain:process { signal_perms getsession };
-allow watchdog_t watchdog_t:capability { kill };
+allow watchdog_t self:capability { kill };
 allow watchdog_t sbin_t:dir search;
=20
 # for updating mtab on umount
diff -urN orig/domains/program/unused/xdm.te mod/domains/program/unused/xdm=
=2Ete
--- orig/domains/program/unused/xdm.te	2004-10-11 10:03:24.000000000 +0200
+++ mod/domains/program/unused/xdm.te	2004-10-11 10:32:22.000000000 +0200
@@ -310,8 +310,8 @@
 allow xdm_t var_log_t:file { read };
 dontaudit xdm_t krb5_conf_t:file { write };
 allow xdm_t krb5_conf_t:file { getattr read };
-allow xdm_t xdm_t:capability { sys_nice sys_rawio };
-allow xdm_t xdm_t:process { setrlimit };
+allow xdm_t self:capability { sys_nice sys_rawio };
+allow xdm_t self:process { setrlimit };
 allow xdm_t wtmp_t:file { getattr read };
=20
 domain_auto_trans(initrc_t, xserver_exec_t, xdm_xserver_t)
diff -urN orig/domains/program/unused/xfs.te mod/domains/program/unused/xfs=
=2Ete
--- orig/domains/program/unused/xfs.te	2004-09-11 14:31:47.000000000 +0200
+++ mod/domains/program/unused/xfs.te	2004-10-11 10:32:22.000000000 +0200
@@ -30,12 +30,12 @@
 can_ypbind(xfs_t)
=20
 # Use capabilities.
-allow xfs_t xfs_t:capability { setgid setuid };
+allow xfs_t self:capability { setgid setuid };
=20
 # Bind to /tmp/.font-unix/fs-1.
 allow xfs_t xfs_tmp_t:unix_stream_socket name_bind;
-allow xfs_t xfs_t:unix_stream_socket create_stream_socket_perms;
-allow xfs_t xfs_t:unix_dgram_socket create_socket_perms;
+allow xfs_t self:unix_stream_socket create_stream_socket_perms;
+allow xfs_t self:unix_dgram_socket create_socket_perms;
=20
 # Read /usr/X11R6/lib/X11/fonts/.* and /usr/share/fonts/.*
 allow xfs_t fonts_t:dir search;
diff -urN orig/domains/program/unused/ypbind.te mod/domains/program/unused/=
ypbind.te
--- orig/domains/program/unused/ypbind.te	2004-10-11 10:03:24.000000000 +02=
00
+++ mod/domains/program/unused/ypbind.te	2004-10-11 10:32:22.000000000 +0200
@@ -21,7 +21,7 @@
 can_network(ypbind_t)
 allow ypbind_t port_t:{ tcp_socket udp_socket } name_bind;
=20
-allow ypbind_t ypbind_t:fifo_file rw_file_perms;
+allow ypbind_t self:fifo_file rw_file_perms;
=20
 allow ypbind_t { sysctl_t sysctl_kernel_t }:dir search;
 allow ypbind_t sysctl_kernel_t:file { getattr read };
diff -urN orig/targeted/domains/unconfined.te mod/targeted/domains/unconfin=
ed.te
--- orig/targeted/domains/unconfined.te	2004-10-11 10:03:26.000000000 +0200
+++ mod/targeted/domains/unconfined.te	2004-10-11 10:32:22.000000000 +0200
@@ -37,4 +37,4 @@
 user_typealias(user)
=20
 allow unconfined_t unlabeled_t:filesystem *;
-allow unlabeled_t unlabeled_t:filesystem { associate };
+allow unlabeled_t self:filesystem { associate };
diff -urN orig/types/file.te mod/types/file.te
--- orig/types/file.te	2004-09-23 11:38:30.000000000 +0200
+++ mod/types/file.te	2004-10-11 10:32:22.000000000 +0200
@@ -263,31 +263,31 @@
 ')
=20
 # Allow the pty to be associated with the file system.
-allow devpts_t devpts_t:filesystem associate;
+allow devpts_t self:filesystem associate;
=20
 type tmpfs_t, file_type, sysadmfile, fs_type, root_dir_type;
 allow { tmpfs_t tmp_t } tmpfs_t:filesystem associate;
=20
 type autofs_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
-allow autofs_t autofs_t:filesystem associate;
+allow autofs_t self:filesystem associate;
=20
 type usbdevfs_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
-allow usbdevfs_t usbdevfs_t:filesystem associate;
+allow usbdevfs_t self:filesystem associate;
=20
 type sysfs_t, fs_type, root_dir_type, sysadmfile;
-allow sysfs_t sysfs_t:filesystem associate;
+allow sysfs_t self:filesystem associate;
=20
 type iso9660_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
-allow iso9660_t iso9660_t:filesystem associate;
+allow iso9660_t self:filesystem associate;
=20
 type romfs_t, fs_type, root_dir_type, sysadmfile;
-allow romfs_t romfs_t:filesystem associate;
+allow romfs_t self:filesystem associate;
=20
 type ramfs_t, fs_type, root_dir_type, sysadmfile;
-allow ramfs_t ramfs_t:filesystem associate;
+allow ramfs_t self:filesystem associate;
=20
 type dosfs_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
-allow dosfs_t dosfs_t:filesystem associate;
+allow dosfs_t self:filesystem associate;
=20
 # udev_runtime_t is the type of the udev table file
 type udev_runtime_t, file_type, sysadmfile;
@@ -296,7 +296,7 @@
 type krb5_conf_t, file_type, sysadmfile;
=20
 type cifs_t, fs_type, root_dir_type, noexattrfile, sysadmfile;
-allow cifs_t cifs_t:filesystem associate;
+allow cifs_t self:filesystem associate;
 typealias cifs_t alias sambafs_t;
=20
 # removable_t is the default type of all removable media

--5vNYLRcllDrimb99--

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBakpaxWIrrrL0q+cRAiRWAJ4svK6ZCQiDg/TD3BtMZ7djY44HagCghFTr
L9E8sBkcW5c5woIoPoOGx4k=
=vW11
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
