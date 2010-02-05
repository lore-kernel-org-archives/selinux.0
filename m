Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o15JSN9X009619
	for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2010 14:28:23 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o15JSSdW005018
	for <selinux@tycho.nsa.gov>; Fri, 5 Feb 2010 19:28:29 GMT
Date: Fri, 5 Feb 2010 20:28:07 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov, Paul Moore <paul.moore@hp.com>
Subject: Re: MLS and network
Message-ID: <20100205192806.GP1750@myhost.felk.cvut.cz>
References: <20100204174901.GL1750@myhost.felk.cvut.cz>
 <1265306980.22595.7.camel@moss-pluto.epoch.ncsc.mil>
 <20100205051921.GM1750@myhost.felk.cvut.cz>
 <1265378086.18100.33.camel@moss-pluto.epoch.ncsc.mil>
 <20100205160720.GN1750@myhost.felk.cvut.cz>
 <1265388590.18100.73.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6tPipYVl+OcoAvSh"
In-Reply-To: <1265388590.18100.73.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--6tPipYVl+OcoAvSh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen Smalley wrote:
> tcp_socket write, read, and connect are checks between the process
> security context and the (local) socket security context.
> name_connect is between the process' context and the port context.
> None of those are per-packet checks.

OK, just to be sure I understand: the local socket's context is copied
=66rom its owning process?

> At the risk of flooding your audit log, you might add the following
> policy module to see all grantings of egress permission:

No problem, it's a VM, we can do anything.=20

type=3DUSER_ROLE_CHANGE msg=3Daudit(1265396934.824:46): user pid=3D1061
uid=3D500 auid=3D500 ses=3D3 subj=3Duser_u:user_r:newrole_t:s0-s1 msg=3D'ne=
wrole:
old-context=3Duser_u:user_r:user_t:s0-s1
new-context=3Duser_u:user_r:user_t:s1-s1: exe=3D"/usr/bin/newrole"
hostname=3D? addr=3D? terminal=3D/dev/tty2 res=3Dsuccess'

type=3DAVC msg=3Daudit(1265396951.168:47): avc:  granted  { egress } for
pid=3D1088 comm=3D"ftp" saddr=3D10.0.2.15 src=3D53060 daddr=3D147.32.127.222
dest=3D21 netif=3Deth0 scontext=3Duser_u:user_r:user_t:s1
tcontext=3Dsystem_u:object_r:netif_t:s0-s15:c0.c1023 tclass=3Dnetif

type=3DAVC msg=3Daudit(1265396951.171:48): avc:  denied  { ingress } for
saddr=3D147.32.127.222 src=3D21 daddr=3D10.0.2.15 dest=3D53060 netif=3Deth0
scontext=3Dsystem_u:object_r:netlabel_peer_t:s0
tcontext=3Dsystem_u:object_r:netif_t:s0-s15:c0.c1023 tclass=3Dnetif

I'm kinda puzzled as of what's going on. For the egress operation the
user process is writing to the interface, but that has s0-s15. So maybe
I need to semanage the interface? But why is the default so wide, how
can I semanage all interfaces? I can't see a _default_ one...

When I do it, I get a denied egress, but only as long as I have the
netlabelctl in place. Why isn't labeling the interface sufficient? The
netlabel type is not mentioned in the egress message at all...


Michal Svoboda

--6tPipYVl+OcoAvSh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktscUYACgkQg/fU9pp1uX56ngCgpiY7HC/3DY/0PMKAn6kM7BSP
R+AAn2QK2HWhqR0tZ+us0C4RioukD4k9
=4sB1
-----END PGP SIGNATURE-----

--6tPipYVl+OcoAvSh--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
