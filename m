Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6PNohrT021577
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 19:50:43 -0400 (EDT)
Received: from monk.area614.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6PNogYd010637
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 23:50:42 GMT
Received: from [10.76.0.1] (nexus.verbum.private [10.76.0.1])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by monk.area614.net (Postfix) with ESMTP id 6AF9541081C
	for <selinux@tycho.nsa.gov>; Sun, 25 Jul 2004 19:50:44 -0400 (EDT)
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-QeXnpuowo8+fi1O65d2D"
Message-Id: <1090799087.13627.14.camel@nexus.verbum.private>
Mime-Version: 1.0
Subject: [patch] openvpn policy
Date: Sun, 25 Jul 2004 19:50:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-QeXnpuowo8+fi1O65d2D
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Attached is a policy for OpenVPN (http://openvpn.sf.net).  The last two
parts of openvpn.te seem just slightly unclean; if anyone sees a better
way, let me know.

I've only tested a simple configuration with pre-shared static keys.

(OT, but: OpenVPN is really cool.)

--=-QeXnpuowo8+fi1O65d2D
Content-Disposition: attachment; filename=openvpn.te
Content-Type: text/plain; name=openvpn.te; charset=UTF-8
Content-Transfer-Encoding: 7bit

#DESC OpenVPN - Firewall-friendly SSL-based VPN
#
# Author: Colin Walters <walters@verbum.org>
#
########################################
#

daemon_domain(openvpn)
etcdir_domain(openvpn)

type openvpn_port_t, port_type;

allow openvpn_t { etc_t etc_runtime_t }:{ file lnk_file } r_file_perms;

allow openvpn_t { random_device_t urandom_device_t }:chr_file { read getattr };
allow openvpn_t devpts_t:dir { search getattr };
allow openvpn_t tun_tap_device_t:chr_file rw_file_perms;
allow openvpn_t proc_t:file { getattr read };

allow openvpn_t self:unix_dgram_socket create_socket_perms;
allow openvpn_t self:unix_stream_socket create_stream_socket_perms;
allow openvpn_t self:unix_dgram_socket sendto;
allow openvpn_t self:unix_stream_socket connectto;
allow openvpn_t self:capability { net_admin };
r_dir_file(openvpn_t, sysctl_net_t)

can_network(openvpn_t)
allow openvpn_t openvpn_port_t:udp_socket { name_bind };

# OpenVPN executes a lot of helper programs and scripts
allow openvpn_t { bin_t sbin_t }:dir { search getattr };
allow openvpn_t bin_t:lnk_file { getattr read };
can_exec(openvpn_t, { bin_t sbin_t shell_exec_t })
# Do not transition to ifconfig_t, since then it needs
# permission to access openvpn_t:udp_socket, which seems
# worse.
can_exec(openvpn_t, ifconfig_exec_t)

# The Fedora init script iterates over /etc/openvpn/*.conf, and
# starts a daemon for each file.
r_dir_file(initrc_t, openvpn_etc_t)

--=-QeXnpuowo8+fi1O65d2D
Content-Disposition: attachment; filename=openvpn.fc
Content-Type: text/plain; name=openvpn.fc; charset=UTF-8
Content-Transfer-Encoding: 7bit

# OpenVPN

/etc/openvpn(/*)?	--	system_u:object_r:openvpn_etc_t
/usr/sbin/openvpn	--	system_u:object_r:openvpn_exec_t

--=-QeXnpuowo8+fi1O65d2D
Content-Disposition: attachment; filename=openvpn-net-contexts.patch
Content-Type: text/x-patch; name=openvpn-net-contexts.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

* modified files

--- orig/net_contexts
+++ mod/net_contexts
@@ -190,6 +190,9 @@
 portcon tcp 8080  system_u:object_r:http_cache_port_t
 portcon udp 3130  system_u:object_r:http_cache_port_t
 ')
+ifdef(`openvpn.te', `
+portcon udp 5000 system_u:object_r:openvpn_port_t
+')
 ifdef(`transproxy.te', `portcon tcp 8081 system_u:object_r:transproxy_port_t')
 ifdef(`amanda.te', `
 portcon udp 10080 system_u:object_r:amanda_port_t




--=-QeXnpuowo8+fi1O65d2D--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
