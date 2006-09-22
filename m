Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MF9qXb022014
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 11:09:52 -0400
Message-ID: <36282A1733C57546BE392885C0618592015734E5@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>,
        Joshua Brindle
	 <jbrindle@tresys.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Karl MacMillan
	 <kmacmillan@mentalrootkit.com>,
        Paul Moore <paul.moore@hp.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Fri, 22 Sep 2006 11:09:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Yes, that would be like computing a process label from an old process
> label and an executable file label.  Or like computing a new 
> file label
> from a process label and a parent directory label.  Who could imagine
> such a thing?  ;)
> 
> Seriously, there isn't anything wrong with the notion of using label
> transitions to capture state from multiple labels, and we do that all
> the time for _object_ labels.  Where we run into a problem here is the
> fact that the user of getpeercon() wants a subject label, not 
> an object
> label.  If the label transition function had an inverse, that might be
> workable,

The "inverse" is the default. The IPSec label is what's returned
by default (in the absence of any transition rules). A transition
can always turn out a "domain" in the non-ipsec case if a domain is
what's needed.

> although I'd hate to require applications to deal 
> with it, but
> it doesn't have an inverse (in general; specific policy may 
> permit such
> inversion, but the function itself provides no such guarantee).
> 
> > And it also isn't what I (personally) want. I want the domain on the
> > other end, I don't want to have to have some incredibly 
> complex setup of
> > associations and secmarks just to get recalculate the 
> context we already
> > had on the other end, I just want it. That is what 
> getpeercon() should
> > return. I don't care either way about getdatacon() but 
> getpeercon should
> > stick around and should get the peer domain.
> 
> Yes, we don't want to change the getpeercon() interface, and we want
> consistent semantics between AF_LOCAL and AF_INET.

Again, a transition can always turn out an appropriate domain, because
we can't have getpeercon() fail in the MLS case.

> 
> > That said, I'm thinking that this scheme should be scrapped 
> and instead
> > we do something like the following: secmark is totally 
> non-relavent to
> > the peer context, it labels packets and I don't believe 
> there is ever a
> > need to know the label of a packet (if there is we can add
> > getpacketcon()). Secmark will be used for enforcement of 
> network flow
> > only.
> 
> That may be the right approach given the divergent purposes of secmark
> vs. labeled networking, but it doesn't resolve what motivated 
> the secid
> reconciliation work in the first place.

The following being the main objectives:

1. Socket-independent flow control at the entry and exit points.
2. Ability to service requests at the lavel of an interface, node, etc.


> 
> >  The security association can have a context, that context will be
> > used for enforcement of polmatch, just like now. The label 
> won't be used
> > for getpeercon(), only to create associations and give 
> access to them.
> > Then the actual domain making the connection can be sent to 
> the remote
> > side by racoon, this should be the label that getpeercon() returns.
> 
> If you just mean that the SA context would come from the 
> flow's context
> rather than the SPD rule, then I think we all agreed to that.  But the
> context is still ultimately stored in the SA and obtained from it by
> getpeercon().  That doesn't change.

That's correct. Whatever is the socket context on the remote end that
will (could) become the SA context.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
