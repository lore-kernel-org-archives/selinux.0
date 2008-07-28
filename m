Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6SCbahJ016756
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2008 08:37:36 -0400
Received: from QMTA02.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6SCbZgU017862
	for <selinux@tycho.nsa.gov>; Mon, 28 Jul 2008 12:37:35 GMT
Subject: Re: [refpolicy-patch 15/23] soundserver policy update
From: Chris PeBenito <pebenito@gentoo.org>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <20080719210253.454830587@hardeman.nu>
References: <20080719205002.462190042@hardeman.nu>
	 <20080719210253.454830587@hardeman.nu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hiecJVBPdoHihkFLuTKu"
Date: Mon, 28 Jul 2008 08:37:20 -0400
Message-Id: <1217248640.4959.5.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-hiecJVBPdoHihkFLuTKu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_services_soundserver.patch=
)
> This policy was written by Ken Yang and reviewed by Dan Walsh:
> http://marc.info/?l=3Dfedora-selinux-list&m=3D118561164825982&w=3D2
> and here:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D250453
>=20
> I updated the .fc changes to also work with Debian paths.

Does not apply cleanly.

> diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/serv=
ices/soundserver.fc serefpolicy-3.5.0/policy/modules/services/soundserver.f=
c
> --- nsaserefpolicy/policy/modules/services/soundserver.fc	2008-06-12 23:2=
5:05.000000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/services/soundserver.fc	2008-07-15 1=
4:05:13.000000000 -0400
> @@ -7,4 +7,8 @@
>  /usr/sbin/yiff		--	gen_context(system_u:object_r:soundd_exec_t,s0)
> =20
>  /var/run/yiff-[0-9]+\.pid --	gen_context(system_u:object_r:soundd_var_ru=
n_t,s0)
> +/var/run/nasd(/.*)?  	gen_context(system_u:object_r:soundd_var_run_t,s0)
> +
>  /var/state/yiff(/.*)?		gen_context(system_u:object_r:soundd_state_t,s0)
> +
> +/etc/(rc.d/)?init.d/nas(d)?	--	gen_context(system_u:object_r:soundd_scri=
pt_exec_t,s0)
> diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/serv=
ices/soundserver.if serefpolicy-3.5.0/policy/modules/services/soundserver.i=
f
> --- nsaserefpolicy/policy/modules/services/soundserver.if	2008-06-12 23:2=
5:05.000000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/services/soundserver.if	2008-07-15 1=
4:05:13.000000000 -0400
> @@ -13,3 +13,74 @@
>  interface(`soundserver_tcp_connect',`
>  	refpolicywarn(`$0($*) has been deprecated.')
>  ')
> +
> +########################################
> +## <summary>
> +##	Execute soundd server in the soundd domain.
> +## </summary>
> +## <param name=3D"domain">
> +##	<summary>
> +##	The type of the process performing this action.
> +##	</summary>
> +## </param>
> +#
> +#
> +interface(`soundserver_script_domtrans',`
> +	gen_require(`
> +		type soundd_script_exec_t;
> +	')
> +
> +	init_script_domtrans_spec($1,soundd_script_exec_t)
> +')
> +
> +########################################
> +## <summary>
> +##	All of the rules required to administrate=20
> +##	an soundd environment
> +## </summary>
> +## <param name=3D"domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +## <param name=3D"role">
> +##	<summary>
> +##	The role to be allowed to manage the soundd domain.
> +##	</summary>
> +## </param>
> +## <param name=3D"terminal">
> +##	<summary>
> +##	The type of the user terminal.
> +##	</summary>
> +## </param>
> +## <rolecap/>
> +#
> +interface(`soundserver_admin',`
> +	gen_require(`
> +		type soundd_t;
> +		type soundd_script_exec_t;
> +		type soundd_etc_t;
> +		type soundd_tmp_t;
> +		type soundd_var_run_t;
> +	')
> +
> +	allow $1 soundd_t:process { ptrace signal_perms getattr };
> +	read_files_pattern($1, soundd_t, soundd_t)
> +	       =20
> +	# Allow soundd_t to restart the apache service
> +	soundserver_script_domtrans($1)
> +	domain_system_change_exemption($1)
> +	role_transition $2 soundd_script_exec_t system_r;
> +	allow $2 system_r;
> +
> +	files_list_tmp($1)
> +        manage_all_pattern($1,soundd_tmp_t)
> +
> +	files_list_etc($1)
> +        manage_all_pattern($1,soundd_etc_t)
> +
> +	files_list_pids($1)
> +        manage_all_pattern($1,soundd_var_run_t)
> +')
> +
> +
> diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/serv=
ices/soundserver.te serefpolicy-3.5.0/policy/modules/services/soundserver.t=
e
> --- nsaserefpolicy/policy/modules/services/soundserver.te	2008-07-10 11:3=
8:46.000000000 -0400
> +++ serefpolicy-3.5.0/policy/modules/services/soundserver.te	2008-07-15 1=
4:05:13.000000000 -0400
> @@ -10,9 +10,6 @@
>  type soundd_exec_t;
>  init_daemon_domain(soundd_t,soundd_exec_t)
> =20
> -type soundd_etc_t alias etc_soundd_t;
> -files_type(soundd_etc_t)
> -
>  type soundd_state_t;
>  files_type(soundd_state_t)
> =20
> @@ -26,21 +23,30 @@
>  type soundd_var_run_t;
>  files_pid_file(soundd_var_run_t)
> =20
> +type soundd_etc_t;
> +files_config_file(soundd_etc_t)
> +
> +type soundd_script_exec_t;
> +init_script_type(soundd_script_exec_t)
> +
>  ########################################
>  #
> -# Declarations
> +# sound server local policy
>  #
> =20
> +allow soundd_t self:capability dac_override;
>  dontaudit soundd_t self:capability sys_tty_config;
>  allow soundd_t self:process { setpgid signal_perms };
>  allow soundd_t self:tcp_socket create_stream_socket_perms;
>  allow soundd_t self:udp_socket create_socket_perms;
> +allow soundd_t self:unix_stream_socket { connectto create_stream_socket_=
perms };
> +
> +fs_getattr_all_fs(soundd_t)
> +
>  # for yiff
>  allow soundd_t self:shm create_shm_perms;
> =20
> -allow soundd_t soundd_etc_t:dir list_dir_perms;
> -allow soundd_t soundd_etc_t:file read_file_perms;
> -allow soundd_t soundd_etc_t:lnk_file { getattr read };
> +read_files_pattern(soundd_t,soundd_etc_t,soundd_etc_t)
> =20
>  manage_files_pattern(soundd_t,soundd_state_t,soundd_state_t)
>  manage_lnk_files_pattern(soundd_t,soundd_state_t,soundd_state_t)
> @@ -55,8 +61,10 @@
>  manage_sock_files_pattern(soundd_t,soundd_tmpfs_t,soundd_tmpfs_t)
>  fs_tmpfs_filetrans(soundd_t,soundd_tmpfs_t,{ dir file lnk_file sock_file=
 fifo_file })
> =20
> +manage_sock_files_pattern(soundd_t,soundd_var_run_t,soundd_var_run_t)
>  manage_files_pattern(soundd_t,soundd_var_run_t,soundd_var_run_t)
> -files_pid_filetrans(soundd_t,soundd_var_run_t,file)
> +manage_dirs_pattern(soundd_t,soundd_var_run_t,soundd_var_run_t)
> +files_pid_filetrans(soundd_t,soundd_var_run_t,{ file dir })
> =20
>  kernel_read_kernel_sysctls(soundd_t)
>  kernel_list_proc(soundd_t)
> @@ -96,10 +104,13 @@
>  sysnet_read_config(soundd_t)
> =20
>  userdom_dontaudit_use_unpriv_user_fds(soundd_t)
> -
>  sysadm_dontaudit_search_home_dirs(soundd_t)
> =20
>  optional_policy(`
> +	alsa_domtrans(soundd_t)
> +')
> +
> +optional_policy(`
>  	seutil_sigchld_newrole(soundd_t)
>  ')
> =20

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-hiecJVBPdoHihkFLuTKu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiNvYAACgkQvI7kLeavkkNwqACgoabimC/AXT+428uPsSv/44IR
PkcAn1iN8sxkE+ciCSac8lKnNcQf3YOQ
=Os4z
-----END PGP SIGNATURE-----

--=-hiecJVBPdoHihkFLuTKu--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
