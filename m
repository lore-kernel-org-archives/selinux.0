Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7PGRWrT006719
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 12:27:32 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7PGRVuQ015225
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 16:27:31 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i7PGRswY013660
	for <selinux@tycho.nsa.gov>; Wed, 25 Aug 2004 12:27:54 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i7PGRsUq013659
	for selinux@tycho.nsa.gov; Wed, 25 Aug 2004 12:27:54 -0400
Message-ID: <412CAE6B.30006@redhat.com>
Date: Wed, 25 Aug 2004 11:21:15 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Latest Diffs.
Content-Type: multipart/mixed;
 boundary="------------070200060009080504040106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070200060009080504040106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

We now have named booleans working with named master updates.

Added can_ypbind to lots of te files to support NIS environments.

Dan



--------------070200060009080504040106
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/modutil.te policy-1.17.3/domains/program/modutil.te
--- nsapolicy/domains/program/modutil.te	2004-08-24 20:21:25.000000000 -0400
+++ policy-1.17.3/domains/program/modutil.te	2004-08-24 15:39:13.000000000 -0400
@@ -78,6 +78,7 @@
 unconfined_domain(insmod_t) 
 ')
 can_network(insmod_t)
+can_ypbind(insmod_t)
 in_user_role(insmod_t)
 uses_shlib(insmod_t)
 read_locale(insmod_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/syslogd.te policy-1.17.3/domains/program/syslogd.te
--- nsapolicy/domains/program/syslogd.te	2004-08-24 09:21:09.000000000 -0400
+++ policy-1.17.3/domains/program/syslogd.te	2004-08-24 15:39:33.000000000 -0400
@@ -21,6 +21,7 @@
 
 # can_network is for the UDP socket
 can_network(syslogd_t)
+can_ypbind(syslogd_t)
 
 r_dir_file(syslogd_t, sysfs_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.17.3/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2004-05-11 13:55:39.000000000 -0400
+++ policy-1.17.3/domains/program/unused/amanda.te	2004-08-24 15:23:43.000000000 -0400
@@ -172,6 +172,7 @@
 ###################################
 
 can_network(amanda_t);
+can_ypbind(amanda_t);
 
 allow amanda_t self:fifo_file { getattr read write ioctl lock };
 allow amanda_t self:unix_stream_socket { connect create read write };
@@ -248,6 +249,7 @@
 #############################################
 
 can_network(amanda_recover_t);
+can_ypbind(amanda_recover_t);
 
 allow amanda_recover_t self:fifo_file { getattr ioctl read write };
 allow amanda_recover_t self:unix_stream_socket { connect create read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amavis.te policy-1.17.3/domains/program/unused/amavis.te
--- nsapolicy/domains/program/unused/amavis.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/amavis.te	2004-08-24 15:23:57.000000000 -0400
@@ -27,6 +27,7 @@
 
 # networking
 can_network(amavisd_t)
+can_ypbind(amavisd_t);
 can_tcp_connect(mail_server_sender, amavisd_t);
 can_tcp_connect(amavisd_t, mail_server_domain)
 allow amavisd_t amavis_port_t:tcp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/asterisk.te policy-1.17.3/domains/program/unused/asterisk.te
--- nsapolicy/domains/program/unused/asterisk.te	2004-08-06 08:23:51.000000000 -0400
+++ policy-1.17.3/domains/program/unused/asterisk.te	2004-08-24 15:24:13.000000000 -0400
@@ -24,6 +24,7 @@
 allow asterisk_t var_spool_t:dir search;
 
 can_network(asterisk_t)
+can_ypbind(asterisk_t)
 allow asterisk_t etc_t:file { getattr read };
 
 allow asterisk_t self:unix_stream_socket { connectto create_stream_socket_perms };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/backup.te policy-1.17.3/domains/program/unused/backup.te
--- nsapolicy/domains/program/unused/backup.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/backup.te	2004-08-24 15:24:26.000000000 -0400
@@ -27,6 +27,7 @@
 allow backup_t urandom_device_t:chr_file read;
 
 can_network(backup_t)
+can_ypbind(backup_t)
 uses_shlib(backup_t)
 
 allow backup_t devtty_t:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/bluetooth.te policy-1.17.3/domains/program/unused/bluetooth.te
--- nsapolicy/domains/program/unused/bluetooth.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/bluetooth.te	2004-08-24 15:24:39.000000000 -0400
@@ -21,6 +21,7 @@
 
 # Use the network.
 can_network(bluetooth_t)
+can_ypbind(bluetooth_t)
 allow bluetooth_t self:socket { create setopt ioctl bind listen };
 allow bluetooth_t self:unix_dgram_socket create_socket_perms;
 allow bluetooth_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/calamaris.te policy-1.17.3/domains/program/unused/calamaris.te
--- nsapolicy/domains/program/unused/calamaris.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/calamaris.te	2004-08-24 15:24:54.000000000 -0400
@@ -60,6 +60,7 @@
 dontaudit calamaris_t etc_t:file ioctl;
 dontaudit calamaris_t sysadm_home_dir_t:dir { getattr search };
 can_network(calamaris_t)
+can_ypbind(calamaris_t)
 ifdef(`named.te', `
 can_udp_send(calamaris_t, named_t)
 can_udp_send(named_t, calamaris_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ciped.te policy-1.17.3/domains/program/unused/ciped.te
--- nsapolicy/domains/program/unused/ciped.te	2004-02-02 10:17:22.000000000 -0500
+++ policy-1.17.3/domains/program/unused/ciped.te	2004-08-24 15:25:13.000000000 -0400
@@ -8,6 +8,7 @@
 type cipe_port_t, port_type;
 
 can_network(ciped_t)
+can_ypbind(ciped_t)
 allow ciped_t cipe_port_t:udp_socket name_bind;
 
 allow ciped_t devpts_t:dir { search };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/clamav.te policy-1.17.3/domains/program/unused/clamav.te
--- nsapolicy/domains/program/unused/clamav.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/clamav.te	2004-08-24 15:25:24.000000000 -0400
@@ -23,6 +23,7 @@
 allow freshclam_t sysctl_kernel_t:file { getattr read };
 
 can_network(freshclam_t)
+can_ypbind(freshclam_t)
 
 # Access virus signatures
 allow freshclam_t { var_t var_lib_t }:dir search;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/courier.te policy-1.17.3/domains/program/unused/courier.te
--- nsapolicy/domains/program/unused/courier.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/courier.te	2004-08-24 15:25:38.000000000 -0400
@@ -47,6 +47,7 @@
 
 # Use the network.
 can_network(courier_$1_t)
+can_ypbind(courier_$1_t)
 allow courier_$1_t self:fifo_file { read write getattr };
 allow courier_$1_t self:unix_stream_socket create_stream_socket_perms;
 allow courier_$1_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ddt-client.te policy-1.17.3/domains/program/unused/ddt-client.te
--- nsapolicy/domains/program/unused/ddt-client.te	2004-06-16 13:37:32.000000000 -0400
+++ policy-1.17.3/domains/program/unused/ddt-client.te	2004-08-24 15:25:57.000000000 -0400
@@ -24,6 +24,7 @@
 
 # Use the network.
 can_network(ddt_client_t)
+can_ypbind(ddt_client_t)
 allow ddt_client_t self:unix_stream_socket create_socket_perms;
 allow ddt_client_t self:unix_dgram_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/devfsd.te policy-1.17.3/domains/program/unused/devfsd.te
--- nsapolicy/domains/program/unused/devfsd.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/devfsd.te	2004-08-24 15:26:10.000000000 -0400
@@ -90,4 +90,5 @@
 
 # for nss-ldap etc
 can_network(devfsd_t)
+can_ypbind(devfsd_t)
 allow devfsd_t self:tcp_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpc.te policy-1.17.3/domains/program/unused/dhcpc.te
--- nsapolicy/domains/program/unused/dhcpc.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/dhcpc.te	2004-08-24 14:40:38.000000000 -0400
@@ -23,6 +23,7 @@
 allow dhcpc_t urandom_device_t:chr_file read;
 
 can_network(dhcpc_t)
+can_ypbind(dhcpc_t)
 allow dhcpc_t self:unix_dgram_socket create_socket_perms;
 allow dhcpc_t self:unix_stream_socket create_socket_perms;
 allow dhcpc_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dhcpd.te policy-1.17.3/domains/program/unused/dhcpd.te
--- nsapolicy/domains/program/unused/dhcpd.te	2004-07-08 09:50:26.000000000 -0400
+++ policy-1.17.3/domains/program/unused/dhcpd.te	2004-08-25 11:07:37.147621196 -0400
@@ -30,6 +30,7 @@
 
 # Use the network.
 can_network(dhcpd_t)
+can_ypbind(dhcpd_t)
 allow dhcpd_t self:unix_dgram_socket create_socket_perms;
 allow dhcpd_t self:unix_stream_socket create_socket_perms;
 
@@ -64,3 +65,4 @@
 
 # allow reading /proc
 allow dhcpd_t proc_t:{ file lnk_file } r_file_perms;
+tmp_domain(dhcpd)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dictd.te policy-1.17.3/domains/program/unused/dictd.te
--- nsapolicy/domains/program/unused/dictd.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.17.3/domains/program/unused/dictd.te	2004-08-24 15:26:27.000000000 -0400
@@ -43,6 +43,7 @@
 allow dictd_t self:unix_stream_socket create_stream_socket_perms;
 
 can_network(dictd_t)
+can_ypbind(dictd_t)
 can_tcp_connect(userdomain, dictd_t)
 
 allow dictd_t fs_t:filesystem getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/distcc.te policy-1.17.3/domains/program/unused/distcc.te
--- nsapolicy/domains/program/unused/distcc.te	2004-07-28 16:04:18.000000000 -0400
+++ policy-1.17.3/domains/program/unused/distcc.te	2004-08-24 15:26:40.000000000 -0400
@@ -5,6 +5,7 @@
 
 daemon_domain(distccd)
 can_network(distccd_t)
+can_ypbind(distccd_t)
 log_domain(distccd)
 tmp_domain(distccd)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dnsmasq.te policy-1.17.3/domains/program/unused/dnsmasq.te
--- nsapolicy/domains/program/unused/dnsmasq.te	2004-07-07 16:46:41.000000000 -0400
+++ policy-1.17.3/domains/program/unused/dnsmasq.te	2004-08-24 15:26:54.000000000 -0400
@@ -17,6 +17,7 @@
 
 # network-related goodies
 can_network(dnsmasq_t)
+can_ypbind(dnsmasq_t)
 allow dnsmasq_t self:packet_socket create_socket_perms;
 allow dnsmasq_t self:unix_dgram_socket create_socket_perms;
 allow dnsmasq_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.17.3/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2004-06-25 06:22:39.000000000 -0400
+++ policy-1.17.3/domains/program/unused/dovecot.te	2004-08-24 15:27:10.000000000 -0400
@@ -14,6 +14,7 @@
 allow dovecot_t self:capability { chown net_bind_service setgid setuid sys_chroot dac_override dac_read_search };
 allow dovecot_t self:process { setrlimit };
 can_network(dovecot_t)
+can_ypbind(dovecot_t)
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket create_stream_socket_perms;
 can_unix_connect(dovecot_t, self)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dpkg.te policy-1.17.3/domains/program/unused/dpkg.te
--- nsapolicy/domains/program/unused/dpkg.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/dpkg.te	2004-08-24 15:27:37.000000000 -0400
@@ -327,6 +327,7 @@
 allow apt_t self:process { signal sigchld fork };
 allow apt_t sysadm_t:process sigchld;
 can_network({ apt_t dpkg_t })
+can_ypbind({ apt_t dpkg_t })
 
 allow { apt_t dpkg_t } var_t:dir { search getattr };
 dontaudit apt_t { fs_type file_type }:dir getattr;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/fingerd.te policy-1.17.3/domains/program/unused/fingerd.te
--- nsapolicy/domains/program/unused/fingerd.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/fingerd.te	2004-08-24 15:27:49.000000000 -0400
@@ -48,6 +48,7 @@
 
 # Use the network.
 can_network(fingerd_t)
+can_ypbind(fingerd_t)
 
 allow fingerd_t self:unix_dgram_socket create_socket_perms;
 allow fingerd_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/gatekeeper.te policy-1.17.3/domains/program/unused/gatekeeper.te
--- nsapolicy/domains/program/unused/gatekeeper.te	2004-06-16 13:37:32.000000000 -0400
+++ policy-1.17.3/domains/program/unused/gatekeeper.te	2004-08-24 15:28:06.000000000 -0400
@@ -24,6 +24,7 @@
 
 # Use the network.
 can_network(gatekeeper_t)
+can_ypbind(gatekeeper_t)
 allow gatekeeper_t gatekeeper_port_t:{ udp_socket tcp_socket } name_bind;
 allow gatekeeper_t self:unix_stream_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hald.te policy-1.17.3/domains/program/unused/hald.te
--- nsapolicy/domains/program/unused/hald.te	2004-08-24 20:21:28.000000000 -0400
+++ policy-1.17.3/domains/program/unused/hald.te	2004-08-24 15:28:18.000000000 -0400
@@ -27,6 +27,7 @@
 allow hald_t self:netlink_route_socket r_netlink_socket_perms;
 allow hald_t self:capability { net_admin sys_admin };
 can_network(hald_t)
+can_ypbind(hald_t)
 
 ifdef(`updfstab.te', `domain_auto_trans(hald_t, updfstab_exec_t, updfstab_t)')
 ifdef(`udev.te', `domain_auto_trans(hald_t, udev_exec_t, udev_t)')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/hotplug.te policy-1.17.3/domains/program/unused/hotplug.te
--- nsapolicy/domains/program/unused/hotplug.te	2004-08-24 20:21:28.000000000 -0400
+++ policy-1.17.3/domains/program/unused/hotplug.te	2004-08-24 15:28:30.000000000 -0400
@@ -136,6 +136,7 @@
 file_type_auto_trans(hotplug_t, etc_t, etc_runtime_t, file)
 
 can_network(hotplug_t)
+can_ypbind(hotplug_t)
 
 # Allow hotplug (including /sbin/ifup-local) to start/stop services and # run sendmail -q
 domain_auto_trans(hotplug_t, initrc_exec_t, initrc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/howl.te policy-1.17.3/domains/program/unused/howl.te
--- nsapolicy/domains/program/unused/howl.te	2004-08-06 08:23:51.000000000 -0400
+++ policy-1.17.3/domains/program/unused/howl.te	2004-08-24 15:28:44.000000000 -0400
@@ -1,6 +1,7 @@
 daemon_domain(howl)
 allow howl_t proc_t:file { getattr read };
 can_network(howl_t)
+can_ypbind(howl_t)
 allow howl_t self:capability net_admin;
 
 allow howl_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/i18n_input.te policy-1.17.3/domains/program/unused/i18n_input.te
--- nsapolicy/domains/program/unused/i18n_input.te	2004-06-16 13:38:16.000000000 -0400
+++ policy-1.17.3/domains/program/unused/i18n_input.te	2004-08-24 15:28:55.000000000 -0400
@@ -10,6 +10,7 @@
 
 can_exec(i18n_input_t, i18n_input_exec_t)
 can_network(i18n_input_t)
+can_ypbind(i18n_input_t)
 
 ## No Unix Socket Connection at the moment
 ##
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/innd.te policy-1.17.3/domains/program/unused/innd.te
--- nsapolicy/domains/program/unused/innd.te	2004-06-16 13:37:32.000000000 -0400
+++ policy-1.17.3/domains/program/unused/innd.te	2004-08-24 15:29:20.000000000 -0400
@@ -29,6 +29,7 @@
 allow innd_t var_spool_t:dir { getattr search };
 
 can_network(innd_t)
+can_ypbind(innd_t)
 
 can_unix_send( { innd_t sysadm_t }, { innd_t sysadm_t } )
 allow innd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ipsec.te policy-1.17.3/domains/program/unused/ipsec.te
--- nsapolicy/domains/program/unused/ipsec.te	2004-06-16 13:37:32.000000000 -0400
+++ policy-1.17.3/domains/program/unused/ipsec.te	2004-08-24 15:29:32.000000000 -0400
@@ -169,6 +169,7 @@
 
 # Pluto needs network access
 can_network(ipsec_t)
+can_ypbind(ipsec_t)
 allow ipsec_t ipsec_t:unix_dgram_socket { create connect write };
 
 # for sleep
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ircd.te policy-1.17.3/domains/program/unused/ircd.te
--- nsapolicy/domains/program/unused/ircd.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.17.3/domains/program/unused/ircd.te	2004-08-24 15:29:46.000000000 -0400
@@ -24,6 +24,7 @@
 
 # Use the network.
 can_network(ircd_t)
+can_ypbind(ircd_t)
 #allow ircd_t self:fifo_file { read write };
 allow ircd_t self:unix_stream_socket create_socket_perms;
 allow ircd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/jabberd.te policy-1.17.3/domains/program/unused/jabberd.te
--- nsapolicy/domains/program/unused/jabberd.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.17.3/domains/program/unused/jabberd.te	2004-08-24 15:29:58.000000000 -0400
@@ -20,6 +20,7 @@
 allow jabberd_t random_device_t:file r_file_perms;
 
 can_network(jabberd_t)
+can_ypbind(jabberd_t)
 
 allow jabberd_t self:unix_dgram_socket create_socket_perms;
 allow jabberd_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/kerberos.te policy-1.17.3/domains/program/unused/kerberos.te
--- nsapolicy/domains/program/unused/kerberos.te	2004-06-24 08:50:07.000000000 -0400
+++ policy-1.17.3/domains/program/unused/kerberos.te	2004-08-24 15:30:30.000000000 -0400
@@ -38,8 +38,8 @@
 allow kadmind_t self:capability { setuid setgid net_bind_service chown fowner dac_override sys_nice };
 
 # krb5kdc and kadmind can use network
-can_network(krb5kdc_t)
-can_network(kadmind_t)
+can_network( { krb5kdc_t kadmind_t } )
+can_ypbind( { krb5kdc_t kadmind_t } )
 
 # allow UDP transfer to/from any program
 can_udp_send(kerberos_port_t, krb5kdc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lpd.te policy-1.17.3/domains/program/unused/lpd.te
--- nsapolicy/domains/program/unused/lpd.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/lpd.te	2004-08-24 15:30:51.000000000 -0400
@@ -37,6 +37,7 @@
 role system_r types checkpc_t;
 uses_shlib(checkpc_t)
 can_network(checkpc_t)
+can_ypbind(checkpc_t)
 log_domain(checkpc)
 type checkpc_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(initrc_t, checkpc_exec_t, checkpc_t)
@@ -103,6 +104,7 @@
 
 # Use the network.
 can_network(lpd_t)
+can_ypbind(lpd_t)
 allow lpd_t self:fifo_file rw_file_perms;
 allow lpd_t self:unix_stream_socket create_stream_socket_perms;
 allow lpd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/lrrd.te policy-1.17.3/domains/program/unused/lrrd.te
--- nsapolicy/domains/program/unused/lrrd.te	2004-03-17 13:26:05.000000000 -0500
+++ policy-1.17.3/domains/program/unused/lrrd.te	2004-08-24 15:31:02.000000000 -0400
@@ -59,6 +59,7 @@
 can_unix_connect(lrrd_t, lrrd_t)
 can_unix_send(lrrd_t, lrrd_t)
 can_network(lrrd_t)
+can_ypbind(lrrd_t)
 
 ifdef(`logrotate.te', `
 r_dir_file(logrotate_t, lrrd_etc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mailman.te policy-1.17.3/domains/program/unused/mailman.te
--- nsapolicy/domains/program/unused/mailman.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/mailman.te	2004-08-24 15:31:17.000000000 -0400
@@ -29,6 +29,7 @@
 allow mailman_$1_t mailman_lock_t:dir rw_dir_perms;
 allow mailman_$1_t fs_t:filesystem getattr;
 can_network(mailman_$1_t)
+can_ypbind(mailman_$1_t)
 allow mailman_$1_t self:unix_stream_socket create_socket_perms;
 allow mailman_$1_t var_t:dir r_dir_perms;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/monopd.te policy-1.17.3/domains/program/unused/monopd.te
--- nsapolicy/domains/program/unused/monopd.te	2004-03-23 15:58:08.000000000 -0500
+++ policy-1.17.3/domains/program/unused/monopd.te	2004-08-24 15:31:33.000000000 -0400
@@ -16,6 +16,7 @@
 
 # Use the network.
 can_network(monopd_t)
+can_ypbind(monopd_t)
 
 type monopd_port_t, port_type;
 allow monopd_t monopd_port_t:tcp_socket name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mrtg.te policy-1.17.3/domains/program/unused/mrtg.te
--- nsapolicy/domains/program/unused/mrtg.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/mrtg.te	2004-08-24 15:31:46.000000000 -0400
@@ -32,6 +32,7 @@
 
 # Use the network.
 can_network(mrtg_t)
+can_ypbind(mrtg_t)
 
 allow mrtg_t self:fifo_file { getattr read write ioctl };
 allow mrtg_t { admin_tty_type devtty_t }:chr_file rw_file_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/mysqld.te policy-1.17.3/domains/program/unused/mysqld.te
--- nsapolicy/domains/program/unused/mysqld.te	2004-08-22 20:55:01.000000000 -0400
+++ policy-1.17.3/domains/program/unused/mysqld.te	2004-08-24 15:31:59.000000000 -0400
@@ -44,6 +44,7 @@
 allow mysqld_t var_lib_t:dir { getattr search };
 
 can_network(mysqld_t)
+can_ypbind(mysqld_t)
 
 # read config files
 r_dir_file(initrc_t, mysqld_etc_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nagios.te policy-1.17.3/domains/program/unused/nagios.te
--- nsapolicy/domains/program/unused/nagios.te	2004-06-16 13:38:16.000000000 -0400
+++ policy-1.17.3/domains/program/unused/nagios.te	2004-08-24 15:32:14.000000000 -0400
@@ -42,6 +42,7 @@
 allow nagios_t proc_t:file { getattr read };
 
 can_network(nagios_t)
+can_ypbind(nagios_t)
 
 # read config files
 allow nagios_t { etc_t etc_runtime_t }:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/named.te policy-1.17.3/domains/program/unused/named.te
--- nsapolicy/domains/program/unused/named.te	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/domains/program/unused/named.te	2004-08-25 11:05:14.054851490 -0400
@@ -32,10 +32,10 @@
 type named_conf_t, file_type, sysadmfile;
 typealias named_conf_t alias rndc_conf_t;
 
-# for zone files
+# for primary zone files
 type named_zone_t, file_type, sysadmfile;
 
-# named.ca files
+# for secondary zone files
 type named_cache_t, file_type, sysadmfile;
 
 # Use capabilities. Surplus capabilities may be allowed.
@@ -68,7 +68,8 @@
 #read zone files
 r_dir_file(named_t, named_zone_t)
 
-r_dir_file(named_t, named_cache_t)
+#write cache for secondary zones
+rw_dir_create_file(named_t, named_cache_t)
 
 allow named_t self:unix_stream_socket create_stream_socket_perms;
 allow named_t self:unix_dgram_socket create_socket_perms;
@@ -100,7 +101,14 @@
 can_ypbind(ndc_t)
 read_locale(ndc_t)
 can_tcp_connect(ndc_t, named_t)
-allow { named_t ndc_t initrc_t } rndc_conf_t:file { getattr read };
+dontaudit ndc_t unlabeled_t:file read;
+allow ndc_t var_t:dir search;
+
+# for /etc/rndc.key
+ifdef(`distro_redhat', `
+allow { ndc_t initrc_t } named_conf_t:dir search;
+')
+allow { ndc_t initrc_t } named_conf_t:file { getattr read };
 
 allow ndc_t etc_t:dir r_dir_perms;
 allow ndc_t etc_t:file r_file_perms;
@@ -138,8 +146,6 @@
 allow ndc_t named_var_run_t:file getattr;
 allow ndc_t named_zone_t:dir { read getattr };
 allow ndc_t named_zone_t:file getattr;
-create_dir_file(ndc_t, named_zone_t)
 dontaudit ndc_t sysadm_home_t:dir { getattr search read };
 ')
 allow ndc_t self:netlink_route_socket { bind create getattr nlmsg_read read write };
-dontaudit named_t devpts_t:chr_file { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nessusd.te policy-1.17.3/domains/program/unused/nessusd.te
--- nsapolicy/domains/program/unused/nessusd.te	2004-06-16 13:37:32.000000000 -0400
+++ policy-1.17.3/domains/program/unused/nessusd.te	2004-08-24 15:32:29.000000000 -0400
@@ -23,6 +23,7 @@
 
 # Use the network.
 can_network(nessusd_t)
+can_ypbind(nessusd_t)
 allow nessusd_t self:unix_stream_socket create_socket_perms;
 #allow nessusd_t self:unix_dgram_socket create_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nsd.te policy-1.17.3/domains/program/unused/nsd.te
--- nsapolicy/domains/program/unused/nsd.te	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/domains/program/unused/nsd.te	2004-08-24 15:32:51.000000000 -0400
@@ -20,6 +20,7 @@
 role system_r types nsd_crond_t;
 uses_shlib(nsd_crond_t)
 can_network(nsd_crond_t)
+can_ypbind(nsd_crond_t)
 allow nsd_crond_t self:unix_dgram_socket create_socket_perms;
 allow nsd_crond_t self:process { fork signal_perms };
 system_crond_entry(nsd_exec_t, nsd_crond_t)
@@ -78,6 +79,7 @@
 
 # nsd can use network
 can_network(nsd_t)
+can_ypbind(nsd_t)
 # allow client access from caching BIND
 ifdef(`named.te', `
 can_udp_send(named_t, nsd_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.17.3/domains/program/unused/portmap.te
--- nsapolicy/domains/program/unused/portmap.te	2004-08-06 09:52:51.000000000 -0400
+++ policy-1.17.3/domains/program/unused/portmap.te	2004-08-24 15:33:22.000000000 -0400
@@ -14,6 +14,7 @@
 daemon_domain(portmap)
 
 can_network(portmap_t)
+can_ypbind(portmap_t)
 allow portmap_t self:unix_dgram_socket create_socket_perms;
 allow portmap_t self:unix_stream_socket create_stream_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postfix.te policy-1.17.3/domains/program/unused/postfix.te
--- nsapolicy/domains/program/unused/postfix.te	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/domains/program/unused/postfix.te	2004-08-24 15:33:43.000000000 -0400
@@ -111,6 +111,7 @@
 allow postfix_master_t postfix_private_t:sock_file create_file_perms;
 allow postfix_master_t postfix_private_t:fifo_file create_file_perms;
 can_network(postfix_master_t)
+can_ypbind(postfix_master_t)
 allow postfix_master_t smtp_port_t:tcp_socket name_bind;
 allow postfix_master_t postfix_spool_maildrop_t:dir rw_dir_perms;
 allow postfix_master_t postfix_spool_maildrop_t:file { unlink rename getattr };
@@ -149,6 +150,7 @@
 allow postfix_$1_t postfix_master_t:unix_stream_socket { connectto rw_stream_socket_perms };
 allow postfix_$1_t self:capability { setuid setgid dac_override };
 can_network(postfix_$1_t)
+can_ypbind(postfix_$1_t)
 ')
 
 postfix_server_domain(smtp, `, mail_server_sender')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/postgrey.te policy-1.17.3/domains/program/unused/postgrey.te
--- nsapolicy/domains/program/unused/postgrey.te	2004-08-06 08:23:51.000000000 -0400
+++ policy-1.17.3/domains/program/unused/postgrey.te	2004-08-24 15:33:58.000000000 -0400
@@ -18,6 +18,7 @@
 etcdir_domain(postgrey)
 
 can_network(postgrey_t)
+can_ypbind(postgrey_t)
 allow postgrey_t postgrey_port_t:tcp_socket name_bind;
 allow postgrey_t self:unix_stream_socket create_stream_socket_perms;
 allow postgrey_t proc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/pppd.te policy-1.17.3/domains/program/unused/pppd.te
--- nsapolicy/domains/program/unused/pppd.te	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/domains/program/unused/pppd.te	2004-08-24 15:34:10.000000000 -0400
@@ -31,6 +31,7 @@
 
 # Use the network.
 can_network(pppd_t)
+can_ypbind(pppd_t)
 
 # Use capabilities.
 allow pppd_t self:capability { net_admin setuid setgid fsetid };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/qmail.te policy-1.17.3/domains/program/unused/qmail.te
--- nsapolicy/domains/program/unused/qmail.te	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/domains/program/unused/qmail.te	2004-08-24 15:35:03.000000000 -0400
@@ -85,6 +85,7 @@
 qmaild_sub_domain(qmail_rspawn_t, qmail_remote)
 allow qmail_rspawn_t qmail_remote_exec_t:file read;
 can_network(qmail_remote_t)
+can_ypbind(qmail_remote_t)
 allow qmail_remote_t qmail_spool_t:dir search;
 allow qmail_remote_t qmail_spool_t:file rw_file_perms;
 allow qmail_remote_t self:tcp_socket create_socket_perms;
@@ -125,10 +126,12 @@
 allow qmail_tcp_env_t inetd_t:process sigchld;
 allow qmail_tcp_env_t sbin_t:dir search;
 can_network(qmail_tcp_env_t)
+can_ypbind(qmail_tcp_env_t)
 
 qmaild_sub_domain(qmail_tcp_env_t, qmail_smtpd)
 allow qmail_tcp_env_t qmail_smtpd_exec_t:file read;
 can_network(qmail_smtpd_t)
+can_ypbind(qmail_smtpd_t)
 allow qmail_smtpd_t inetd_t:fd use;
 allow qmail_smtpd_t inetd_t:tcp_socket { read write };
 allow qmail_smtpd_t inetd_t:process sigchld;
@@ -175,6 +178,7 @@
 qmaild_sub_domain(user_crond_t, qmail_serialmail)
 in_user_role(qmail_serialmail_t)
 can_network(qmail_serialmail_t)
+can_ypbind(qmail_serialmail_t)
 can_exec(qmail_serialmail_t, qmail_serialmail_exec_t)
 allow qmail_serialmail_t self:process { fork signal_perms };
 allow qmail_serialmail_t proc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/radius.te policy-1.17.3/domains/program/unused/radius.te
--- nsapolicy/domains/program/unused/radius.te	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/domains/program/unused/radius.te	2004-08-24 15:35:16.000000000 -0400
@@ -51,6 +51,7 @@
 allow radiusd_t self:capability { chown dac_override fsetid kill setgid setuid sys_resource sys_tty_config };
 
 can_network(radiusd_t)
+can_ypbind(radiusd_t)
 allow radiusd_t { radius_port_t radacct_port_t }:udp_socket name_bind;
 
 # for RADIUS proxy port
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rhgb.te policy-1.17.3/domains/program/unused/rhgb.te
--- nsapolicy/domains/program/unused/rhgb.te	2004-08-18 07:50:46.000000000 -0400
+++ policy-1.17.3/domains/program/unused/rhgb.te	2004-08-24 15:35:28.000000000 -0400
@@ -39,6 +39,7 @@
 dontaudit rhgb_t var_run_t:dir { search };
 
 can_network(rhgb_t)
+can_ypbind(rhgb_t)
 
 # for fonts
 allow rhgb_t usr_t:{ file lnk_file } { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rpm.te policy-1.17.3/domains/program/unused/rpm.te
--- nsapolicy/domains/program/unused/rpm.te	2004-08-24 20:21:30.000000000 -0400
+++ policy-1.17.3/domains/program/unused/rpm.te	2004-08-24 15:35:49.000000000 -0400
@@ -33,6 +33,7 @@
 log_domain(rpm)
 
 can_network(rpm_t)
+can_ypbind(rpm_t)
 
 # Allow the rpm domain to execute other programs
 can_exec_any(rpm_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/rshd.te policy-1.17.3/domains/program/unused/rshd.te
--- nsapolicy/domains/program/unused/rshd.te	2003-10-02 09:40:03.000000000 -0400
+++ policy-1.17.3/domains/program/unused/rshd.te	2004-08-24 15:36:06.000000000 -0400
@@ -24,4 +24,5 @@
 
 # Use the network.
 can_network(rshd_t)
+can_ypbind(rshd_t)
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/slapd.te policy-1.17.3/domains/program/unused/slapd.te
--- nsapolicy/domains/program/unused/slapd.te	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/domains/program/unused/slapd.te	2004-08-24 15:36:23.000000000 -0400
@@ -24,6 +24,7 @@
 
 # Use the network.
 can_network(slapd_t)
+can_ypbind(slapd_t)
 allow slapd_t self:fifo_file { read write };
 allow slapd_t self:unix_stream_socket create_socket_perms;
 allow slapd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/snmpd.te policy-1.17.3/domains/program/unused/snmpd.te
--- nsapolicy/domains/program/unused/snmpd.te	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/domains/program/unused/snmpd.te	2004-08-24 15:36:35.000000000 -0400
@@ -14,6 +14,7 @@
 allow snmpd_t var_t:dir getattr;
 
 can_network(snmpd_t)
+can_ypbind(snmpd_t)
 
 type snmp_port_t, port_type;
 allow snmpd_t snmp_port_t:{ udp_socket tcp_socket } name_bind;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/tcpd.te policy-1.17.3/domains/program/unused/tcpd.te
--- nsapolicy/domains/program/unused/tcpd.te	2004-07-27 09:27:33.000000000 -0400
+++ policy-1.17.3/domains/program/unused/tcpd.te	2004-08-24 15:36:55.000000000 -0400
@@ -22,6 +22,7 @@
 dontaudit tcpd_t var_t:dir search;
 
 can_network(tcpd_t)
+can_ypbind(tcpd_t)
 allow tcpd_t self:unix_dgram_socket create_socket_perms;
 allow tcpd_t self:unix_stream_socket create_socket_perms;
 allow tcpd_t etc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/traceroute.te policy-1.17.3/domains/program/unused/traceroute.te
--- nsapolicy/domains/program/unused/traceroute.te	2004-07-27 09:27:33.000000000 -0400
+++ policy-1.17.3/domains/program/unused/traceroute.te	2004-08-24 15:37:08.000000000 -0400
@@ -19,6 +19,7 @@
 in_user_role(traceroute_t)
 uses_shlib(traceroute_t)
 can_network(traceroute_t)
+can_ypbind(traceroute_t)
 allow traceroute_t node_t:rawip_socket node_bind;
 type traceroute_exec_t, file_type, sysadmfile, exec_type;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/udev.te policy-1.17.3/domains/program/unused/udev.te
--- nsapolicy/domains/program/unused/udev.te	2004-08-18 07:50:46.000000000 -0400
+++ policy-1.17.3/domains/program/unused/udev.te	2004-08-24 11:31:34.000000000 -0400
@@ -37,6 +37,8 @@
 allow udev_t { sbin_t bin_t }:lnk_file read;
 can_exec(udev_t, { shell_exec_t bin_t sbin_t } )
 can_exec(udev_t, udev_exec_t)
+can_exec(udev_t, hostname_exec_t)
+can_exec(udev_t, iptables_exec_t)
 r_dir_file(udev_t, sysfs_t)
 allow udev_t sysadm_tty_device_t:chr_file { read write };
 allow udev_t { device_t device_type }:{chr_file blk_file} { relabelfrom relabelto create_file_perms };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/watchdog.te policy-1.17.3/domains/program/unused/watchdog.te
--- nsapolicy/domains/program/unused/watchdog.te	2004-06-16 13:37:32.000000000 -0400
+++ policy-1.17.3/domains/program/unused/watchdog.te	2004-08-24 15:37:32.000000000 -0400
@@ -24,6 +24,7 @@
 allow watchdog_t self:fifo_file rw_file_perms;
 allow watchdog_t self:unix_stream_socket create_socket_perms;
 can_network(watchdog_t)
+can_ypbind(watchdog_t)
 allow watchdog_t self:udp_socket create_socket_perms;
 allow watchdog_t bin_t:dir search;
 allow watchdog_t bin_t:lnk_file read;
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/xprint.te policy-1.17.3/domains/program/unused/xprint.te
--- nsapolicy/domains/program/unused/xprint.te	2004-06-16 13:37:32.000000000 -0400
+++ policy-1.17.3/domains/program/unused/xprint.te	2004-08-24 15:37:55.000000000 -0400
@@ -30,6 +30,7 @@
 
 # Use the network.
 can_network(xprint_t)
+can_ypbind(xprint_t)
 allow xprint_t self:fifo_file rw_file_perms;
 allow xprint_t self:unix_stream_socket create_stream_socket_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/zebra.te policy-1.17.3/domains/program/unused/zebra.te
--- nsapolicy/domains/program/unused/zebra.te	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/domains/program/unused/zebra.te	2004-08-24 15:37:46.000000000 -0400
@@ -10,6 +10,7 @@
 r_dir_file({ initrc_t zebra_t }, zebra_conf_t)
 
 can_network(zebra_t)
+can_ypbind(zebra_t)
 allow zebra_t { etc_t etc_runtime_t }:file { getattr read };
 
 allow zebra_t self:process setcap;
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/named.fc policy-1.17.3/file_contexts/program/named.fc
--- nsapolicy/file_contexts/program/named.fc	2004-08-17 07:46:24.000000000 -0400
+++ policy-1.17.3/file_contexts/program/named.fc	2004-08-25 11:12:35.118746147 -0400
@@ -1,28 +1,34 @@
 # named
-/var/named(/.*)?      		system_u:object_r:named_zone_t
-/var/named/named.ca     --	system_u:object_r:named_cache_t
+/var/named(/.*)?		system_u:object_r:named_zone_t
+/var/named/slaves(/.*)?		system_u:object_r:named_cache_t
+/var/named/data(/.*)?		system_u:object_r:named_cache_t
 /etc/named\.conf	--	system_u:object_r:named_conf_t
-/etc/named\.custom	--	system_u:object_r:named_conf_t
-/etc/rndc.*		--	system_u:object_r:rndc_conf_t
+
+ifdef(`distro_debian', `
+/etc/bind(/.*)?			system_u:object_r:named_zone_t
+/etc/bind/named\.conf	--	system_u:object_r:named_conf_t
+/etc/bind/rndc\.key	--	system_u:object_r:named_conf_t
+/var/cache/bind(/.*)?		system_u:object_r:named_cache_t
+') dnl distro_debian
+
+/etc/rndc.*		--	system_u:object_r:named_conf_t
 /usr/sbin/named.*      	--	system_u:object_r:named_exec_t
 /usr/sbin/r?ndc		--	system_u:object_r:ndc_exec_t
 /var/run/ndc		-s	system_u:object_r:named_var_run_t
+/var/run/bind(/.*)?		system_u:object_r:named_var_run_t
 /var/run/named.*		system_u:object_r:named_var_run_t
 /usr/sbin/lwresd	--	system_u:object_r:named_exec_t
-/var/named/chroot	-d    	system_u:object_r:root_t
-/var/named/chroot/dev(/.*)?    	system_u:object_r:device_t
+ifdef(`distro_redhat', `
+/var/named/named\.ca	--	system_u:object_r:named_conf_t
+/var/named/chroot(/.*)?		system_u:object_r:named_conf_t
 /var/named/chroot/dev/null   -c	system_u:object_r:null_device_t
-/var/named/chroot/dev/zero   -c	system_u:object_r:zero_device_t
 /var/named/chroot/dev/random -c	system_u:object_r:random_device_t
-/var/named/chroot/etc(/.*)?    	system_u:object_r:etc_t
 /var/named/chroot/etc/named\.conf -- system_u:object_r:named_conf_t
-/var/named/chroot/etc/named\.custom -- system_u:object_r:named_conf_t
-/var/named/chroot/etc/rndc.* -- system_u:object_r:rndc_conf_t
-/var/named/chroot/var(/.*)?	system_u:object_r:var_t
-/var/named/chroot/var/named(/.*)?   		system_u:object_r:named_zone_t
-/var/named/chroot/var/named/named.ca    system_u:object_r:named_cache_t
-/var/named/chroot/var/run(/.*)?	system_u:object_r:var_run_t
+/var/named/chroot/etc/rndc.* -- system_u:object_r:named_conf_t
 /var/named/chroot/var/run/named.* system_u:object_r:named_var_run_t
-/var/named/chroot/var/tmp	-d system_u:object_r:tmp_t
-
-
+/var/named/chroot/var/tmp(/.*)? system_u:object_r:named_cache_t
+/var/named/chroot/var/named(/.*)?	system_u:object_r:named_zone_t
+/var/named/chroot/var/named/slaves(/.*)? system_u:object_r:named_cache_t
+/var/named/chroot/var/named/data(/.*)? system_u:object_r:named_cache_t
+/var/named/chroot/var/named/named\.ca	--	system_u:object_r:named_conf_t
+') dnl distro_redhat
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.17.3/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2004-08-23 14:05:46.000000000 -0400
+++ policy-1.17.3/macros/global_macros.te	2004-08-25 11:07:23.120212255 -0400
@@ -292,7 +292,11 @@
 ifdef(`automount.te', `
 allow $1_t autofs_t:dir { search getattr };
 ')dnl end if automount.te
-
+ifdef(`targeted_policy', `
+dontaudit $1_t devpts_t:chr_file { read write };
+dontaudit $1_t unlabeled_t:file read;
+')dnl end if targeted_policy
+ 
 ')dnl end macro daemon_core_rules
 
 #######################
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_macros.te policy-1.17.3/macros/program/gpg_macros.te
--- nsapolicy/macros/program/gpg_macros.te	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/macros/program/gpg_macros.te	2004-08-24 15:40:43.000000000 -0400
@@ -32,6 +32,7 @@
 domain_auto_trans($1_t, gpg_exec_t, $1_gpg_t)
 
 can_network($1_gpg_t)
+can_ypbind($1_gpg_t)
 
 # for a bug in kmail
 dontaudit $1_gpg_t $1_t:unix_stream_socket { getattr read write };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/spamassassin_macros.te policy-1.17.3/macros/program/spamassassin_macros.te
--- nsapolicy/macros/program/spamassassin_macros.te	2004-05-04 15:35:54.000000000 -0400
+++ policy-1.17.3/macros/program/spamassassin_macros.te	2004-08-24 15:43:36.000000000 -0400
@@ -87,8 +87,11 @@
 
 spamassassin_agent_privs($1_spamassassin_t, $1)
 
-# Uncomment if you have spamassassin do DNS lookups
-#can_network($1_spamassassin_t)
+# set tunable if you have spamassassin do DNS lookups
+ifdef(`spamassasin_can_network', `
+can_network($1_spamassassin_t)
+can_ypbind($1_spamassassin_t)
+')
 
 ###
 # Define the domain for /usr/bin/spamc
@@ -96,6 +99,7 @@
 ifdef(`spamc.te',`
 spamassassin_program_domain($1, spamc)
 can_network($1_spamc_t)
+can_ypbind($1_spamc_t)
 
 # Allow connecting to a local spamd
 ifdef(`spamd.te',`
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.17.3/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2004-08-22 20:55:02.000000000 -0400
+++ policy-1.17.3/tunables/distro.tun	2004-08-24 10:46:58.000000000 -0400
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.17.3/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2004-08-02 15:14:25.000000000 -0400
+++ policy-1.17.3/tunables/tunable.tun	2004-08-24 15:43:29.000000000 -0400
@@ -5,40 +5,40 @@
 dnl define(`user_net_control')
 
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Support NFS home directories
-dnl define(`nfs_home_dirs')
+define(`nfs_home_dirs')
 
 # Allow users to run games
-dnl define(`use_games')
+define(`use_games')
 
 # Allow ypbind to run with NIS
-dnl define(`allow_ypbind')
+define(`allow_ypbind')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow sysadm_t to do almost everything
 dnl define(`unrestricted_admin')
 
 # Allow the read/write/create on any NFS file system
-dnl define(`nfs_export_all_rw')
+define(`nfs_export_all_rw')
 
 # Allow users to unrestricted access
 dnl define(`unlimitedUsers')
@@ -48,9 +48,11 @@
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.
 dnl define(`unlimitedInetd')
 
+# Allow spamassasin to do DNS lookups
+dnl define(`spamassasin_can_network')

--------------070200060009080504040106--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
