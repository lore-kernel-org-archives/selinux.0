Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0SHDPW7020840
 for <selinux@tycho.nsa.gov>; Tue, 28 Jan 2014 12:13:26 -0500
Received: from localhost ([31.19.15.133]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MRXSK-1Vju4P3Wvo-00SfSo for <selinux@tycho.nsa.gov>;
 Tue, 28 Jan 2014 18:13:22 +0100
Date: Tue, 28 Jan 2014 18:12:59 +0100
From: Ole Kliemann <ole@plastictree.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Strange context on unix_stream_socket
Message-ID: <20140128171259.GC2501@telmora.telvanni>
References: <20140125205944.GB2542@telmora.telvanni>
 <20140126122922.GA2837@telmora.telvanni>
 <20140126224640.GE2837@telmora.telvanni>
 <52E68747.5020006@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
In-Reply-To: <52E68747.5020006@tycho.nsa.gov>
Sender: telvanni@gmx.net
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2014 at 11:20:23AM -0500, Stephen Smalley wrote:
> On 01/26/2014 05:46 PM, Ole Kliemann wrote:
> > I have written my own little socket test program. Process P1 with=20
> > context TYPE1:RANGE1 creates a socket and listens on it. P2 with=20
> > context TYPE2:RANGE2 connects to this socket.
> >=20
> > Process P1 accepts the connection. The socket created throught=20
> > accept() in P1 has actually the context TYPE1:RANGE2.
> >=20
> > Is this expected behavior?=20
>=20
> Yes.  That was the behavior desired by the MLS/LSPP community, as they
> want the socket to mirror the client level for multi-level servers, and
> in the single-level server case, you are only allowed to connect at the
> same level.

Thank you for the clarification.

Is there no way to control this? To state more precisly: I can=20
very well _connect_ to everything the policy allows me to, I then=20
just cannot use this connection. That's a bit weird.

Although I admit, the problems arise from my specific situation=20
where I have one realm the consist of only one type but is=20
separated by MLS and another realm that is MLS-ignorant and uses=20
TE. All vectors running between the two realms are also only=20
controll by TE. When I now use sockets between the MLS and=20
non-MLS realm these connections should only be controlled by TE,
but as a result of above mentioned labeling behavior, MLS=20
suddenly gets in the way.

I can imagine, in an MLS-only environment this behavior makes=20
more sense; specificly in the case of multi-level servers. All=20
the more desirable it would be if the policy was to make such=20
labeling decisions at the discretion of the policy writer.

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlLn5RsACgkQS1FjE303ERzL8QCdFg3Ecok9nWQHq03MwiM/wUmo
JY8Anj8n/jU7fPbtyd5N30pIyw4FR9TJ
=cqU7
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
