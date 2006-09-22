Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8M0iaKh031263
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 20:44:36 -0400
Message-ID: <36282A1733C57546BE392885C061859201573443@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
        Joshua Brindle
	 <jbrindle@tresys.com>, Paul Moore <paul.moore@hp.com>,
        latten@austin.ibm.com, jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Thu, 21 Sep 2006 20:44:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[Sorry, this is long but couldn't pare it down much to keep context]

> > > I doubt it will work in all cases. And returning a label when 
> > > in fact we
> > > don't have the information (e.g., when only using secmark)
> > 
> > The reality is that you DO have the information.
> 
> No you don't - with secmark you have information about the packet, but
> not the sending process. You can potentially infer 
> information, but that
> is all.

As you note later, with labeled-ipsec, you have the label on the
sending process as well.

> 
> >  The source of the info
> > has entirely to do with the network layout/configuration, resulting
> > in the use of externally labeled packets Vs. internal. E.g. 
> All the data
> > coming thru a Secret interface is Secret.
> 
> That is the distinction I'm trying to make - network layout or
> configuration effects

I know you meant to say "affects" here, and I was arguing that it
actually "effects" (or conveys) the label of the packet. :)

> the label of the packet. The process that sent
> that object is different.

True. And where you do infact need to differentiate based on the process
(rss_aggregator_t), you use labeled-ipsec and convey BOTH the packet Type
and the Process Type as rss_aggregator_http_packet_t (using a transition) to
the
app. Voila, your app is now able to make decisions based on BOTH the attribs
using a single sid.

> This becomes - I think - more important when
> you begin to use this information for more than MLS style
> confidentiality.
> 
> >  It doesn't matter whether the
> > data was labeled as such prior to entering which it may not 
> for reasons
> > of performance, trust in the underlying network hardware, etc.
> > 
> 
> I agree that it doesn't matter whether the packet was labeled on the
> current or sending machine - but it still says nothing about 
> the context
> of the originating process.

It does when you use labeled-ipsec and when you convey BOTH the packet
Type and the process Type to the app in a single sid. And we could
change the name of getpeercon() to be more meaningful/accurate to,
say getdatacon(), if need be.

> 
> Actually, let me modify that a bit. With the current ipsec 
> labeling you
> could set up things so that packets are labeled with a context that
> implies something about the packet itself (e.g., http_packet_t). The
> current proposal does _not_ do this.

It actually does, via the transition logic, as mentioned in the previous
comment.

> 
> Currently ipsec transfers information about the sending 
> process. In the
> MLS world these are the same - a secret process sends secret packets -
> but with type enforcement things can and usually are different.
> Maintaining this differentiation is important.
> 
> Policy that deals with the packet object class is enforcing 
> access based
> on the security attributes of the packet (usually implied by network
> layout, etc.). Applications that use getpeercon are enforcing access
> based on the security context of the sending application. Different
> concepts, different objects, and, therefore, different labels. I think
> mixing these two things is not a good idea.

As opposed to mixing the two, we are actually resolving/reconciling
the two for proper access control (in assuring rss_aggregator_http_t
can only access the rss stuff, in your example).

> 
> > > changes the
> > > semantics of this call. The call should indicate what 
> > > information it has
> > > by returning an error without ipsec or netlabel.
> > 
> > You could simulate the error by letting httpd_client_packet_lo_t
> > run into trouble for example; or smartly handle it via policy
> > transitions, etc.
> > 
> 
> This obscures the fact that there is no _explicit_ data about the
> sending process.

As determined/enforced by policy, correct.

I see 3 scenarios here:

1. You use the iptables rule to tell you the packet Type in conjunction
   with a labeled-ipsec SA that tells you the process type. You are
   then conveying BOTH to the app, using transition rules, in a single
   context (perhaps better regarded as a "data" context as opposed to a
   pure peer context).

2. You aren't using labeled-ipsec, you are on a (usually a trusted) network
and you
   have chosen to convey the data (thru explicit/deliberate network
   layout/config) about the sending process, where you have setup your
   iptables rule with the sending proc's context.

3. You aren't using labeled-ipsec, you are on the Internet, and you have
   the packet Type initially, and your policy would then treat it
accordingly.

> 
> > > 
> > > I also think this change is confusing which object class we 
> > > are dealing
> > > with. Packets are a separate object from a process. Yes 
> packets may
> > > inherit the context of the process in some circumstances, but they
> > > remain distinct objects.
> > 
> > Agreed and I don't see where we are changing this.
> > 
> 
> Of course this is a change - see above.
> 
> > > Making getpeercon return the packet label is
> > > returning the label of the wrong object.
> > 
> > If a packet arrived at the sock as Secret (the details of 
> how it came
> > to assume that label is again to do with considerations of network
> > layout, trust, and such as mentioned earlier), it OUGHT to 
> be treated
> > as having come from a Secret peer.
> > 
> 
> Again, this implied relationship only makes sense for MLS. With type
> enforcement there is no sane way to infer the process type from the
> packet type.

There is, per scenario 2 in the precious comment. And where you can't
infer, you acknowledge that in the policy, by optionally transitioning
to unlabeled_http_packet_t and treating it accordingly.

> 
> For example, firefox_t, wget_t, rss_aggregator_t might be types for
> applications that all generate packets of type http_packet_t.
> Differentiating these makes it possible to assign the _correct_
> equivalence type

This is what we are doing using transitions.

> to the packets that is distinct from the application
> that generated it. This is what most policy would want to deal with.
> 
> A security aware application, however, might want to enforce
> finer-grained access control over urls based on the context of the
> application (e.g., rss_aggregator_t can only access urls that 
> return rss
> data).

Yes, this can be done as mentioned earlier.

> 
> > > 
> > > I started to write a long post on scenarios where the 
> > > distinction would
> > > be important, but honestly I think it comes down to what 
> I said above.
> > 
> > I would like to look at a couple.
> > 
> 
> There is one above, though somewhat contrived. In general, though, we
> might want to:
> 
> 1) Have 1 process context generated multiple packet types. 
> bind_t might
> generate packets of type dns_packet_t and zone_transfer_t. Or a
> multi-level trusted app might generate both secret and 
> top-secret packet
> types while its label is top-secret.

It's in fact this packet type that would come across labeled-ipsec
in this scenario. If you also wanted to convey the process Type,
use bind_zone_transfer_t so the ipsec SA will use this context.

> 
> 2) Have 2 processes generate the same packet types - see above.

Again, you could always convey BOTH the packet label and the proc
label, by sort of commingling them.

> 
> 3) Have 1 process generate 1 packet context that is different from the
> process context (e.g., httpd_t generates http_packet_t).

Yes, this is (http_packet_t) is what would normally come across via
labeled-ipsec.

> 
> The reciever of these packets might want to enforce security based on
> any of the above attributes (packet or process). By collapsing these
> into a single type you lose information.

There's no loss of info. You are using transitions to weld, if you will,
the two together. You only "lose" info, when you don't properly weld.

> 
> > > We have two objects and each object should be labeled 
> > > independently. It
> > > might be possible to use transition rules to combine the 
> information
> > > from the two labels into a third (which is essentially 
> what would be
> > > happening), but it mis-represents the underlying system and 

The "mis-representation" will depend on how well the policy is written.
No different from having these two labels all the way thru, but not
having the policy done correctly to use them.

> > > is going to
> > > be difficult to manage. It would require an explosion of 
> types to not
> > > lose information (i.e., one type for every possible 
> process / packet
> > > type pair).

You wouldn't do it for all possible process/packet type pairs.
You would define a process-packet Type only where you need to have
BOTH the elements (such as in the httpd/rss_aggregator
scenario like you mentioned earlier). What other scenarios come
to mind here?

> > 
> > Not necessarily, you would do the extra rules only when you ARE
> > using labeled IPSec and that too when you aren't interested in
> > your trusted app seeing the IPSec Type. That's the only time you
> > would do transitions. The reconciliation logic is about 
> progressively
> > refining the label of the packet all the while making sure, secmark
> > and such have a say in it.
> > 
> > > 
> > > The reconciliation scheme currently changes the semantics of both
> > > getpeercon

Perhaps we can rename this to getdatacon or something like that. Or
perhaps just better document getpeercon.

> and the new packet object classes in what I see as
> > > non-intuitive ways. Apps and policy will have to take into 
> > > account which
> > > labeling mechanism is in use (e.g., the packet object class 
> > > checks will
> > > sometimes get packet types and sometimes get process types

As long as the policy just worries about the "data" context, things
should be OK.

> > 
> > Where are they getting the process types?
> > 
> 
> The current ipsec proposals labels the packet with the process context
> by default, correct? (yes, I know that you can set up 
> different mappings
> manually - I'm trying to talk about what will be the most widely used
> config) This is in keeping with the spirit of CIPSO I think, where you
> are transferring the process labels. In this case the packet 
> rules would
> see something like httpd_t instead of what you would see with secmark
> currently - http_packet_t (well, http_server_packet_t.
> 
> > > - same for
> > > getpeercon). It seems like this will require additional 
> > > policy and code.
> > 
> > I would appreciate an example.
> 
> This is assuming that we are trying to deploy a single policy to cover
> both secmark alone and secmark plus ipsec (which is what we 
> and probably
> the other distros want to ship). Currently you need to:
> 
> 1) For non-selinux aware apps: generate additional allow 
> rules to allow
> both receipt of addition types for packet objects (e.g, http_packet_t
> and httpd_t) _or_ create type transition rules that generate
> http_packet_t or a 3rd type when secmark and ipsec are both 
> used (which
> would need more allow rules if a 3rd type is generated).

You don't have to always do everything you mention. For example:

1. Only one allow rule for httpd_t, if your app MUST be using ipsec
   or if IPSec is optional, another allow rule for http_packet_t.
or
2. A transition to http_packet_t and an allow rule for http_packet_t
   (which you should currently have anyway).
or
3. A transition to httpd_http_t and an allow rule for httpd_http_t.

So, you are talking only 1 additional rule.

> 
> 2) For selinux-aware apps: manually make calls to resolve type_change
> rules or be prepared to handle multiple types (again with 
> more policy to
> allow the additional types).

A getpeercon() is happening anyway and SELinux had already done its
magic in "appropriately" "commingling" the two labels. So, you would
have just one transition rule in addition to the others that you would
have anyway; you would just use this "data" context in a setexeccon,
avc_has_perm,
etc.

> This is essentially a work-around for the
> fact that you aren't getting back the process type.

You are, if you defined the transitions and ONLY WHEN YOU
REALLY NEED THEM.

> 
> > > 
> > > The simplest solution is to keep the labels separate as Josh 
> > > suggested.
> > 
> > The thing I am trying to understand is, why would an app want
> > to know the entry/exit point context?
> 
> I don't agree with your model that secmark is an entry/exit point.

As viewed currently (as a marking system for packet Types), it's probably
not.

But why can't it be instead a SECPOINT or a SECGATE, which instead defines
the Type of a security point, with all packets coming thru assuming that
Type, and with additional flow control checks to make sure only certain
process Types (via IPSec) can come thru those points?

> 
> My assertion is that there is a packet type and a process 
> type - secmark
> sets the packet type and, currently, ipsec stores the process type in
> the SA for the packet (implies, whatever). Keeping those 
> separate allows
> you to see either the label of the packet of the label of the process.
> 
> >  This context is now for
> > flow control checks. I believe a lot of the confusion here
> > might have to do with naming.
> > 
> 
> No, it is that I don't agree with the proposed model. I think that it
> confuses several concepts and obscures the underlying architecture.

I would instead argue (as I have) that the model actually makes it possible
to handle various scenarios under the current constraints (only one field
on the skb, only one spi field on an IPSec SA, etc.).

> 
> > > However, I think that it would be better to pass packet 
> and process
> > > labels over ipsec but that would likely be a fundamental 
> change to the
> > > ipsec labeling model.
> > 
> > More info and checks are always good, but from a complexity 
> and performance
> > standpoint
> > why couldn't we have the source machine worry about 
> resolving the two
> > labels? 
> 
> Because they are logically distinct.

We very much recognize that they are disctinct and hence the need for
transitions ans what not to handle them accordingly in the policy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
