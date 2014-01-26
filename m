Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0QMl5hS025579
 for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2014 17:47:05 -0500
Received: from localhost ([127.0.0.1])
 by l4ms.rz.uni-kiel.de with esmtp (Exim 4.80.1)
 (envelope-from <kliemann@philsem.uni-kiel.de>) id 1W7YTm-0005Ww-FS
 for selinux@tycho.nsa.gov; Sun, 26 Jan 2014 23:47:02 +0100
Date: Sun, 26 Jan 2014 23:46:40 +0100
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: Re: Strange context on unix_stream_socket
Message-ID: <20140126224640.GE2837@telmora.telvanni>
References: <20140125205944.GB2542@telmora.telvanni>
 <20140126122922.GA2837@telmora.telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
In-Reply-To: <20140126122922.GA2837@telmora.telvanni>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 26, 2014 at 01:29:22PM +0100, Ole Kliemann wrote:
> On Sat, Jan 25, 2014 at 09:59:44PM +0100, Ole Kliemann wrote:
> > I'm having an odd problem:
> >=20
> > I am running my own MCS constrainted policy on Ubuntu 12.04. At=20
> > some point I have a process with context=20
> >=20
> >     sub_t:s0:c20-s0:c20.c29
> >=20
> > From this process I try to access a jack daemon with mplayer. For=20
> > this purpose unix stream sockets are being used. I then get an=20
> > avc denial saying that
> >=20
> >     process sub_t:s0:c20-s0:c20.c29
> >=20
> > tried to access=20
> >=20
> >     unix_stream_socket sub_t:s0
> >=20
> > which is prohibited by mcs constrain. The socket is on sockfs and=20
> > has no file associated with it.
> >=20
> > The problem is that under no circumstances the policy allows the=20
> > creation of anything with 'sub_t:s0'.=20
> >=20
> > Using an auditallow rule like
> >=20
> >     auditallow any_type sub_t:unix_stream_socket { create relabelto rel=
abelfrom };
> >=20
> > clearly shows that indeed no socket with a context like that is=20
> > created nor relabel to.  And yet it exists.
>=20
> With strace and GDB I managed to find out this much:
>=20
> mplayer open several sockets and listens on at least one of them.=20
> All these sockets have correct context. I determined the context=20
> using
>=20
>     'stat -L /proc/PID/fd/FD'
>=20
> I hope that is a valid method.
>=20
> It then accept a connection on a listening socket, probably=20
> coming from the jack daemon. As we know, the system call=20
> accepting a connection on a socket returns a new socket itself.=20
> At the point the system call returns, this new socket is found in=20
> /proc/PID/fd/ and has the offending context.
>=20
> Now I don't know much about these sockets. Process A listens on=20
> socket S0 and accepts the connection of process B. A new socket=20
> S1 appears. Who, in terms of policy, is the creating process for=20
> socket S1? How does the kernel determine the context of such a=20
> socket?

I have written my own little socket test program. Process P1 with=20
context TYPE1:RANGE1 creates a socket and listens on it. P2 with=20
context TYPE2:RANGE2 connects to this socket.

Process P1 accepts the connection. The socket created throught=20
accept() in P1 has actually the context TYPE1:RANGE2.

Is this expected behavior?=20

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlLlkFAACgkQS1FjE303ERy4MwCbBXnxX3aW3oYfIcJ2CVP8NL2L
NVkAn3Zoq4Samm/is8UL3RLbUnJoYPuC
=KeuQ
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
