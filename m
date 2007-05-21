Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LKVQM2021117
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 16:31:26 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4LKVP9R025797
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 20:31:25 GMT
From: Paul Moore <paul.moore@hp.com>
To: casey@schaufler-ca.com
Subject: Re: Question on networking accesses
Date: Mon, 21 May 2007 16:30:51 -0400
Cc: selinux@tycho.nsa.gov
References: <520218.3716.qm@web36606.mail.mud.yahoo.com>
In-Reply-To: <520218.3716.qm@web36606.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705211630.52200.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, May 21 2007 4:18:48 pm Casey Schaufler wrote:
> --- Paul Moore <paul.moore@hp.com> wrote:
> > On Monday, May 21 2007 12:07:21 pm Casey Schaufler wrote:
> > > --- Paul Moore <paul.moore@hp.com> wrote:
> > > > On Monday, May 21 2007 9:48:52 am Casey Schaufler wrote:
> > > > > I have what I hope is a fairly straitforward question on the
> > > > > SELinux networking model. Let's pretend that I have a process A
> > > > > that sends a UDP packet P to a second process B. From the viewpoint
> > > > > of access control is this:
> > > > >
> > > > >     - process A writing to process B
> > > > >     - process B reading from process A
> > > > >     - process A creating packet P, and process B reading packet P
> > > > >
> > > > > some combination of the above, or something else entirely?
> > > > >
> > > > >From 10,000 feet up in the air that sounds roughly about right.
> > > > > Although if
> > > >
> > > > you are talking about labeled networking it can be a bit more
> > > > involved, especially if you are using labeled IPsec.
> > > >
> > > > Can you be a bit more specific?
> > >
> > > How about if I throw out an example. The evaluation team loved this
> > > one back in '92.
> >
> > The example wasn't quite what I was hoping for as I'm still a little
> > confused
> >
> > as to exactly what you are looking for.  However, it's Monday and writing
> > email is looking more attractive than real work so let me take a stab at
> > explaining the network access controls from both a sender and receiver
> > point of view.  I'm certain I'll make a mistake or two, but hopefully
> > somebody will
> >
> > point those out.
> >
> >  A - sender without any form of labeled networking:
> >    1. The process must have write/send access to the socket
> >    2. The socket must have write/send access for the compat_net/SECMARK
> >       controls
> >
> >  B - receiver without any form of labeled networking
> >    1. The packet's receiving socket must have read/recv access for the
> >       incoming packet based on the compat_net/SECMARK label
> >    2. The process must have read/recv access for the socket
>
> If I read this correctly you're saying that within each process
> there are controls on using sockets (A1, A2, B2) and that in
> addition to those the receiver requires read access (B1) to the
> packet, based on the label attached to it.

Actually it's receiver's socket which requires read access to the packet, this 
is important as the socket's label is not always the same as the process 
which created it.  Not sure if it matters for our discussion here, but I 
didn't want that detail lost. 

> The label attached to the packet is an object label, not a subject label,

Yes.

> and is determined by the attributes of the sender.

Whoa there, not always.  Under SELinux packets can have two labels, 
an "internal" or generated label which is determined locally by the 
compat_net/SECMARK mechanisms and an "external" label which is assigned by 
the sender either though NetLabel or labeled IPsec.

> >  C - sender with labeled networking using NetLabel
> >    (same as without any labeled networking, see "A")
> >
> >  D - receiver with labeled networking using NetLabel
> >    1. The packet's receiving socket must have read/recv access for the
> >       incoming packet based on the compat_net/SECMARK label
> >    2. The packet's receiving socket must have read/recv access for the
> >       incoming packet based on the NetLabel security attributes
> >    3. The process must have read/recv access for the socket
> >
> > It is a bit more complicated with labeled IPsec as you have to deal with
> > labeled matching of the socket and SPD/SA but I'll leave that as an
> > exercise for the reader.
>
> It appears that you're treating the packet as a labeled object,
> with creation by the sender and deletion by either the receiver
> on successful delivery or the system on failure. This model has
> has had a tough row to hoe in prior evaluations, as a network
> packet does not fit the traditional object model well.

Okay, I'll bite - why not, and what did prior systems do?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
