Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0PKxs5f006615
 for <selinux@tycho.nsa.gov>; Sat, 25 Jan 2014 15:59:55 -0500
Received: from localhost ([127.0.0.1])
 by l4ms.rz.uni-kiel.de with esmtp (Exim 4.80.1)
 (envelope-from <kliemann@philsem.uni-kiel.de>) id 1W7AKV-00054f-Tn
 for selinux@tycho.nsa.gov; Sat, 25 Jan 2014 21:59:51 +0100
Date: Sat, 25 Jan 2014 21:59:44 +0100
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: Strange context on unix_stream_socket
Message-ID: <20140125205944.GB2542@telmora.telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm having an odd problem:

I am running my own MCS constrainted policy on Ubuntu 12.04. At=20
some point I have a process with context=20

    sub_t:s0:c20-s0:c20.c29

=46rom this process I try to access a jack daemon with mplayer. For=20
this purpose unix stream sockets are being used. I then get an=20
avc denial saying that

    process sub_t:s0:c20-s0:c20.c29

tried to access=20

    unix_stream_socket sub_t:s0

which is prohibited by mcs constrain. The socket is on sockfs and=20
has no file associated with it.

The problem is that under no circumstances the policy allows the=20
creation of anything with 'sub_t:s0'.=20

Using an auditallow rule like

    auditallow any_type sub_t:unix_stream_socket { create relabelto relabel=
=66rom };

clearly shows that indeed no socket with a context like that is=20
created nor relabel to.  And yet it exists.


I'd highly appreciate any hint on this matter. Including how to=20
debug further. How can I display the security context of a socket=20
on sockfs?=20

Best regards
Ole

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlLkJcAACgkQS1FjE303ERxU5wCfV7TD0wj2Ftrngpp1sMHg6zpf
vHYAnjvfz82m7GUOeG4Eq+grjjtdp2hu
=f6lF
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
