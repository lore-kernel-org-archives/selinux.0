Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0AHh6dO008444
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 12:43:06 -0500
Received: by mail-wg0-f53.google.com with SMTP id x13so13031752wgg.12
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 09:43:03 -0800 (PST)
Received: from bigboy.network2 (84-245-31-108.dsl.cambrium.nl. [84.245.31.108])
 by mx.google.com with ESMTPSA id uq1sm14484145wjc.14.2015.01.10.09.43.02
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sat, 10 Jan 2015 09:43:02 -0800 (PST)
Date: Sat, 10 Jan 2015 18:43:00 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: RFC: https://bugzilla.redhat.com/show_bug.cgi?id=1174405
Message-ID: <20150110174300.GA28262@bigboy.network2>
References: <1420837553.31986.2.camel@gmail.com>
 <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
 <CAHZ_AjsxSJ3adY-UeMfik9xzOczk1411hk_ckSRPNbBOFSkwbA@mail.gmail.com>
 <14ad1cb43d8.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <1420883781.24061.22.camel@gmail.com>
 <CAB9W1A2Ro0mTqOwJOBL=9S9SaE0C_sXw3MUKpGP4L9VQObokYw@mail.gmail.com>
 <20150110171950.GA23358@bigboy.network2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <20150110171950.GA23358@bigboy.network2>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2015 at 06:19:51PM +0100, Dominick Grift wrote:
> On Sat, Jan 10, 2015 at 11:49:29AM -0500, Stephen Smalley wrote:
> > This behavior has a) always been present in SELinux, b) documented in
> > the original SELinux technical report and the LSM-based SELinux
> > technical report, and c) discussed plenty of times before.  So you're
> > free to disagree but it isn't new or hidden from view.  It was viewed
> > as logically inconsistent and not useful to impose a restriction upon
> > bind(2) to a port number in the local port range when such port
> > numbers have no security semantics and can be obtained by any process
> > that can create a socket just by connecting (TCP) or sending (UDP) on
> > that socket.  At that time, the ipv4 code will cheerfully assign an
> > available port number out of that local port range to the socket if it
> > is unbound.  If you truly want to control port numbers in that range,
> > it is not a mere matter of removing the exemption from the
> > selinux_socket_bind hook but also introducing a new LSM hook inside
> > the ipv4 code to keep trying until it finds a port number that is
> > allowed.  The potential overhead of applying such checking could be
> > non-trivial and would show up on connect() and sendto()/sendmsg()
> > calls.  You are free to submit a patch to do exactly that, with
> > performance measurements if you wish.
>=20
> I can live with this "logical inconsistency", and other "gotchas" but i w=
ould prefer that tools/libraries like sesearch would some how communicate t=
his.
> It may be documented, and discussed but besides a handful of kernel coder=
s and a few others, i bet not many are aware of this inconsistency, and oth=
er gotchas
> If the tools would some how show that there is a special case, then polic=
y authors would not be left totally in the dark but how would one implement=
 that...
>=20

There is a difference between not being hidden from view, and being promine=
ntly visible. I prefer the latter in instances like these to avoid this emb=
arrassment.

> >=20
> > On Sat, Jan 10, 2015 at 4:56 AM, Dominick Grift <dac.override@gmail.com=
> wrote:
> > > On Fri, 2015-01-09 at 22:02 -0500, Paul Moore wrote:
> > >> I think there is a point of clarification that may help put everyone=
 at
> > >> ease... SELinux provides two permissions relevant to socket bind()
> > >> operations, bind and name_bind. The name_bind operation controls the
> > >> socket's ability to bind to a specific port, while the bind operation
> > >> controls the ability of a domain to bind a socket.  Those of you who=
 wish
> > >> to restrict a domain from performing a socket bind() operation, rega=
rdless
> > >> of the port, would likely find your answer with the socket:bind perm=
ission.
> > >>
> > >
> > > Good to know but the socket bind access vector is checked on the doma=
in
> > > type and not on the port type
> > >
> > > Thus is you have a process with a requirement to bind a socket to a p=
ort
> > > < ephemeral, then it is automatically also able listen on ports >=3D
> > > ephemeral from an selinux pov
> > >
> > > Although this is good to know and in rare cases may be useful, it is =
in
> > > my view indeed still a consolation prize at best
> > >
> > >> --
> > >> paul moore
> > >> www.paul-moore.com
> > >>
> > >>
> > >>
> > >> On January 9, 2015 5:24:22 PM eric gisse <jowr.pi@gmail.com> wrote:
> > >>
> > >> > I disagree.
> > >> >
> > >> > I've had to have technical discussions justifying my belief that
> > >> > certain common things should be available to all domains such as
> > >> > /dev/urandom and more recently /proc/sys/vm/overcommit_memory.
> > >> >
> > >> > Discussions around those reasonable defaults basically rotate arou=
nd
> > >> > the philsophical notion of least privilege.
> > >> >
> > >> > So seeing there's an entire swath of ports that programs can bind =
to
> > >> > by default is crazytalk and blows that notion out of the water.
> > >> >
> > >> > Further, it is bad policy.
> > >> >
> > >> > Consider sshd, or any other daemon that does nothing but bind to a
> > >> > port and listen for connections.
> > >> >
> > >> > It does not need the ability to bind to to anything other than its'
> > >> > daemon port, not even epheremal ports. Yet it can, regardless of
> > >> > policy considerations. Which is the underlying point here.
> > >> >
> > >> > If someone gains access to a server through a compromised service,
> > >> > they can bind a backdoor to that epheremal range or at least exfil
> > >> > data.
> > >> >
> > >> > This is bad, bad, bad and rather surprising because until it was
> > >> > pointed out by this thread I would not have considered it possible=
 due
> > >> > to the...vehemence... in which least privilege has been upheld.
> > >> >
> > >> >
> > >> >
> > >> >
> > >> > On Fri, Jan 9, 2015 at 3:52 PM, Stephen Smalley
> > >> > <stephen.smalley@gmail.com> wrote:
> > >> > > Ports in the local port range can be auto-assigned by the kernel=
 to
> > >> > > unbound sockets on first use.  So it makes no sense to control t=
hem,
> > >> > > and there isn't even an LSM hook in the place where such auto-po=
rt
> > >> > > selection occurs.  Controlling binding to ports is only useful w=
hen
> > >> > > the port number is a "name" (i.e. a well-defined value that is
> > >> > > expected to correspond to a specific service), to prevent spoofi=
ng of
> > >> > > security-relevant services like sshd.
> > >> > >
> > >> > > On Fri, Jan 9, 2015 at 4:05 PM, Dominick Grift <dac.override@gma=
il.com>
> > >> > wrote:
> > >> > >> https://bugzilla.redhat.com/show_bug.cgi?id=3D1174405
> > >> > >>
> > >> > >> This is a inconsistency in SELinux
> > >> > >>
> > >> > >>
> > >> > >>
> > >> > >> _______________________________________________
> > >> > >> Selinux mailing list
> > >> > >> Selinux@tycho.nsa.gov
> > >> > >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > >> > >> To get help, send an email containing "help" to
> > >> > Selinux-request@tycho.nsa.gov.
> > >> > > _______________________________________________
> > >> > > Selinux mailing list
> > >> > > Selinux@tycho.nsa.gov
> > >> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > >> > > To get help, send an email containing "help" to
> > >> > Selinux-request@tycho.nsa.gov.
> > >> > _______________________________________________
> > >> > Selinux mailing list
> > >> > Selinux@tycho.nsa.gov
> > >> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > >> > To get help, send an email containing "help" to Selinux-request@ty=
cho.nsa.gov.
> > >>
> > >>
> > >> _______________________________________________
> > >> Selinux mailing list
> > >> Selinux@tycho.nsa.gov
> > >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > >> To get help, send an email containing "help" to Selinux-request@tych=
o.nsa.gov.
> > >
> > >
>=20
> --=20
> Dominick Grift



--=20
Dominick Grift

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUsWSeAAoJENAR6kfG5xmcw38MAKug+s4hUcV8uhbc5oh8B0Cr
c4+7bYDjH2GO8xYcXyPiJAC8w3fpOjkwpTuRBw6T8gsKC6rcnBeeTF8YhWG5qNGK
b8Bh58OmhfxL4dzGjVAh7ma/T1NDIUyYSny60imjaEayX98Jzq5HlIpi2o1my6c1
inpOWh5w/Ts0J8GqEDTvfJ2nGZr2dtZvTRD7M0kw3gg/PZVuVn73IYY1CzNwikLG
OOiR1DWaQ/R6j4FiSLatfpHib+N05pD0fEyYPnMyxgiXw0IAw878EPreFclM7LJh
k20Mw6DaJR9e50ql7NV6o8HqJI3wS37cskwnDvbc2halF0JzRnlJBfGigH4TtWUw
3YXPNrzWGOjLwzZotNq3evXDQhqIXMHiFm1N0UyyHid/xwxFK8rohra65nHVQNx3
cu4UCm34hTqYq/Wg4dz6tSwsNAXZwpVXZufMZne/azflAmAJTNoQtVLE6LWOCzGJ
4jMzbGJCjCVR3JdKeByueiuhe+foFv2bs5QDxOPIcQ==
=HZLu
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
