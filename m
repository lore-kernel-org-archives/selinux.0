Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MFjZjX023452
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 11:45:35 -0400
Message-ID: <36282A1733C57546BE392885C0618592015734F8@chaos.tcs.tcs-sec.com>
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
Date: Fri, 22 Sep 2006 11:45:13 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > You can always have getpeercon return a "domain" by turning out a
> > domain (a unlabeled_t one?) in the non labeled-ipsec case.
> 
> The only thing I don't like about this is that it starts giving
> types/domains implicit meaning that is not defined by policy.

I don't know what you are talking about here. I was saying you
could turn out a "true domain" using transitions.
 
>  I know we
> sort of do that already with some of the MLS attributes

Examples?

> but I 
> think it's
> worth trying to avoid.

Not an issue as long as you get your policy right.

> 
> Plus, what if the remote domain was honestly running in "unlabeled_t"?
> Stupid, yes, but possibile I imagine.

unlabeled_t anywhere is unlabeled. It doesn't matter how it came to be
unlabeled_t.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
