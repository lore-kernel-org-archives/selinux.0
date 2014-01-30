Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0UIY3Q5007648
 for <selinux@tycho.nsa.gov>; Thu, 30 Jan 2014 13:34:03 -0500
Received: from localhost ([31.19.15.133]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Meduu-1VtaNL40lM-00OHx9 for <selinux@tycho.nsa.gov>;
 Thu, 30 Jan 2014 19:34:00 +0100
Date: Thu, 30 Jan 2014 19:33:44 +0100
From: Ole Kliemann <ole@plastictree.net>
To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: Strange context on unix_stream_socket
Message-ID: <20140130183344.GA2563@telmora.telvanni>
References: <20140125205944.GB2542@telmora.telvanni>
 <20140126122922.GA2837@telmora.telvanni>
 <20140126224640.GE2837@telmora.telvanni>
 <52E68747.5020006@tycho.nsa.gov>
 <20140128171259.GC2501@telmora.telvanni>
 <52E7E74E.7020901@tycho.nsa.gov>
 <1391094621.17775.YahooMailNeo@web87901.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
In-Reply-To: <1391094621.17775.YahooMailNeo@web87901.mail.ir2.yahoo.com>
Sender: telvanni@gmx.net
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2014 at 03:10:21PM +0000, Richard Haines wrote:
> Out of idle curiosity would a range_transition rule resolve this problem ?
>=20
> range_transition source target : unix_stream_socket s0;

It wouldn't help as the current labeling behavior is a function=20
of types _and ranges_ while range_transition is merely a function=20
of types. As far as I can see the current behavior cannot be=20
expressed with current policy language.

>=20
>=20
>=20
> ----- Original Message -----
> > From: Stephen Smalley <sds@tycho.nsa.gov>
> > To: Ole Kliemann <ole@plastictree.net>
> > Cc: selinux@tycho.nsa.gov
> > Sent: Tuesday, 28 January 2014, 17:22
> > Subject: Re: Strange context on unix_stream_socket
> >=20
> > On 01/28/2014 12:12 PM, Ole Kliemann wrote:
> >>  On Mon, Jan 27, 2014 at 11:20:23AM -0500, Stephen Smalley wrote:
> >>>  On 01/26/2014 05:46 PM, Ole Kliemann wrote:
> >>>>  I have written my own little socket test program. Process P1 with=
=20
> >>>>  context TYPE1:RANGE1 creates a socket and listens on it. P2 with=20
> >>>>  context TYPE2:RANGE2 connects to this socket.
> >>>>=20
> >>>>  Process P1 accepts the connection. The socket created throught=20
> >>>>  accept() in P1 has actually the context TYPE1:RANGE2.
> >>>>=20
> >>>>  Is this expected behavior?=20
> >>>=20
> >>>  Yes.=A0 That was the behavior desired by the MLS/LSPP community, as =
they
> >>>  want the socket to mirror the client level for multi-level servers, =
and
> >>>  in the single-level server case, you are only allowed to connect at =
the
> >>>  same level.
> >>=20
> >>  Thank you for the clarification.
> >>=20
> >>  Is there no way to control this? To state more precisly: I can=20
> >>  very well _connect_ to everything the policy allows me to, I then=20
> >>  just cannot use this connection. That's a bit weird.
> >>=20
> >>  Although I admit, the problems arise from my specific situation=20
> >>  where I have one realm the consist of only one type but is=20
> >>  separated by MLS and another realm that is MLS-ignorant and uses=20
> >>  TE. All vectors running between the two realms are also only=20
> >>  controll by TE. When I now use sockets between the MLS and=20
> >>  non-MLS realm these connections should only be controlled by TE,
> >>  but as a result of above mentioned labeling behavior, MLS=20
> >>  suddenly gets in the way.
> >>=20
> >>  I can imagine, in an MLS-only environment this behavior makes=20
> >>  more sense; specificly in the case of multi-level servers. All=20
> >>  the more desirable it would be if the policy was to make such=20
> >>  labeling decisions at the discretion of the policy writer.
> >=20
> > Yes, in prior implementations we allowed it to be configurable as a
> > transition on the listening socket security context and the incoming
> > packet security context.=A0 That would be preferable IMHO, but is not
> > possible today without kernel code changes.
> >=20
> >=20
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to=20
> > Selinux-request@tycho.nsa.gov.
> >

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlLqmwcACgkQS1FjE303ERzhiwCfRMnT0d59TR/wEMf+ydFOy3wX
pNEAn0iGIkmR1THRYzFWdkLMIECWIgYO
=UCKL
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
