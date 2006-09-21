Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LJblOT024556
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 15:37:47 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8LJbIcD024056
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 19:37:18 GMT
Subject: RE: Labeled networking packets
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Joshua Brindle <jbrindle@tresys.com>,
        Paul Moore <paul.moore@hp.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <36282A1733C57546BE392885C06185920157333E@chaos.tcs.tcs-sec.com>
References: <36282A1733C57546BE392885C06185920157333E@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 15:37:27 -0400
Message-Id: <1158867447.28640.90.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-21 at 13:14 -0400, Venkat Yekkirala wrote:
> > > > Callers of getpeercon() expect it to return a subject 
> > label that they
> > > > can use in a call to e.g. avc_has_perm() as the 
> > source/subject context
> > > > or setexeccon() or (shudder) setcon().  If it returns
> > > > httpd_client_packet_lo_t, then the caller is going to run 
> > into trouble
> > > > upon trying to use the context as a subject label.
> > > 
> > > Yes, the caller is going to run into trouble here, but only 
> > because your
> > > policy
> > > is wanting it, is it not? i.e., a trusted app can always 
> > work in conjunction
> > > with policy (via transitions and whatnot if need be) in 
> > servicing the
> > > request
> > > at the appropriate label.
> > 
> > I doubt it will work in all cases. And returning a label when 
> > in fact we
> > don't have the information (e.g., when only using secmark)
> 
> The reality is that you DO have the information.

No you don't - with secmark you have information about the packet, but
not the sending process. You can potentially infer information, but that
is all.

>  The source of the info
> has entirely to do with the network layout/configuration, resulting
> in the use of externally labeled packets Vs. internal. E.g. All the data
> coming thru a Secret interface is Secret.

That is the distinction I'm trying to make - network layout or
configuration effects the label of the packet. The process that sent
that object is different. This becomes - I think - more important when
you begin to use this information for more than MLS style
confidentiality.

>  It doesn't matter whether the
> data was labeled as such prior to entering which it may not for reasons
> of performance, trust in the underlying network hardware, etc.
> 

I agree that it doesn't matter whether the packet was labeled on the
current or sending machine - but it still says nothing about the context
of the originating process.

Actually, let me modify that a bit. With the current ipsec labeling you
could set up things so that packets are labeled with a context that
implies something about the packet itself (e.g., http_packet_t). The
current proposal does _not_ do this.

Currently ipsec transfers information about the sending process. In the
MLS world these are the same - a secret process sends secret packets -
but with type enforcement things can and usually are different.
Maintaining this differentiation is important.

Policy that deals with the packet object class is enforcing access based
on the security attributes of the packet (usually implied by network
layout, etc.). Applications that use getpeercon are enforcing access
based on the security context of the sending application. Different
concepts, different objects, and, therefore, different labels. I think
mixing these two things is not a good idea.

> > changes the
> > semantics of this call. The call should indicate what 
> > information it has
> > by returning an error without ipsec or netlabel.
> 
> You could simulate the error by letting httpd_client_packet_lo_t
> run into trouble for example; or smartly handle it via policy
> transitions, etc.
> 

This obscures the fact that there is no _explicit_ data about the
sending process.

> > 
> > I also think this change is confusing which object class we 
> > are dealing
> > with. Packets are a separate object from a process. Yes packets may
> > inherit the context of the process in some circumstances, but they
> > remain distinct objects.
> 
> Agreed and I don't see where we are changing this.
> 

Of course this is a change - see above.

> > Making getpeercon return the packet label is
> > returning the label of the wrong object.
> 
> If a packet arrived at the sock as Secret (the details of how it came
> to assume that label is again to do with considerations of network
> layout, trust, and such as mentioned earlier), it OUGHT to be treated
> as having come from a Secret peer.
> 

Again, this implied relationship only makes sense for MLS. With type
enforcement there is no sane way to infer the process type from the
packet type.

For example, firefox_t, wget_t, rss_aggregator_t might be types for
applications that all generate packets of type http_packet_t.
Differentiating these makes it possible to assign the _correct_
equivalence type to the packets that is distinct from the application
that generated it. This is what most policy would want to deal with.

A security aware application, however, might want to enforce
finer-grained access control over urls based on the context of the
application (e.g., rss_aggregator_t can only access urls that return rss
data).

> > 
> > I started to write a long post on scenarios where the 
> > distinction would
> > be important, but honestly I think it comes down to what I said above.
> 
> I would like to look at a couple.
> 

There is one above, though somewhat contrived. In general, though, we
might want to:

1) Have 1 process context generated multiple packet types. bind_t might
generate packets of type dns_packet_t and zone_transfer_t. Or a
multi-level trusted app might generate both secret and top-secret packet
types while its label is top-secret.

2) Have 2 processes generate the same packet types - see above.

3) Have 1 process generate 1 packet context that is different from the
process context (e.g., httpd_t generates http_packet_t).

The reciever of these packets might want to enforce security based on
any of the above attributes (packet or process). By collapsing these
into a single type you lose information.

> > We have two objects and each object should be labeled 
> > independently. It
> > might be possible to use transition rules to combine the information
> > from the two labels into a third (which is essentially what would be
> > happening), but it mis-represents the underlying system and 
> > is going to
> > be difficult to manage. It would require an explosion of types to not
> > lose information (i.e., one type for every possible process / packet
> > type pair).
> 
> Not necessarily, you would do the extra rules only when you ARE
> using labeled IPSec and that too when you aren't interested in
> your trusted app seeing the IPSec Type. That's the only time you
> would do transitions. The reconciliation logic is about progressively
> refining the label of the packet all the while making sure, secmark
> and such have a say in it.
> 
> > 
> > The reconciliation scheme currently changes the semantics of both
> > getpeercon and the new packet object classes in what I see as
> > non-intuitive ways. Apps and policy will have to take into 
> > account which
> > labeling mechanism is in use (e.g., the packet object class 
> > checks will
> > sometimes get packet types and sometimes get process types
> 
> Where are they getting the process types?
> 

The current ipsec proposals labels the packet with the process context
by default, correct? (yes, I know that you can set up different mappings
manually - I'm trying to talk about what will be the most widely used
config) This is in keeping with the spirit of CIPSO I think, where you
are transferring the process labels. In this case the packet rules would
see something like httpd_t instead of what you would see with secmark
currently - http_packet_t (well, http_server_packet_t.

> > - same for
> > getpeercon). It seems like this will require additional 
> > policy and code.
> 
> I would appreciate an example.

This is assuming that we are trying to deploy a single policy to cover
both secmark alone and secmark plus ipsec (which is what we and probably
the other distros want to ship). Currently you need to:

1) For non-selinux aware apps: generate additional allow rules to allow
both receipt of addition types for packet objects (e.g, http_packet_t
and httpd_t) _or_ create type transition rules that generate
http_packet_t or a 3rd type when secmark and ipsec are both used (which
would need more allow rules if a 3rd type is generated).

2) For selinux-aware apps: manually make calls to resolve type_change
rules or be prepared to handle multiple types (again with more policy to
allow the additional types). This is essentially a work-around for the
fact that you aren't getting back the process type.

> > 
> > The simplest solution is to keep the labels separate as Josh 
> > suggested.
> 
> The thing I am trying to understand is, why would an app want
> to know the entry/exit point context?

I don't agree with your model that secmark is an entry/exit point.

My assertion is that there is a packet type and a process type - secmark
sets the packet type and, currently, ipsec stores the process type in
the SA for the packet (implies, whatever). Keeping those separate allows
you to see either the label of the packet of the label of the process.

>  This context is now for
> flow control checks. I believe a lot of the confusion here
> might have to do with naming.
> 

No, it is that I don't agree with the proposed model. I think that it
confuses several concepts and obscures the underlying architecture.

> > However, I think that it would be better to pass packet and process
> > labels over ipsec but that would likely be a fundamental change to the
> > ipsec labeling model.
> 
> More info and checks are always good, but from a complexity and performance
> standpoint
> why couldn't we have the source machine worry about resolving the two
> labels? 

Because they are logically distinct.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
