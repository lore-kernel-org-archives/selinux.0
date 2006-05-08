Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k487Kfj0011861
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 03:20:41 -0400
Received: from node19.avira.ro (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k487Kctw029574
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 07:20:40 GMT
Date: Mon, 8 May 2006 10:20:34 +0300
From: Petre Rodan <kaiowas@gentoo.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: Chris PeBenito <pebenito@gentoo.org>
Subject: policy for clockspeed
Message-ID: <20060508072034.GA6138@peter.avira.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--5/uDoXvLw7AC5HRs
Content-Type: multipart/mixed; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

attached you'll find a clockspeed policy.

'clockspeed uses a hardware tick counter to compensate for a persistently f=
ast or slow system clock. given a few time measurements from a reliable sou=
rce, it computes and then eliminates the clock skew.'
http://cr.yp.to/clockspeed.html

cheers,
peter

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="clockspeed.fc"


#
# /usr
#
/usr/bin/clockadd	--	gen_context(system_u:object_r:clockspeed_cli_exec_t,s0)
/usr/bin/clockspeed	--	gen_context(system_u:object_r:clockspeed_srv_exec_t,s0)
/usr/bin/sntpclock	--	gen_context(system_u:object_r:clockspeed_cli_exec_t,s0)
/usr/bin/taiclock	--	gen_context(system_u:object_r:clockspeed_cli_exec_t,s0)
/usr/bin/taiclockd	--	gen_context(system_u:object_r:clockspeed_srv_exec_t,s0)

#
# /var
#
/var/lib/clockspeed(/.*)?	gen_context(system_u:object_r:clockspeed_var_lib_t,s0)

--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="clockspeed.if"

## <summary>Clockspeed simple network time protocol client</summary>


########################################
## <summary>
##      Execute clockspeed utilities in the clockspeed_cli domain.
## </summary>
## <param name="domain">
##      <summary>
##      The type of the process performing this action.
##      </summary>
## </param>
#
interface(`clockspeed_domtrans_cli',`
        gen_require(`
                type clockspeed_cli_t, clocksped_cli_exec_t;
        ')

	domain_auto_trans($1, clockspeed_cli_exec_t, clockspeed_cli_t)
	allow $1 clockspeed_cli_t:fd use;
	allow clockspeed_cli_t $1:fd use;
	allow clockspeed_cli_t $1:fifo_file { read write };
	allow clockspeed_cli_t $1:process sigchld;

')

########################################
## <summary>
##	Allow the specified role the clockspeed_cli domain.
## </summary>
## <param name="domain">
##	<summary>
##	The type of the process performing this action.
##	</summary>
## </param>
## <param name="role">
##	<summary>
##	The role to be allowed the clockspeed_cli domain.
##	</summary>
## </param>
## <param name="terminal">
##	<summary>
##	The type of the terminal allow the clockspeed_cli domain to use.
##	</summary>
## </param>
#
template(`clockspeed_run_cli',`

	role $2 types clockspeed_cli_t;
	clockspeed_domtrans_cli($1)
	allow clockspeed_cli_t $3:chr_file { getattr read write ioctl };

')


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="clockspeed.te"


policy_module(clockspeed,1.0.0)


########################################
#
# Declarations
#

type clockspeed_cli_t;
type clockspeed_cli_exec_t;
domain_type(clockspeed_cli_t)
domain_entry_file(clockspeed_cli_t,clockspeed_cli_exec_t)

type clockspeed_srv_t;
type clockspeed_srv_exec_t;
init_daemon_domain(clockspeed_srv_t, clockspeed_srv_exec_t)

type clockspeed_var_lib_t;
files_type(clockspeed_var_lib_t)


########################################
#
# Local policy
#

# policy for ntp clients

allow clockspeed_cli_t self:capability sys_time;
allow clockspeed_cli_t self:udp_socket create_socket_perms;
allow clockspeed_cli_t clockspeed_var_lib_t:dir search;
allow clockspeed_cli_t clockspeed_var_lib_t:file { getattr read };

corenet_non_ipsec_sendrecv(clockspeed_cli_t)
corenet_udp_receive_ntp_port(clockspeed_cli_t)
corenet_udp_send_ntp_port(clockspeed_cli_t)
corenet_udp_sendrecv_generic_if(clockspeed_cli_t)
corenet_udp_sendrecv_generic_node(clockspeed_cli_t)

files_list_var_lib(clockspeed_cli_t)
files_read_etc_files(clockspeed_cli_t)
libs_use_ld_so(clockspeed_cli_t)
libs_use_shared_libs(clockspeed_cli_t)
miscfiles_read_localization(clockspeed_cli_t)


# policy for clockspeed and taiclockd daemons

allow clockspeed_srv_t self:capability { sys_time net_bind_service };
allow clockspeed_srv_t self:udp_socket create_socket_perms;
allow clockspeed_srv_t self:unix_dgram_socket create_socket_perms;
allow clockspeed_srv_t self:unix_stream_socket create_socket_perms;

allow clockspeed_srv_t clockspeed_var_lib_t:dir rw_dir_perms;
allow clockspeed_srv_t clockspeed_var_lib_t:file create_file_perms;
allow clockspeed_srv_t clockspeed_var_lib_t:fifo_file create_file_perms;

corenet_non_ipsec_sendrecv(clockspeed_srv_t)
corenet_udp_bind_clockspeed_port(clockspeed_srv_t)
corenet_udp_bind_inaddr_any_node(clockspeed_srv_t)
corenet_udp_receive_ntp_port(clockspeed_srv_t)
corenet_udp_send_ntp_port(clockspeed_srv_t)
corenet_udp_sendrecv_generic_if(clockspeed_srv_t)
corenet_udp_sendrecv_generic_node(clockspeed_srv_t)

files_read_etc_files(clockspeed_srv_t)
files_list_var_lib(clockspeed_srv_t)
libs_use_ld_so(clockspeed_srv_t)
libs_use_shared_libs(clockspeed_srv_t)
miscfiles_read_localization(clockspeed_srv_t)

optional_policy(`
	daemontools_service_domain(clockspeed_srv_t,clockspeed_srv_exec_t)
')


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="userdomain.patch"
Content-Transfer-Encoding: quoted-printable

Index: policy/modules/system/userdomain.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/serefpolicy/refpolicy/policy/modules/system/userdomain.t=
e,v
retrieving revision 1.84
diff -u -r1.84 userdomain.te
--- policy/modules/system/userdomain.te	4 May 2006 20:43:40 -0000	1.84
+++ policy/modules/system/userdomain.te	7 May 2006 11:10:08 -0000
@@ -228,6 +228,10 @@
 	')
=20
 	optional_policy(`
+		clockspeed_run_cli(sysadm_t,sysadm_r,admin_terminal)
+	')
+
+	optional_policy(`
 		clock_run(sysadm_t,sysadm_r,admin_terminal)
 	')
=20

--k+w/mQv8wyuph6w0--

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)

iD8DBQFEXvFCGSBEIeh4AEYRAmPDAJ4g8QCiUXrhpjmJ/iKW2Ndar340mgCfdQe/
ruH8r6q9KwhWirdWZZ6Jo5Q=
=Ivnl
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
