Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8QFwKVU020110
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 11:58:20 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8QFvHoN029414
	for <selinux@tycho.nsa.gov>; Tue, 26 Sep 2006 15:57:17 GMT
Message-ID: <36282A1733C57546BE392885C061859201573859@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: sds@tycho.nsa.gov
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore
	 <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
Date: Tue, 26 Sep 2006 11:58:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Might I also add that secpoint handles transient "domains" well
in the forwarding case (not handled by secmark).

> -----Original Message-----
> From: Venkat Yekkirala 
> Sent: Tuesday, September 26, 2006 10:51 AM
> To: 'sds@tycho.nsa.gov'
> Cc: Christopher J. PeBenito; Chad Hanson; Karl MacMillan;
> selinux@tycho.nsa.gov; Darrel Goeddel; dwalsh@redhat.com;
> jmorris@redhat.com; latten@austin.ibm.com; Paul Moore; Joshua Brindle
> Subject: RE: Labeled networking packets
> 
> 
> > > This is still a little hazy in my mind; as to why secmark is being
> > > employed this way. What are the kinds of threats this is designed
> > > to handle?
> > 
> > I think James and/or Chris can answer better, since James 
> designed and
> > implemented secmark (based in part on the summit discussions) 
> > and Chris
> > has sought to leverage it in refpolicy, but I'll make an 
> > attempt below.
> > James and/or Chris, feel free to correct me or elaborate further.
> > 
> > James Morris originally described secmark in:
> > http://james-morris.livejournal.com/11010.html
> > 
> > The refpolicy policy and iptables/netfilter rules are based on the
> > examples there, although there are some differences, like 
> the encoding
> > of the client or server direction into the type labels so 
> that policy
> > can permit inbound connections while prohibiting outbound 
> ones or vice
> > versa (which you don't get from simple send/recv checks).
> > 
> > As currently employed, secmark is effectively labeling 
> > packets based on
> > their functional purpose, and then using policy to limit 
> > applications to
> > least privilege.  Hence, all traffic on an inbound connection 
> > to port 80
> > are classified as http_server_packet_t ("traffic on a 
> connection to a
> > http server") and httpd_t is allowed to send and recv such traffic.
> > Meanwhile, all traffic on an outbound connection to port 80 is
> > classified as http_client_packet_t ("traffic on a connection 
> > from a http
> > client"), and httpd_t is not allowed to send/recv such 
> > traffic (unless a
> > boolean is enabled that indicates that it is supposed to 
> function as a
> > relay), in an attempt to limit e.g. worm propagation from a 
> > compromised
> > httpd to other httpd daemons.  Meanwhile, if httpd needs to 
> > initiate and
> > communicate on an outbound connection to say a postgres 
> > server, it would
> > be allowed to send/recv packets classified as 
> postgres_client_packet_t
> > ("traffic on a connection from a postgres client").
> 
> I see the current use of secmark as directly mappable (as 
> exemplified below)
> to the security point paradigm, which I see as being more intuitive
> since it's more in line with the "filtering" aspect of 
> iptables. And you
> will have also gotten rid of an additional packet object as a distinct
> Type, thus making things less complex to that extent.
> 
> In the example above, you would have "fine-grained security points"
> as given below:
> 
> All new connections INTO port 80: http_client_t default domain, with
> additional explicit "domains" fire_fox_t, rss_aggregator_t, etc.
> 
> allow httpd_t http_client_t:peer { sendto recvfrom }
> allow httpd_t fire_fox_t:peer { sendto recvfrom }
> ...
> 
> Now, a compromised httpd_t isn't able initiate OUTGOING connections
> to port 80 (other than to itself for graceful shutdown in conjunction
> with additional policy).
> 
> For connections to postgres:
> 
> All new OUTGOING connections from port 80 to postgres-port: 
> postgres_t default
> 
> allow httpd_t postgres_t:peer { sendto recvfrom }
> 
> > 
> > A few observations:
> > 1) A single domain may be sending and receiving multiple 
> packet types
> > for different purposes.
> 
> A single domain may be sending to and receiving from multiple 
> "domains"
> as defined by the "fine grained security check points".
> 
> > 2) Multiple domains may be sending the same packet type for the same
> > purpose.
> 
> Mutiple domains will be allowed to send to the same "security 
> check point".
> 
> > 3) A single packet may have different types on the output 
> side and the
> > input side.
> 
> This is very non-intuitive, as opposed to defining security 
> check points
> with just the "domains" that can be received from and sent to.
> 
> > 4) Enforcement is done locally based on local information,
> 
> This holds true in the "secpoint" case well.
> 
> > not in
> > cooperation with a peer based on peer information.
> 
> No such constraints in the secpoint case. Enforcement is based on the
> best available info as driven by policy.
> 
> >  This is 
> > typical for
> > iptables/firewall-style restrictions, vs. labeled networking.
> 
> While covering for the "local info, local enforcement model", secpoint
> also allows you to "filter" domains that can come in or go out, when
> such info is available. Any time you are labeling externally, this is
> indeed expected and is very intuitive.
> 
> >  We can
> > for example immediately deny an attempt by httpd_t to send
> > http_client_packet_t on the sending side,
> 
> Which is covered by secpoint.
> 
> > versus deferring enforcement
> > to the receiver based on the receiving socket label.
> 
> We aren't deferring it; still enforcing on the sender.
> 
> > 5) Despite the lack of outbound vs. inbound connection 
> distinctions in
> > the permission checks (per-packet send/recv), we are able to allow
> > outbound without allowing inbound or vice versa based on the packet
> > types.
> 
> Directly mappable to secpoint. You define one secpoint for the inbond
> and another for the outbound and allow send/recv as appropriate.
> 
> > 
> > > Could we not look at data in transit as sort of an extension of
> > > the remote socket into the local machine?
> > 
> > In the labeled networking sense, yes.  But secmark as currently
> > envisioned is rather different - it isn't an extension of the data
> > origin.
> 
> The way I understand/see it: additional complexity for no 
> real benefit.
> 
> > 
> > > Could we then not look at the "packet" (as well as any 
> > other networking
> > > element) as a "sub-domain" Type a la the socket?
> > 
> > Ditto.
> > 
> > > Could we not replace secmark with "security check points" defining
> > > the "domains" that can come/leave thru (unlabeled_t or such in the
> > > unlabeled case), as well as the default domain to be assigned in
> > > the absence of an explicit domain defined for the packet?
> > > 
> > > What kind of threats can be handled in secmark that can NOT be
> > > handled in the latter?
> > 
> > Can you provide equivalents to the httpd examples given above 
> > using your
> > model?
> 
> Described above.
> 
> > 
> > > For example, you could treat ALL the traffic to port 80 
> > from a certain
> > > node (not running SELinux) to be in the "domain" 
> mozilla_t, if your
> > > network/system layout/configuration is such that ONLY that 
> > kind of traffic
> > > (as opposed to rss_aggregator_t) is assured to come thru 
> > that "security
> > > point"
> > > correct?
> > 
> > You could treat all traffic to port 80 as having that 
> domain, although
> > in practice, there can be multiple domains that can act as 
> > clients of a
> > given service (and thus connect to that port), which is why 
> > we have the
> > indirection of a separate packet type that is sent by a 
> > domain.
> 
> I don't see why the "packet Type" indirection is needed at all.
> 
> >  But you
> > also lose the stateful benefits of secmark here,
> 
> Nope, you still are leveraging the stateful benefits of iptables.
> 
> > including the ability
> > to distinguish inbound vs. outbound.
> 
> Done in the secpoint case as well.
> 
> Votes? :)
> 
> PS: I have had my routine dose of caffiene, so I believe I am 
> being sane
> in the above :)
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
