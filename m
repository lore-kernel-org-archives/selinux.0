Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MFvBhp024005
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 11:57:11 -0400
Message-ID: <36282A1733C57546BE392885C061859201573500@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>
Cc: Joshua Brindle <jbrindle@tresys.com>,
        Stephen Smalley
	 <sds@epoch.ncsc.mil>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, latten@austin.ibm.com,
        jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Fri, 22 Sep 2006 11:56:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > It IS FOR LABELING as far as MLS is concerned.
> 
> Perhaps we are just overloading the term "labeling".  It kinda sounds
> like the non-MLS folks want to be able to distinguish between "remote
> labeling", i.e. SA or NetLabel, and "local labeling", i.e. secmark.  I
> realize that there are certain users who don't care to make that
> distinction because they can put a certain level of trust in the
> physical network configuration.  However, considering the 
> flexibility of
> SELinux in general I think any built-in assumption is going to upset
> someone.  I think the best idea is to arrive at some sort of policy
> abstraction which would allow either of the behaviors listed above.

This we have attempted to do via transitions.

> 
> For handling incoming packets this may mean that we keep all of the
> packet labeling mechanisms separate, allowing each to have it's own
> permission check.

But how would you then make sure a secret cipso didn't arrive thru a
TopSecret SA?

> 
> For dealing with getpeercon() issues perhaps we only allow "remote
> labeled" contexts to be reported by default, but if policy 
> allows (yes,
> we would need some sort of new allow rule or policy construct) the
> "locally labeled" context could be used as a fallback.
> 
> I know it's not ideal for any one scenario, but I think it may be
> flexibile enough to deal with all of them.

That would mean you would have separate policies.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
