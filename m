Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MFafcW023000
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 11:36:41 -0400
Message-ID: <36282A1733C57546BE392885C0618592015734F0@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>, Paul Moore <paul.moore@hp.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
        Karl MacMillan
	 <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Fri, 22 Sep 2006 11:36:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > Ignoring the secmark issue for a moment ...
> > 
> there is no secmark issue, secmark isn't for labeling.

It IS FOR LABELING as far as MLS is concerned.

> 
> > Resolving a SA label and a NetLabel label right now isn't too
> > difficult.
> >  Currently we do two separate checks for each labeling 
> mechanism.  If
> > we
> > wanted to consolidate the checks into one we could do as Stephen
> > originally suggested and check to make sure that the NetLabel label
> > falls within the range of the SA label and that the socket 
> was allowed
> > to receive packets from the resulting combination (TE from the SA
> > context, MLS label from NetLabel).  This becomes a bit more
> > complicated
> > once NetLabel starts labeling packets with a full context but the
> > basics
> > would still apply I believe.
> > 
> Right, that is all well and good as long as netlabel is MLS only. I
> don't think we should be making assumptions like checking that the
> netlabel is within the range of the SA label

Why not? Wouldn't you want to make sure the Secret cipso packet arrived thru
a "Classified to Secret" SA?

> if there is ever an
> expectation of doing full contexts in netlabel.
> 
> Further, I don't think we've fully understood each other yet. I don't
> want the SA label used for anything except permission checks. The SA
> label is the 'local socket' label for an association and isn't
> interesting at all.

It will be interesting if configuration makes sure the SA label is the
"domain" label when negotiated by racoon.

> The label returned with getpeercon() should be a
> domain label that is negotiated by racoon.


> 
> I think we've mostly agreed that getpeercon() should be returning
> domains, now the question is how. Assuming the racoon thing 
> works we can
> get one from ipsec, and netlabel obviously has a labeling scheme. If
> both are in use we have an ambiguous label which I think is 
> an error, I
> don't think trying to reconcile both labels using a type_transition is

No type transitions needed. Just a check to make sure a Secret packet can
come thru a ranged IPSec SA, and if it can then cipso overrides the SA label
(MLS-wise) assumed by the packet.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
