Subject: RE: Labeled networking packets
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Hanson <chanson@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015737BB@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C0618592015737BB@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 09:35:46 -0400
Message-Id: <1159277746.16991.82.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-25 at 17:46 -0400, Venkat Yekkirala wrote:
> > But the secmark often tells you nothing about the data origin, or even
> > the way it entered the system, at least as currently employed by
> > refpolicy / netfilter_contexts.  That's my point.
> 
> This is still a little hazy in my mind; as to why secmark is being
> employed this way. What are the kinds of threats this is designed
> to handle?

I think James and/or Chris can answer better, since James designed and
implemented secmark (based in part on the summit discussions) and Chris
has sought to leverage it in refpolicy, but I'll make an attempt below.
James and/or Chris, feel free to correct me or elaborate further.

James Morris originally described secmark in:
http://james-morris.livejournal.com/11010.html

The refpolicy policy and iptables/netfilter rules are based on the
examples there, although there are some differences, like the encoding
of the client or server direction into the type labels so that policy
can permit inbound connections while prohibiting outbound ones or vice
versa (which you don't get from simple send/recv checks).

As currently employed, secmark is effectively labeling packets based on
their functional purpose, and then using policy to limit applications to
least privilege.  Hence, all traffic on an inbound connection to port 80
are classified as http_server_packet_t ("traffic on a connection to a
http server") and httpd_t is allowed to send and recv such traffic.
Meanwhile, all traffic on an outbound connection to port 80 is
classified as http_client_packet_t ("traffic on a connection from a http
client"), and httpd_t is not allowed to send/recv such traffic (unless a
boolean is enabled that indicates that it is supposed to function as a
relay), in an attempt to limit e.g. worm propagation from a compromised
httpd to other httpd daemons.  Meanwhile, if httpd needs to initiate and
communicate on an outbound connection to say a postgres server, it would
be allowed to send/recv packets classified as postgres_client_packet_t
("traffic on a connection from a postgres client").

A few observations:
1) A single domain may be sending and receiving multiple packet types
for different purposes.
2) Multiple domains may be sending the same packet type for the same
purpose.
3) A single packet may have different types on the output side and the
input side.
4) Enforcement is done locally based on local information, not in
cooperation with a peer based on peer information.  This is typical for
iptables/firewall-style restrictions, vs. labeled networking.  We can
for example immediately deny an attempt by httpd_t to send
http_client_packet_t on the sending side, versus deferring enforcement
to the receiver based on the receiving socket label.
5) Despite the lack of outbound vs. inbound connection distinctions in
the permission checks (per-packet send/recv), we are able to allow
outbound without allowing inbound or vice versa based on the packet
types.

> Could we not look at data in transit as sort of an extension of
> the remote socket into the local machine?

In the labeled networking sense, yes.  But secmark as currently
envisioned is rather different - it isn't an extension of the data
origin.

> Could we then not look at the "packet" (as well as any other networking
> element) as a "sub-domain" Type a la the socket?

Ditto.

> Could we not replace secmark with "security check points" defining
> the "domains" that can come/leave thru (unlabeled_t or such in the
> unlabeled case), as well as the default domain to be assigned in
> the absence of an explicit domain defined for the packet?
> 
> What kind of threats can be handled in secmark that can NOT be
> handled in the latter?

Can you provide equivalents to the httpd examples given above using your
model?

> For example, you could treat ALL the traffic to port 80 from a certain
> node (not running SELinux) to be in the "domain" mozilla_t, if your
> network/system layout/configuration is such that ONLY that kind of traffic
> (as opposed to rss_aggregator_t) is assured to come thru that "security
> point"
> correct?

You could treat all traffic to port 80 as having that domain, although
in practice, there can be multiple domains that can act as clients of a
given service (and thus connect to that port), which is why we have the
indirection of a separate packet type that is sent by a domain.  But you
also lose the stateful benefits of secmark here, including the ability
to distinguish inbound vs. outbound.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
