Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k970TwmZ014256
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 20:29:58 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k970ShWt026744
	for <selinux@tycho.nsa.gov>; Sat, 7 Oct 2006 00:28:43 GMT
Message-ID: <36282A1733C57546BE392885C0618592015CFD30@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com
Cc: paul.moore@hp.com, Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>
Subject: RE: Labeled Networking For LSPP: Where we are and where we need t
	o go (quickly)
Date: Fri, 6 Oct 2006 20:29:30 -0400 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> This is great, we are getting there.  But, we still need at least 3-4
> more patches before tomorrow!!
> 
> Patch1: finish the error propagation backport for the ipsec 
> leak (Being
> completed by Eric Paris)
> Patch2: audit ipsec config changes (Being completed by Joy Latten)
> Patch3: find and fix current issues with unlabeled_t packets 
> that can't
> be explained (Paul Moore and Venkat)
I am currently investigating this and hope to have a patch by Monday.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
