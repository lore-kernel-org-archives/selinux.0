Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t4TLcaN5023448
 for <selinux@tycho.nsa.gov>; Fri, 29 May 2015 17:38:36 -0400
Received: by wifw1 with SMTP id w1so39346946wif.0
 for <selinux@tycho.nsa.gov>; Fri, 29 May 2015 14:38:34 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id o5sm5486890wia.0.2015.05.29.14.38.32
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 29 May 2015 14:38:33 -0700 (PDT)
Date: Fri, 29 May 2015 23:38:31 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC][PATCH] selinux: Remove unused permission definitions
Message-ID: <20150529213830.GA23540@x131e>
References: <1432739005-1955-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhRs+qZgKsU7t+bnBQUf+A6=wYev-KP1hoViOvLDZcaf+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
In-Reply-To: <CAHC9VhRs+qZgKsU7t+bnBQUf+A6=wYev-KP1hoViOvLDZcaf+Q@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 05:14:53PM -0400, Paul Moore wrote:
> On Wed, May 27, 2015 at 11:03 AM, Stephen Smalley <sds@tycho.nsa.gov> wro=
te:
> > Remove unused permission definitions from SELinux.
> > Many of these were only ever used in pre-mainline
> > versions of SELinux, prior to Linux 2.6.0.  Some of them
> > were used in the legacy network or compat_net=3D1 checks
> > that were disabled by default in Linux 2.6.18 and
> > fully removed in Linux 2.6.30.
> >
> > Permissions never used in mainline Linux:
> > file swapon
> > filesystem transition
> > tcp_socket { connectto newconn acceptfrom }
> > node enforce_dest
> > unix_stream_socket { newconn acceptfrom }
> >
> > Legacy network checks, removed in 2.6.30:
> > socket { recv_msg send_msg }
> > node { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_r=
ecv dccp_send }
> > netif { tcp_recv tcp_send udp_recv udp_send rawip_recv rawip_send dccp_=
recv dccp_send }
> >
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  security/selinux/include/classmap.h | 22 ++++++++--------------
> >  1 file changed, 8 insertions(+), 14 deletions(-)
>=20
> Seems very reasonable to me.  Chris, any objections from a policy point o=
f view?

I do not mean to reply on Chris' behalf but in light of what he said earlie=
r:

"The short answer is that I'd prefer to remove policy known to be unusable."

I just want to mention that i like the idea of losing some dead weight wher=
e it makes sense as well.

>=20
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/inc=
lude/classmap.h
> > index 1d8b924..5a4eef5 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -2,12 +2,12 @@
> >      "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append"
> >
> >  #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link", \
> > -    "rename", "execute", "swapon", "quotaon", "mounton", "audit_access=
", \
> > +    "rename", "execute", "quotaon", "mounton", "audit_access", \
> >      "open", "execmod"
> >
> >  #define COMMON_SOCK_PERMS COMMON_FILE_SOCK_PERMS, "bind", "connect", \
> >      "listen", "accept", "getopt", "setopt", "shutdown", "recvfrom",  \
> > -    "sendto", "recv_msg", "send_msg", "name_bind"
> > +    "sendto", "name_bind"
> >
> >  #define COMMON_IPC_PERMS "create", "destroy", "getattr", "setattr", "r=
ead", \
> >             "write", "associate", "unix_read", "unix_write"
> > @@ -44,7 +44,7 @@ struct security_class_mapping secclass_map[] =3D {
> >             "audit_control", "setfcap", NULL } },
> >         { "filesystem",
> >           { "mount", "remount", "unmount", "getattr",
> > -           "relabelfrom", "relabelto", "transition", "associate", "quo=
tamod",
> > +           "relabelfrom", "relabelto", "associate", "quotamod",
> >             "quotaget", NULL } },
> >         { "file",
> >           { COMMON_FILE_PERMS,
> > @@ -67,7 +67,7 @@ struct security_class_mapping secclass_map[] =3D {
> >           { COMMON_SOCK_PERMS, NULL } },
> >         { "tcp_socket",
> >           { COMMON_SOCK_PERMS,
> > -           "connectto", "newconn", "acceptfrom", "node_bind", "name_co=
nnect",
> > +           "node_bind", "name_connect",
> >             NULL } },
> >         { "udp_socket",
> >           { COMMON_SOCK_PERMS,
> > @@ -76,13 +76,9 @@ struct security_class_mapping secclass_map[] =3D {
> >           { COMMON_SOCK_PERMS,
> >             "node_bind", NULL } },
> >         { "node",
> > -         { "tcp_recv", "tcp_send", "udp_recv", "udp_send",
> > -           "rawip_recv", "rawip_send", "enforce_dest",
> > -           "dccp_recv", "dccp_send", "recvfrom", "sendto", NULL } },
> > +         { "recvfrom", "sendto", NULL } },
> >         { "netif",
> > -         {  "tcp_recv", "tcp_send", "udp_recv", "udp_send",
> > -            "rawip_recv", "rawip_send", "dccp_recv", "dccp_send",
> > -            "ingress", "egress", NULL } },
> > +         { "ingress", "egress", NULL } },
> >         { "netlink_socket",
> >           { COMMON_SOCK_PERMS, NULL } },
> >         { "packet_socket",
> > @@ -90,11 +86,9 @@ struct security_class_mapping secclass_map[] =3D {
> >         { "key_socket",
> >           { COMMON_SOCK_PERMS, NULL } },
> >         { "unix_stream_socket",
> > -         { COMMON_SOCK_PERMS, "connectto", "newconn", "acceptfrom", NU=
LL
> > -         } },
> > +         { COMMON_SOCK_PERMS, "connectto", NULL } },
> >         { "unix_dgram_socket",
> > -         { COMMON_SOCK_PERMS, NULL
> > -         } },
> > +         { COMMON_SOCK_PERMS, NULL } },
> >         { "sem",
> >           { COMMON_IPC_PERMS, NULL } },
> >         { "msg", { "send", "receive", NULL } },
> > --
> > 2.1.0
> >
>=20
>=20
>=20
> --=20
> paul moore
> www.paul-moore.com
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

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVaNxRAAoJENAR6kfG5xmc2O4L/iN3dvJ3qSlwM6OCa2gRl8+N
N8qPqLyJXCt6Oq3AaDKQe2OTA3ivDoH8MdnYMXkLILMkl/D8Pq4cUBUUyEqqpfTD
ZcDf3v10SwookSx6J7Qbdv+DjOG1xx/VzBwMGAbK5XTtyFnnuF8LhqO9ReSTyaUB
jEugcgA96iT7/qGJIW4dDzLHIejFUsxJNAVgGrhBMMhjSJymsT8eqZFaUzdNMzVV
hBigpm5SgWivb051yizM4LiJzJnfx41jANLxdfU2p9JZxAFnVGInk2r2sIeW/Kb6
5xsvwvrXMJyr3oepX/UDDT4EoOV5hUBqFMbzoFG5+DaJEuSCt03ik418Hc4Z4l2E
/DLYwH15v65vE3+M/UgJE/dpREhdHuTZXoaNfvfJ/o77sQCnSvWIfMC+cJflpDZA
QVIXj47YRLu4e0pwri3iXNeTZ6aDVMZZnG05KKaipVrWnJiv5GV59+gzzPIHZRWe
cApP742gQYt8pPuQilhKTHCmMpejD1ED4xxooJRCnw==
=9I3U
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
