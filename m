Subject: Re: SELinux Networking Enhancements
From: Joshua Brindle <jbrindle@tresys.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>,
        "'jmorris@namei.org'" <jmorris@namei.org>,
        "'sds@tycho.nsa.gov'" <sds@tycho.nsa.gov>
In-Reply-To: <36282A1733C57546BE392885C0618592238483@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592238483@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 08:40:21 -0400
Message-Id: <1161002421.22920.24.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2006-10-15 at 23:14 -0400, Venkat Yekkirala wrote:
> There has been a lot of confusion for some time on the new
> proposed controls vis a vis the controls past and present.
> 
<snip>
> 
> 
> NEW CONTROLS (SECPOINT):
> 
> The implementation of secmark paves the way, from an implementation
> standpoint, for the implementation of a different set of controls
> that seemlessly and comprehensively provide a way to impose controls
> on forwarded traffic as well as traffic destined for and generated on
> the local machine. It also paves the way for carrying the peer/datagram
> contexts for localhost traffic.
> 

Its not that we don't understand it, its just that we don't agree. The
secpoint "paradigm" is convoluted IMO and we need something simple. I
basically bailed on this conversation because it wasn't going anywhere.

While you still disagree, I think most of us believe that secmarks
should be _local only_ enforcement, not peer labeling, an ipsec rule is
in no way a "peer", a remote socket is a peer and a peer should
represent that.

I believe the secpoint paradigm is very complicated to understand and
use, for example, you'll have to have a number of flow_in and flow_out
rules not necessarily related to the domain and socket being used.
You'll get a flow_out for the domain->socket->secmark->(any other
secmark that we happen to hit which is non-ideal)->association.

There is not an intuitive way of binding a domain to an association.
Rather than doing a string of checks like this it should be laid out and
obvious:

allow domain socket : tcp_sock { write read };
allow socket secmark : packet { send recv };
allow secmark association : association { flow_out flow_in };
allow domain association : association { sendto recvfrom };

this effectively (and obviously) binds the domain type to the socket and
the association, binds the socket to the packet and binds the packet to
the association. 

Without having to follow a trail of flow_in rules this effectively does
the access control that that we want.

Network labeling should be very simple: you use the network label if its
present. If some reconciliation needs to happen between ipsec and
Netlabel thats fine but the bottom line is peer contexts are external
and have nothing to do with the local labeling (except for access
control).

What is the problem with what I have above (which is what I thought we
were going to do after the conf call..)

> Specifically the following objects are defined/used:
> 
> 1. Fine-grained security filter points defined using iptables rules.
>    These points carry the following contexts:
>         a. A set of domains that can flow-in and/or flow_out the secpoint.
>         b. A default context to be associated with all traffic that enters
>            the secpoint without carrying an explicit label such as NetLabel,
>            labeled-ipsec-SA, etc, iff such "unlabeled" domain can actually
>            flow thru that secpoint.
> 
>         NOTE: The way these 2 contexts are specified in this implementation
>         is by specifying the default context with the iptables rule and then
>         using SELinux policy to specify the set of domains that can
>         flow_in/flow_out of a secpoint with such a default context.
> 
> 2. Packets: These carry the socket label in the outbound case, or the label
>         they came in with, in the inbound case. The label in the inbound
> case
>         can either be an externally specified label (label over the wire) or
>         in it's absence the default label from the secpoint it came in thru.
> 
> 3. Sockets.
> 
> Access Control:
> 
> 1. Packets are filtered at the security points they pass thru.
> 
>    Forwarded traffic: This is filtered on the way in like any other
>    traffic and filtered on the way out like any other traffic as well.
> 
>    Peer/datagram context: These are transparently available for localhost
>    traffic without needing any special configuration or use of specific
>    labeling protocols.
> 
> 2. Access control checks come into play (like they currently do)
>    when a socket receives a packet.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
