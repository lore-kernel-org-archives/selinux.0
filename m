Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIEXHIi013396
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 09:33:17 -0500 (EST)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIEXGnn026015
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 14:33:19 GMT
Message-ID: <419CB2A8.7020504@redhat.com>
Date: Thu, 18 Nov 2004 09:33:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>,
   Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux <selinux@tycho.nsa.gov>
Subject: can_network patch.
References: <41741A2C.8040408@redhat.com>	 <200410260138.19426.russell@coker.com.au>	 <20041025213122.GA2535@jmh.mhn.de>	 <200410270036.14935.russell@coker.com.au>	 <1099690788.16488.52.camel@moss-lions.epoch.ncsc.mil>	 <4192A029.5050909@redhat.com> <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1100722524.22035.18.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------050903040608050705030607"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050903040608050705030607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------050903040608050705030607
Content-Type: text/x-patch;
 name="policy-network.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policy-network.patch"

diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/ssh.te policy-1.19.2.good/domains/program/ssh.te
--- policy-1.19.2/domains/program/ssh.te	2004-11-18 08:14:48.000000000 -0500
+++ policy-1.19.2.good/domains/program/ssh.te	2004-11-18 08:35:53.834772235 -0500
@@ -69,6 +69,7 @@
 allow $1_t urandom_device_t:chr_file { getattr read };
 
 can_network($1_t)
+allow $1_t self:{ udp_socket tcp_socket } connect;
 
 allow $1_t self:capability { kill sys_chroot sys_resource chown dac_override fowner fsetid setgid setuid sys_tty_config };
 allow $1_t { home_root_t home_dir_type }:dir { search getattr };
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/apache.te policy-1.19.2.good/domains/program/unused/apache.te
--- policy-1.19.2/domains/program/unused/apache.te	2004-11-18 08:50:10.113157831 -0500
+++ policy-1.19.2.good/domains/program/unused/apache.te	2004-11-18 08:35:53.836772009 -0500
@@ -140,6 +140,7 @@
 
 can_network(httpd_t)
 can_ypbind(httpd_t)
+allow httpd_t self:{ tcp_socket udp_socket } connect;
 
 ###################
 # Allow httpd to search users diretories
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/canna.te policy-1.19.2.good/domains/program/unused/canna.te
--- policy-1.19.2/domains/program/unused/canna.te	2004-11-18 08:14:51.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/canna.te	2004-11-18 08:35:53.837771897 -0500
@@ -28,8 +28,9 @@
 
 rw_dir_create_file(canna_t, canna_var_lib_t)
 
-can_network(canna_t)
+can_tcp_network(canna_t)
 can_ypbind(canna_t)
+allow canna_t self:tcp_socket connect;
 
 allow userdomain canna_var_run_t:dir search;
 allow userdomain canna_var_run_t:sock_file write;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/cups.te policy-1.19.2.good/domains/program/unused/cups.te
--- policy-1.19.2/domains/program/unused/cups.te	2004-11-18 08:51:22.563983161 -0500
+++ policy-1.19.2.good/domains/program/unused/cups.te	2004-11-18 08:35:53.839771671 -0500
@@ -19,6 +19,7 @@
 typealias cupsd_rw_etc_t alias etc_cupsd_rw_t;
 
 can_network(cupsd_t)
+allow cupsd_t self:{ tcp_socket udp_socket } connect;
 
 logdir_domain(cupsd)
 
@@ -194,6 +195,7 @@
 
 can_network(cupsd_config_t)
 can_tcp_connect(cupsd_config_t, cupsd_t)
+allow cupsd_config_t self:tcp_socket connect;
 allow cupsd_config_t self:fifo_file rw_file_perms;
 
 allow cupsd_config_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/cyrus.te policy-1.19.2.good/domains/program/unused/cyrus.te
--- policy-1.19.2/domains/program/unused/cyrus.te	2004-11-18 08:51:47.260196672 -0500
+++ policy-1.19.2.good/domains/program/unused/cyrus.te	2004-11-18 08:35:53.839771671 -0500
@@ -20,6 +20,7 @@
 
 can_network(cyrus_t)
 can_ypbind(cyrus_t)
+allow cyrus_t self:{ tcp_socket udp_socket } connect;
 can_exec(cyrus_t, bin_t)
 allow cyrus_t cyrus_var_lib_t:dir create_dir_perms;
 allow cyrus_t cyrus_var_lib_t:{file sock_file } create_file_perms;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/dhcpc.te policy-1.19.2.good/domains/program/unused/dhcpc.te
--- policy-1.19.2/domains/program/unused/dhcpc.te	2004-11-18 08:14:53.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/dhcpc.te	2004-11-18 08:52:51.492949252 -0500
@@ -22,8 +22,9 @@
 # for SSP
 allow dhcpc_t urandom_device_t:chr_file read;
 
-can_network(dhcpc_t)
+can_network(dhcpc_t, `{ dhcpc_port_t dhcpd_port_t }')
 can_ypbind(dhcpc_t)
+allow dhcpc_t self:tcp_socket connect;
 allow dhcpc_t self:unix_dgram_socket create_socket_perms;
 allow dhcpc_t self:unix_stream_socket create_socket_perms;
 allow dhcpc_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/dhcpd.te policy-1.19.2.good/domains/program/unused/dhcpd.te
--- policy-1.19.2/domains/program/unused/dhcpd.te	2004-11-18 08:53:24.057275000 -0500
+++ policy-1.19.2.good/domains/program/unused/dhcpd.te	2004-11-18 08:35:53.840771558 -0500
@@ -31,6 +31,7 @@
 # Use the network.
 can_network(dhcpd_t)
 can_ypbind(dhcpd_t)
+allow dhcpd_t self:tcp_socket connect;
 allow dhcpd_t self:unix_dgram_socket create_socket_perms;
 allow dhcpd_t self:unix_stream_socket create_socket_perms;
 allow dhcpd_t self:netlink_route_socket r_netlink_socket_perms;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/dovecot.te policy-1.19.2.good/domains/program/unused/dovecot.te
--- policy-1.19.2/domains/program/unused/dovecot.te	2004-11-18 08:14:48.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/dovecot.te	2004-11-18 08:35:53.841771445 -0500
@@ -15,6 +15,8 @@
 allow dovecot_t self:process setrlimit;
 can_network(dovecot_t)
 can_ypbind(dovecot_t)
+allow dovecot_t self:tcp_socket connect;
+
 allow dovecot_t self:unix_dgram_socket create_socket_perms;
 allow dovecot_t self:unix_stream_socket create_stream_socket_perms;
 can_unix_connect(dovecot_t, self)
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/ftpd.te policy-1.19.2.good/domains/program/unused/ftpd.te
--- policy-1.19.2/domains/program/unused/ftpd.te	2004-11-18 08:54:09.695125653 -0500
+++ policy-1.19.2.good/domains/program/unused/ftpd.te	2004-11-18 08:35:53.842771333 -0500
@@ -16,6 +16,7 @@
 typealias ftpd_etc_t alias etc_ftpd_t;
 
 can_network(ftpd_t)
+allow ftpd_t self:udp_socket connect;
 allow ftpd_t self:unix_dgram_socket { sendto create_socket_perms };
 allow ftpd_t self:unix_stream_socket create_socket_perms;
 allow ftpd_t self:process { getcap setcap setsched setrlimit };
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/i18n_input.te policy-1.19.2.good/domains/program/unused/i18n_input.te
--- policy-1.19.2/domains/program/unused/i18n_input.te	2004-11-18 08:14:53.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/i18n_input.te	2004-11-18 08:35:53.842771333 -0500
@@ -11,6 +11,7 @@
 can_exec(i18n_input_t, i18n_input_exec_t)
 can_network(i18n_input_t)
 can_ypbind(i18n_input_t)
+allow i18n_input_t self:udp_socket connect;
 
 can_tcp_connect(userdomain, i18n_input_t)
 
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/inetd.te policy-1.19.2.good/domains/program/unused/inetd.te
--- policy-1.19.2/domains/program/unused/inetd.te	2004-11-18 08:14:56.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/inetd.te	2004-11-18 08:35:53.843771220 -0500
@@ -21,6 +21,8 @@
 daemon_domain(inetd, `ifdef(`unlimitedInetd', `,admin, etc_writer, fs_domain, auth_write, privmem')' )
 
 can_network(inetd_t)
+allow inetd_t self:{ tcp_socket udp_socket } connect;
+
 allow inetd_t self:unix_dgram_socket create_socket_perms;
 allow inetd_t self:unix_stream_socket create_socket_perms;
 allow inetd_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/innd.te policy-1.19.2.good/domains/program/unused/innd.te
--- policy-1.19.2/domains/program/unused/innd.te	2004-11-18 08:54:50.625507454 -0500
+++ policy-1.19.2.good/domains/program/unused/innd.te	2004-11-18 08:35:53.843771220 -0500
@@ -30,6 +30,7 @@
 
 can_network(innd_t)
 can_ypbind(innd_t)
+allow innd_t self:udp_socket connect;
 
 can_unix_send( { innd_t sysadm_t }, { innd_t sysadm_t } )
 allow innd_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/kerberos.te policy-1.19.2.good/domains/program/unused/kerberos.te
--- policy-1.19.2/domains/program/unused/kerberos.te	2004-11-18 08:14:50.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/kerberos.te	2004-11-18 08:35:53.844771107 -0500
@@ -16,10 +16,6 @@
 #
 # Rules for the krb5kdc_t,kadmind_t domains.
 #
-type kerberos_port_t, port_type, reserved_port_type;
-type kerberos_admin_port_t, port_type, reserved_port_type;
-type kerberos_master_port_t, port_type;
-
 daemon_domain(krb5kdc)
 daemon_domain(kadmind)
 
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/mailman.te policy-1.19.2.good/domains/program/unused/mailman.te
--- policy-1.19.2/domains/program/unused/mailman.te	2004-11-18 08:14:49.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/mailman.te	2004-11-18 08:35:53.845770994 -0500
@@ -29,12 +29,14 @@
 allow mailman_$1_t mailman_lock_t:dir rw_dir_perms;
 allow mailman_$1_t fs_t:filesystem getattr;
 can_network(mailman_$1_t)
+allow mailman_$1_t self:udp_socket connect;
 allow mailman_$1_t self:unix_stream_socket create_socket_perms;
 allow mailman_$1_t var_t:dir r_dir_perms;
 ')
 
 mailman_domain(queue, `, auth_chkpwd, nscd_client_domain')
 can_tcp_connect(mailman_queue_t, mail_server_domain)
+allow mailman_queue_t self:tcp_socket connect;
 
 can_exec(mailman_queue_t, su_exec_t)
 allow mailman_queue_t self:capability { setgid setuid };
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/named.te policy-1.19.2.good/domains/program/unused/named.te
--- policy-1.19.2/domains/program/unused/named.te	2004-11-18 08:55:41.707743815 -0500
+++ policy-1.19.2.good/domains/program/unused/named.te	2004-11-18 08:35:53.847770768 -0500
@@ -51,6 +51,8 @@
 #Named can use network
 can_network(named_t)
 can_ypbind(named_t)
+allow named_t self:tcp_socket connect;
+
 # allow UDP transfer to/from any program
 can_udp_send(domain, named_t)
 can_udp_send(named_t, domain)
@@ -102,6 +104,8 @@
 uses_shlib(ndc_t)
 can_network(ndc_t)
 can_ypbind(ndc_t)
+allow ndc_t self:tcp_socket connect;
+can_resolve(ndc_t)
 read_locale(ndc_t)
 can_tcp_connect(ndc_t, named_t)
 
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/nscd.te policy-1.19.2.good/domains/program/unused/nscd.te
--- policy-1.19.2/domains/program/unused/nscd.te	2004-11-18 08:14:48.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/nscd.te	2004-11-18 08:35:53.847770768 -0500
@@ -24,6 +24,7 @@
 allow nscd_t etc_t:lnk_file read;
 can_network(nscd_t)
 can_ypbind(nscd_t)
+allow nscd_t self:{ tcp_socket udp_socket } connect;
 
 file_type_auto_trans(nscd_t, var_run_t, nscd_var_run_t, sock_file)
 
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/ntpd.te policy-1.19.2.good/domains/program/unused/ntpd.te
--- policy-1.19.2/domains/program/unused/ntpd.te	2004-11-18 09:16:48.946760475 -0500
+++ policy-1.19.2.good/domains/program/unused/ntpd.te	2004-11-18 08:35:53.848770656 -0500
@@ -39,6 +39,7 @@
 # Use the network.
 can_network(ntpd_t)
 can_ypbind(ntpd_t)
+allow ntpd_t self:{ tcp_socket udp_socket } connect;
 allow ntpd_t ntp_port_t:udp_socket name_bind;
 allow ntpd_t self:unix_dgram_socket create_socket_perms;
 allow ntpd_t self:unix_stream_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/ping.te policy-1.19.2.good/domains/program/unused/ping.te
--- policy-1.19.2/domains/program/unused/ping.te	2004-11-18 08:14:51.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/ping.te	2004-11-18 08:35:53.848770656 -0500
@@ -35,6 +35,7 @@
 can_ypbind(ping_t)
 allow ping_t etc_t:file { getattr read };
 allow ping_t self:unix_stream_socket create_socket_perms;
+allow ping_t self:{ tcp_socket udp_socket } connect;
 
 # Let ping create raw ICMP packets.
 allow ping_t self:rawip_socket { create ioctl read write bind getopt setopt };
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/postfix.te policy-1.19.2.good/domains/program/unused/postfix.te
--- policy-1.19.2/domains/program/unused/postfix.te	2004-11-18 08:14:50.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/postfix.te	2004-11-18 08:35:53.849770543 -0500
@@ -119,6 +119,8 @@
 allow postfix_master_t postfix_private_t:fifo_file create_file_perms;
 can_network(postfix_master_t)
 can_ypbind(postfix_master_t)
+allow postfix_master_t self:{ tcp_socket udp_socket } connect;
+
 allow postfix_master_t smtp_port_t:tcp_socket name_bind;
 allow postfix_master_t postfix_spool_maildrop_t:dir rw_dir_perms;
 allow postfix_master_t postfix_spool_maildrop_t:file { unlink rename getattr };
@@ -158,6 +160,7 @@
 allow postfix_$1_t self:capability { setuid setgid dac_override };
 can_network(postfix_$1_t)
 can_ypbind(postfix_$1_t)
+allow postfix_$1_t self:{ tcp_socket udp_socket } connect;
 ')
 
 postfix_server_domain(smtp, `, mail_server_sender')
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/postgresql.te policy-1.19.2.good/domains/program/unused/postgresql.te
--- policy-1.19.2/domains/program/unused/postgresql.te	2004-11-18 08:57:40.718315780 -0500
+++ policy-1.19.2.good/domains/program/unused/postgresql.te	2004-11-18 08:35:53.850770430 -0500
@@ -14,6 +14,7 @@
 daemon_domain(postgresql)
 allow initrc_t postgresql_exec_t:lnk_file read;
 allow postgresql_t usr_t:file { getattr read };
+allow postgresql_t self:udp_socket connect;
 
 allow postgresql_t postgresql_var_run_t:sock_file create_file_perms;
 
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/privoxy.te policy-1.19.2.good/domains/program/unused/privoxy.te
--- policy-1.19.2/domains/program/unused/privoxy.te	2004-11-18 08:14:49.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/privoxy.te	2004-11-18 08:35:53.851770317 -0500
@@ -18,6 +18,7 @@
 # Use the network.
 can_network(privoxy_t)
 allow privoxy_t port_t:{ tcp_socket udp_socket } name_bind;
+allow privoxy_t self:{ tcp_socket udp_socket } connect;
 allow privoxy_t etc_t:file { getattr read };
 allow privoxy_t self:capability { setgid setuid };
 allow privoxy_t self:unix_stream_socket create_socket_perms ;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/rpcd.te policy-1.19.2.good/domains/program/unused/rpcd.te
--- policy-1.19.2/domains/program/unused/rpcd.te	2004-11-18 08:58:17.120208533 -0500
+++ policy-1.19.2.good/domains/program/unused/rpcd.te	2004-11-18 08:35:53.851770317 -0500
@@ -14,6 +14,7 @@
 daemon_base_domain($1)
 can_network($1_t)
 can_ypbind($1_t)
+allow $1_t self:{ udp_socket tcp_socket } connect;
 allow $1_t etc_t:file { getattr read };
 read_locale($1_t)
 allow $1_t self:capability net_bind_service;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/sendmail.te policy-1.19.2.good/domains/program/unused/sendmail.te
--- policy-1.19.2/domains/program/unused/sendmail.te	2004-11-18 08:14:51.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/sendmail.te	2004-11-18 08:35:53.852770204 -0500
@@ -27,6 +27,7 @@
 # Use the network.
 can_network(sendmail_t)
 can_ypbind(sendmail_t)
+allow sendmail_t self:{ tcp_socket udp_socket } connect;
 
 allow sendmail_t self:unix_stream_socket create_stream_socket_perms;
 allow sendmail_t self:unix_dgram_socket create_socket_perms;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/slapd.te policy-1.19.2.good/domains/program/unused/slapd.te
--- policy-1.19.2/domains/program/unused/slapd.te	2004-11-18 08:14:51.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/slapd.te	2004-11-18 08:35:53.852770204 -0500
@@ -30,6 +30,7 @@
 allow slapd_t self:unix_dgram_socket create_socket_perms;
 # allow any domain to connect to the LDAP server
 can_tcp_connect(domain, slapd_t)
+allow slapd_t self:{ tcp_socket udp_socket } connect;
 
 # Use capabilities  should not need kill...
 allow slapd_t self:capability { kill setgid setuid net_bind_service net_raw };
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/snmpd.te policy-1.19.2.good/domains/program/unused/snmpd.te
--- policy-1.19.2/domains/program/unused/snmpd.te	2004-11-18 08:58:52.256244113 -0500
+++ policy-1.19.2.good/domains/program/unused/snmpd.te	2004-11-18 08:35:53.853770092 -0500
@@ -15,6 +15,7 @@
 
 can_network(snmpd_t)
 can_ypbind(snmpd_t)
+allow snmpd_t self:{ tcp_socket udp_socket } connect;
 
 type snmp_port_t, port_type, reserved_port_type;
 allow snmpd_t snmp_port_t:{ udp_socket tcp_socket } name_bind;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/spamd.te policy-1.19.2.good/domains/program/unused/spamd.te
--- policy-1.19.2/domains/program/unused/spamd.te	2004-11-18 08:14:53.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/spamd.te	2004-11-18 08:35:53.853770092 -0500
@@ -24,6 +24,7 @@
 dontaudit spamd_t sysadm_home_dir_t:dir getattr;
 
 can_network(spamd_t)
+allow spamd_t self:{ tcp_socket udp_socket } connect;
 allow spamd_t self:capability net_bind_service;
 
 allow spamd_t proc_t:file { getattr read };
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/squid.te policy-1.19.2.good/domains/program/unused/squid.te
--- policy-1.19.2/domains/program/unused/squid.te	2004-11-18 08:59:29.988986705 -0500
+++ policy-1.19.2.good/domains/program/unused/squid.te	2004-11-18 08:35:53.854769979 -0500
@@ -55,6 +55,7 @@
 can_network(squid_t)
 can_ypbind(squid_t)
 can_tcp_connect(web_client_domain, squid_t)
+allow squid_t self:{ tcp_socket udp_socket } connect;
 
 # tcp port 8080 and udp port 3130 is http_cache_port_t (see net_contexts)
 allow squid_t http_cache_port_t:tcp_socket name_bind;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/traceroute.te policy-1.19.2.good/domains/program/unused/traceroute.te
--- policy-1.19.2/domains/program/unused/traceroute.te	2004-11-18 08:14:54.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/traceroute.te	2004-11-18 08:35:53.855769866 -0500
@@ -20,6 +20,7 @@
 uses_shlib(traceroute_t)
 can_network(traceroute_t)
 can_ypbind(traceroute_t)
+allow traceroute_t self:{ tcp_socket udp_socket } connect;
 allow traceroute_t node_t:rawip_socket node_bind;
 type traceroute_exec_t, file_type, sysadmfile, exec_type;
 
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/vpnc.te policy-1.19.2.good/domains/program/unused/vpnc.te
--- policy-1.19.2/domains/program/unused/vpnc.te	2004-11-18 09:17:37.765252256 -0500
+++ policy-1.19.2.good/domains/program/unused/vpnc.te	2004-11-18 08:35:53.855769866 -0500
@@ -17,6 +17,7 @@
 # Use the network.
 can_network(vpnc_t)
 can_ypbind(vpnc_t)
+allow vpnc_t self:udp_socket connect;
 allow vpnc_t self:socket create_socket_perms;
 
 # Use capabilities.
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/xdm.te policy-1.19.2.good/domains/program/unused/xdm.te
--- policy-1.19.2/domains/program/unused/xdm.te	2004-11-18 09:01:02.054598887 -0500
+++ policy-1.19.2.good/domains/program/unused/xdm.te	2004-11-18 08:35:53.856769753 -0500
@@ -46,6 +46,7 @@
 allow xdm_t default_context_t:file { read getattr };
 
 can_network(xdm_t)
+allow xdm_t self:udp_socket connect;
 allow xdm_t self:unix_stream_socket { connectto create_stream_socket_perms };
 allow xdm_t self:unix_dgram_socket create_socket_perms;
 allow xdm_t self:fifo_file rw_file_perms;
diff --exclude-from=exclude -N -u -r policy-1.19.2/domains/program/unused/ypbind.te policy-1.19.2.good/domains/program/unused/ypbind.te
--- policy-1.19.2/domains/program/unused/ypbind.te	2004-11-18 08:14:53.000000000 -0500
+++ policy-1.19.2.good/domains/program/unused/ypbind.te	2004-11-18 08:35:53.857769640 -0500
@@ -20,6 +20,7 @@
 # Use the network.
 can_network(ypbind_t)
 allow ypbind_t port_t:{ tcp_socket udp_socket } name_bind;
+allow ypbind_t self:{ tcp_socket udp_socket } connect;
 
 allow ypbind_t self:fifo_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/base_user_macros.te policy-1.19.2.good/macros/base_user_macros.te
--- policy-1.19.2/macros/base_user_macros.te	2004-11-18 09:01:27.432735456 -0500
+++ policy-1.19.2.good/macros/base_user_macros.te	2004-11-18 08:35:53.862769076 -0500
@@ -196,6 +196,7 @@
 # Use the network.
 can_network($1_t)
 can_ypbind($1_t)
+allow $1_t self:{ tcp_socket udp_socket } connect;
 
 ifdef(`pamconsole.te', `
 allow $1_t pam_var_console_t:dir search;
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/global_macros.te policy-1.19.2.good/macros/global_macros.te
--- policy-1.19.2/macros/global_macros.te	2004-11-18 08:14:45.000000000 -0500
+++ policy-1.19.2.good/macros/global_macros.te	2004-11-18 08:35:53.865768738 -0500
@@ -118,64 +118,6 @@
 
 #################################
 #
-# can_network(domain)
-#
-# Permissions for accessing the network.
-# See types/network.te for the network types.
-# See net_contexts for security contexts for network entities.
-#
-define(`can_network',`
-#
-# Allow the domain to create and use UDP and TCP sockets.
-# Other kinds of sockets must be separately authorized for use.
-allow $1 self:udp_socket create_socket_perms;
-allow $1 self:tcp_socket create_stream_socket_perms;
-
-#
-# Allow the domain to send or receive using any network interface.
-# netif_type is a type attribute for all network interface types.
-#
-allow $1 netif_type:netif { tcp_send udp_send rawip_send };
-allow $1 netif_type:netif { tcp_recv udp_recv rawip_recv };
-
-#
-# Allow the domain to send to or receive from any node.
-# node_type is a type attribute for all node types.
-#
-allow $1 node_type:node { tcp_send udp_send rawip_send };
-allow $1 node_type:node { tcp_recv udp_recv rawip_recv };
-
-#
-# Allow the domain to send to or receive from any port.
-# port_type is a type attribute for all port types.
-#
-allow $1 port_type:{ tcp_socket udp_socket } { send_msg recv_msg };
-
-#
-# Allow the domain to send NFS client requests via the socket
-# created by mount.
-#
-allow $1 mount_t:udp_socket rw_socket_perms;
-
-#
-# Bind to the default port type.
-# Other port types must be separately authorized.
-#
-#allow $1 port_t:udp_socket name_bind;
-#allow $1 port_t:tcp_socket name_bind;
-
-# XXX Allow binding to any node type.  Remove once
-# individual rules have been added to all domains that 
-# bind sockets. 
-allow $1 node_type: { tcp_socket udp_socket } node_bind;
-#
-# Allow access to network files including /etc/resolv.conf
-#
-allow $1 net_conf_t:file r_file_perms;
-')dnl end can_network definition
-
-#################################
-#
 # can_sysctl(domain)
 #
 # Permissions for modifying sysctl parameters.
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/network_macros.te policy-1.19.2.good/macros/network_macros.te
--- policy-1.19.2/macros/network_macros.te	1969-12-31 19:00:00.000000000 -0500
+++ policy-1.19.2.good/macros/network_macros.te	2004-11-18 08:35:53.865768738 -0500
@@ -0,0 +1,103 @@
+#################################
+#
+# can_network(domain)
+#
+# Permissions for accessing the network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`base_can_network',`
+#
+# Allow the domain to create and use $2 sockets.
+# Other kinds of sockets must be separately authorized for use.
+allow $1 self:$2_socket connected_socket_perms;
+
+#
+# Allow the domain to send or receive using any network interface.
+# netif_type is a type attribute for all network interface types.
+#
+allow $1 netif_type:netif { $2_send rawip_send };
+allow $1 netif_type:netif { $2_recv rawip_recv };
+
+#
+# Allow the domain to send to or receive from any node.
+# node_type is a type attribute for all node types.
+#
+allow $1 node_type:node { $2_send rawip_send };
+allow $1 node_type:node { $2_recv rawip_recv };
+
+#
+# Allow the domain to send to or receive from any port.
+# port_type is a type attribute for all port types.
+#
+ifelse($3, `', `
+allow $1 port_type:$2_socket { send_msg recv_msg };
+', `
+allow $1 $3:$2_socket { send_msg recv_msg };
+')
+
+# XXX Allow binding to any node type.  Remove once
+# individual rules have been added to all domains that 
+# bind sockets. 
+allow $1 node_type:$2_socket node_bind;
+#
+# Allow access to network files including /etc/resolv.conf
+#
+allow $1 net_conf_t:file r_file_perms;
+')dnl end can_network definition
+
+#################################
+#
+# can_tcp_network(domain)
+#
+# Permissions for accessing a tcp network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_tcp_network',`
+base_can_network($1, tcp, `$2')
+allow $1 self:tcp_socket { listen accept };
+')
+
+#################################
+#
+# can_udp_network(domain)
+#
+# Permissions for accessing a udp network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_udp_network',`
+base_can_network($1, udp, `$2')
+')
+
+#################################
+#
+# can_network(domain)
+#
+# Permissions for accessing the network.
+# See types/network.te for the network types.
+# See net_contexts for security contexts for network entities.
+#
+define(`can_network',`
+
+can_tcp_network($1, `$2')
+can_udp_network($1, `$2')
+
+#
+# Allow the domain to send NFS client requests via the socket
+# created by mount.
+#
+allow $1 mount_t:udp_socket rw_socket_perms;
+
+')dnl end can_network definition
+
+define(`can_resolve',`
+can_udp_network($1, `dns_port_t')
+allow $1 self:udp_socket connect;
+')
+define(`can_ldap',`
+can_tcp_network($1, `ldap_port_t')
+allow $1 self:tcp_socket connect;
+')
+
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/program/chkpwd_macros.te policy-1.19.2.good/macros/program/chkpwd_macros.te
--- policy-1.19.2/macros/program/chkpwd_macros.te	2004-11-18 08:14:45.000000000 -0500
+++ policy-1.19.2.good/macros/program/chkpwd_macros.te	2004-11-18 08:35:53.904764338 -0500
@@ -22,6 +22,8 @@
 can_getcon($1_chkpwd_t)
 can_ypbind($1_chkpwd_t)
 can_kerberos($1_chkpwd_t)
+can_ldap($1_chkpwd_t)
+can_resolve($1_chkpwd_t)
 # Transition from the user domain to this domain.
 ifelse($1, system, `
 domain_auto_trans(auth_chkpwd, chkpwd_exec_t, system_chkpwd_t)
@@ -31,6 +33,8 @@
 dontaudit $1_chkpwd_t { user_tty_type tty_device_t }:chr_file rw_file_perms;
 can_ypbind(auth_chkpwd)
 can_kerberos(auth_chkpwd)
+can_ldap(auth_chkpwd)
+can_resolve(auth_chkpwd)
 ', `
 domain_auto_trans($1_t, chkpwd_exec_t, $1_chkpwd_t)
 allow $1_t sbin_t:dir search;
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/program/crond_macros.te policy-1.19.2.good/macros/program/crond_macros.te
--- policy-1.19.2/macros/program/crond_macros.te	2004-11-18 08:14:44.000000000 -0500
+++ policy-1.19.2.good/macros/program/crond_macros.te	2004-11-18 08:35:53.905764225 -0500
@@ -68,6 +68,7 @@
 # This domain is granted permissions common to most domains.
 can_network($1_crond_t)
 can_ypbind($1_crond_t)
+allow $1_crond_t self:{ tcp_socket udp_socket } connect;
 r_dir_file($1_crond_t, self)
 allow $1_crond_t self:fifo_file rw_file_perms;
 allow $1_crond_t self:unix_stream_socket create_stream_socket_perms;
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/program/kerberos_macros.te policy-1.19.2.good/macros/program/kerberos_macros.te
--- policy-1.19.2/macros/program/kerberos_macros.te	2004-11-18 09:08:04.893889675 -0500
+++ policy-1.19.2.good/macros/program/kerberos_macros.te	2004-11-18 08:35:53.906764112 -0500
@@ -1,7 +1,8 @@
 define(`can_kerberos',`
 ifdef(`kerberos.te',`
 if (allow_kerberos) {
-can_network($1)
+allow $1 self:{ udp_socket tcp_socket } connect;
+can_network($1, `kerberos_port_t')
 dontaudit $1 krb5_conf_t:file write;
 allow $1 krb5_conf_t:file { getattr read };
 }
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/program/lpr_macros.te policy-1.19.2.good/macros/program/lpr_macros.te
--- policy-1.19.2/macros/program/lpr_macros.te	2004-11-18 09:09:14.527032926 -0500
+++ policy-1.19.2.good/macros/program/lpr_macros.te	2004-11-18 08:35:53.906764112 -0500
@@ -103,6 +103,7 @@
 
 # Connect to lpd via a TCP socket.
 can_tcp_connect($1_lpr_t, lpd_t)
+allow $1_lpr_t self:tcp_socket connect;
 
 allow $1_lpr_t fs_t:filesystem getattr;
 # Send SIGHUP to lpd.
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/program/mozilla_macros.te policy-1.19.2.good/macros/program/mozilla_macros.te
--- policy-1.19.2/macros/program/mozilla_macros.te	2004-11-18 09:10:42.462111158 -0500
+++ policy-1.19.2.good/macros/program/mozilla_macros.te	2004-11-18 09:10:17.656909944 -0500
@@ -17,6 +17,7 @@
 #
 define(`mozilla_domain',`
 x_client_domain($1, mozilla, `, web_client_domain, privlog')
+allow $1_mozilla_t self:{ tcp_socket udp_socket } connect;
 
 allow $1_mozilla_t sound_device_t:chr_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/program/mta_macros.te policy-1.19.2.good/macros/program/mta_macros.te
--- policy-1.19.2/macros/program/mta_macros.te	2004-11-18 09:11:15.394395389 -0500
+++ policy-1.19.2.good/macros/program/mta_macros.te	2004-11-18 08:35:53.908763887 -0500
@@ -37,6 +37,7 @@
 can_ypbind($1_mail_t)
 allow $1_mail_t self:unix_dgram_socket create_socket_perms;
 allow $1_mail_t self:unix_stream_socket create_socket_perms;
+allow $1_mail_t self:{ tcp_socket udp_socket } connect;
 
 read_locale($1_mail_t)
 read_sysctl($1_mail_t)
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/program/ssh_macros.te policy-1.19.2.good/macros/program/ssh_macros.te
--- policy-1.19.2/macros/program/ssh_macros.te	2004-11-18 08:14:45.000000000 -0500
+++ policy-1.19.2.good/macros/program/ssh_macros.te	2004-11-18 08:35:53.909763774 -0500
@@ -84,6 +84,7 @@
 # to access the network.
 can_network($1_ssh_t)
 can_ypbind($1_ssh_t)
+allow $1_ssh_t self:{ tcp_socket udp_socket } connect;
 
 # Use capabilities.
 allow $1_ssh_t self:capability { setuid setgid dac_override dac_read_search };
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/program/xserver_macros.te policy-1.19.2.good/macros/program/xserver_macros.te
--- policy-1.19.2/macros/program/xserver_macros.te	2004-11-18 09:12:18.809240254 -0500
+++ policy-1.19.2.good/macros/program/xserver_macros.te	2004-11-18 08:35:53.909763774 -0500
@@ -53,6 +52,7 @@
 uses_shlib($1_xserver_t)
 can_network($1_xserver_t)
 can_ypbind($1_xserver_t)
+allow $1_xserver_t self:udp_socket connect;
 allow $1_xserver_t xserver_port_t:tcp_socket name_bind;
 
 # for access within the domain
diff --exclude-from=exclude -N -u -r policy-1.19.2/macros/program/ypbind_macros.te policy-1.19.2.good/macros/program/ypbind_macros.te
--- policy-1.19.2/macros/program/ypbind_macros.te	2004-11-18 08:14:45.000000000 -0500
+++ policy-1.19.2.good/macros/program/ypbind_macros.te	2004-11-18 08:35:53.910763661 -0500
@@ -4,6 +4,7 @@
 can_network($1)
 r_dir_file($1,var_yp_t)
 allow $1 { reserved_port_t port_t }:{ tcp_socket udp_socket } name_bind;
+allow $1 self:{ tcp_socket udp_socket } connect;
 dontaudit $1 self:capability net_bind_service;
 ')
 
diff --exclude-from=exclude -N -u -r policy-1.19.2/net_contexts policy-1.19.2.good/net_contexts
--- policy-1.19.2/net_contexts	2004-11-18 08:14:45.000000000 -0500
+++ policy-1.19.2.good/net_contexts	2004-11-18 08:35:53.911763548 -0500
@@ -113,7 +113,6 @@
 portcon tcp 631 system_u:object_r:ipp_port_t
 portcon udp 631 system_u:object_r:ipp_port_t
 ')
-ifdef(`kerberos.te', `
 portcon tcp 88 system_u:object_r:kerberos_port_t
 portcon udp 88 system_u:object_r:kerberos_port_t
 portcon tcp 749 system_u:object_r:kerberos_admin_port_t
@@ -121,7 +120,6 @@
 portcon udp 750 system_u:object_r:kerberos_port_t
 portcon tcp 4444 system_u:object_r:kerberos_master_port_t
 portcon udp 4444 system_u:object_r:kerberos_master_port_t
-')
 ifdef(`spamd.te', `portcon tcp 783 system_u:object_r:spamd_port_t')
 ifdef(`rsync.te', `
 portcon tcp 873 system_u:object_r:rsync_port_t
diff --exclude-from=exclude -N -u -r policy-1.19.2/types/network.te policy-1.19.2.good/types/network.te
--- policy-1.19.2/types/network.te	2004-11-18 08:14:44.000000000 -0500
+++ policy-1.19.2.good/types/network.te	2004-11-18 08:35:53.913763323 -0500
@@ -64,6 +64,13 @@
 type mail_port_t, port_type;
 
 #
+# Ports used to communicate with kerberos server
+#
+type kerberos_port_t, port_type, reserved_port_type;
+type kerberos_admin_port_t, port_type, reserved_port_type;
+type kerberos_master_port_t, port_type;
+
+#
 # port_t is the default type of INET port numbers.
 # The *_port_t types are used for specific port
 # numbers in net_contexts or net_contexts.mls.

--------------050903040608050705030607--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
