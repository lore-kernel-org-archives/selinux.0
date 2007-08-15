Message-ID: <46C37F99.1060406@trustedcs.com>
From: Darrel Goeddel <DGoeddel@TrustedCS.com>
To: James Morris <jmorris@namei.org>
Cc: Paul Moore <paul.moore@hp.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, kaigai@ak.jp.nec.com, joe@nall.com,
        Eric Paris
	 <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Wed, 15 Aug 2007 18:35:05 -0400
MIME-Version: 1.0
in-reply-to: <Pine.LNX.4.64.0708142044300.14855@us.intercode.com.au>
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Morris wrote:
> On Tue, 14 Aug 2007, Darrel Goeddel wrote:
> 
>> The recv check at the socket layer becomes socket (proxy for local 
>> process)
>> receiving information from the secmark (peer process).  This process vs.
>> process style check didn't seem to have a natural fit with sending the
>> information because the peer isn't as well known as it could be in the
>> receive case.  For this reason, send is actually absent in this idea 
>> right now.
>> If there were a process vs. process check on send the peer process could
>> only
>> be identified through the SECMARK fallback labels.
> 
> Perhaps I'm missing something, but the send check is necessary for e.g. 
> "can a httpd_server_t socket send an smtp_client_t packet" ?

The send check would be necessary for that particular type of check.  In
the proposed scheme, that particular question would never arise.  The
skb is merely an extension of the socket, much as the socket is an
extension of the process.  The question is now "can httpd_server_t
flow_out of an smtp_t network entity?"  I'm having trouble coming up with
nice terminology for that one.  How's this for the question - "can an
httpd_server_t packet go to a destination with certain characteristics?"

> What you're calling fallback labels will likely be the only labels a 
> normal user encounters.

That is correct.  In the absence of labeled network (just about all cases),
the SECMARK facility will provide the label of the peer.

>> There's that darn send again...  The flow_out check from SECFILTER is 
>> really performing the duties of the current send operation.
> 
> I think there's a slight misunderstanding here.  I'm proposing not having 
> SECFILTER at all, and instead adding netif_in and netif_out SELinux hooks.

That would provide flow control only at the interface level.  That is
certainly better than the current lack of flow control ability, but it
does not offer the flexibility of the iptables mechanism.  It also gives us
different controls over forwarded traffic.  Instead of the ability of
the unique forward check that SECFILTER would provide, we are limited
to using the in and out netif checks.  We can no longer say that sysadm_t
traffic can come into the machine, sysadm_t traffic can go out of the
machine, but sysadm_t traffic can not pass through the machine.

> Discussion of security gates and similar I think will really confuse 
> people, as will the idea of labeling such abstract entities, which is 
> heading down a similar path to earlier proposals on this topic.

I think a lot of the previous confusion came from some of the
following points:

- trying to use secmark as BOTH an implicit fallback context AND
 a flow control point
- the transitions from secmark to xfrm to NetLabel, etc., that were
 thrown in to allow domain->packet->domain

I'm avoiding those issues with these simple rules:

- SECMARK is used only for establishing a fallback context for the peer
- SECFILTER is used only for performing the flow control checks
- the packet always carries the peer's context, not a data context

>> - a packet goes though "filter points", the packet is the subject and the
>>  "filter point" is the object it must pass through (these filters happen
>>   at input, output, and forwarding)
> 
> What they really are is the boundary of network layer of the machine, 
> which is to say, the boundary of machine itself in terms of network 
> functionality.  i.e. once a packet is accepted into the IP stack, it can 
> be forwarded, delivered etc.
> 
> So, allowing flow_in means "the packet can flow into this machine", and 
> similar for flow_forward and flow_out.
> 
> The socket recv/send checks are against the endpoint (at least, as 
> delegated by an authorized endpoint via the socket).

The recv check makes sense.  The socket is getting a packet from peer
peer_domain_t:secret, can the socket read that in?  The label of
peer_domain_t:secret came from the SECMARK mechanism which arrived at
that label based on the characteristics of the sender.  The
peer_domain_t:secret could have just as easily been explicitly conveyed
by the sender.

Does it make sense to make that check for outgoing traffic?  There is
no way to have peer-provided information about the receiver, you only
know where the info is going, not who will actually get it.  Yes, I
understand that I double standard here because I somehow believe that
the src characteristics for incoming packets are more useful than the
dst characteristics for outgoing packets.  I don't love outgoing
packets any less - I am giving the incoming more credibility because
there _can_ be real information about the context in that case.

Using SECMARK for the target of the outgoing access check means that we
are back to needing another place to store the "target" info in the skb,
or the SECMARK module will be performing the access check (via LSM to
the security server) :(  This is the reason SECFILTER came about - to
separate the labeling mechanism from the enforcement mechanism.  I
think the separation adds clarity.

SECFILTER really is doing the same job for outgoing traffic as the current
usage of SECMARK, the only difference is that the subject comes from the
skb (same as the socket for locally generated traffic) and the decision
is made in the SECFILTER module, not delayed (which needs storage) until
later.

I'll bang my head around here to see what kind of functionality would be
missing (as opposed to the SECMARK/SECFILTER combo) with what you are
suggesting.  I'll try to come up with some diagrams for the different
methods that are being discussed to make sure we are on the same page.
Since you are going for "no SECFILTER", how are you envisioning the
network layer checks you described before being (flow_in, flow_forward,
flow_out) handled?  Or are you saying the idea should go, not just the
SECFILTER way of doing it?

> The netif_in and netif_out allow checking of the packet flowing across 
> specific physical interfaces.
> 
> I don't think we need to add any new abstractions here, and these should 
> be understandable by people who can configure networking.
> 
>> - a socket reading a packet must be able to listen to the peer that 
>>   created it - a slightly new meaning for current socket vs. secmark 
>>   access check
> 
> I'm not sure what this means.

The socket vs. secmark check conceptually means "can the local process
read this type of information" right now.  By having the secmark field
always convey the context of the peer, the check takes on a slightly
different meaning - "can the local process read information written by
the peer process?".

-- 

Darrel



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
