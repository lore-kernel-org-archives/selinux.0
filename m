Date: Tue, 30 May 2006 13:17:33 +0300
From: Petre Rodan <kaiowas@gentoo.org>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux@tycho.nsa.gov, Chris PeBenito <cpebenito@tresys.com>
Subject: Re: nepenthes policy
Message-ID: <20060530101733.GB6633@peter.avira.local>
References: <20060526170318.GA10733@peter.sunspire.org> <200605272136.43846.russell@coker.com.au> <20060527165749.GE6721@peter.sunspire.org> <200605280907.40813.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ycz6tD7Th1CMF4v7"
In-Reply-To: <200605280907.40813.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Ycz6tD7Th1CMF4v7
Content-Type: multipart/mixed; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Russell,

On Sun, May 28, 2006 at 10:07:36AM +1000, Russell Coker wrote:
> On Sunday 28 May 2006 02:57, Petre Rodan <kaiowas@gentoo.org> wrote:
> > > Why not use honeypot_t?
> > >
> > > Having one set of policy for all honeypot programs should work reason=
ably
> > > well.
> > >  When we get the MCS changes as recently discussed merged it will be
> > > possible to isolate multiple instances of a single honeypot program (=
or
> > > multiple programs that perform the honeypot function) by categories.
> >
> > I almost agree with your idea, but I think it be wiser to wait for anot=
her
> > honeypot policy and decide at that point if it makes sense merging them
>=20
> Of course changing the names of domains is a minor pain and rarely gets d=
one. =20
> More generally anything that involves removing lines from a .te file will=
=20
> take a lot of work to get accepted.  It's best to do it right the first t=
ime.

I made a honeyd policy, hereby attached.
IMHO there is no reason to merge the two, because:
 - rules differ a great deal between the two. similarities between the prog=
rams really end at their role
 - having different policies for the two enables easier maintenance on the =
long run
 - easier audit of the policy since it is clear which honeypot needs what

PS the honeyd policy will need tweaking, since I did not test all possible =
configurations and the internal webserver was unusable in my install. any f=
eedback is appreciated.

bye,
peter

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="honeyd.fc"


#
# /etc
#
/etc/honeyd.conf	--		gen_context(system_u:object_r:honeyd_etc_t,s0)

#
# /usr
#
/usr/bin/honeydctl		--	gen_context(system_u:object_r:honeyd_ctl_exec_t,s0)
/usr/sbin/honeyd		--	gen_context(system_u:object_r:honeyd_exec_t,s0)
/usr/share/honeyd(/.*)?			gen_context(system_u:object_r:honeyd_data_t,s0)
/usr/share/honeyd/scripts(/.*)?/.*.sh	--	gen_context(system_u:object_r:honeyd_script_exec_t,s0)
/usr/share/honeyd/scripts(/.*)?/.*.pl	--	gen_context(system_u:object_r:honeyd_script_exec_t,s0)
/usr/share/honeyd/webserver/htdocs(/.*)		gen_context(system_u:object_r:honeyd_rwdata_t,s0)

#
# /var
#
/var/run/honeyd.pid	--	gen_context(system_u:object_r:honeyd_var_run_t,s0)
/var/run/honeyd.sock	-s	gen_context(system_u:object_r:honeyd_var_run_t,s0)


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="honeyd.if"

## <summary>honeyd honeypot</summary>

########################################
## <summary>
##      Execute honeydctl in the honeyd_ctl domain.
## </summary>
## <param name="domain">
##      <summary>
##      Domain allowed access.
##      </summary>
## </param>
#
interface(`honeyd_domtrans_ctl',`
	gen_require(`
		type honeyd_ctl_t, honeyd_ctl_exec_t;
	')

	domain_auto_trans($1, honeyd_ctl_exec_t, honeyd_ctl_t)
	allow honeyd_ctl_t $1:fd use;
	allow honeyd_ctl_t $1:fifo_file { read write };
	allow honeyd_ctl_t $1:process sigchld;
')

########################################
## <summary>
##	Allow the specified role the honeyd_ctl_t domain.
## </summary>
## <param name="domain">
##	<summary>
##	Domain allowed access.
##	</summary>
## </param>
## <param name="role">
##	<summary>
##	The role to be allowed the honeyd_ctl domain.
##	</summary>
## </param>
## <param name="terminal">
##	<summary>
##	The type of the terminal allow the honeyd_ctl domain to use.
##	</summary>
## </param>
#
template(`honeyd_run_ctl',`
	gen_require(`
		type honeyd_ctl_t;
	')

	role $2 types honeyd_ctl_t;
	honeyd_domtrans_ctl($1)
	allow honeyd_ctl_t $3:chr_file { getattr read write ioctl };

')


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="honeyd.te"


policy_module(honeyd,1.0.0)


########################################
#
# Declarations
#

type honeyd_t;
type honeyd_exec_t;
init_daemon_domain(honeyd_t,honeyd_exec_t)

type honeyd_etc_t;
files_type(honeyd_etc_t)

type honeyd_ctl_t;
type honeyd_ctl_exec_t;
domain_type(honeyd_ctl_t)
domain_entry_file(honeyd_ctl_t,honeyd_ctl_exec_t)

type honeyd_data_t;
files_type(honeyd_data_t)

type honeyd_rwdata_t;
files_type(honeyd_rwdata_t)

type honeyd_script_t;
type honeyd_script_exec_t;
domain_type(honeyd_script_t)
domain_entry_file(honeyd_script_t,honeyd_script_exec_t)

type honeyd_script_tmp_t;
files_tmp_file(honeyd_script_tmp_t)

type honeyd_var_run_t;
files_pid_file(honeyd_var_run_t)


########################################
#
# honeyd local policy
#

allow honeyd_t self:capability { net_bind_service net_raw setgid setuid sys_resource };
allow honeyd_t self:packet_socket { bind create getopt ioctl read setopt };
allow honeyd_t self:process { setrlimit setsched };
allow honeyd_t self:rawip_socket create_socket_perms;
allow honeyd_t self:tcp_socket create_stream_socket_perms;
allow honeyd_t self:udp_socket create_socket_perms;

allow honeyd_t honeyd_data_t:dir r_dir_perms;
allow honeyd_t honeyd_data_t:file r_file_perms;
allow honeyd_t honeyd_etc_t:file r_file_perms;
allow honeyd_t honeyd_rwdata_t:dir rw_dir_perms;
allow honeyd_t honeyd_rwdata_t:file create_file_perms;
allow honeyd_t honeyd_var_run_t:file create_file_perms;
allow honeyd_t honeyd_var_run_t:sock_file create_file_perms;

kernel_read_kernel_sysctls(honeyd_t)

corenet_non_ipsec_sendrecv(honeyd_t)
corenet_raw_send_generic_if(honeyd_t)
corenet_raw_send_generic_node(honeyd_t)
corenet_tcp_bind_http_port(honeyd_t)
corenet_tcp_bind_inaddr_any_node(honeyd_t)
corenet_tcp_connect_all_ports(honeyd_t)
corenet_tcp_sendrecv_all_if(honeyd_t)
corenet_tcp_sendrecv_all_nodes(honeyd_t)
corenet_tcp_sendrecv_all_ports(honeyd_t)
corenet_udp_sendrecv_all_if(honeyd_t)
corenet_udp_sendrecv_all_nodes(honeyd_t)
corenet_udp_sendrecv_all_ports(honeyd_t)

corecmd_exec_shell(honeyd_t)
corecmd_getattr_bin_files(honeyd_t)
corecmd_read_bin_symlinks(honeyd_t)
corecmd_search_sbin(honeyd_t)
files_pid_filetrans(honeyd_t,honeyd_var_run_t,{ file sock_file })
files_read_etc_files(honeyd_t)
files_read_usr_files(honeyd_t)
files_search_pids(honeyd_t)
libs_use_ld_so(honeyd_t)
libs_use_shared_libs(honeyd_t)
logging_search_logs(honeyd_t)
logging_send_syslog_msg(honeyd_t)
miscfiles_read_localization(honeyd_t)
sysnet_read_config(honeyd_t)


########################################
#
# honeydctl local policy
#

allow honeyd_ctl_t self:process signal;

allow honeyd_ctl_t honeyd_t:unix_stream_socket connectto;
allow honeyd_ctl_t honeyd_var_run_t:sock_file write;

files_read_etc_files(honeyd_ctl_t)
libs_use_ld_so(honeyd_ctl_t)
libs_use_shared_libs(honeyd_ctl_t)


########################################
#
# local policy for the honeyd scripts
#

domain_auto_trans(honeyd_t,honeyd_script_exec_t,honeyd_script_t)

allow honeyd_script_t self:fifo_file rw_file_perms;

allow honeyd_script_t honeyd_t:fd use;
allow honeyd_script_t honeyd_t:packet_socket { read write };
allow honeyd_script_t honeyd_t:process sigchld;
allow honeyd_script_t honeyd_t:rawip_socket { read write };
allow honeyd_script_t honeyd_t:udp_socket { read write };
allow honeyd_script_t honeyd_t:unix_stream_socket rw_socket_perms;

allow honeyd_script_t honeyd_data_t:dir r_dir_perms;
allow honeyd_script_t honeyd_data_t:file r_file_perms;
allow honeyd_script_t honeyd_script_tmp_t:file create_file_perms;

corecmd_exec_bin(honeyd_script_t)
files_read_etc_files(honeyd_script_t)
files_tmp_filetrans(honeyd_script_t, honeyd_script_tmp_t, file)
libs_use_ld_so(honeyd_script_t)
libs_use_shared_libs(honeyd_script_t)
miscfiles_read_localization(honeyd_script_t)


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="userdomain.diff"
Content-Transfer-Encoding: quoted-printable

Index: policy/modules/system/userdomain.te
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/serefpolicy/refpolicy/policy/modules/system/userdomain.t=
e,v
retrieving revision 1.88
diff -u -r1.88 userdomain.te
--- policy/modules/system/userdomain.te	29 May 2006 19:57:21 -0000	1.88
+++ policy/modules/system/userdomain.te	30 May 2006 09:50:22 -0000
@@ -228,6 +228,10 @@
 	')
=20
 	optional_policy(`
+		honeyd_domtrans_ctl(sysadm_t,sysadm_r,admin_terminal)
+	')
+
+	optional_policy(`
 		clock_run(sysadm_t,sysadm_r,admin_terminal)
 	')
=20

--4ZLFUWh1odzi/v6L--

--Ycz6tD7Th1CMF4v7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)

iD8DBQFEfBu9GSBEIeh4AEYRAs53AJ9vFg2/5l7qC3S3F8WEYN5SEOOXJwCfQ0II
SIuFSiqZw3EuWF47Jl5lAxQ=
=VOqE
-----END PGP SIGNATURE-----

--Ycz6tD7Th1CMF4v7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
