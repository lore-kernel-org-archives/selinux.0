Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MEwCte021482
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 10:58:12 -0400
Message-ID: <36282A1733C57546BE392885C0618592015734DA@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan
	 <kmacmillan@mentalrootkit.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Paul Moore <paul.moore@hp.com>,
        latten@austin.ibm.com, jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Fri, 22 Sep 2006 10:57:54 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> And it also isn't what I (personally) want. I want the domain on the
> other end, I don't want to have to have some incredibly 
> complex setup of

Which you don't need to. The IPSec SA label will prevail by default (no
rules needed) and this is what you will get from getpeercon.

CURRENT POLICY:

1. Allow socket to receive secmark.

NEW POLICY:

1. Allow ipsec (unlabeled when no ipsec) to come thru secmark (secpoint,
secgate whatever).

2. Allow socket to recieve ipsec.

We could have failed when there's no IPSec. But for MLS, the level on the
secmark is as good as the level of the peer and so we can't let getpeercon
fail.

Yes, in the scenarios we deal with anything coming thru the Secret interface
needs to be serviced at Secret.

EXAMPLE:

On the remote end, you have a pol_cli_t socket setup to use labeled IPSec.

Rules on the pol mgr server:

1. allow pol_cli_t pol_pkt_t:packet { flow_in }

2. allow pol_mgr_t pol_cli_t:packet { recv }

getpeercon will return pol_cli_t. No transition rules needed.

> associations and secmarks just to get recalculate the context 
> we already
> had on the other end, I just want it.

> That is what getpeercon() should
> return. I don't care either way about getdatacon() but 
> getpeercon should
> stick around and should get the peer domain.

As far as a peer "domain", it's first of all NOT guranteed to be
a "domain" in the first place. It's whatever context is associated
with the remote context.

> 
> This is of interest to me for the policy management server. 
> We need the
> full context of the client in order to do access control checks on the
> policy updates. That means the context I get from getpeercon() will be
> the source of access checks. Source should always (in this context
> anyway) be a domain.
> This transition scheme gives me some 
> kind of object
> type and I'm not sure it's a domain (or if its anything), 
> just because I
> can create crazy labeling to give the same context doesn't mean it's a
> domain.

The mechanisms have to be agnostic necessarily. It's how you define your
policy with regard to a domain or not.

> 
> And this doesn't even begin to address what a mess managing all this
> labeling is going to be. We haven't even decided how to handle secmark
> rules in distros yet and now we are going to need a whole new set of
> labels (that also have to interact with local non-selinux
> configurations)
> 
> That said, I'm thinking that this scheme should be scrapped 
> and instead
> we do something like the following: secmark is totally non-relavent to
> the peer context, it labels packets and I don't believe there 
> is ever a
> need to know the label of a packet (if there is we can add
> getpacketcon()). Secmark will be used for enforcement of network flow
> only.

The problem is currently there's no flow control at the entry and
exit points for forwarded traffic and such that don't deal with sockets.

> The security association can have a context, that 
> context will be
> used for enforcement of polmatch, just like now. The label 
> won't be used
> for getpeercon(), only to create associations and give access to them.
> Then the actual domain making the connection can be sent to the remote
> side by racoon, this should be the label that getpeercon() 
> returns. Note
> that racoon can send the domain context (default) or if necessary do
> some sort of translation (eg., system_u:object_r:sysadm_t:s0 ->
> system_u:object_r:sysadm_t) or similar, it will be up to the local
> configuration to decide how that works though.
> 
> This is, IMO, a much cleaner, simpler and more pure 
> implementation that
> doesn't try mixing different kinds of objects, each object fits in its
> own place and when we call getpeercon() we know we'll be getting a
> domain that we can use in rule lookups or setexeccon(). 
> 
> If there is no ipsec then getpeercon() returns an error, as it should,
> to let the application asking know that the peer context 
> isn't available

This won't meet the MLS needs as mentioned above.

> (the reconciliation with unlabaled->secmark->somethingelse 
> could be very
> dangerous since the application can't know if it can really trust the
> label)

This trust, you implement in the policy, is it not?

> 
> Comments? I'm starting to look at Joy's racoon patch to see 
> what we can
> do there but I think this is the correct way to handle this problem.
> 
> 
> Joshua Brindle
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
