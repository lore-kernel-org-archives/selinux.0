Date: Thu, 16 Aug 2007 08:04:41 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Darrel Goeddel <DGoeddel@TrustedCS.com>
cc: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, kaigai@ak.jp.nec.com, joe@nall.com,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
In-Reply-To: <46C37F99.1060406@trustedcs.com>
Message-ID: <Xine.LNX.4.64.0708160711280.30949@us.intercode.com.au>
References: <46C37F99.1060406@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 15 Aug 2007, Darrel Goeddel wrote:

> > 
> > Perhaps I'm missing something, but the send check is necessary for e.g. 
> > "can a httpd_server_t socket send an smtp_client_t packet" ?
> 
> The send check would be necessary for that particular type of check.  In
> the proposed scheme, that particular question would never arise.  The
> skb is merely an extension of the socket, much as the socket is an
> extension of the process.  The question is now "can httpd_server_t
> flow_out of an smtp_t network entity?"  I'm having trouble coming up with
> nice terminology for that one.  How's this for the question - "can an
> httpd_server_t packet go to a destination with certain characteristics?"

I don't see the problem.  The skb is labeled by SECMARK and optionally 
external labeling, and then the check is applied.

There is no need for for new terminology or abstractions, it is simply 
"Can socket_t send packet_t" ?

> > What you're calling fallback labels will likely be the only labels a 
> > normal user encounters.
> 
> That is correct.  In the absence of labeled network (just about all cases),
> the SECMARK facility will provide the label of the peer.

Not really.  It will be a label describing what we know about the packet, 
which in the case of local labeling, is based only on local attributes 
(e.g. destination port, derived from existing connection etc.).

Once external labeling is applied, what we know will become more specific, 
and ultimately, could be the label of the peer.

> >> There's that darn send again...  The flow_out check from SECFILTER is 
> >> really performing the duties of the current send operation.
> > 
> > I think there's a slight misunderstanding here.  I'm proposing not having 
> > SECFILTER at all, and instead adding netif_in and netif_out SELinux hooks.
> 
> That would provide flow control only at the interface level.  That is
> certainly better than the current lack of flow control ability, but it
> does not offer the flexibility of the iptables mechanism.

It's not needed here -- the flexibility is provided in the selection and 
classification of packets.  What you need here is the ability to control 
which interfaces a packet can flow across, and this does not call for the 
use of a generalized and separate mechanism.

> It also gives us
> different controls over forwarded traffic.  Instead of the ability of
> the unique forward check that SECFILTER would provide, we are limited
> to using the in and out netif checks.  We can no longer say that sysadm_t
> traffic can come into the machine, sysadm_t traffic can go out of the
> machine, but sysadm_t traffic can not pass through the machine.

The forward check will be performed via the flow_forward hook.

> > Discussion of security gates and similar I think will really confuse 
> > people, as will the idea of labeling such abstract entities, which is 
> > heading down a similar path to earlier proposals on this topic.
> 
> I think a lot of the previous confusion came from some of the
> following points:
> 
> - trying to use secmark as BOTH an implicit fallback context AND
>  a flow control point
> - the transitions from secmark to xfrm to NetLabel, etc., that were
>  thrown in to allow domain->packet->domain
> 
> I'm avoiding those issues with these simple rules:
> 
> - SECMARK is used only for establishing a fallback context for the peer

Not in the general case, only when external labeling is in use.

> - SECFILTER is used only for performing the flow control checks

Unnecessary and complicated.  SELinux hooks can do this within the 
existing framework.

> - the packet always carries the peer's context, not a data context

What is a "data context"?

The label always simply has the most specific current information about 
the packet.  It may be some default for all packets, it may be based upon 
local attributes, or it may carry the label of the peer.

> >> - a packet goes though "filter points", the packet is the subject and 
> >>   the "filter point" is the object it must pass through (these 
> >>   filters happen
> >>   at input, output, and forwarding)
> > 
> > What they really are is the boundary of network layer of the machine, 
> > which is to say, the boundary of machine itself in terms of network 
> > functionality.  i.e. once a packet is accepted into the IP stack, it can 
> > be forwarded, delivered etc.
> > 
> > So, allowing flow_in means "the packet can flow into this machine", and 
> > similar for flow_forward and flow_out.
> > 
> > The socket recv/send checks are against the endpoint (at least, as 
> > delegated by an authorized endpoint via the socket).
> 
> The recv check makes sense.  The socket is getting a packet from peer
> peer_domain_t:secret, can the socket read that in?  The label of
> peer_domain_t:secret came from the SECMARK mechanism which arrived at
> that label based on the characteristics of the sender.  The
> peer_domain_t:secret could have just as easily been explicitly conveyed
> by the sender.
> 
> Does it make sense to make that check for outgoing traffic?  There is
> no way to have peer-provided information about the receiver, you only
> know where the info is going, not who will actually get it.  Yes, I
> understand that I double standard here because I somehow believe that
> the src characteristics for incoming packets are more useful than the
> dst characteristics for outgoing packets.  I don't love outgoing
> packets any less - I am giving the incoming more credibility because
> there _can_ be real information about the context in that case.

So, you trust the characteristics of a packet arriving from the network 
more than those on locally generated packets?

Keep in mind that we are also able to leverage connection tracking, so the 
vast majority of packet labeling via secmark will have been validated as 
being part of an existing connection.

> Using SECMARK for the target of the outgoing access check means that we
> are back to needing another place to store the "target" info in the skb,

I need a concrete example.  What target information?  How is it used?

> SECFILTER really is doing the same job for outgoing traffic as the current
> usage of SECMARK, the only difference is that the subject comes from the
> skb (same as the socket for locally generated traffic) and the decision
> is made in the SECFILTER module, not delayed (which needs storage) until
> later.

I don't understand.

> I'll bang my head around here to see what kind of functionality would be
> missing (as opposed to the SECMARK/SECFILTER combo) with what you are
> suggesting.  I'll try to come up with some diagrams for the different
> methods that are being discussed to make sure we are on the same page.
> Since you are going for "no SECFILTER", how are you envisioning the
> network layer checks you described before being (flow_in, flow_forward,
> flow_out) handled?  Or are you saying the idea should go, not just the
> SECFILTER way of doing it?

Well, we need something for the forwarding case at least.  Is it enough to 
have just a flow_forward check which matches the packet label against 
kernel_t ?  

e.g. "Can this machine forward a packet labeled intranet_t" ?

> 
> > The netif_in and netif_out allow checking of the packet flowing across 
> > specific physical interfaces.
> > 
> > I don't think we need to add any new abstractions here, and these should 
> > be understandable by people who can configure networking.
> > 
> >> - a socket reading a packet must be able to listen to the peer that 
> >>   created it - a slightly new meaning for current socket vs. secmark 
> >>   access check
> > 
> > I'm not sure what this means.
> 
> The socket vs. secmark check conceptually means "can the local process
> read this type of information" right now. 

The secmark label can be anything at all, so it means whatever its labeled 
with.  e.g. someone could label all traffic passing over eth0 as "secret", 
or "sysadm_t"

> By having the secmark field
> always convey the context of the peer, the check takes on a slightly
> different meaning - "can the local process read information written by
> the peer process?".

As mentioned, it carries the most specific currently available information 
about the packet.  What it means in terms of distributed information flow 
is thus context-specific.

Without a specific field for e.g. peer_sid, which always only means the 
peer, policy development & analysis will need to be "aware" of what the 
label represents in a specific situation.

I think this is an acceptable trade-off, as the users of external labeling 
where such concepts are also critical also tend to have access to policy 
expertise and can tightly control the policy and deployment.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
