Subject: RE: SELinux Networking Enhancements
From: Joshua Brindle <jbrindle@tresys.com>
To: vyekkirala@TrustedCS.com
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov
In-Reply-To: <000301c6f12f$c4958cd0$cc0a010a@tcssec.com>
References: <000301c6f12f$c4958cd0$cc0a010a@tcssec.com>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 09:23:00 -0400
Message-Id: <1161177780.30986.32.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-16 at 09:31 -0500, Venkat Yekkirala wrote:
> > Its not that we don't understand it, its just that we don't agree. The
> > secpoint "paradigm" is convoluted IMO and we need something simple.
> 
> But no one has comeup with a "simpler" alternative that
> also addresses the shortcomings of secmark.
> 
> > I
> > basically bailed on this conversation because it wasn't going
> > anywhere.
> >
> > While you still disagree, I think most of us believe that secmarks
> 
> Only there are no secmarks in the new design to begin with. The word
> is a holdover from the current secmark design.
> 

the point is that the new design is being challenged, you can't fall
back on "that isn't what it means anymore" because it is what it means
until your changes go in. 

> > should be _local only_ enforcement, not peer labeling, an
> > ipsec rule is
> > in no way a "peer",
> 
> Agreed. But I fail to see where having a "default" peer on a netfilter
> rule/secpoint
> would hurt. FYI- this is how MLS implementations work. You have an interface
> that you would label everything coming thru by default with "Secret".
> 

first, getpeercon() returning something that isn't an external label is
not good, how are applications to cope with this behavior?

Second, MLS implementations work this way because they are hard coded
to. We aren't hard coded to do anything, there is no "default" in this
case, you'd have to specify defaults with iptables and I question how
scalable that is anyway. You either have really course grained secmarks
(one per interface with 1 type and an MLS range) or if you start
breaking it down into protocol, port, etc you have a full set for every
interface with a different type and the mls range. There doesn't seem to
be alot of flexibility here.

> Also, don't we deem all data on a filesystem that doesn't support individual
> file labeling to be at the label it's mounted at?
> 

no, it gets a label based on genfscon (eg., cd's get iso9660_t no matter
where it is mounted)

> > a remote socket is a peer and a peer should
> > represent that.
> 
> Sure. That's also allowed in secpoint.
> 

secpoint supports that by mutating labels. If there is no labeled
networking present getpeercon() returns a totally different label from a
totally different place that represents a totally different thing
(secpoint isn't the same as remote peer IMO)

> >
> > I believe the secpoint paradigm is very complicated to understand and
> > use, for example, you'll have to have a number of flow_in and flow_out
> > rules not necessarily related to the domain and socket being used.
> 
> Exactly the kind of stuff needed for "comprehensive" flow-control that
> would also accommodate forwarded traffic. And we seem to have just run
> away from it so far.
> 

So I never heard about this requirement until now. I'll grant that it is
an interesting problem but if it is truly a requirement why wasn't it
part of prior conversations? Perhaps we can come up with a good solution
that addresses it as well.

> > You'll get a flow_out for the domain->socket->secmark->(any other
> > secmark that we happen to hit which is non-ideal)->association.
> 
> Have you never gone thru multiple security check points at airports
> and such?
> 

Yes, and my name stays the same after each one.

> >
> > There is not an intuitive way of binding a domain to an association.
> 
> I think we have mixup on terminology here. An "association" is traditionally
> used to refer to an IPSec SA and it has nothing innately to do with
> flow-control.
> 

It does, the association has a label, policy should allow me to say
"this domain can write data to only this association". That puts the
ability to enforce confidentiality at the network level inside SELinux
policy, where we want it.

Meaning, for policy analysis we need to show that certain domains can
only speak to domains on other machines via certain associations. 


I see that James responded on LSPP yesterday with same basic
requirements that I'm trying to allude to here so I'll just wrap this
up.. 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
