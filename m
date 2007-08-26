Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7QMjKQQ019654
	for <selinux@tycho.nsa.gov>; Sun, 26 Aug 2007 18:45:20 -0400
Received: from atlantic.devin.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7QMjIWt029714
	for <selinux@tycho.nsa.gov>; Sun, 26 Aug 2007 22:45:18 GMT
Date: Sun, 26 Aug 2007 15:45:16 -0700
From: Devin Carraway <selinux-list@devin.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: [refpolicy] policy & patch for bitlbee
Message-ID: <20070826224516.GA32414@atlantic.devin.com>
References: <20070819045707.GJ18641@atlantic.devin.com> <46D00510.80608@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
In-Reply-To: <46D00510.80608@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--/WwmFnJnmDyWGHa4
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 25, 2007 at 06:31:44AM -0400, Daniel J Walsh wrote:
> So I would remove
[...]
> type bitlbee_share_t;
> files_type(bitlbee_share_t)

After talking a bit about this on #selinux, I went ahead with your suggesti=
on
to remove bitlbee_share_t, and allow a usr_t read.  I kept bitlbee_conf_t,
since it can have an authentication secret in it.

Here's an updated version.  It adds (and uses) an interface
bitlbee_read_config() to permit reading bitlbee_conf_t.

Thanks again.

--=20
Devin  \ aqua(at)devin.com, IRC:Requiem; http://www.devin.com
Carraway \ 1024D/E9ABFCD2: 13E7 199E DD1E 65F0 8905 2E43 5395 CA0D E9AB FCD2

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bitlbee.te"
Content-Transfer-Encoding: quoted-printable

policy_module(bitlbee, 1.0.0)

# $Id: bitlbee.te 673 2007-08-11 21:03:48Z aqua $
#=20
# (Draft) SELinux policy for the bitlbee IM gateway server, using refpolicy
#=20
# Devin Carraway <devin@debian.org>

gen_require(`
	type tcpd_t;
')

########################################
#
# Declarations
#

type bitlbee_t;
type bitlbee_exec_t;

# bitlbee is usually run from inetd, but also can be run standalone
init_daemon_domain(bitlbee_t, bitlbee_exec_t)

type bitlbee_conf_t;
files_config_file(bitlbee_conf_t)

type bitlbee_share_t;
files_type(bitlbee_share_t)

type bitlbee_var_t;
files_type(bitlbee_var_t)

########################################
#
# Local policy
#
#

# normally started from inetd using tcpwrappers, so use those entry points
domain_auto_trans(tcpd_t, bitlbee_exec_t, bitlbee_t)
inetd_tcp_service_domain(bitlbee_t, bitlbee_exec_t);

# allow library loading
libs_legacy_use_shared_libs(bitlbee_t)
libs_use_ld_so(bitlbee_t)

# it needs read-only access to etc_t and to its own systemwide configuration
files_read_etc_files(bitlbee_t)
bitlbee_read_config(bitlbee_t)

# grant read-only access to the user help files
files_read_usr_files(bitlbee_t)

# user account information is read and edited at runtime; give the usual
# r/w access to bitlbee_var_t
files_var_lib_filetrans(bitlbee_t, bitlbee_var_t, file)
allow bitlbee_t bitlbee_var_t:dir rw_dir_perms;
allow bitlbee_t bitlbee_var_t:file manage_file_perms;

# read-only access to /var/run
files_search_pids(bitlbee_t)

# bitlbee's own network sockets (UDP, TCP and unix domain sockets)
allow bitlbee_t self:udp_socket { create_socket_perms };
allow bitlbee_t self:tcp_socket { create_stream_socket_perms connected_stre=
am_socket_perms };
allow bitlbee_t self:unix_stream_socket { create_stream_socket_perms };
corenet_udp_sendrecv_generic_if(bitlbee_t)
corenet_udp_sendrecv_generic_node(bitlbee_t)
corenet_udp_sendrecv_lo_node(bitlbee_t)
corenet_tcp_sendrecv_generic_if(bitlbee_t)
corenet_tcp_sendrecv_generic_node(bitlbee_t)
corenet_tcp_sendrecv_lo_node(bitlbee_t)
corenet_all_recvfrom_unlabeled(bitlbee_t)

# Permit DNS requests
corenet_udp_sendrecv_dns_port(bitlbee_t)

# Allow bitlbee to connect to jabber servers
corenet_tcp_connect_jabber_client_port(bitlbee_t)
corenet_tcp_sendrecv_jabber_client_port(bitlbee_t)

# to AIM servers:
corenet_tcp_connect_aol_port(bitlbee_t)
corenet_tcp_sendrecv_aol_port(bitlbee_t)

# and to MMCC (Yahoo IM) servers:
corenet_tcp_connect_mmcc_port(bitlbee_t)
corenet_tcp_sendrecv_mmcc_port(bitlbee_t)

# and to MSNP (MSN Messenger) servers:
corenet_tcp_connect_msnp_port(bitlbee_t)
corenet_tcp_sendrecv_msnp_port(bitlbee_t)


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bitlbee.if"

## <summary>Bitlbee service</summary>

########################################
## <summary>
##     Read bitlbee configuration files
## </summary>
## <param name="domain">
##     <summary>
##         Domain allowed accesss.
##     </summary>
## </param>
#
interface(`bitlbee_read_config',`
	gen_require(`
		type bitlbee_conf_t;
	')

	files_search_etc($1)
	allow $1 bitlbee_conf_t:dir { getattr read search };
	allow $1 bitlbee_conf_t:file { read getattr };
')


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bitlbee.fc"

/usr/sbin/bitlbee	--	gen_context(system_u:object_r:bitlbee_exec_t,s0)
/etc/bitlbee(/.*)?		gen_context(system_u:object_r:bitlbee_conf_t,s0)
/var/lib/bitlbee(/.*)?		gen_context(system_u:object_r:bitlbee_var_t,s0)

--J2SCkAp4GZ/dPZZf
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="bitlbee-network-ports.patch"

Index: policy/modules/kernel/corenetwork.te.in
===================================================================
--- policy/modules/kernel/corenetwork.te.in	(revision 2399)
+++ policy/modules/kernel/corenetwork.te.in	(working copy)
@@ -67,6 +67,7 @@
 network_port(amanda, udp,10080,s0, tcp,10080,s0, udp,10081,s0, tcp,10081,s0, tcp,10082,s0, tcp,10083,s0)
 network_port(amavisd_recv, tcp,10024,s0)
 network_port(amavisd_send, tcp,10025,s0)
+network_port(aol, tcp,5190,s0, udp,5190,s0)
 network_port(apcupsd, tcp,3551,s0, udp,3551,s0)
 network_port(asterisk, tcp,1720,s0, udp,2427,s0, udp,2727,s0, udp,4569,s0, udp,5060,s0)
 network_port(auth, tcp,113,s0)
@@ -112,6 +113,8 @@
 type lrrd_port_t, port_type; dnl network_port(lrrd_port_t) # no defined portcon
 network_port(lmtp, tcp,24,s0, udp,24,s0)
 network_port(mail, tcp,2000,s0)
+network_port(mmcc, tcp,5050,s0, udp,5050,s0)
+network_port(msnp, tcp,1863,s0, udp,1863,s0)
 network_port(monopd, tcp,1234,s0)
 network_port(mysqld, tcp,3306,s0)
 network_port(nessus, tcp,1241,s0)

--J2SCkAp4GZ/dPZZf--

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG0gJ8U5XKDemr/NIRAurTAJwJdV/q7MKZlX8JNTbxCH0WBLuGEgCgwzhF
nD0wODFwvX/C2ObSsG6rAPU=
=qLQv
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
