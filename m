Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0QCTdD9005313
 for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2014 07:29:39 -0500
Received: from localhost ([127.0.0.1])
 by l4ms.rz.uni-kiel.de with esmtp (Exim 4.80.1)
 (envelope-from <kliemann@philsem.uni-kiel.de>) id 1W7OqF-0005eg-LY
 for selinux@tycho.nsa.gov; Sun, 26 Jan 2014 13:29:35 +0100
Date: Sun, 26 Jan 2014 13:29:22 +0100
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: Re: Strange context on unix_stream_socket
Message-ID: <20140126122922.GA2837@telmora.telvanni>
References: <20140125205944.GB2542@telmora.telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
In-Reply-To: <20140125205944.GB2542@telmora.telvanni>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2014 at 09:59:44PM +0100, Ole Kliemann wrote:
> I'm having an odd problem:
>=20
> I am running my own MCS constrainted policy on Ubuntu 12.04. At=20
> some point I have a process with context=20
>=20
>     sub_t:s0:c20-s0:c20.c29
>=20
> From this process I try to access a jack daemon with mplayer. For=20
> this purpose unix stream sockets are being used. I then get an=20
> avc denial saying that
>=20
>     process sub_t:s0:c20-s0:c20.c29
>=20
> tried to access=20
>=20
>     unix_stream_socket sub_t:s0
>=20
> which is prohibited by mcs constrain. The socket is on sockfs and=20
> has no file associated with it.
>=20
> The problem is that under no circumstances the policy allows the=20
> creation of anything with 'sub_t:s0'.=20
>=20
> Using an auditallow rule like
>=20
>     auditallow any_type sub_t:unix_stream_socket { create relabelto relab=
elfrom };
>=20
> clearly shows that indeed no socket with a context like that is=20
> created nor relabel to.  And yet it exists.

With strace and GDB I managed to find out this much:

mplayer open several sockets and listens on at least one of them.=20
All these sockets have correct context. I determined the context=20
using

    'stat -L /proc/PID/fd/FD'

I hope that is a valid method.

It then accept a connection on a listening socket, probably=20
coming from the jack daemon. As we know, the system call=20
accepting a connection on a socket returns a new socket itself.=20
At the point the system call returns, this new socket is found in=20
/proc/PID/fd/ and has the offending context.

Now I don't know much about these sockets. Process A listens on=20
socket S0 and accepts the connection of process B. A new socket=20
S1 appears. Who, in terms of policy, is the creating process for=20
socket S1? How does the kernel determine the context of such a=20
socket?

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlLk/6IACgkQS1FjE303ERyYFgCfQtn3gH2CKcrAZulAOF4Qgv+g
gIAAn1rcnaHYYMmUeyDYJmeh41dOHJSO
=KyVx
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
