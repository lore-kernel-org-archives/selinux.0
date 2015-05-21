Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4LGVpnm024045
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 12:31:59 -0400
Received: by wicmx19 with SMTP id mx19so18267157wic.0
 for <selinux@tycho.nsa.gov>; Thu, 21 May 2015 09:31:56 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id x3sm3615705wiy.20.2015.05.21.09.31.55
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 May 2015 09:31:55 -0700 (PDT)
Date: Thu, 21 May 2015 18:31:54 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: add selinux_openssh_contexts_path()
Message-ID: <20150521163153.GC683@x131e>
References: <1432224862-14659-1-git-send-email-plautrba@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2/5bycvrmDh4d1IB"
In-Reply-To: <1432224862-14659-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--2/5bycvrmDh4d1IB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2015 at 06:14:22PM +0200, Petr Lautrbach wrote:
> openssh in Fedora uses "sshd_net_t" type for privilege separated
> processes in the preauthentication phase. Similarly, openssh portable uses
> "sftp_t" for internal-sftp processes. Both type are hardcoded what is not=
 ideal.
> Therefore selinux_openssh_contexts_path() was created to get a path where=
 sshd
> can get a correct types prepared by a distribution or an administrator.
>=20
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> ---
>  libselinux/include/selinux/selinux.h |  1 +
>  libselinux/src/file_path_suffixes.h  |  1 +
>  libselinux/src/selinux_config.c      | 12 ++++++++++--
>  libselinux/src/selinux_internal.h    |  1 +
>  4 files changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index d0eb5c6..4beb170 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -543,6 +543,7 @@ extern const char *selinux_virtual_image_context_path=
(void);
>  extern const char *selinux_lxc_contexts_path(void);
>  extern const char *selinux_x_context_path(void);
>  extern const char *selinux_sepgsql_context_path(void);
> +extern const char *selinux_openssh_contexts_path(void);
>  extern const char *selinux_systemd_contexts_path(void);
>  extern const char *selinux_contexts_path(void);
>  extern const char *selinux_securetty_types_path(void);
> diff --git a/libselinux/src/file_path_suffixes.h b/libselinux/src/file_pa=
th_suffixes.h
> index 3c92424..d1f9b48 100644
> --- a/libselinux/src/file_path_suffixes.h
> +++ b/libselinux/src/file_path_suffixes.h
> @@ -23,6 +23,7 @@ S_(BINPOLICY, "/policy/policy")
>      S_(VIRTUAL_DOMAIN, "/contexts/virtual_domain_context")
>      S_(VIRTUAL_IMAGE, "/contexts/virtual_image_context")
>      S_(LXC_CONTEXTS, "/contexts/lxc_contexts")
> +    S_(OPENSSH_CONTEXTS, "/contexts/openssh_contexts")
>      S_(SYSTEMD_CONTEXTS, "/contexts/systemd_contexts")
>      S_(FILE_CONTEXT_SUBS, "/contexts/files/file_contexts.subs")
>      S_(FILE_CONTEXT_SUBS_DIST, "/contexts/files/file_contexts.subs_dist")
> diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_con=
fig.c
> index 0a80141..bec5f3b 100644
> --- a/libselinux/src/selinux_config.c
> +++ b/libselinux/src/selinux_config.c
> @@ -48,8 +48,9 @@
>  #define FILE_CONTEXT_SUBS_DIST 25
>  #define LXC_CONTEXTS      26
>  #define BOOLEAN_SUBS      27
> -#define SYSTEMD_CONTEXTS  28
> -#define NEL               29
> +#define OPENSSH_CONTEXTS  28
> +#define SYSTEMD_CONTEXTS  29
> +#define NEL               30

How come openssh_context becomes version 28 and systemd_contexts changes fr=
om 28 to 29?

> =20
>  /* Part of one-time lazy init */
>  static pthread_once_t once =3D PTHREAD_ONCE_INIT;
> @@ -491,6 +492,13 @@ const char *selinux_lxc_contexts_path(void)
> =20
>  hidden_def(selinux_lxc_contexts_path)
> =20
> +const char *selinux_openssh_contexts_path(void)
> +{
> +    return get_path(OPENSSH_CONTEXTS);
> +}
> +
> +hidden_def(selinux_openssh_contexts_path)
> +
>  const char *selinux_systemd_contexts_path(void)
>  {
>  	return get_path(SYSTEMD_CONTEXTS);
> diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_i=
nternal.h
> index 0abf1b4..844e408 100644
> --- a/libselinux/src/selinux_internal.h
> +++ b/libselinux/src/selinux_internal.h
> @@ -83,6 +83,7 @@ hidden_proto(selinux_mkload_policy)
>      hidden_proto(selinux_media_context_path)
>      hidden_proto(selinux_x_context_path)
>      hidden_proto(selinux_sepgsql_context_path)
> +    hidden_proto(selinux_openssh_contexts_path)
>      hidden_proto(selinux_systemd_contexts_path)
>      hidden_proto(selinux_path)
>      hidden_proto(selinux_check_passwd_access)
> --=20
> 2.4.1
>=20
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--2/5bycvrmDh4d1IB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVXgh1AAoJENAR6kfG5xmcHMgMAKzm9Z9Hs1T3gYZ4pGr2wjMp
+nLeXa3ZP7JR0e2SY0CGAKBf7GrnMG3BzN4d0bgSyh6wFW76QjcoTQZOqa0uKtap
a+6XRLiLoJzgbaBOZxgwdvWXQNyekGoeQyjS8w4vaeb4V1DG05ZidLuR8CORwPFt
0VgMigfGnS3mqLjLF8AlShJx0izytD5cg/QdgrFZ16w7ml87+oCTN2WSccOE1OwK
aByP4TQfqWyAR0I3jQATYfWXVW9umF/qB8ZfVZPARdONzTiGjOWJ6j+oSd1gZTC3
QjT7RI7ySIMIFAhEVV1H5Aya8gdNKiYVhq0h8P2p+NAp/+AbRC3RbsijESXcdca3
pwJtUcpnfQvaJjpqnokO7JIRA+SkSz+JJCWPfu+vFhP0pEZEWw9rBnt3j/hpKQL9
+odJBy/QHOWtw3FH4eHMqUOirikxdi/uam3MpIcwolXFUVdjvTZ8nVYFWlW1S+s1
pZ1p5K/rbiDooEcRcfC5fhJArtZtDeXm/yzxYu7bzA==
=uL9b
-----END PGP SIGNATURE-----

--2/5bycvrmDh4d1IB--
