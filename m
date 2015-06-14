Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5E5Xttc023770
 for <selinux@tycho.nsa.gov>; Sun, 14 Jun 2015 01:33:55 -0400
Received: by wgzl5 with SMTP id l5so21950125wgz.3
 for <selinux@tycho.nsa.gov>; Sat, 13 Jun 2015 22:33:53 -0700 (PDT)
Received: from localhost.localdomain (84-245-28-90.dsl.cambrium.nl.
 [84.245.28.90])
 by mx.google.com with ESMTPSA id u6sm13089590wja.40.2015.06.13.22.33.52
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 13 Jun 2015 22:33:52 -0700 (PDT)
Date: Sun, 14 Jun 2015 07:33:50 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] selinux: Remove unused permission definitions
Message-ID: <20150614053349.GA5191@localhost.localdomain>
References: <1432739005-1955-1-git-send-email-sds@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <1432739005-1955-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2015 at 11:03:25AM -0400, Stephen Smalley wrote:
> Remove unused permission definitions from SELinux.
> Many of these were only ever used in pre-mainline
> versions of SELinux, prior to Linux 2.6.0.  Some of them
> were used in the legacy network or compat_net=3D1 checks
> that were disabled by default in Linux 2.6.18 and
> fully removed in Linux 2.6.30.
>=20
> Permissions never used in mainline Linux:
> file swapon

I think that blk_file (fixed disk) swapon is actually used in my policy by =
fstools (i think swapon command)

> filesystem transition
> tcp_socket { connectto newconn acceptfrom }
> node enforce_dest
> unix_stream_socket { newconn acceptfrom }
>=20
> Legacy network checks, removed in 2.6.30:
> socket { recv_msg send_msg }
> node { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_rec=
v dccp_send }
> netif { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_re=
cv dccp_send }
>=20
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  security/selinux/include/classmap.h | 22 ++++++++--------------
>  1 file changed, 8 insertions(+), 14 deletions(-)
>=20
> diff --git a/security/selinux/include/classmap.h b/security/selinux/inclu=
de/classmap.h
> index 1d8b924..5a4eef5 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -2,12 +2,12 @@
>      "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append"
> =20
>  #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
> -    "rename", "execute", "swapon", "quotaon", "mounton", "audit_access",=
 \
> +    "rename", "execute", "quotaon", "mounton", "audit_access", \
>      "open", "execmod"
> =20
>  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
>      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
> -    "sendto", "recv_msg", "send_msg", "name_bind"
> +    "sendto", "name_bind"
> =20
>  #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr", "rea=
d", \
>  	    "write", "associate", "unix_read", "unix_write"
> @@ -44,7 +44,7 @@ struct security_class_mapping secclass_map[] =3D {
>  	    "audit_control", "setfcap", NULL } },
>  	{ "filesystem",
>  	  { "mount", "remount", "unmount", "getattr",
> -	    "relabelfrom", "relabelto", "transition", "associate", "quotamod",
> +	    "relabelfrom", "relabelto", "associate", "quotamod",
>  	    "quotaget", NULL } },
>  	{ "file",
>  	  { COMMON_FILE_PERMS,
> @@ -67,7 +67,7 @@ struct security_class_mapping secclass_map[] =3D {
>  	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "tcp_socket",
>  	  { COMMON_SOCK_PERMS,
> -	    "connectto", "newconn", "acceptfrom", "node_bind", "name_connect",
> +	    "node_bind", "name_connect",
>  	    NULL } },
>  	{ "udp_socket",
>  	  { COMMON_SOCK_PERMS,
> @@ -76,13 +76,9 @@ struct security_class_mapping secclass_map[] =3D {
>  	  { COMMON_SOCK_PERMS,
>  	    "node_bind", NULL } },
>  	{ "node",
> -	  { "tcp_recv", "tcp_send", "udp_recv", "udp_send",
> -	    "rawip_recv", "rawip_send", "enforce_dest",
> -	    "dccp_recv", "dccp_send", "recvfrom", "sendto", NULL } },
> +	  { "recvfrom", "sendto", NULL } },
>  	{ "netif",
> -	  {  "tcp_recv", "tcp_send", "udp_recv", "udp_send",
> -	     "rawip_recv", "rawip_send", "dccp_recv", "dccp_send",
> -	     "ingress", "egress", NULL } },
> +	  { "ingress", "egress", NULL } },
>  	{ "netlink_socket",
>  	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "packet_socket",
> @@ -90,11 +86,9 @@ struct security_class_mapping secclass_map[] =3D {
>  	{ "key_socket",
>  	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "unix_stream_socket",
> -	  { COMMON_SOCK_PERMS, "connectto", "newconn", "acceptfrom", NULL
> -	  } },
> +	  { COMMON_SOCK_PERMS, "connectto", NULL } },
>  	{ "unix_dgram_socket",
> -	  { COMMON_SOCK_PERMS, NULL
> -	  } },
> +	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "sem",
>  	  { COMMON_IPC_PERMS, NULL } },
>  	{ "msg", { "send", "receive", NULL } },
> --=20
> 2.1.0
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

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVfRI5AAoJENAR6kfG5xmc8PQMALtK0pqUPbBgwepc2JUuNrmN
XY4FmTa0Q9/CntugyQz/SMEhRNwT+gdRd26o2+8EJxUr/tx8HmzO3GbYg3L76HDC
lfTg6IAuQ0C2Ys3EThTRrZDHgXLMvUWIscUPFhMVV8hNc86X9qcTpTYNGawIsfea
uD52LDmEDHSebNj7H/DKh+DQtLEIElk1fSxOegWejzST0flJn15hR1ymjgGUAyuu
dlnlet8W6hdD6MRs6GOGTfxh9V9t8I0QDo2WxaAzs3/J6ShFayfyKNe1Njan2u2E
NRUOXPrn+e69sYdo6BZ4s+ayE2Ac0yOZaOJuAm5az1SOj6TMgli5Q1v/g7ZTMYtr
p2M4Px3AmvTOWqnkbLEuFSMA4GBMq46S9GcZ5HVazF0usmK7/GFUrEBL+J15VC41
MCEE5xQG9Y8/qsIi3LdHUAG55Zjl9ry9dk1iAjF4p+Ncc5vM27jTy7X3HNLJhj5l
9nuEQnrp6+jKuKn02pJtgeablC4+5xifnsElkmP8FQ==
=Nmnd
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
