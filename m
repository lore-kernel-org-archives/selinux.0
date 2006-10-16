Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Joshua Brindle'" <jbrindle@tresys.com>
Cc: <selinux@tycho.nsa.gov>, <jmorris@namei.org>, <sds@tycho.nsa.gov>
Subject: RE: SELinux Networking Enhancements
Date: Mon, 16 Oct 2006 09:31:28 -0500
Message-ID: <000301c6f12f$c4958cd0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1161002421.22920.24.camel@twoface.columbia.tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Its not that we don't understand it, its just that we don't agree. The
> secpoint "paradigm" is convoluted IMO and we need something simple.

But no one has comeup with a "simpler" alternative that
also addresses the shortcomings of secmark.

> I
> basically bailed on this conversation because it wasn't going
> anywhere.
>
> While you still disagree, I think most of us believe that secmarks

Only there are no secmarks in the new design to begin with. The word
is a holdover from the current secmark design.

> should be _local only_ enforcement, not peer labeling, an
> ipsec rule is
> in no way a "peer",

Agreed. But I fail to see where having a "default" peer on a netfilter
rule/secpoint
would hurt. FYI- this is how MLS implementations work. You have an interface
that you would label everything coming thru by default with "Secret".

Also, don't we deem all data on a filesystem that doesn't support individual
file labeling to be at the label it's mounted at?

> a remote socket is a peer and a peer should
> represent that.

Sure. That's also allowed in secpoint.

>
> I believe the secpoint paradigm is very complicated to understand and
> use, for example, you'll have to have a number of flow_in and flow_out
> rules not necessarily related to the domain and socket being used.

Exactly the kind of stuff needed for "comprehensive" flow-control that
would also accommodate forwarded traffic. And we seem to have just run
away from it so far.

> You'll get a flow_out for the domain->socket->secmark->(any other
> secmark that we happen to hit which is non-ideal)->association.

Have you never gone thru multiple security check points at airports
and such?

>
> There is not an intuitive way of binding a domain to an association.

I think we have mixup on terminology here. An "association" is traditionally
used to refer to an IPSec SA and it has nothing innately to do with
flow-control.

> Rather than doing a string of checks like this it should be
> laid out and
> obvious:
>
> allow domain socket : tcp_sock { write read };

Available.

> allow socket secmark : packet { send recv };

This is VERY NARROW in that it doesn't accommodate the forwarding
case. If one were to take a broader view of things, it would be:

allow packet secpoint { flow_out }

where packet carries the socket's label in the socket case, and
for the inbound:

allow packet secpoint { flow_in }
allow socket packet { recv }

> allow secmark association : association { flow_out flow_in };

Can't do this. Too late in the chain to base IPSec associations based
on secmark. And we don't need to. You just let the association
"trasparently" chosen to correspond to the label of the packet (socket
indirectly).

> allow domain association : association { sendto recvfrom };

The sendto happens "transparently". The recvfrom is redundant when
you already have a packet assume the SA label, and are doing (as mentioned
above as well):

allow socket packet { recv }

>
> this effectively (and obviously) binds the domain type to the
> socket and
> the association, binds the socket to the packet and binds the
> packet to
> the association.
>
> Without having to follow a trail of flow_in rules this

Not any more difficult than following a trail of context transitions
and such for processes when doing policy. Perhaps even simpler.

> effectively does
> the access control that that we want.
>
> Network labeling should be very simple:

AND COMPREHENSIVE.

> you use the network
> label if its
> present. If some reconciliation needs to happen between ipsec and
> Netlabel thats fine but the bottom line is peer contexts are external
> and have nothing to do with the local labeling

For MLS the "default" labeling is needed and if you can't leverage
it for TE then no one is forcing you to do so. You would just frame
your policy accordingly where the "default" labels fail to operate
like explicit peer contexts.

> (except for access
> control).
>
> What is the problem with what I have above (which is what I thought we
> were going to do after the conf call..)

Not comprehensive as explained above.
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
