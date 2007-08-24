Message-ID: <D709A20F2164C84E8B7014B0301F5EF8481CBD@HAVOC.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov
Cc: James Morris <jmorris@namei.org>,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Fri, 24 Aug 2007 13:37:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I will go ahead and offer my comments to the below in my
personal capacity.

> -----Original Message-----
> From: Paul Moore [mailto:paul.moore@hp.com]
(snip)
> As a reminder, below is a definition of the two types of labels.
> 
> Secmark, or internal, labels are essentially a means for 
> integrating the 
> traditional firewall rules with SELinux mandatory access 
> controls.  The 
> secmark labels allow policy writers and security 
> administrators to meet 
> security goals similar to the following:
>  "Only allow Apache to accept connections over tcp/80 from 
>   192.168.0.0/24, restricting it to my local network and not
>   the Big-Bad-Internet."
>  -- or --
>  "Only allow a particular instance of Firefox to connect to
>   1.2.3.4 over tcp/443, restricting it to my online banking
>   site."
> 

Secmark is currently playing the role of arbitrating between
a socket and a packet, based on the internal knowledge of the
packet. I don't see why this "internal" label of the packet
couldn't be the internally defined peer label that MUST be
the same as any external peer label coming in with the packet.

Thus the current socket Vs. packet.recv check would be retained intact.

For the outgoing, the packet would get it's label from the socket
and then the check would whether the label on the packet matches
the "internally" defined "local" label. There can further be a
socket Vs. packet.send, but this will typically boil down to
can a httpd_t socket send a httpd_t packet (if and when the
ability to write a packet to a socket with a label different
from the socket's, the target of the check would then be
that label).

Essentially, the following characterization:

One would define what peers are "expected" to come in with what
characteristics using iptables selectors. Similarly, one would
define what local domains are expected to go out with what
characteristics using iptables selectors. A label coming in with
a packet MUST match the "expected" label or the packet will be dropped.
For the outgoing also, a packet's label (domain label from the socket)
MUST match the "expected" label (defined using iptables selectors) or the
packet will be dropped.

We also inherently have flow control in the above.

> Peer, or external, labels, furnished by NetLabel or labeled 
> IPsec/XFRM, 
> provide the domain/context/label of the process which generated the 
> packet/data.  The external labels allow policy writers and security 
> administrators to meet security goals similar to the following:
>  "This instance of Apache serves sensitive financial data and
>   I only want specific clients/peers/domains to be able to access
>   the data from this Apache instance."
>  -- or --
>  "I want to ensure that users connecting to the login server over
>   a Secret connection run in a Secret domain."
> 
>  * Splitting the SECMARK field

Having a single label for a packet, essentially, the label of the
data contained in the packet, would greatly simplify things and
IMHO easier to understand.

(snip)

>  * Packet flow control
> 
> Another long standing goal that has not seen much success 
> over the years.  The 
> two approaches currently being considered are: per-interface 
> checks against 
> the peer label with the possibility of an additional 
> forwarding hook/check if 
> needed for labeling purposes, as well as an iptables based filtering 
> mechanism which has already been discussed off and on on the 
> public SELinux 
> and LSPP mailing lists (SECFILTER/SECPOINT).  The idea behind 
> the iptables 
> based filtering mechanism is that "filter points" could be 
> defined using 
> iptables/netfilter which would provide very granular access 
> control checks.  
> The big question that is currently being debated is how much 
> granularity is 
> needed and how much makes sense? 

See the above.

> 
>  * Fallback labels
> 
> The simple idea that started this whole discussion.  The need 
> for a usable 
> peer label fallback mechanism is understood by everyone but 
> the granularity 
> with which peer fallback labels are assigned are still a 
> source of debate.  
> The idea is wether the granularity proposed in this NetLabel 
> patchset which 
> allows per-host/subnet granularity for each interface is 
> enough, and if not 
> is a very granular iptables/netfilter peer label assignment 
> of fallback 
> labels required?  This topic did come up briefly some time 
> ago on the public 
> mailing list between Joshua Brindle and myself and we agreed that the 
> granularity presented in this patchset is sufficient, 
> however, not everyone 
> feels this way so we are still discussing the best solution.

I am one of those that feel that non-granular fallbacks would
be restrictive enough for the general case. We would essentially
need per interface/node/port granularity, which is easily
accomplished via iptables.

> 
> As part of the peer fallback label discussion it became 
> apparent to everyone 
> that better integration/cooperation between the NetLabel and 
> XFRM labeling 
> mechanisms is needed.  The strict separation worked well in 
> the beginning but 
> as we start to develop a richer set of functionality the two labeling 
> mechanisms need to work better together to ensure the 
> consistency of the 
> network access controls.  If the approach put forward in this 
> patch set is 
> agreed upon as the right way to solve the peer fallback 
> problem I will be 
> modifying it to take into account XFRM labels so that the 
> NetLabel provided 
> fallback peer label will only be used when there is no XFRM 
> or NetLabel/CIPSO 
> label on the packet.  Further, work will be done to ensure 
> that when both a 
> XFRM and NetLabel/CIPSO label are present on an incoming 
> packet that the 
> labels are the same, otherwise the packet will be dropped/rejected.

I agree here.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
