Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5EFonBD022130
 for <selinux@tycho.nsa.gov>; Sun, 14 Jun 2015 11:50:49 -0400
Received: by wibdq8 with SMTP id dq8so55316546wib.1
 for <selinux@tycho.nsa.gov>; Sun, 14 Jun 2015 08:50:45 -0700 (PDT)
Received: from localhost.localdomain (84-245-28-90.dsl.cambrium.nl.
 [84.245.28.90])
 by mx.google.com with ESMTPSA id k2sm11837429wif.3.2015.06.14.08.50.44
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Jun 2015 08:50:44 -0700 (PDT)
Date: Sun, 14 Jun 2015 17:50:43 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] selinux: Remove unused permission definitions
Message-ID: <20150614155042.GB5191@localhost.localdomain>
References: <1432739005-1955-1-git-send-email-sds@tycho.nsa.gov>
 <20150614053349.GA5191@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
In-Reply-To: <20150614053349.GA5191@localhost.localdomain>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 14, 2015 at 07:33:49AM +0200, Dominick Grift wrote:
> On Wed, May 27, 2015 at 11:03:25AM -0400, Stephen Smalley wrote:
> > Remove unused permission definitions from SELinux.
> > Many of these were only ever used in pre-mainline
> > versions of SELinux, prior to Linux 2.6.0.  Some of them
> > were used in the legacy network or compat_net=3D1 checks
> > that were disabled by default in Linux 2.6.18 and
> > fully removed in Linux 2.6.30.
> >=20
> > Permissions never used in mainline Linux:
> > file swapon
>=20
> I think that blk_file (fixed disk) swapon is actually used in my policy b=
y fstools (i think swapon command)

Nah, Probably added to my policy by assumption (Sometimes i just can't resi=
st the temptation to assume..)

We'll see .. i won't be removing these permissions from my policy until Fed=
ora 23 (Kernel 4.2) at the least anyway's

>=20
> > filesystem transition
> > tcp_socket { connectto newconn acceptfrom }
> > node enforce_dest
> > unix_stream_socket { newconn acceptfrom }
> >=20
> > Legacy network checks, removed in 2.6.30:
> > socket { recv_msg send_msg }
> > node { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_r=
ecv dccp_send }
> > netif { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_=
recv dccp_send }
> >=20
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  security/selinux/include/classmap.h | 22 ++++++++--------------
> >  1 file changed, 8 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 1d8b924..5a4eef5 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -2,12 +2,12 @@
> >      "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append"
> > =20
> >  #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
> > -    "rename", "execute", "swapon", "quotaon", "mounton", "audit_access=
", \
> > +    "rename", "execute", "quotaon", "mounton", "audit_access", \
> >      "open", "execmod"
> > =20
> >  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
> >      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
> > -    "sendto", "recv_msg", "send_msg", "name_bind"
> > +    "sendto", "name_bind"
> > =20
> >  #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr", "r=
ead", \
> >  	    "write", "associate", "unix_read", "unix_write"
> > @@ -44,7 +44,7 @@ struct security_class_mapping secclass_map[] =3D {
> >  	    "audit_control", "setfcap", NULL } },
> >  	{ "filesystem",
> >  	  { "mount", "remount", "unmount", "getattr",
> > -	    "relabelfrom", "relabelto", "transition", "associate", "quotamod",
> > +	    "relabelfrom", "relabelto", "associate", "quotamod",
> >  	    "quotaget", NULL } },
> >  	{ "file",
> >  	  { COMMON_FILE_PERMS,
> > @@ -67,7 +67,7 @@ struct security_class_mapping secclass_map[] =3D {
> >  	  { COMMON_SOCK_PERMS, NULL } },
> >  	{ "tcp_socket",
> >  	  { COMMON_SOCK_PERMS,
> > -	    "connectto", "newconn", "acceptfrom", "node_bind", "name_connect",
> > +	    "node_bind", "name_connect",
> >  	    NULL } },
> >  	{ "udp_socket",
> >  	  { COMMON_SOCK_PERMS,
> > @@ -76,13 +76,9 @@ struct security_class_mapping secclass_map[] =3D {
> >  	  { COMMON_SOCK_PERMS,
> >  	    "node_bind", NULL } },
> >  	{ "node",
> > -	  { "tcp_recv", "tcp_send", "udp_recv", "udp_send",
> > -	    "rawip_recv", "rawip_send", "enforce_dest",
> > -	    "dccp_recv", "dccp_send", "recvfrom", "sendto", NULL } },
> > +	  { "recvfrom", "sendto", NULL } },
> >  	{ "netif",
> > -	  {  "tcp_recv", "tcp_send", "udp_recv", "udp_send",
> > -	     "rawip_recv", "rawip_send", "dccp_recv", "dccp_send",
> > -	     "ingress", "egress", NULL } },
> > +	  { "ingress", "egress", NULL } },
> >  	{ "netlink_socket",
> >  	  { COMMON_SOCK_PERMS, NULL } },
> >  	{ "packet_socket",
> > @@ -90,11 +86,9 @@ struct security_class_mapping secclass_map[] =3D {
> >  	{ "key_socket",
> >  	  { COMMON_SOCK_PERMS, NULL } },
> >  	{ "unix_stream_socket",
> > -	  { COMMON_SOCK_PERMS, "connectto", "newconn", "acceptfrom", NULL
> > -	  } },
> > +	  { COMMON_SOCK_PERMS, "connectto", NULL } },
> >  	{ "unix_dgram_socket",
> > -	  { COMMON_SOCK_PERMS, NULL
> > -	  } },
> > +	  { COMMON_SOCK_PERMS, NULL } },
> >  	{ "sem",
> >  	  { COMMON_IPC_PERMS, NULL } },
> >  	{ "msg", { "send", "receive", NULL } },
> > --=20
> > 2.1.0
> >=20
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
>=20
> --=20
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
> Dominick Grift



--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVfaLOAAoJENAR6kfG5xmc1rYL/jyHJZEGNPwbicCFF8e0qGUy
Fx1Rs2ILiqCXmXv/dUUIQfo9gS/RkYTKLM2YBs0/B5lv10wPYycNwNzA37Kfs5Wi
IvjRr+gsK5LC65DPID5+Ho9W6AVwgcuRUteDJEqWz2BRxBKbl9jMUyshMLjmSoAt
0fzSiqLZ7yXo8K7H0LUaITUjVSL9Jn+4wBIhjnzlUr59zbp5gzsTzkRoEMZRAAqG
E3npmx4RyQ5GTfUltNl+QE8pPvn4EOb0FKgZRzZDKffdgeD7zCiI7j03pjn6mYmP
JTM/b6RTaCAszno/EYwGsZBSA5PBiIropJd8FwHhB3BMNh43iPZfh0jf8YeSnVW1
GQJkAti1Zmby5vo50sxEiteJgeqc4yVmsZWOGfDEuunCnBANsVc3/kwdUr0gBoPm
Mr7C++FEurmC8gStT2jPb1O+E7QPrknRxIksBUaOFumxjkNQz+mOyUrxl9lYQ1h9
EF7R5JojNawoWURxqRpIGwFw9sOpwcudxAs8fUDFGg==
=F6mq
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
