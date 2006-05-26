Date: Fri, 26 May 2006 20:03:18 +0300
From: Petre Rodan <kaiowas@gentoo.org>
To: SELinux@tycho.nsa.gov
Cc: Chris PeBenito <cpebenito@tresys.com>
Subject: nepenthes policy
Message-ID: <20060526170318.GA10733@peter.sunspire.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--FkmkrVfFsRoUs1wW
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

attached you can find a reference policy for <subj>

"Nepenthes is a low interaction honeypot like honeyd or mwcollect.=20
Low Interaction Honeypots emulate known vulnerabilities to collect=20
information about potential attacks. Nepenthes is designed to emulate=20
vulnerabilties worms use to spread, and to capture these worms."
                                             http://nepenthes.sf.net

cheers,
peter

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nepenthes.fc"


#
# /etc
#
/etc/nepenthes(/.*)?		gen_context(system_u:object_r:nepenthes_etc_t,s0)

#
# /usr
#
/usr/sbin/nepenthes	--	gen_context(system_u:object_r:nepenthes_exec_t,s0)

#
# /var
#
/var/lib/cache/nepenthes(/.*)?	gen_context(system_u:object_r:nepenthes_var_lib_t,s0)
/var/lib/nepenthes(/.*)?	gen_context(system_u:object_r:nepenthes_var_lib_t,s0)
/var/log/nepenthes(/.*)?	gen_context(system_u:object_r:nepenthes_var_log_t,s0)


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nepenthes.if"

## <summary>nepenthes low interaction honeypot</summary>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nepenthes.te"


policy_module(nepenthes,1.0.0)


########################################
#
# Declarations
#

type nepenthes_t;
type nepenthes_exec_t;
init_daemon_domain(nepenthes_t,nepenthes_exec_t)

type nepenthes_etc_t;
files_type(nepenthes_etc_t)

type nepenthes_var_lib_t;
files_type(nepenthes_var_lib_t)

type nepenthes_var_log_t;
logging_log_file(nepenthes_var_log_t)


########################################
#
# nepenthes local policy
#

allow nepenthes_t self:capability { chown dac_override net_bind_service setgid setuid };
allow nepenthes_t self:process { getcap setcap };
allow nepenthes_t self:tcp_socket create_stream_socket_perms;
allow nepenthes_t self:udp_socket create_socket_perms;
allow nepenthes_t self:unix_stream_socket { connect create };

allow nepenthes_t nepenthes_etc_t:dir r_dir_perms;
allow nepenthes_t nepenthes_etc_t:file r_file_perms;
allow nepenthes_t nepenthes_etc_t:lnk_file { getattr read };
allow nepenthes_t nepenthes_var_lib_t:dir rw_dir_perms;
allow nepenthes_t nepenthes_var_lib_t:file create_file_perms;
allow nepenthes_t nepenthes_var_log_t:dir rw_dir_perms;
allow nepenthes_t nepenthes_var_log_t:file create_file_perms;

corenet_non_ipsec_sendrecv(nepenthes_t)
corenet_tcp_bind_all_nodes(nepenthes_t)
corenet_tcp_bind_all_ports(nepenthes_t)
corenet_tcp_bind_inaddr_any_node(nepenthes_t)
corenet_tcp_connect_all_ports(nepenthes_t)
corenet_tcp_sendrecv_all_if(nepenthes_t)
corenet_tcp_sendrecv_all_nodes(nepenthes_t)
corenet_tcp_sendrecv_all_ports(nepenthes_t)
corenet_udp_bind_all_nodes(nepenthes_t)
corenet_udp_bind_all_ports(nepenthes_t)
corenet_udp_bind_inaddr_any_node(nepenthes_t)
corenet_udp_sendrecv_all_if(nepenthes_t)
corenet_udp_sendrecv_all_nodes(nepenthes_t)
corenet_udp_sendrecv_all_ports(nepenthes_t)

files_list_var_lib(nepenthes_t)
files_read_etc_files(nepenthes_t)
files_read_usr_files(nepenthes_t)
files_search_pids(nepenthes_t)
libs_use_ld_so(nepenthes_t)
libs_use_shared_libs(nepenthes_t)
logging_search_logs(nepenthes_t)
miscfiles_read_localization(nepenthes_t)
sysnet_read_config(nepenthes_t)


--PEIAKu/WMn1b1Hv9--

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)

iD8DBQFEdzTWGSBEIeh4AEYRAuBMAJ9vnuP/O6RFHhx5F0Mj1bwM/1/v1wCggglE
2BUeuK4lLxoRCmJrvTWimdI=
=jAeX
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
