Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AEgiSb017518
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 10:42:44 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AEg4Tb002898
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 14:42:04 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFDEA@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        "'selinux@tycho.nsa.gov'"
	 <selinux@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Tue, 10 Oct 2006 10:42:24 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> I don't think this is a desired behavior for a couple reasons.  First,
> this means that every domain that has access to a specific packet, for
> example, http_client_packet_t, but not to client_packet_t, 
> will have to
> dontaudit the client_packet_t access.  Thats a lot of 

But this is a problem of our own making in the policy. If we
jump into a unique chain for a label (or a set of labels all
fine-grained to the same "grade", and hence are non-conflicting)
then we shouldn't see this. Please refer to the links I mentioned in
my response to Joshua.

> dontauditing, and
> also it will cover up legitimate denials on client_packet_t.  Second,

It won't if you defined the catch-all security point only for the
real catch-all cases.

> this will cause permissive to have a different behavior than 
> enforcing.
> This makes development in permissive more difficult, since you'll get
> spurious denials that you wouldn't get in enforcing.
> 
> > > (PeBenito changed the netmsg initial sid to no_extlabel_t, he 
> > > didn't like network_t I guess).
> > 
> > This is scary to my eyes at least. I had already laid out the
> > intended usage of these controls in terms of peer "domains" as
> > opposed to "packet types".
> 
> The refpolicy interfaces should be able to make this abstraction.
> Network_t wasn't clear in my opinion, since you only needed 
> that access
> for non labeled networking.

Nope, all of the following need to be able to flow_out of this pipe
that represents the network.

1. All the local domains that need to access the network directly
   without flowing thru any "fine-grained" security points.

2. All fine-grained security point domains assumed by packets that
   are flowing out of these security points. This check should have
   been avoidable, but is not due to implementation constraints.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
