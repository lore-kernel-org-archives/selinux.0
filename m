Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MF4Zvp021772
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 11:04:35 -0400
Received: from twoface.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MF3UO3004426
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 15:03:34 GMT
Subject: Re: Labeled networking packets
From: Joshua Brindle <jbrindle@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
In-Reply-To: <4513F790.9020603@hp.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588443997@exchange.columbia.tresys.com>
	 <1158929251.7748.224.camel@moss-spartans.epoch.ncsc.mil>
	 <1158930147.17541.10.camel@twoface.columbia.tresys.com>
	 <4513F790.9020603@hp.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 10:58:05 -0400
Message-Id: <1158937085.17541.27.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 10:47 -0400, Paul Moore wrote:
> <snip>
> > This scheme has a new label that is negotiated by racoon and is used
> as
> > the subject label returned by getpeercon(), it is different from
> what we
> > are already doing. The rest would basically be the same, there would
> be
> > no reconciliation. The only thing I'm not sure of here is the
> > interaction of the label negotiated by racoon and a cipso label. It
> > almost seems like we need to disallow using them at the same time, I
> > suspect people might not like this limitation though.
> >
> 
> Since all of the remote network labeling mechanisms, SA and NetLabel
> labeling, are relatively new to Linux I think it's going to be hard to
> say for certain how users will end up using them.  While similar in
> that
> both mechanisms allow remote packet labeling, they acomplish very
> different goals so I think it is reasonable to expect users who need
> remote network labeling to run both SA and NetLabel labels on the same
> system.
> 
so we need to define the limitations now before people start using them
in unexpected ways.

> Ignoring the secmark issue for a moment ...
> 
there is no secmark issue, secmark isn't for labeling.

> Resolving a SA label and a NetLabel label right now isn't too
> difficult.
>  Currently we do two separate checks for each labeling mechanism.  If
> we
> wanted to consolidate the checks into one we could do as Stephen
> originally suggested and check to make sure that the NetLabel label
> falls within the range of the SA label and that the socket was allowed
> to receive packets from the resulting combination (TE from the SA
> context, MLS label from NetLabel).  This becomes a bit more
> complicated
> once NetLabel starts labeling packets with a full context but the
> basics
> would still apply I believe.
> 
Right, that is all well and good as long as netlabel is MLS only. I
don't think we should be making assumptions like checking that the
netlabel is within the range of the SA label if there is ever an
expectation of doing full contexts in netlabel.

Further, I don't think we've fully understood each other yet. I don't
want the SA label used for anything except permission checks. The SA
label is the 'local socket' label for an association and isn't
interesting at all. The label returned with getpeercon() should be a
domain label that is negotiated by racoon.

I think we've mostly agreed that getpeercon() should be returning
domains, now the question is how. Assuming the racoon thing works we can
get one from ipsec, and netlabel obviously has a labeling scheme. If
both are in use we have an ambiguous label which I think is an error, I
don't think trying to reconcile both labels using a type_transition is
the right way to go (domain_a->domain_b == new_domain?), I'm not even
sure what the ramifications are there. 

Do you have a scenario where one might want both labeling schemes at the
same time? Note that if you need netlabel (legacy os on the other side)
and you also want ipsec for integrity then the isakmp negotiation would
not include a context and netlabel would be used.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
