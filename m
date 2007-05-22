Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4M3l64k012082
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 23:47:07 -0400
Received: from mailhub.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4M3l5d9028604
	for <selinux@tycho.nsa.gov>; Tue, 22 May 2007 03:47:06 GMT
From: Paul Moore <paul.moore@hp.com>
To: casey@schaufler-ca.com
Subject: Re: Question on networking accesses
Date: Mon, 21 May 2007 23:46:58 -0400
Cc: selinux@tycho.nsa.gov
References: <315251.46234.qm@web36607.mail.mud.yahoo.com>
In-Reply-To: <315251.46234.qm@web36607.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705212346.59212.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 21 May 2007 5:06:36 pm Casey Schaufler wrote:
> --- Paul Moore <paul.moore@hp.com> wrote:
> > On Monday, May 21 2007 4:18:48 pm Casey Schaufler wrote:
> > Under SELinux packets can have two labels,
> > an "internal" or generated label which is determined locally by the
> > compat_net/SECMARK mechanisms and an "external" label which is assigned
> > by the sender either though NetLabel or labeled IPsec.
>
> The packet can get a label-of-convinience for cases where the
> attributes of the sender are unavailable and must be infered.
> Ok by me.

Just to be clear, the internal label is not quite the same as the external 
label.  Both can be used to control access between a packet and it's sending 
or receiving socket but that is where the similarities end; for example you 
can't do a getpeercon() call on a connection that does not have an external 
label.

I mention this because it is my understanding the other trusted OSs had a 
facility to assign "external" labels to packets that were not labeled, i.e. 
the "label-of-convenience".  For example, all traffic on interface X is 
labeled "SuperSecret" while traffic on interface Y is 
labeled "SuperDoubleSecret".  At some point I would like implement something 
like this, as I see this as a nice feature, but we currently do not support 
this use case.

> > > It appears that you're treating the packet as a labeled object,
> > > with creation by the sender and deletion by either the receiver
> > > on successful delivery or the system on failure. This model has
> > > has had a tough row to hoe in prior evaluations, as a network
> > > packet does not fit the traditional object model well.
> >
> > Okay, I'll bite - why not, and what did prior systems do?
>
> The question always comes down to what are the subjects, and
> what are the objects. For a packet to be an object on it's own
> it needs a name by which a subject can access it, and packets
> don't have names.

Perhaps not a name in a conventional sense, but I think you could consider 
them as having a name based on the src/port-dst/port tuple.  After all, if 
there was no way to identify packets how would networking work and what is a 
name if not a way to identify an object?

> Further, processes don't go out of their way 
> to access packets, the data packets contain shows up in a socket
> as if by magic.

I see your point, but the process does have to explicitly perform an action to 
receive data.  In the case of stream connections an accept() is required 
whereas datagram connections require a recvfrom/msg/etc call.  As far as 
the "magic", how does data get into a file to be consumed by a process :)

> The systems that I worked on treated it as the sender writing to
> the receiver, with sender and receiver attributes contained in the
> respective sockets. The sender is the subject doing the write,
> and the receiver is the object being written to, with sockets and
> various other kernel data containers being used to ensure that
> the information required to make access checks is available where
> required.
>
> The primary difference is that in the 20th century scheme the
> subject (sender) and object (receiver) are clearly identified
> whereas in the SELinux scheme a subject (sender) creates something
> that doesn't quite look like an object (packet) that is read by
> something that sort of resembles a subject (socket) but that does
> not actually have a life of its own, being a data component of a
> of the receiver.

I guess with SELinux you could think of it as the following:

 - process A (subject) writes to socket A1 (object)
 - socket A1 (subject) sends packet to compat_net/SECMARK (object)

    packet traverses the ether (real magic)

 - socket B1 (subject) receives the packet via int/ext labels (object)
 - process B (subject) receives the data via socket B1 (object)

While it's different from what you may be used to I don't think it's _that_ 
different, especially if you tilt your head ever so slightly and squint.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
