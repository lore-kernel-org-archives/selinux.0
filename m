Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MJlsFJ032162
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 15:47:54 -0400
Subject: Re: Labeled networking packets
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Paul Moore <paul.moore@hp.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <1158937085.17541.27.camel@twoface.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443997@exchange.columbia.tresys.com>
	 <1158929251.7748.224.camel@moss-spartans.epoch.ncsc.mil>
	 <1158930147.17541.10.camel@twoface.columbia.tresys.com>
	 <4513F790.9020603@hp.com>
	 <1158937085.17541.27.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 15:49:10 -0400
Message-Id: <1158954550.19877.49.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 10:58 -0400, Joshua Brindle wrote:
> Right, that is all well and good as long as netlabel is MLS only. I
> don't think we should be making assumptions like checking that the
> netlabel is within the range of the SA label if there is ever an
> expectation of doing full contexts in netlabel.

As far as core SELinux is concerned, it is just a permission check
between the labels; the MLS logic remains encapsulated in a
mlsconstraint on that permission.  As far as the types are concerned,
various options are possible, from requiring strict equality (i.e. type
in the netlabel context must equal the type in the SA label) to allowing
more complex relationships, which isn't inconceivable.

> Further, I don't think we've fully understood each other yet. I don't
> want the SA label used for anything except permission checks. The SA
> label is the 'local socket' label for an association and isn't
> interesting at all. The label returned with getpeercon() should be a
> domain label that is negotiated by racoon.

I think there is a basic misunderstanding here of how IPSEC labeling
works.  The context information always comes from the SA; the only
question is how the SA context is computed in the first place by the
sender.  There is no other source of context information for received
packets.  racoon just handles the out-of-band exchange with the peer
racoon to set up the SA before the IPSEC-protected traffic can begin to
flow.  When a packet is received, the SPI in the IPSEC header can be
looked up to find the SA, and the SA then contains the context to use
for the packet (whether you interpret that context as the peer context
or data context or whatever).

> I think we've mostly agreed that getpeercon() should be returning
> domains, now the question is how. Assuming the racoon thing works we can
> get one from ipsec, and netlabel obviously has a labeling scheme. If
> both are in use we have an ambiguous label which I think is an error, I
> don't think trying to reconcile both labels using a type_transition is
> the right way to go (domain_a->domain_b == new_domain?), I'm not even
> sure what the ramifications are there. 
> 
> Do you have a scenario where one might want both labeling schemes at the
> same time? Note that if you need netlabel (legacy os on the other side)
> and you also want ipsec for integrity then the isakmp negotiation would
> not include a context and netlabel would be used.

Fine-grained per-packet labeling on a shared SA.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
