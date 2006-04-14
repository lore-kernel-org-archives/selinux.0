Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k3EIpkdM002207
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 14:51:46 -0400
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k3EIphZb014577
	for <selinux@tycho.nsa.gov>; Fri, 14 Apr 2006 18:51:44 GMT
Date: Fri, 14 Apr 2006 21:51:25 +0300
From: Petre Rodan <kaiowas@gentoo.org>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: Chris PeBenito <pebenito@gentoo.org>, Erich Schubert <erich@debian.org>
Subject: Re: VPN module
Message-ID: <20060414185125.GA7399@peter.sunspire.org>
References: <1144238374.19128.11.camel@wintermute.xmldesign.de> <1144248600.12875.2.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
In-Reply-To: <1144248600.12875.2.camel@sgc.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--U+BazGySraz5kW0T
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

We had to come up with an openvpn module asap and due to the fact that Eric=
h did not have it on his high priority todo list, I went ahead and wrote it.

cheers,
peter

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn.fc"


#
# /etc
#
/etc/openvpn(/.*)?         gen_context(system_u:object_r:openvpn_etc_t,s0)

#
# /usr
#
/usr/sbin/openvpn       -- gen_context(system_u:object_r:openvpn_exec_t,s0)

#
# /var
#
/var/log/openvpn.*      -- gen_context(system_u:object_r:openvpn_var_log_t,s0)
/var/run/openvpn.*      -- gen_context(system_u:object_r:openvpn_var_run_t,s0)


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn.if"

## <summary>full-featured SSL VPN solution</summary>

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn.te"


policy_module(openvpn,1.0.0)


########################################
#
# Declarations
#

# main openvpn domain
type openvpn_t;
type openvpn_exec_t;
init_daemon_domain(openvpn_t, openvpn_exec_t)

# configuration files
type openvpn_etc_t;
files_type(openvpn_etc_t)

# log files
type openvpn_var_log_t;
logging_log_file(openvpn_var_log_t)

# pid files
type openvpn_var_run_t;
files_pid_file(openvpn_var_run_t)

########################################
#
# openvpn local policy
#

allow openvpn_t self:capability { net_admin setgid setuid };
allow openvpn_t self:unix_dgram_socket { create_socket_perms sendto };
allow openvpn_t self:unix_stream_socket { create_stream_socket_perms connectto };
allow openvpn_t self:udp_socket create_socket_perms;
allow openvpn_t self:tcp_socket create_socket_perms;

kernel_read_net_sysctls(openvpn_t)
kernel_read_network_state(openvpn_t)
kernel_read_system_state(openvpn_t)

allow openvpn_t openvpn_etc_t:dir r_dir_perms;
allow openvpn_t openvpn_etc_t:file r_file_perms;
allow openvpn_t openvpn_etc_t:lnk_file { getattr read };
allow openvpn_t openvpn_var_log_t:file create_file_perms;
allow openvpn_t openvpn_var_run_t:file create_file_perms;

allow initrc_t openvpn_etc_t:dir r_dir_perms;
allow initrc_t openvpn_etc_t:file r_file_perms;
allow initrc_t openvpn_etc_t:lnk_file { getattr read };

corecmd_exec_bin(openvpn_t)
corecmd_exec_sbin(openvpn_t)
corecmd_exec_shell(openvpn_t)

corenet_non_ipsec_sendrecv(openvpn_t)
corenet_rw_tun_tap_dev(openvpn_t)
corenet_tcp_bind_openvpn_port(openvpn_t)
corenet_tcp_bind_all_nodes(openvpn_t)
corenet_tcp_sendrecv_all_if(openvpn_t)
corenet_tcp_sendrecv_all_ports(openvpn_t)
corenet_tcp_sendrecv_generic_if(openvpn_t)
corenet_tcp_sendrecv_generic_node(openvpn_t)
corenet_udp_bind_openvpn_port(openvpn_t)
corenet_udp_bind_all_nodes(openvpn_t)
corenet_udp_sendrecv_all_if(clamd_t)
corenet_udp_sendrecv_all_ports(openvpn_t)
corenet_udp_sendrecv_generic_if(openvpn_t)
corenet_udp_sendrecv_generic_node(openvpn_t)

dev_read_rand(openvpn_t)
dev_read_urand(openvpn_t)

files_pid_filetrans(openvpn_t, openvpn_var_run_t, file)
files_read_etc_files(openvpn_t)
files_read_etc_runtime_files(openvpn_t)

libs_use_ld_so(openvpn_t)
libs_use_shared_libs(openvpn_t)
logging_log_filetrans(openvpn_t,openvpn_var_log_t,file)
logging_send_syslog_msg(openvpn_t)
miscfiles_read_localization(openvpn_t)

sysnet_exec_ifconfig(openvpn_t)

optional_policy(`
	daemontools_service_domain(openvpn_t,openvpn_exec_t)
')


--/9DWx/yDrRhgMJTb--

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2-ecc0.1.6 (GNU/Linux)

iD8DBQFEP+8tGSBEIeh4AEYRAgizAJ4gJ2dw0WaVkHGqkk/zrYi+FsgmIACZAdei
mzuQ68Q/RAVShg+OnLBt+9Y=
=+wLU
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
