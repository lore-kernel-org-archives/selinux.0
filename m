Message-ID: <36282A1733C57546BE392885C0618592238483@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Cc: "'jmorris@namei.org'" <jmorris@namei.org>,
        "'sds@tycho.nsa.gov'"
	 <sds@tycho.nsa.gov>
Subject: SELinux Networking Enhancements
Date: Sun, 15 Oct 2006 23:14:56 -0400
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There has been a lot of confusion for some time on the new
proposed controls vis a vis the controls past and present.

So I wanted to lay out briefly the past, present and the
proposed future of SELinux networking controls on 2.6 kernels
to put things in perpective.

PAST:

One could control network access based on node, netif
and port contexts. Specifically, sockets were subject
to access checks against the 3 contexts mentioned.

No controls on forwarded traffic available. Also,
no way to retrieve the peer context on TCP sockets and
the security context on IP datagrams.


PRESENT:

secmark enables contexts to be specified on packets
based on attributes on a packet (src, dst addresses,
ports, etc.) that are selectable via iptables rules.
Access checks are socket Vs. packet.

Also, labeled networking via IPSec xfrms and NetLabel/CIPSO
has become available. Also implemented is a way to retrieve
the peer context on TCP sockets and the security context on
datagrams.

But still no controls on forwarded traffic are available.
Also, still no easy way to retrieve the peer context on
TCP sockets and the security context on datagrams, in a
transparent fashion in localhost (loopback) communications.
While one could use NetLabel/CIPSO (MLS only) and in theory
IPSec xfrms to do this for localhost communications, it's
awkward, entails undue overhead and something that needs to
be configured via policy to work.


NEW CONTROLS (SECPOINT):

The implementation of secmark paves the way, from an implementation
standpoint, for the implementation of a different set of controls
that seemlessly and comprehensively provide a way to impose controls
on forwarded traffic as well as traffic destined for and generated on
the local machine. It also paves the way for carrying the peer/datagram
contexts for localhost traffic.

Specifically the following objects are defined/used:

1. Fine-grained security filter points defined using iptables rules.
   These points carry the following contexts:
        a. A set of domains that can flow-in and/or flow_out the secpoint.
        b. A default context to be associated with all traffic that enters
           the secpoint without carrying an explicit label such as NetLabel,
           labeled-ipsec-SA, etc, iff such "unlabeled" domain can actually
           flow thru that secpoint.

        NOTE: The way these 2 contexts are specified in this implementation
        is by specifying the default context with the iptables rule and then
        using SELinux policy to specify the set of domains that can
        flow_in/flow_out of a secpoint with such a default context.

2. Packets: These carry the socket label in the outbound case, or the label
        they came in with, in the inbound case. The label in the inbound
case
        can either be an externally specified label (label over the wire) or
        in it's absence the default label from the secpoint it came in thru.

3. Sockets.

Access Control:

1. Packets are filtered at the security points they pass thru.

   Forwarded traffic: This is filtered on the way in like any other
   traffic and filtered on the way out like any other traffic as well.

   Peer/datagram context: These are transparently available for localhost
   traffic without needing any special configuration or use of specific
   labeling protocols.

2. Access control checks come into play (like they currently do)
   when a socket receives a packet.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
