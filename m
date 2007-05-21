Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LL6bdF024191
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 17:06:37 -0400
Received: from web36607.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l4LL6ai1002732
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 21:06:36 GMT
Date: Mon, 21 May 2007 14:06:36 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Question on networking accesses
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705211630.52200.paul.moore@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <315251.46234.qm@web36607.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Paul Moore <paul.moore@hp.com> wrote:

> On Monday, May 21 2007 4:18:48 pm Casey Schaufler wrote:
> > --- Paul Moore <paul.moore@hp.com> wrote:
> > > On Monday, May 21 2007 12:07:21 pm Casey Schaufler wrote:
> > > > --- Paul Moore <paul.moore@hp.com> wrote:
> > > > > On Monday, May 21 2007 9:48:52 am Casey Schaufler wrote:
> > > > > > I have what I hope is a fairly straitforward question on the
> > > > > > SELinux networking model. Let's pretend that I have a process A
> > > > > > that sends a UDP packet P to a second process B. From the viewpoint
> > > > > > of access control is this:
> > > > > >
> > > > > >     - process A writing to process B
> > > > > >     - process B reading from process A
> > > > > >     - process A creating packet P, and process B reading packet P
> > > > > >
> > > > > > some combination of the above, or something else entirely?
> > > > > >
> > > > > >From 10,000 feet up in the air that sounds roughly about right.
> > > > > > Although if
> > > > >
> > > > > you are talking about labeled networking it can be a bit more
> > > > > involved, especially if you are using labeled IPsec.
> > > > >
> > > > > Can you be a bit more specific?
> > > >
> > > > How about if I throw out an example. The evaluation team loved this
> > > > one back in '92.
> > >
> > > The example wasn't quite what I was hoping for as I'm still a little
> > > confused
> > >
> > > as to exactly what you are looking for.  However, it's Monday and writing
> > > email is looking more attractive than real work so let me take a stab at
> > > explaining the network access controls from both a sender and receiver
> > > point of view.  I'm certain I'll make a mistake or two, but hopefully
> > > somebody will
> > >
> > > point those out.
> > >
> > >  A - sender without any form of labeled networking:
> > >    1. The process must have write/send access to the socket
> > >    2. The socket must have write/send access for the compat_net/SECMARK
> > >       controls
> > >
> > >  B - receiver without any form of labeled networking
> > >    1. The packet's receiving socket must have read/recv access for the
> > >       incoming packet based on the compat_net/SECMARK label
> > >    2. The process must have read/recv access for the socket
> >
> > If I read this correctly you're saying that within each process
> > there are controls on using sockets (A1, A2, B2) and that in
> > addition to those the receiver requires read access (B1) to the
> > packet, based on the label attached to it.
> 
> Actually it's receiver's socket which requires read access to the packet,
> this 
> is important as the socket's label is not always the same as the process 
> which created it.  Not sure if it matters for our discussion here, but I 
> didn't want that detail lost. 

What is a socket in this model? If a socket requires read access
to the packet it would seem that the socket is an active entity.
If the socket does not have the same accesses as the process it is
attached to, it starts to sound as if the socket is a seperate
entity from the process. It almost sounds like the socket is a
subject in its own right. I don't think that's what you intend,
but I could be wrong.

> > The label attached to the packet is an object label, not a subject label,
> 
> Yes.
> 
> > and is determined by the attributes of the sender.
> 
> Whoa there, not always.

Gulp.

> Under SELinux packets can have two labels, 
> an "internal" or generated label which is determined locally by the 
> compat_net/SECMARK mechanisms and an "external" label which is assigned by 
> the sender either though NetLabel or labeled IPsec.

The packet can get a label-of-convinience for cases where the
attributes of the sender are unavailable and must be infered.
Ok by me.

> > >  C - sender with labeled networking using NetLabel
> > >    (same as without any labeled networking, see "A")
> > >
> > >  D - receiver with labeled networking using NetLabel
> > >    1. The packet's receiving socket must have read/recv access for the
> > >       incoming packet based on the compat_net/SECMARK label
> > >    2. The packet's receiving socket must have read/recv access for the
> > >       incoming packet based on the NetLabel security attributes
> > >    3. The process must have read/recv access for the socket
> > >
> > > It is a bit more complicated with labeled IPsec as you have to deal with
> > > labeled matching of the socket and SPD/SA but I'll leave that as an
> > > exercise for the reader.
> >
> > It appears that you're treating the packet as a labeled object,
> > with creation by the sender and deletion by either the receiver
> > on successful delivery or the system on failure. This model has
> > has had a tough row to hoe in prior evaluations, as a network
> > packet does not fit the traditional object model well.
> 
> Okay, I'll bite - why not, and what did prior systems do?

The question always comes down to what are the subjects, and
what are the objects. For a packet to be an object on it's own
it needs a name by which a subject can access it, and packets
don't have names. Further, processes don't go out of their way
to access packets, the data packets contain shows up in a socket
as if by magic.

The systems that I worked on treated it as the sender writing to
the receiver, with sender and receiver attributes contained in the
respective sockets. The sender is the subject doing the write,
and the receiver is the object being written to, with sockets and
various other kernel data containers being used to ensure that
the information required to make access checks is available where
required.

The primary difference is that in the 20th century scheme the
subject (sender) and object (receiver) are clearly identified
whereas in the SELinux scheme a subject (sender) creates something
that doesn't quite look like an object (packet) that is read by
something that sort of resembles a subject (socket) but that does
not actually have a life of its own, being a data component of a
of the receiver.


Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
