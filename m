Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PLkO91029182
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 17:46:24 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PLjnaU016306
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 21:45:51 GMT
Message-ID: <36282A1733C57546BE392885C0618592015737BB@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Chad Hanson
	 <chanson@TrustedCS.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Venkat Yekkirala
	 <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle
	 <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
Date: Mon, 25 Sep 2006 17:46:05 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> But the secmark often tells you nothing about the data origin, or even
> the way it entered the system, at least as currently employed by
> refpolicy / netfilter_contexts.  That's my point.

This is still a little hazy in my mind; as to why secmark is being
employed this way. What are the kinds of threats this is designed
to handle?

Could we not look at data in transit as sort of an extension of
the remote socket into the local machine?

Could we then not look at the "packet" (as well as any other networking
element) as a "sub-domain" Type a la the socket?

Could we not replace secmark with "security check points" defining
the "domains" that can come/leave thru (unlabeled_t or such in the
unlabeled case), as well as the default domain to be assigned in
the absence of an explicit domain defined for the packet?

What kind of threats can be handled in secmark that can NOT be
handled in the latter?


> 
> You can certainly create custom iptables secmark rules that label
> packets based on the receiving NIC, and then they would be 
> useful in the
> manner you describe.  But in general, they aren't guaranteed 
> to tell you
> anything about the origin at all.

It would, depending on the network layout correct?

For example, you could treat ALL the traffic to port 80 from a certain
node (not running SELinux) to be in the "domain" mozilla_t, if your
network/system layout/configuration is such that ONLY that kind of traffic
(as opposed to rss_aggregator_t) is assured to come thru that "security
point"
correct?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
