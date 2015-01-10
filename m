Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0AJFOs9013914
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 14:15:24 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so8044272wiv.1
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 11:15:21 -0800 (PST)
Received: from bigboy.network2 (84-245-31-108.dsl.cambrium.nl. [84.245.31.108])
 by mx.google.com with ESMTPSA id bj3sm3369207wib.3.2015.01.10.11.15.20
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Sat, 10 Jan 2015 11:15:20 -0800 (PST)
Date: Sat, 10 Jan 2015 20:15:18 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: RFC: https://bugzilla.redhat.com/show_bug.cgi?id=1174405
Message-ID: <20150110191517.GA30004@bigboy.network2>
References: <1420837553.31986.2.camel@gmail.com>
 <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
 <CAHZ_AjsxSJ3adY-UeMfik9xzOczk1411hk_ckSRPNbBOFSkwbA@mail.gmail.com>
 <14ad1cb43d8.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <1420883781.24061.22.camel@gmail.com>
 <CAB9W1A2Ro0mTqOwJOBL=9S9SaE0C_sXw3MUKpGP4L9VQObokYw@mail.gmail.com>
 <20150110171950.GA23358@bigboy.network2>
 <20150110174300.GA28262@bigboy.network2>
 <CAB9W1A1rLu_5XnMXqn0kbR0yhD-D39RmBTF12=1Kz320Hv5iEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
In-Reply-To: <CAB9W1A1rLu_5XnMXqn0kbR0yhD-D39RmBTF12=1Kz320Hv5iEA@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2015 at 01:54:01PM -0500, Stephen Smalley wrote:
> Well, I noted it in the technical reports I wrote originally for
> SELinux.  I guess it didn't get carried into documentation written by
> others, although it has been discussed on this list and the Fedora
> SELinux list various times.  Also, even if we were to implement such a
> check, we'd have to dontaudit it in most cases because the kernel
> would automatically be scanning the range for an available and allowed
> port, and various userspace libraries do exactly the same thing when
> trying to bind to an available port.  Which would render it a
> mysterious denial on random send/connect and bind calls.

You hinted that implementing a check for this could affect performance, and=
 so i am no longer in favor of that solution.

however i would like some of the tools to be aware of this issue.

for example if i do

sesearch -A -s sshd_t -t port_type -c tcp_socket -p name_bind

That it returns somehow that this access to ports in the local port range w=
ill be allowed. So that auditors see that it is allowed even though there i=
s no rule to allow it.
At least then they know there is something going on and can look for docume=
ntation about it.

The problem is how does one implement that in an informative way without re=
lying on customizable identifiers.

>=20
> On Sat, Jan 10, 2015 at 12:43 PM, Dominick Grift <dac.override@gmail.com>=
 wrote:
> > On Sat, Jan 10, 2015 at 06:19:51PM +0100, Dominick Grift wrote:
> >> On Sat, Jan 10, 2015 at 11:49:29AM -0500, Stephen Smalley wrote:
> >> > This behavior has a) always been present in SELinux, b) documented in
> >> > the original SELinux technical report and the LSM-based SELinux
> >> > technical report, and c) discussed plenty of times before.  So you're
> >> > free to disagree but it isn't new or hidden from view.  It was viewed
> >> > as logically inconsistent and not useful to impose a restriction upon
> >> > bind(2) to a port number in the local port range when such port
> >> > numbers have no security semantics and can be obtained by any process
> >> > that can create a socket just by connecting (TCP) or sending (UDP) on
> >> > that socket.  At that time, the ipv4 code will cheerfully assign an
> >> > available port number out of that local port range to the socket if =
it
> >> > is unbound.  If you truly want to control port numbers in that range,
> >> > it is not a mere matter of removing the exemption from the
> >> > selinux_socket_bind hook but also introducing a new LSM hook inside
> >> > the ipv4 code to keep trying until it finds a port number that is
> >> > allowed.  The potential overhead of applying such checking could be
> >> > non-trivial and would show up on connect() and sendto()/sendmsg()
> >> > calls.  You are free to submit a patch to do exactly that, with
> >> > performance measurements if you wish.
> >>
> >> I can live with this "logical inconsistency", and other "gotchas" but =
i would prefer that tools/libraries like sesearch would some how communicat=
e this.
> >> It may be documented, and discussed but besides a handful of kernel co=
ders and a few others, i bet not many are aware of this inconsistency, and =
other gotchas
> >> If the tools would some how show that there is a special case, then po=
licy authors would not be left totally in the dark but how would one implem=
ent that...
> >>
> >
> > There is a difference between not being hidden from view, and being pro=
minently visible. I prefer the latter in instances like these to avoid this=
 embarrassment.
> >
> >> >
> >> > On Sat, Jan 10, 2015 at 4:56 AM, Dominick Grift <dac.override@gmail.=
com> wrote:
> >> > > On Fri, 2015-01-09 at 22:02 -0500, Paul Moore wrote:
> >> > >> I think there is a point of clarification that may help put every=
one at
> >> > >> ease... SELinux provides two permissions relevant to socket bind()
> >> > >> operations, bind and name_bind. The name_bind operation controls =
the
> >> > >> socket's ability to bind to a specific port, while the bind opera=
tion
> >> > >> controls the ability of a domain to bind a socket.  Those of you =
who wish
> >> > >> to restrict a domain from performing a socket bind() operation, r=
egardless
> >> > >> of the port, would likely find your answer with the socket:bind p=
ermission.
> >> > >>
> >> > >
> >> > > Good to know but the socket bind access vector is checked on the d=
omain
> >> > > type and not on the port type
> >> > >
> >> > > Thus is you have a process with a requirement to bind a socket to =
a port
> >> > > < ephemeral, then it is automatically also able listen on ports >=
=3D
> >> > > ephemeral from an selinux pov
> >> > >
> >> > > Although this is good to know and in rare cases may be useful, it =
is in
> >> > > my view indeed still a consolation prize at best
> >> > >
> >> > >> --
> >> > >> paul moore
> >> > >> www.paul-moore.com
> >> > >>
> >> > >>
> >> > >>
> >> > >> On January 9, 2015 5:24:22 PM eric gisse <jowr.pi@gmail.com> wrot=
e:
> >> > >>
> >> > >> > I disagree.
> >> > >> >
> >> > >> > I've had to have technical discussions justifying my belief that
> >> > >> > certain common things should be available to all domains such as
> >> > >> > /dev/urandom and more recently /proc/sys/vm/overcommit_memory.
> >> > >> >
> >> > >> > Discussions around those reasonable defaults basically rotate a=
round
> >> > >> > the philsophical notion of least privilege.
> >> > >> >
> >> > >> > So seeing there's an entire swath of ports that programs can bi=
nd to
> >> > >> > by default is crazytalk and blows that notion out of the water.
> >> > >> >
> >> > >> > Further, it is bad policy.
> >> > >> >
> >> > >> > Consider sshd, or any other daemon that does nothing but bind t=
o a
> >> > >> > port and listen for connections.
> >> > >> >
> >> > >> > It does not need the ability to bind to to anything other than =
its'
> >> > >> > daemon port, not even epheremal ports. Yet it can, regardless of
> >> > >> > policy considerations. Which is the underlying point here.
> >> > >> >
> >> > >> > If someone gains access to a server through a compromised servi=
ce,
> >> > >> > they can bind a backdoor to that epheremal range or at least ex=
fil
> >> > >> > data.
> >> > >> >
> >> > >> > This is bad, bad, bad and rather surprising because until it was
> >> > >> > pointed out by this thread I would not have considered it possi=
ble due
> >> > >> > to the...vehemence... in which least privilege has been upheld.
> >> > >> >
> >> > >> >
> >> > >> >
> >> > >> >
> >> > >> > On Fri, Jan 9, 2015 at 3:52 PM, Stephen Smalley
> >> > >> > <stephen.smalley@gmail.com> wrote:
> >> > >> > > Ports in the local port range can be auto-assigned by the ker=
nel to
> >> > >> > > unbound sockets on first use.  So it makes no sense to contro=
l them,
> >> > >> > > and there isn't even an LSM hook in the place where such auto=
-port
> >> > >> > > selection occurs.  Controlling binding to ports is only usefu=
l when
> >> > >> > > the port number is a "name" (i.e. a well-defined value that is
> >> > >> > > expected to correspond to a specific service), to prevent spo=
ofing of
> >> > >> > > security-relevant services like sshd.
> >> > >> > >
> >> > >> > > On Fri, Jan 9, 2015 at 4:05 PM, Dominick Grift <dac.override@=
gmail.com>
> >> > >> > wrote:
> >> > >> > >> https://bugzilla.redhat.com/show_bug.cgi?id=3D1174405
> >> > >> > >>
> >> > >> > >> This is a inconsistency in SELinux
> >> > >> > >>
> >> > >> > >>
> >> > >> > >>
> >> > >> > >> _______________________________________________
> >> > >> > >> Selinux mailing list
> >> > >> > >> Selinux@tycho.nsa.gov
> >> > >> > >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >> > >> > >> To get help, send an email containing "help" to
> >> > >> > Selinux-request@tycho.nsa.gov.
> >> > >> > > _______________________________________________
> >> > >> > > Selinux mailing list
> >> > >> > > Selinux@tycho.nsa.gov
> >> > >> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >> > >> > > To get help, send an email containing "help" to
> >> > >> > Selinux-request@tycho.nsa.gov.
> >> > >> > _______________________________________________
> >> > >> > Selinux mailing list
> >> > >> > Selinux@tycho.nsa.gov
> >> > >> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >> > >> > To get help, send an email containing "help" to Selinux-request=
@tycho.nsa.gov.
> >> > >>
> >> > >>
> >> > >> _______________________________________________
> >> > >> Selinux mailing list
> >> > >> Selinux@tycho.nsa.gov
> >> > >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> >> > >> To get help, send an email containing "help" to Selinux-request@t=
ycho.nsa.gov.
> >> > >
> >> > >
> >>
> >> --
> >> Dominick Grift
> >
> >
> >
> > --
> > Dominick Grift
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
Dominick Grift

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUsXo/AAoJENAR6kfG5xmcZ5sMALcSzS3SWY3sImblGNpYAPkn
8LGIlruSwGiVmS5xxd2k0gsTZ4gxhFYEcRtn6FXhD5rhAMA/0+xTm/340MSHQW5+
C5vO+CCRYhuUFv9QU7IQ4OfZKz1awz+nj1ENnq4zui94Y4B4dYEUZRKS00R6RSg9
/WZrN5Csn7TdX4eVZvBx14wkHrsHrMa1ugm8o9/8CFUb905MbfQOSvBIdgkjFc9r
OkgQOHhS0roB9eRrljoqX0+OZi2ksPRm9L51oLOqP94N36Cz2fVDeKi9VenIi+52
9Qp9k9SzMWTRAqbXPs0t3C/pn9kQiFzhuwcJ8f7+ozGevvlc11o4g5k8TCaDCsrJ
N+uelDGErdmp3iPPadwQLjgArxHtvQU+milwKSwCxaJu7BuxaclGy4Hx7HrVO7Bh
M3D/mBRXFQ5LAdX18VI1W5BVnbDJae3eYHfU6f8QjAjmp3cFwkzRKLSCrRtl/OeK
qBeC1jKreLqSDSkrSgvjppge1AQBgiBfzXXVa0sYXg==
=XhjG
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
