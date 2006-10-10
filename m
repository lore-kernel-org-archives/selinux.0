Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AJFnVM026434
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 15:15:49 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9AJEWvk013547
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 19:14:33 GMT
Reply-To: <vyekkirala@TrustedCS.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "'Christopher J. PeBenito'" <cpebenito@tresys.com>,
        "Venkat Yekkirala" <vyekkirala@tcsfw4.tcs-sec.com>
Cc: "Joshua Brindle" <jbrindle@tresys.com>, <selinux@tycho.nsa.gov>
Subject: RE: Denials from newest kernel
Date: Tue, 10 Oct 2006 14:15:33 -0500
Message-ID: <000801c6eca0$75eee1f0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1160505217.20774.93.camel@sgc>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Tue, 2006-10-10 at 10:42 -0400, Venkat Yekkirala wrote:
> > > I don't think this is a desired behavior for a couple
> reasons.  First,
> > > this means that every domain that has access to a
> specific packet, for
> > > example, http_client_packet_t, but not to client_packet_t,
> > > will have to
> > > dontaudit the client_packet_t access.  Thats a lot of
> >
> > But this is a problem of our own making in the policy. If we
> > jump into a unique chain for a label (or a set of labels all
> > fine-grained to the same "grade", and hence are non-conflicting)
> > then we shouldn't see this. Please refer to the links I mentioned in
> > my response to Joshua.
> >
> > > dontauditing, and
> > > also it will cover up legitimate denials on
> client_packet_t.  Second,
> >
> > It won't if you defined the catch-all security point only for the
> > real catch-all cases.
>
> On both of the above two points, you're making my point.  You're
> applying to constraints to the chaining of iptables rules,

My point is that you already were applying constraints to the chaining
of iptabels rules in the current secmark paradigm, which is that the
secmark label on the last rule will prevail. Were you not?

> making
> secmark work differently than the remainder of netfilter.

I don't understand this point; can't really compare an accessory (semark)
to the mechanism it's piggybacking on (netfilter).

>
> > > this will cause permissive to have a different behavior than
> > > enforcing.
> > > This makes development in permissive more difficult,
> since you'll get
> > > spurious denials that you wouldn't get in enforcing.

Can you give an example of a spurious denial here?

>
> You didn't respond to this, and it is an important point.
>
> > > > > (PeBenito changed the netmsg initial sid to no_extlabel_t, he
> > > > > didn't like network_t I guess).
> > > >
> > > > This is scary to my eyes at least. I had already laid out the
> > > > intended usage of these controls in terms of peer "domains" as
> > > > opposed to "packet types".
> > >
> > > The refpolicy interfaces should be able to make this abstraction.
> > > Network_t wasn't clear in my opinion, since you only needed
> > > that access
> > > for non labeled networking.
> >
> > Nope, all of the following need to be able to flow_out of this pipe
> > that represents the network.
> >
> > 1. All the local domains that need to access the network directly
> >    without flowing thru any "fine-grained" security points.
> >
> > 2. All fine-grained security point domains assumed by packets that
> >    are flowing out of these security points. This check should have
> >    been avoidable, but is not due to implementation constraints.
>
> I don't understand, it seems as though you're saying that all network
> traffic will hit a network_t flow out check, regardless of
> whether it is
> labeled networking or non-labeled networking.

It doesn't matter whether it's labeled or non-labeled. What matters is that
anything that hasn't been subject to a security point will be subject to the
network_t check to see if it can flow out to the network.

Additionally, due to implementation constraints, the security point domains
themselves are subject to the network_t check as well, as noted above.

>  Can you
> illustrate with a
> couple allow rule examples?

The following describes the checks.

http://marc.theaimsgroup.com/?l=selinux&m=116042211115508&w=2

Example 1:

firefox_t can't directly access the network.

allow firefox_t  p_httpd_t:packet { flow_out };

allow p_httpd_t  network_t:packet { flow_out };

Example 2:

firefox_t can directly access the network.

allow firefox_t network_t:packet { flow_out };

NOTE: I deliberately used the "p" prefix in p_httpd_t
      to signify that it's a peer domain (not necessarily
      in the tcp sense, but just that firefox_t is communicating
      to a peer domain labeled p_httpd_t).

>
> --
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
