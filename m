Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Joshua Brindle'" <jbrindle@tresys.com>
Cc: <selinux@tycho.nsa.gov>, <jmorris@namei.org>, <sds@tycho.nsa.gov>
Subject: RE: SELinux Networking Enhancements
Date: Wed, 18 Oct 2006 10:10:27 -0500
Message-ID: <000d01c6f2c7$8c1e2f80$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1161177780.30986.32.camel@twoface.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Mon, 2006-10-16 at 09:31 -0500, Venkat Yekkirala wrote:
> > > Its not that we don't understand it, its just that we
> don't agree. The
> > > secpoint "paradigm" is convoluted IMO and we need
> something simple.
> >
> > But no one has comeup with a "simpler" alternative that
> > also addresses the shortcomings of secmark.
> >
> > > I
> > > basically bailed on this conversation because it wasn't going
> > > anywhere.
> > >
> > > While you still disagree, I think most of us believe that secmarks
> >
> > Only there are no secmarks in the new design to begin with. The word
> > is a holdover from the current secmark design.
> >
>
> the point is that the new design is being challenged, you can't fall
> back on "that isn't what it means anymore" because it is what it means
> until your changes go in.

But you don't look at elements of any new design as elements of an
old design with old meanings. When you do that you will not only be
confused,
you will have also missed the goals the new design is attempting to satisfy.

For example, you don't look at the design of an airplane and complain the
yoke
isn't a steering. You ought to look to see what an airplane accomplishes and
objectively determine whether it meets the needs.

If you don't have a runway in your backyard :) then you can't have an
airplane
and you reject it. But if you do and all the destinations do as well (some
of
which you can't reach by car), there's no reason to reject the airplane on
the
premise it doesn't have a steering like in a car.

>
> > > should be _local only_ enforcement, not peer labeling, an
> > > ipsec rule is
> > > in no way a "peer",
> >
> > Agreed. But I fail to see where having a "default" peer on
> a netfilter
> > rule/secpoint
> > would hurt. FYI- this is how MLS implementations work. You
> have an interface
> > that you would label everything coming thru by default with
> "Secret".
> >
>
> first, getpeercon() returning something that isn't an
> external label is
> not good, how are applications to cope with this behavior?

I thought you had a point there, so I did offer to have it return
only a true peer.

>
> Second, MLS implementations work this way because they are hard coded
> to. We aren't hard coded to do anything, there is no "default" in this
> case, you'd have to specify defaults with iptables and I question how
> scalable that is anyway. You either have really course
> grained secmarks
> (one per interface with 1 type and an MLS range) or if you start
> breaking it down into protocol, port, etc you have a full set
> for every
> interface with a different type and the mls range.

based on your needs...
> There
> doesn't seem to
> be alot of flexibility here.

>From an MLS point of view, more flexibility than is needed; for example,
you would still have fine-grained rules down to port, etc., but where you
need to treat all the traffic as secret, you would just have secret on
each one of those rules.

>
> > Also, don't we deem all data on a filesystem that doesn't
> support individual
> > file labeling to be at the label it's mounted at?
> >
>
> no, it gets a label based on genfscon (eg., cd's get
> iso9660_t no matter
> where it is mounted)

The mechanism doesn't matter. The fact still remains you have
a "default" label (or you could in the future) where all the
files on a filesystem that don't have an explicit label would
assume that label.

>
> > > a remote socket is a peer and a peer should
> > > represent that.
> >
> > Sure. That's also allowed in secpoint.
> >
>
> secpoint supports that by mutating labels. If there is no labeled
> networking present getpeercon() returns a totally different
> label from a
> totally different place that represents a totally different thing
> (secpoint isn't the same as remote peer IMO)

There CAN be use cases where you can in fact leverage this, but I
did offer to restrict getpeercon to strictly an explicit peer label
since you seemed to have a need for an explicitly labeled peer.

>
> > >
> > > I believe the secpoint paradigm is very complicated to
> understand and
> > > use, for example, you'll have to have a number of flow_in
> and flow_out
> > > rules not necessarily related to the domain and socket being used.
> >
> > Exactly the kind of stuff needed for "comprehensive"
> flow-control that
> > would also accommodate forwarded traffic. And we seem to
> have just run
> > away from it so far.
> >
>
> So I never heard about this requirement until now.

I am very sorry to say this, but that's because you weren't paying
enough attention. I mentioned this as one of the drawbacks as recently
as this past weekend in this very same thread, but it was also a part
of my original design proposal for labeled networking pointed out from
time to time in the conversations we had the past several months.

> I'll grant
> that it is
> an interesting problem but if it is truly a requirement why wasn't it
> part of prior conversations? Perhaps we can come up with a
> good solution
> that addresses it as well.

Which secpoint set out to solve (remember: it allowed for all the
security goals that were possible in secmark and then some. Now if people
are getting confused that they don't find a steering wheel in the airplane
and simply refuse to use the yoke, it's not my problem).

>
> > > You'll get a flow_out for the domain->socket->secmark->(any other
> > > secmark that we happen to hit which is non-ideal)->association.
> >
> > Have you never gone thru multiple security check points at airports
> > and such?
> >
>
> Yes, and my name stays the same after each one.

But you could also be "labeled" differently if there were a trustworthy
mechanism to carry the label and have fine-grained security points where
they woould process only "transferring passengers" as opposed to those
that are initially boarding. I am not saying they couldn't also use your
name (in addition to the label), the question is what would you objectively
need to satisfy the particular set of security goals at hand.

>
> > >
> > > There is not an intuitive way of binding a domain to an
> association.
> >
> > I think we have mixup on terminology here. An "association"
> is traditionally
> > used to refer to an IPSec SA and it has nothing innately to do with
> > flow-control.
> >
>
> It does, the association has a label, policy should allow me to say
> "this domain can write data to only this association". That puts the
> ability to enforce confidentiality at the network level inside SELinux
> policy, where we want it.

FYI- associations don't operate entirely the way you like them to. For
example,
ALL traffic between 2 machines ordinarily shares the same association.
This is because of the nature of the association (encryption,
authentication,
compress). You could also specify that each and every communication between
a
pair of machines use a different association, but that would be a
performance bummer.
What we have done is to make sure apache_t traffic can only use the apache_t
association.
So both the DNS queries and http service replies going to the SAME machine
would use
the SAME association with the context apache_t (rightfully so since it's ALL
apache traffic).
But if the DNS traffic is going to a different machine then it would use a
different
association, but still labeled apache_t. Unless ofcourse you set it up to
use a unique
association for each communication channel.

Also, as mentioned in the past, the netfilter hooks come into play AFTER the
xfrms are chosen. So, one couldn't base the association on the netfilter
context.

>
> Meaning, for policy analysis we need to show that certain domains can
> only speak to domains on other machines via certain associations.

You can ONLY show what associations a proc can recv from in your policy.
Whether a remote domain can receive your traffic or not is dictated on
the remote machine.

>
>
> I see that James responded on LSPP yesterday with same basic
> requirements that I'm trying to allude to here so I'll just wrap this
> up..

A natural result when people (sadly a couple or so) refuse to objectively
assess a design based on what it can accomplish. I have the satisfaction of
knowing though that I gave it my best shot.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
