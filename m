Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MFLNn4022466
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 11:21:23 -0400
Message-ID: <36282A1733C57546BE392885C0618592015734E9@chaos.tcs.tcs-sec.com>
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
Date: Fri, 22 Sep 2006 11:21:07 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> The argument that the incoming interface should be part of setting the
> context because data coming in on a secret interface should 
> be secret is
> a strawman I think. If there is a domain talking to you on a secret
> interface and the domain on the other side isn't secret you have much
> bigger problems. You really want to know *who* you are talking to when
> you do getpeercon(), not how they are talking to you.

For MLS, we care about the later (i.e. "how they are talking to you").
Once data is labeled Secret, it doesn't matter to us *who* lebeled it
Secret.

> 
> 
> > >   Where we run into a problem here is the
> > > fact that the user of getpeercon() wants a subject label, not an
> > object
> > > label.  If the label transition function had an inverse, 
> that might
> > be
> > > workable, although I'd hate to require applications to 
> deal with it,
> > but
> > > it doesn't have an inverse (in general; specific policy may permit
> > such
> > > inversion, but the function itself provides no such guarantee).
> > >
> > > > And it also isn't what I (personally) want. I want the domain on
> > the
> > > > other end, I don't want to have to have some incredibly complex
> > setup of
> > > > associations and secmarks just to get recalculate the context we
> > already
> > > > had on the other end, I just want it. That is what getpeercon()
> > should
> > > > return. I don't care either way about getdatacon() but 
> getpeercon
> > should
> > > > stick around and should get the peer domain.
> > >
> > > Yes, we don't want to change the getpeercon() interface, 
> and we want
> > > consistent semantics between AF_LOCAL and AF_INET.
> > >
> > 
> > We also want consistent policy with different combinations 
> of network
> > labeling mechanisms - which is going to be very difficult 
> to achieve.
> > 
> > > > That said, I'm thinking that this scheme should be scrapped and
> > instead
> > > > we do something like the following: secmark is totally
> > non-relavent to
> > > > the peer context, it labels packets and I don't believe there is
> > ever a
> > > > need to know the label of a packet (if there is we can add
> > > > getpacketcon()). Secmark will be used for enforcement of network
> > flow
> > > > only.
> > >
> > > That may be the right approach given the divergent purposes of
> > secmark
> > > vs. labeled networking, but it doesn't resolve what motivated the
> > secid
> > > reconciliation work in the first place.
> > >
> > 
> > Which was? It appears to me that we need to resolve the Netlabel and
> > ipsec labels and store the result separately from the secid (or
> > whatever
> > the secmark label is). Is that what you are thinking?
> > 
> 
> I don't know about this either. I was under the impression that
> reconciliation was for multiple *data* labels (e.g., using ipsec and
> cipso at the same time). I don't know how secmark ever got pulled into
> this mess, secmark is for labeling packet objects, we never ask (or
> probably care) what the label on an individual packet is.

For the sake of asking, why wouldn't you care that you have receieved
a packet of Type sysadm_pkt_t vs. secadm_pkt_t?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
