Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7DD9HJh003449
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2008 09:09:17 -0400
Received: from QMTA01.emeryville.ca.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7DD9GtC028365
	for <selinux@tycho.nsa.gov>; Wed, 13 Aug 2008 13:09:17 GMT
Subject: Re: [REFPOLICY PATCH] Added policy module for the oident daemon.
From: Chris PeBenito <pebenito@gentoo.org>
To: Dominick Grift <domg472@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1217077669.8496.2.camel@sulphur.notebook.internal>
References: <1217077669.8496.2.camel@sulphur.notebook.internal>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-N0e9v8IC0wPzDzqnkG7U"
Date: Wed, 13 Aug 2008 09:08:59 -0400
Message-Id: <1218632939.5144.10.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-N0e9v8IC0wPzDzqnkG7U
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2008-07-26 at 15:07 +0200, Dominick Grift wrote:
> Signed-off-by: Dominick Grift <domg472@gmail.com>

The patch looks line-wrapped.  Also a couple comments inline.

> ---
>  policy/modules/services/oidentd.fc |    9 +++++
>  policy/modules/services/oidentd.if |    7 ++++
>  policy/modules/services/oidentd.te |   68
> ++++++++++++++++++++++++++++++++++++
>  3 files changed, 84 insertions(+), 0 deletions(-)
>  create mode 100644 policy/modules/services/oidentd.fc
>  create mode 100644 policy/modules/services/oidentd.if
>  create mode 100644 policy/modules/services/oidentd.te
>=20
> diff --git a/policy/modules/services/oidentd.fc
> b/policy/modules/services/oidentd.fc
> new file mode 100644
> index 0000000..a9209dc
> --- /dev/null
> +++ b/policy/modules/services/oidentd.fc
> @@ -0,0 +1,9 @@
> +
> +/etc/oidentd.conf		--
> gen_context(system_u:object_r:oidentd_config_t,s0)
> +/etc/oidentd_masq.conf	--
> gen_context(system_u:object_r:oidentd_config_t,s0)
> +
> +ifdef(`distro_redhat', `
> +/etc/rc\.d/init\.d/oidentd		--
> gen_context(system_u:object_r:oidentd_script_exec_t,s0)
> +')
> +
> +/usr/sbin/oidentd		--	gen_context(system_u:object_r:oidentd_exec_t,s0)
> diff --git a/policy/modules/services/oidentd.if
> b/policy/modules/services/oidentd.if
> new file mode 100644
> index 0000000..a745861
> --- /dev/null
> +++ b/policy/modules/services/oidentd.if
> @@ -0,0 +1,7 @@
> +## <summary>SELinux policy for the oident daemon.</summary>
> +## <desc>
> +##	<p>
> +##	Applies SELinux security to the oident daemon.
> +##	</p>
> +## </desc>

Better documentation please.  Its obvious that this is a policy for
oidentd.  It would be better to have a one line description of what
oidentd is, in the summary.  The desc should have that, plus more
information about what you can do with the policy.

> diff --git a/policy/modules/services/oidentd.te
> b/policy/modules/services/oidentd.te
> new file mode 100644
> index 0000000..1b770cf
> --- /dev/null
> +++ b/policy/modules/services/oidentd.te
> @@ -0,0 +1,68 @@
> +
> +policy_module(oidentd, 0.0.1)=20
> +
> +########################################
> +#
> +# oidentd private declarations
> +#
> +
> +## <desc>
> +## <p>
> +## Allow the oident daemon to read
> +## unprivileged user home content files.
> +## </p>
> +## </desc>
> +gen_tunable(oidentd_read_unprivileged_user_home_content_files, false)
> +
> +type oidentd_t;
> +type oidentd_exec_t;
> +init_daemon_domain(oidentd_t, oidentd_exec_t)
> +
> +ifdef(`distro_redhat', `
> +type oidentd_script_exec_t;
> +init_script_type(oidentd_script_exec_t)
> +')

This doesn't exist upstream yet.  Having the build option is
insufficient because upstream would fail to build if you set
DISTRO=3Dredhat.

> +type oidentd_config_t;
> +files_config_file(oidentd_config_t)
> +
> +########################################
> +#
> +# oidentd private policy
> +#
> +allow oidentd_t self:capability { setuid setgid };
> +allow oidentd_t self:netlink_route_socket { write getattr read bind
> create nlmsg_read };
> +allow oidentd_t self:netlink_tcpdiag_socket { write read create
> nlmsg_read };
> +allow oidentd_t self:tcp_socket { setopt read bind create accept write
> getattr listen };
> +allow oidentd_t self:udp_socket { write read create connect getattr };
> +allow oidentd_t self:unix_dgram_socket { create connect };
> +
> +allow oidentd_t oidentd_config_t:file read_file_perms;
> +
> +corenet_all_recvfrom_unlabeled(oidentd_t)
> +corenet_all_recvfrom_netlabel(oidentd_t)
> +corenet_tcp_sendrecv_all_if(oidentd_t)
> +corenet_tcp_sendrecv_all_nodes(oidentd_t)
> +corenet_tcp_bind_all_nodes(oidentd_t)
> +corenet_tcp_bind_auth_port(oidentd_t);
> +
> +files_read_etc_files(oidentd_t)
> +
> +kernel_read_kernel_sysctls(oidentd_t)
> +kernel_read_network_state(oidentd_t)
> +kernel_read_network_state_symlinks(oidentd_t)
> +kernel_read_sysctl(oidentd_t)
> +
> +libs_use_ld_so(oidentd_t)
> +libs_use_shared_libs(oidentd_t)
> +
> +logging_send_syslog_msg(oidentd_t)
> +
> +miscfiles_read_localization(oidentd_t)
> +
> +sysnet_read_config(oidentd_t)
> +
> +tunable_policy(`oidentd_read_unprivileged_user_home_content_files', `
> +	# ~/.oidentd.conf
> +	userdom_read_unpriv_users_home_content_files(oidentd_t)
> +')

Why is this last bit needed?  Why would a system service be reading a
conf file from a user's home dir?

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-N0e9v8IC0wPzDzqnkG7U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkii3OsACgkQvI7kLeavkkP7JgCeMKIa11yZcasb3EQLcLprmuh5
ct4AnR/gUUoZFhaquom1jhYYlPjs6cJD
=n+Ox
-----END PGP SIGNATURE-----

--=-N0e9v8IC0wPzDzqnkG7U--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
