Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MFFcUB022254
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 11:15:38 -0400
Message-ID: <36282A1733C57546BE392885C0618592015734E7@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley
	 <sds@epoch.ncsc.mil>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Karl MacMillan
	 <kmacmillan@mentalrootkit.com>,
        Paul Moore <paul.moore@hp.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Fri, 22 Sep 2006 11:15:27 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> bah, fair enough :\. I guess the reason I was objecting was 
> because the
> objects seem *very* different. standard object and subject transitions
> seem pretty intuitive (I'm in a domain, i execute something, I'm in a
> new domain or directories containing files guiding 
> transitions. packets
> and associations are totally separate and used for totally different
> things. And the other problem was that I don't even know if we were
> *trying* to derive a subject label or not, some of the examples I've
> seen floating around indicate that others don't either.

You can always have getpeercon return a "domain" by turning out a
domain (a unlabeled_t one?) in the non labeled-ipsec case.

> 
> > Seriously, there isn't anything wrong with the notion of using label
> > transitions to capture state from multiple labels, and we 
> do that all
> > the time for _object_ labels.  Where we run into a problem 
> here is the
> > fact that the user of getpeercon() wants a subject label, not an
> > object
> 
> This was my main point

See above.

> This scheme has a new label that is negotiated by racoon and 
> is used as
> the subject label returned by getpeercon(), it is different 
> from what we
> are already doing. The rest would basically be the same, 
> there would be
> no reconciliation.

This won't work for MLS.

> The only thing I'm not sure of here is the
> interaction of the label negotiated by racoon and a cipso label. It
> almost seems like we need to disallow using them at the same time, I
> suspect people might not like this limitation though.

I think Paul has addressed this in his follow-on to this.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
