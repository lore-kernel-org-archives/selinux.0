Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0AIs7Gw012365
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 13:54:07 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so7994413wiv.1
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 10:54:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150110174300.GA28262@bigboy.network2>
References: <1420837553.31986.2.camel@gmail.com>
 <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
 <CAHZ_AjsxSJ3adY-UeMfik9xzOczk1411hk_ckSRPNbBOFSkwbA@mail.gmail.com>
 <14ad1cb43d8.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
 <1420883781.24061.22.camel@gmail.com>
 <CAB9W1A2Ro0mTqOwJOBL=9S9SaE0C_sXw3MUKpGP4L9VQObokYw@mail.gmail.com>
 <20150110171950.GA23358@bigboy.network2>
 <20150110174300.GA28262@bigboy.network2>
Date: Sat, 10 Jan 2015 13:54:01 -0500
Message-ID: <CAB9W1A1rLu_5XnMXqn0kbR0yhD-D39RmBTF12=1Kz320Hv5iEA@mail.gmail.com>
Subject: Re: RFC: https://bugzilla.redhat.com/show_bug.cgi?id=1174405
From: Stephen Smalley <stephen.smalley@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Well, I noted it in the technical reports I wrote originally for
SELinux.  I guess it didn't get carried into documentation written by
others, although it has been discussed on this list and the Fedora
SELinux list various times.  Also, even if we were to implement such a
check, we'd have to dontaudit it in most cases because the kernel
would automatically be scanning the range for an available and allowed
port, and various userspace libraries do exactly the same thing when
trying to bind to an available port.  Which would render it a
mysterious denial on random send/connect and bind calls.

On Sat, Jan 10, 2015 at 12:43 PM, Dominick Grift <dac.override@gmail.com> wrote:
> On Sat, Jan 10, 2015 at 06:19:51PM +0100, Dominick Grift wrote:
>> On Sat, Jan 10, 2015 at 11:49:29AM -0500, Stephen Smalley wrote:
>> > This behavior has a) always been present in SELinux, b) documented in
>> > the original SELinux technical report and the LSM-based SELinux
>> > technical report, and c) discussed plenty of times before.  So you're
>> > free to disagree but it isn't new or hidden from view.  It was viewed
>> > as logically inconsistent and not useful to impose a restriction upon
>> > bind(2) to a port number in the local port range when such port
>> > numbers have no security semantics and can be obtained by any process
>> > that can create a socket just by connecting (TCP) or sending (UDP) on
>> > that socket.  At that time, the ipv4 code will cheerfully assign an
>> > available port number out of that local port range to the socket if it
>> > is unbound.  If you truly want to control port numbers in that range,
>> > it is not a mere matter of removing the exemption from the
>> > selinux_socket_bind hook but also introducing a new LSM hook inside
>> > the ipv4 code to keep trying until it finds a port number that is
>> > allowed.  The potential overhead of applying such checking could be
>> > non-trivial and would show up on connect() and sendto()/sendmsg()
>> > calls.  You are free to submit a patch to do exactly that, with
>> > performance measurements if you wish.
>>
>> I can live with this "logical inconsistency", and other "gotchas" but i would prefer that tools/libraries like sesearch would some how communicate this.
>> It may be documented, and discussed but besides a handful of kernel coders and a few others, i bet not many are aware of this inconsistency, and other gotchas
>> If the tools would some how show that there is a special case, then policy authors would not be left totally in the dark but how would one implement that...
>>
>
> There is a difference between not being hidden from view, and being prominently visible. I prefer the latter in instances like these to avoid this embarrassment.
>
>> >
>> > On Sat, Jan 10, 2015 at 4:56 AM, Dominick Grift <dac.override@gmail.com> wrote:
>> > > On Fri, 2015-01-09 at 22:02 -0500, Paul Moore wrote:
>> > >> I think there is a point of clarification that may help put everyone at
>> > >> ease... SELinux provides two permissions relevant to socket bind()
>> > >> operations, bind and name_bind. The name_bind operation controls the
>> > >> socket's ability to bind to a specific port, while the bind operation
>> > >> controls the ability of a domain to bind a socket.  Those of you who wish
>> > >> to restrict a domain from performing a socket bind() operation, regardless
>> > >> of the port, would likely find your answer with the socket:bind permission.
>> > >>
>> > >
>> > > Good to know but the socket bind access vector is checked on the domain
>> > > type and not on the port type
>> > >
>> > > Thus is you have a process with a requirement to bind a socket to a port
>> > > < ephemeral, then it is automatically also able listen on ports >=
>> > > ephemeral from an selinux pov
>> > >
>> > > Although this is good to know and in rare cases may be useful, it is in
>> > > my view indeed still a consolation prize at best
>> > >
>> > >> --
>> > >> paul moore
>> > >> www.paul-moore.com
>> > >>
>> > >>
>> > >>
>> > >> On January 9, 2015 5:24:22 PM eric gisse <jowr.pi@gmail.com> wrote:
>> > >>
>> > >> > I disagree.
>> > >> >
>> > >> > I've had to have technical discussions justifying my belief that
>> > >> > certain common things should be available to all domains such as
>> > >> > /dev/urandom and more recently /proc/sys/vm/overcommit_memory.
>> > >> >
>> > >> > Discussions around those reasonable defaults basically rotate around
>> > >> > the philsophical notion of least privilege.
>> > >> >
>> > >> > So seeing there's an entire swath of ports that programs can bind to
>> > >> > by default is crazytalk and blows that notion out of the water.
>> > >> >
>> > >> > Further, it is bad policy.
>> > >> >
>> > >> > Consider sshd, or any other daemon that does nothing but bind to a
>> > >> > port and listen for connections.
>> > >> >
>> > >> > It does not need the ability to bind to to anything other than its'
>> > >> > daemon port, not even epheremal ports. Yet it can, regardless of
>> > >> > policy considerations. Which is the underlying point here.
>> > >> >
>> > >> > If someone gains access to a server through a compromised service,
>> > >> > they can bind a backdoor to that epheremal range or at least exfil
>> > >> > data.
>> > >> >
>> > >> > This is bad, bad, bad and rather surprising because until it was
>> > >> > pointed out by this thread I would not have considered it possible due
>> > >> > to the...vehemence... in which least privilege has been upheld.
>> > >> >
>> > >> >
>> > >> >
>> > >> >
>> > >> > On Fri, Jan 9, 2015 at 3:52 PM, Stephen Smalley
>> > >> > <stephen.smalley@gmail.com> wrote:
>> > >> > > Ports in the local port range can be auto-assigned by the kernel to
>> > >> > > unbound sockets on first use.  So it makes no sense to control them,
>> > >> > > and there isn't even an LSM hook in the place where such auto-port
>> > >> > > selection occurs.  Controlling binding to ports is only useful when
>> > >> > > the port number is a "name" (i.e. a well-defined value that is
>> > >> > > expected to correspond to a specific service), to prevent spoofing of
>> > >> > > security-relevant services like sshd.
>> > >> > >
>> > >> > > On Fri, Jan 9, 2015 at 4:05 PM, Dominick Grift <dac.override@gmail.com>
>> > >> > wrote:
>> > >> > >> https://bugzilla.redhat.com/show_bug.cgi?id=1174405
>> > >> > >>
>> > >> > >> This is a inconsistency in SELinux
>> > >> > >>
>> > >> > >>
>> > >> > >>
>> > >> > >> _______________________________________________
>> > >> > >> Selinux mailing list
>> > >> > >> Selinux@tycho.nsa.gov
>> > >> > >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> > >> > >> To get help, send an email containing "help" to
>> > >> > Selinux-request@tycho.nsa.gov.
>> > >> > > _______________________________________________
>> > >> > > Selinux mailing list
>> > >> > > Selinux@tycho.nsa.gov
>> > >> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> > >> > > To get help, send an email containing "help" to
>> > >> > Selinux-request@tycho.nsa.gov.
>> > >> > _______________________________________________
>> > >> > Selinux mailing list
>> > >> > Selinux@tycho.nsa.gov
>> > >> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> > >> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>> > >>
>> > >>
>> > >> _______________________________________________
>> > >> Selinux mailing list
>> > >> Selinux@tycho.nsa.gov
>> > >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> > >> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>> > >
>> > >
>>
>> --
>> Dominick Grift
>
>
>
> --
> Dominick Grift
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
