Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0A9uR4B016734
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 04:56:27 -0500
Received: by mail-wg0-f47.google.com with SMTP id n12so11919927wgh.6
 for <selinux@tycho.nsa.gov>; Sat, 10 Jan 2015 01:56:23 -0800 (PST)
Message-ID: <1420883781.24061.22.camel@gmail.com>
Subject: Re: RFC: https://bugzilla.redhat.com/show_bug.cgi?id=1174405
From: Dominick Grift <dac.override@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Date: Sat, 10 Jan 2015 10:56:21 +0100
In-Reply-To: <14ad1cb43d8.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <1420837553.31986.2.camel@gmail.com>
 <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
 <CAHZ_AjsxSJ3adY-UeMfik9xzOczk1411hk_ckSRPNbBOFSkwbA@mail.gmail.com>
 <14ad1cb43d8.2806.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2015-01-09 at 22:02 -0500, Paul Moore wrote:
> I think there is a point of clarification that may help put everyone at 
> ease... SELinux provides two permissions relevant to socket bind() 
> operations, bind and name_bind. The name_bind operation controls the 
> socket's ability to bind to a specific port, while the bind operation 
> controls the ability of a domain to bind a socket.  Those of you who wish 
> to restrict a domain from performing a socket bind() operation, regardless 
> of the port, would likely find your answer with the socket:bind permission.
> 

Good to know but the socket bind access vector is checked on the domain
type and not on the port type

Thus is you have a process with a requirement to bind a socket to a port
< ephemeral, then it is automatically also able listen on ports >=
ephemeral from an selinux pov

Although this is good to know and in rare cases may be useful, it is in
my view indeed still a consolation prize at best

> --
> paul moore
> www.paul-moore.com
> 
> 
> 
> On January 9, 2015 5:24:22 PM eric gisse <jowr.pi@gmail.com> wrote:
> 
> > I disagree.
> >
> > I've had to have technical discussions justifying my belief that
> > certain common things should be available to all domains such as
> > /dev/urandom and more recently /proc/sys/vm/overcommit_memory.
> >
> > Discussions around those reasonable defaults basically rotate around
> > the philsophical notion of least privilege.
> >
> > So seeing there's an entire swath of ports that programs can bind to
> > by default is crazytalk and blows that notion out of the water.
> >
> > Further, it is bad policy.
> >
> > Consider sshd, or any other daemon that does nothing but bind to a
> > port and listen for connections.
> >
> > It does not need the ability to bind to to anything other than its'
> > daemon port, not even epheremal ports. Yet it can, regardless of
> > policy considerations. Which is the underlying point here.
> >
> > If someone gains access to a server through a compromised service,
> > they can bind a backdoor to that epheremal range or at least exfil
> > data.
> >
> > This is bad, bad, bad and rather surprising because until it was
> > pointed out by this thread I would not have considered it possible due
> > to the...vehemence... in which least privilege has been upheld.
> >
> >
> >
> >
> > On Fri, Jan 9, 2015 at 3:52 PM, Stephen Smalley
> > <stephen.smalley@gmail.com> wrote:
> > > Ports in the local port range can be auto-assigned by the kernel to
> > > unbound sockets on first use.  So it makes no sense to control them,
> > > and there isn't even an LSM hook in the place where such auto-port
> > > selection occurs.  Controlling binding to ports is only useful when
> > > the port number is a "name" (i.e. a well-defined value that is
> > > expected to correspond to a specific service), to prevent spoofing of
> > > security-relevant services like sshd.
> > >
> > > On Fri, Jan 9, 2015 at 4:05 PM, Dominick Grift <dac.override@gmail.com> 
> > wrote:
> > >> https://bugzilla.redhat.com/show_bug.cgi?id=1174405
> > >>
> > >> This is a inconsistency in SELinux
> > >>
> > >>
> > >>
> > >> _______________________________________________
> > >> Selinux mailing list
> > >> Selinux@tycho.nsa.gov
> > >> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > >> To get help, send an email containing "help" to 
> > Selinux-request@tycho.nsa.gov.
> > > _______________________________________________
> > > Selinux mailing list
> > > Selinux@tycho.nsa.gov
> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > To get help, send an email containing "help" to 
> > Selinux-request@tycho.nsa.gov.
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
