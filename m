Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA5B3IBE002258
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 06:03:18 -0500
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA5B3Gpv018805
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 11:03:17 GMT
Received: by ug-out-1314.google.com with SMTP id 30so1065316ugs
        for <selinux@tycho.nsa.gov>; Mon, 05 Nov 2007 03:03:16 -0800 (PST)
Date: Mon, 5 Nov 2007 11:50:41 +0100
From: Jan-Frode Myklebust <janfrode@tanso.net>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: policyd module
Message-ID: <20071105105041.GA9569@lc4eb8045376502.ibm.com>
References: <1191243135.4282.42.camel@gorn> <20071003125323.GA15070@lc4eb8045376502.ibm.com> <1191416728.5843.6.camel@gorn> <20071003150600.GA16964@lc4eb8045376502.ibm.com> <1191606242.13098.4.camel@gorn.columbia.tresys.com> <20071005234757.GA4249@lc4eb8045376502.ibm.com> <1191855475.13098.37.camel@gorn> <20071008164636.GA9601@lc4eb8045376502.ibm.com> <20071023160316.GA10042@lc4eb8045376502.ibm.com> <1193231312.9466.104.camel@gorn>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
In-Reply-To: <1193231312.9466.104.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 24, 2007 at 01:08:32PM +0000, Christopher J. PeBenito wrote:
> On Tue, 2007-10-23 at 18:03 +0200, Jan-Frode Myklebust wrote:
> > Resending this one, as it seems to have dropped of your radar. Still
> > applies to refpolicy-head.
> 
> I'm wrestling with the naming.  Policyd, while its the name of the
> server, seems far too generic.  It seems like postfix_policyd would be
> better.

Here's an updated patch against HEAD with name changed to
postfix_policyd, and r_dir_perms/r_file_perms changed to
list_dir_perms/read_file_perms. 

Re: Russels comment "If you make a policy that's generic
	enough for the majority of Postfix policy server modules
	then getting it to also work for Sendmail milters etc
	should not be difficult."

This is not meant as a generic postfix policy policy.. but a
specific policy for the policyd postfix policy daemon :-)


  -jf

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="postfix_policyd.patch"

diff -ruN refpolicy.head/policy/modules/kernel/corenetwork.te.in refpolicy/policy/modules/kernel/corenetwork.te.in
--- refpolicy.head/policy/modules/kernel/corenetwork.te.in	2007-11-05 11:11:01.000000000 +0100
+++ refpolicy/policy/modules/kernel/corenetwork.te.in	2007-11-05 11:18:53.000000000 +0100
@@ -132,6 +132,7 @@
 network_port(openvpn, tcp,1194,s0, udp,1194,s0)
 network_port(pegasus_http, tcp,5988,s0)
 network_port(pegasus_https, tcp,5989,s0)
+network_port(postfix_policyd, tcp,10031,s0)
 network_port(pop, tcp,106,s0, tcp,109,s0, tcp,110,s0, tcp,143,s0, tcp,220,s0, tcp,993,s0, tcp,995,s0, tcp,1109,s0)
 network_port(portmap, udp,111,s0, tcp,111,s0)
 network_port(postgresql, tcp,5432,s0)
diff -ruN refpolicy.head/policy/modules/kernel/corenetwork.te.in.orig refpolicy/policy/modules/kernel/corenetwork.te.in.orig
--- refpolicy.head/policy/modules/kernel/corenetwork.te.in.orig	1970-01-01 01:00:00.000000000 +0100
+++ refpolicy/policy/modules/kernel/corenetwork.te.in.orig	2007-11-05 11:18:53.000000000 +0100
@@ -0,0 +1,242 @@
+
+policy_module(corenetwork,1.2.13)
+
+########################################
+#
+# Declarations
+#
+
+attribute client_packet_type;
+attribute netif_type;
+attribute node_type;
+attribute packet_type;
+attribute port_type;
+attribute reserved_port_type;
+attribute rpc_port_type;
+attribute server_packet_type;
+
+attribute corenet_unconfined_type;
+
+type ppp_device_t;
+dev_node(ppp_device_t)
+
+#
+# tun_tap_device_t is the type of /dev/net/tun/* and /dev/net/tap/*
+#
+type tun_tap_device_t;
+dev_node(tun_tap_device_t)
+
+########################################
+#
+# Ports and packets
+#
+
+#
+# client_packet_t is the default type of IPv4 and IPv6 client packets.
+#
+type client_packet_t, packet_type, client_packet_type;
+
+#
+# The netlabel_peer_t is used by the kernel's NetLabel subsystem for network
+# connections using NetLabel which do not carry full SELinux contexts.
+#
+type netlabel_peer_t;
+sid netmsg gen_context(system_u:object_r:netlabel_peer_t,mls_systemhigh)
+
+#
+# port_t is the default type of INET port numbers.
+#
+type port_t, port_type;
+sid port gen_context(system_u:object_r:port_t,s0)
+
+#
+# reserved_port_t is the type of INET port numbers below 1024.
+#
+type reserved_port_t, port_type, reserved_port_type;
+
+#
+# hi_reserved_port_t is the type of INET port numbers between 600-1023.
+#
+type hi_reserved_port_t, port_type, reserved_port_type, rpc_port_type;
+
+#
+# server_packet_t is the default type of IPv4 and IPv6 server packets.
+#
+type server_packet_t, packet_type, server_packet_type;
+
+network_port(afs_bos, udp,7007,s0)
+network_port(afs_fs, tcp,2040,s0, udp,7000,s0, udp,7005,s0)
+network_port(afs_ka, udp,7004,s0)
+network_port(afs_pt, udp,7002,s0)
+network_port(afs_vl, udp,7003,s0)
+network_port(amanda, udp,10080,s0, tcp,10080,s0, udp,10081,s0, tcp,10081,s0, tcp,10082,s0, tcp,10083,s0)
+network_port(amavisd_recv, tcp,10024,s0)
+network_port(amavisd_send, tcp,10025,s0)
+network_port(aol, udp,5190,s0, tcp,5190,s0, udp,5191,s0, tcp,5191,s0, udp,5192,s0, tcp,5192,s0, udp,5193,s0, tcp,5193,s0) 
+network_port(apcupsd, tcp,3551,s0, udp,3551,s0)
+network_port(asterisk, tcp,1720,s0, udp,2427,s0, udp,2727,s0, udp,4569,s0, udp,5060,s0)
+network_port(auth, tcp,113,s0)
+network_port(bgp, tcp,179,s0, udp,179,s0, tcp,2605,s0, udp,2605,s0)
+type biff_port_t, port_type, reserved_port_type; dnl network_port(biff) # no defined portcon in current strict
+network_port(clamd, tcp,3310,s0)
+network_port(clockspeed, udp,4041,s0)
+network_port(cluster, tcp,5149,s0, udp,5149,s0, tcp,40040,s0, tcp,50006,s0, udp,50006,s0, tcp,50007,s0, udp,50007,s0, tcp,50008,s0, udp,50008,s0)
+network_port(comsat, udp,512,s0)
+network_port(cvs, tcp,2401,s0, udp,2401,s0)
+network_port(dcc, udp,6276,s0, udp,6277,s0)
+network_port(dbskkd, tcp,1178,s0)
+network_port(dhcpc, udp,68,s0)
+network_port(dhcpd, udp,67,s0, tcp,647,s0, udp,647,s0, tcp,847,s0, udp,847,s0)
+network_port(dict, tcp,2628,s0)
+network_port(distccd, tcp,3632,s0)
+network_port(dns, udp,53,s0, tcp,53,s0)
+network_port(fingerd, tcp,79,s0)
+network_port(ftp_data, tcp,20,s0)
+network_port(ftp, tcp,21,s0)
+network_port(gatekeeper, udp,1718,s0, udp,1719,s0, tcp,1721,s0, tcp,7000,s0)
+network_port(giftd, tcp,1213,s0)
+network_port(gopher, tcp,70,s0, udp,70,s0)
+network_port(http_cache, tcp,3128,s0, udp,3130,s0, tcp,8080,s0, tcp,8118,s0) # 8118 is for privoxy
+network_port(http, tcp,80,s0, tcp,443,s0, tcp,488,s0, tcp,8008,s0, tcp,8009,s0, tcp,8443,s0) #8443 is mod_nss default port
+network_port(howl, tcp,5335,s0, udp,5353,s0)
+network_port(hplip, tcp,1782,s0, tcp,2207,s0, tcp,2208,s0, tcp, 8290,s0, tcp,50000,s0, tcp,50002,s0, tcp,8292,s0, tcp,9100,s0, tcp,9101,s0, tcp,9102,s0, tcp,9220,s0, tcp,9221,s0, tcp,9222,s0, tcp,9280,s0, tcp,9281,s0, tcp,9282,s0, tcp,9290,s0, tcp,9291,s0, tcp,9292,s0)
+network_port(i18n_input, tcp,9010,s0)
+network_port(imaze, tcp,5323,s0, udp,5323,s0)
+network_port(inetd_child, tcp,1,s0, udp,1,s0, tcp,7,s0, udp,7,s0, tcp,9,s0, udp,9,s0, tcp,13,s0, udp,13,s0, tcp,19,s0, udp,19,s0, tcp,37,s0, udp,37,s0, tcp,512,s0, tcp,543,s0, tcp,544,s0, tcp,891,s0, udp,891,s0, tcp,892,s0, udp,892,s0, tcp,2105,s0, tcp,5666,s0)
+network_port(innd, tcp,119,s0)
+network_port(ipp, tcp,631,s0, udp,631,s0)
+network_port(ipsecnat, tcp,4500,s0, udp,4500,s0)
+network_port(ircd, tcp,6667,s0)
+network_port(isakmp, udp,500,s0)
+network_port(iscsi, tcp,3260,s0)
+network_port(jabber_client, tcp,5222,s0, tcp,5223,s0)
+network_port(jabber_interserver, tcp,5269,s0)
+network_port(kerberos_admin, tcp,464,s0, udp,464,s0, tcp,749,s0)
+network_port(kerberos_master, tcp,4444,s0, udp,4444,s0)
+network_port(kerberos, tcp,88,s0, udp,88,s0, tcp,750,s0, udp,750,s0)
+network_port(ktalkd, udp,517,s0, udp,518,s0)
+network_port(ldap, tcp,389,s0, udp,389,s0, tcp,636,s0, udp,636,s0, tcp,3268,s0)
+type lrrd_port_t, port_type; dnl network_port(lrrd_port_t) # no defined portcon
+network_port(lmtp, tcp,24,s0, udp,24,s0)
+network_port(mail, tcp,2000,s0)
+network_port(mmcc, tcp,5050,s0, udp,5050,s0)
+network_port(monopd, tcp,1234,s0)
+network_port(msnp, tcp,1863,s0, udp,1863,s0)
+network_port(mysqld, tcp,1186,s0, tcp,3306,s0)
+portcon tcp 63132-63163 gen_context(system_u:object_r:mysqld_port_t, s0)
+network_port(nessus, tcp,1241,s0)
+network_port(netsupport, tcp,5405,s0, udp,5405,s0)
+network_port(nmbd, udp,137,s0, udp,138,s0)
+network_port(ntp, udp,123,s0)
+network_port(ocsp, tcp,9080,s0)
+network_port(openvpn, tcp,1194,s0, udp,1194,s0)
+network_port(pegasus_http, tcp,5988,s0)
+network_port(pegasus_https, tcp,5989,s0)
+network_port(pop, tcp,106,s0, tcp,109,s0, tcp,110,s0, tcp,143,s0, tcp,220,s0, tcp,993,s0, tcp,995,s0, tcp,1109,s0)
+network_port(portmap, udp,111,s0, tcp,111,s0)
+network_port(postgresql, tcp,5432,s0)
+network_port(postgrey, tcp,60000,s0)
+network_port(printer, tcp,515,s0)
+network_port(ptal, tcp,5703,s0)
+network_port(pxe, udp,4011,s0)
+network_port(pyzor, udp,24441,s0)
+network_port(radacct, udp,1646,s0, udp,1813,s0)
+network_port(radius, udp,1645,s0, udp,1812,s0)
+network_port(razor, tcp,2703,s0)
+network_port(ricci, tcp,11111,s0, udp,11111,s0)
+network_port(ricci_modcluster, tcp,16851,s0, udp,16851,s0)
+network_port(rlogind, tcp,513,s0)
+network_port(rndc, tcp,953,s0)
+network_port(router, udp,520,s0)
+network_port(rsh, tcp,514,s0)
+network_port(rsync, tcp,873,s0, udp,873,s0)
+network_port(rwho, udp,513,s0)
+network_port(smbd, tcp,139,s0, tcp,445,s0)
+network_port(smtp, tcp,25,s0, tcp,465,s0, tcp,587,s0)
+network_port(snmp, udp,161,s0, udp,162,s0, tcp,199,s0)
+network_port(spamd, tcp,783,s0)
+network_port(ssh, tcp,22,s0)
+network_port(soundd, tcp,8000,s0, tcp,9433,s0, tcp, 16001, s0)
+type socks_port_t, port_type; dnl network_port(socks) # no defined portcon
+type stunnel_port_t, port_type; dnl network_port(stunnel) # no defined portcon in current strict
+network_port(squid, udp,3401,s0, tcp,3401,s0, udp,4827,s0, tcp,4827,s0) # snmp and htcp
+network_port(swat, tcp,901,s0)
+network_port(syslogd, udp,514,s0)
+network_port(telnetd, tcp,23,s0)
+network_port(tftp, udp,69,s0)
+network_port(tor, tcp,9001,s0, tcp,9030,s0, tcp,9050,s0)
+network_port(traceroute, udp,64000,s0, udp,64001,s0, udp,64002,s0, udp,64003,s0, udp,64004,s0, udp,64005,s0, udp,64006,s0, udp,64007,s0, udp,64008,s0, udp,64009,s0, udp,64010,s0)
+network_port(transproxy, tcp,8081,s0)
+type utcpserver_port_t, port_type; dnl network_port(utcpserver) # no defined portcon
+network_port(uucpd, tcp,540,s0)
+network_port(vnc, tcp,5900,s0)
+network_port(wccp, udp,2048,s0)
+network_port(xdmcp, udp,177,s0, tcp,177,s0)
+network_port(xen, tcp,8002,s0)
+network_port(xfs, tcp,7100,s0)
+network_port(xserver, tcp, 6000, s0, tcp,6001,s0, tcp,6002,s0, tcp,6003,s0, tcp,6004,s0, tcp,6005,s0, tcp,6006,s0, tcp,6007,s0, tcp,6008,s0, tcp,6009,s0, tcp,6010,s0, tcp,6011,s0, tcp,6012,s0, tcp,6013,s0, tcp,6014,s0, tcp,6015,s0, tcp,6016,s0, tcp,6017,s0, tcp,6018,s0, tcp,6019,s0, tcp,6020,s0)
+network_port(zebra, tcp,2600,s0, tcp,2601,s0, tcp,2602,s0, tcp,2603,s0, tcp,2604,s0, tcp,2606,s0, udp,2600,s0, udp,2601,s0, udp,2602,s0, udp,2603,s0, udp,2604,s0, udp,2606,s0)
+network_port(zope, tcp,8021,s0)
+
+# Defaults for reserved ports.  Earlier portcon entries take precedence;
+# these entries just cover any remaining reserved ports not otherwise declared.
+
+portcon tcp 600-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
+portcon udp 600-1023 gen_context(system_u:object_r:hi_reserved_port_t, s0)
+portcon tcp 1-599 gen_context(system_u:object_r:reserved_port_t, s0)
+portcon udp 1-599 gen_context(system_u:object_r:reserved_port_t, s0)
+
+########################################
+#
+# Network nodes
+#
+
+#
+# node_t is the default type of network nodes.
+# The node_*_t types are used for specific network
+# nodes in net_contexts or net_contexts.mls.
+#
+type node_t, node_type;
+sid node gen_context(system_u:object_r:node_t,s0 - mls_systemhigh)
+
+network_node(compat_ipv4, s0, ::, ffff:ffff:ffff:ffff:ffff:ffff::)
+network_node(inaddr_any, s0, 0.0.0.0, 255.255.255.255)
+type node_internal_t, node_type; dnl network_node(internal, s0, , ) # no nodecon for this in current strict policy
+network_node(link_local, s0, fe80::, ffff:ffff:ffff:ffff::, )
+network_node(lo, s0 - mls_systemhigh, 127.0.0.1, 255.255.255.255)
+network_node(mapped_ipv4, s0, ::ffff:0000:0000, ffff:ffff:ffff:ffff:ffff:ffff::)
+network_node(multicast, s0 - mls_systemhigh, ff00::, ff00::)
+network_node(site_local, s0, fec0::, ffc0::)
+network_node(unspec, s0, ::, ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff)
+
+########################################
+#
+# Network Interfaces
+#
+
+#
+# netif_t is the default type of network interfaces.
+#
+type netif_t, netif_type;
+sid netif gen_context(system_u:object_r:netif_t,s0 - mls_systemhigh)
+
+build_option(`enable_mls',`
+network_interface(lo, lo,s0 - mls_systemhigh)
+',`
+typealias netif_t alias netif_lo_t;
+')
+
+########################################
+#
+# Unconfined access to this module
+#
+
+allow corenet_unconfined_type node_type:node *;
+allow corenet_unconfined_type netif_type:netif *;
+allow corenet_unconfined_type packet_type:packet *;
+allow corenet_unconfined_type port_type:tcp_socket { send_msg recv_msg name_connect };
+allow corenet_unconfined_type port_type:udp_socket { send_msg recv_msg };
+
+# Bind to any network address.
+allow corenet_unconfined_type port_type:{ tcp_socket udp_socket } name_bind;
+allow corenet_unconfined_type node_type:{ tcp_socket udp_socket rawip_socket } node_bind;
diff -ruN refpolicy.head/policy/modules/services/postfix_policyd.fc refpolicy/policy/modules/services/postfix_policyd.fc
--- refpolicy.head/policy/modules/services/postfix_policyd.fc	1970-01-01 01:00:00.000000000 +0100
+++ refpolicy/policy/modules/services/postfix_policyd.fc	2007-11-05 11:18:53.000000000 +0100
@@ -0,0 +1,3 @@
+/usr/sbin/policyd		--	gen_context(system_u:object_r:postfix_policyd_exec_t, s0)
+/etc/policyd.conf		--	gen_context(system_u:object_r:postfix_policyd_conf_t, s0)
+/var/run/policyd\.pid		--	gen_context(system_u:object_r:postfix_policyd_var_run_t, s0)
diff -ruN refpolicy.head/policy/modules/services/postfix_policyd.if refpolicy/policy/modules/services/postfix_policyd.if
--- refpolicy.head/policy/modules/services/postfix_policyd.if	1970-01-01 01:00:00.000000000 +0100
+++ refpolicy/policy/modules/services/postfix_policyd.if	2007-11-05 11:18:53.000000000 +0100
@@ -0,0 +1,2 @@
+## <summary>Postfix policy server</summary>
+
diff -ruN refpolicy.head/policy/modules/services/postfix_policyd.te refpolicy/policy/modules/services/postfix_policyd.te
--- refpolicy.head/policy/modules/services/postfix_policyd.te	1970-01-01 01:00:00.000000000 +0100
+++ refpolicy/policy/modules/services/postfix_policyd.te	2007-11-05 11:19:34.000000000 +0100
@@ -0,0 +1,54 @@
+
+policy_module(postfix_policyd, 1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type postfix_policyd_t;
+type postfix_policyd_exec_t;
+init_daemon_domain(postfix_policyd_t, postfix_policyd_exec_t)
+
+type postfix_policyd_conf_t;
+files_config_file(postfix_policyd_conf_t)
+
+type postfix_policyd_var_run_t;
+files_pid_file(postfix_policyd_var_run_t)
+
+########################################
+#
+# Local Policy
+#
+
+allow postfix_policyd_t self:tcp_socket create_stream_socket_perms;
+allow postfix_policyd_t self:capability { sys_resource sys_chroot setgid setuid };
+allow postfix_policyd_t self:process setrlimit;
+allow postfix_policyd_t self:unix_dgram_socket { connect create write};
+
+allow postfix_policyd_t postfix_policyd_conf_t:dir list_dir_perms;
+allow postfix_policyd_t postfix_policyd_conf_t:file read_file_perms;
+allow postfix_policyd_t postfix_policyd_conf_t:lnk_file { getattr read };
+
+allow postfix_policyd_t postfix_policyd_var_run_t:dir rw_dir_perms;
+allow postfix_policyd_t postfix_policyd_var_run_t:file create_file_perms;
+files_pid_filetrans(postfix_policyd_t, postfix_policyd_var_run_t, file)
+
+corenet_tcp_sendrecv_all_if(postfix_policyd_t)
+corenet_tcp_sendrecv_all_nodes(postfix_policyd_t)
+corenet_tcp_sendrecv_all_ports(postfix_policyd_t)
+corenet_all_recvfrom_unlabeled(postfix_policyd_t)
+corenet_tcp_bind_all_nodes(postfix_policyd_t)
+corenet_tcp_bind_postfix_policyd_port(postfix_policyd_t)
+corenet_tcp_bind_mysqld_port(postfix_policyd_t)
+
+sysnet_dns_name_resolve(postfix_policyd_t)
+
+libs_use_ld_so(postfix_policyd_t)
+libs_use_shared_libs(postfix_policyd_t)
+term_use_generic_ptys(postfix_policyd_t)
+files_read_etc_files(postfix_policyd_t)
+logging_send_syslog_msg(postfix_policyd_t)
+
+miscfiles_read_localization(postfix_policyd_t)
+files_read_usr_files(postfix_policyd_t)
diff -ruN refpolicy.head/policy/modules/services/postfix.te refpolicy/policy/modules/services/postfix.te
--- refpolicy.head/policy/modules/services/postfix.te	2007-10-09 21:18:21.000000000 +0200
+++ refpolicy/policy/modules/services/postfix.te	2007-11-05 11:18:53.000000000 +0100
@@ -547,6 +547,9 @@
 # connect to master process
 stream_connect_pattern(postfix_smtpd_t,{ postfix_private_t postfix_public_t },{ postfix_private_t postfix_public_t },postfix_master_t)
 
+# Connect to policy server
+corenet_tcp_connect_postfix_policyd_port(postfix_smtpd_t)
+
 # for prng_exch
 allow postfix_smtpd_t postfix_spool_t:file rw_file_perms;
 allow postfix_smtpd_t postfix_prng_t:file rw_file_perms;

--UlVJffcvxoiEqYs2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
