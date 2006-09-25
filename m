Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PM0ZwO029507
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 18:00:35 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PLxVAk003916
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 21:59:33 GMT
Date: Mon, 25 Sep 2006 18:00:29 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: Stephen Smalley <sds@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov,
        Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>, dwalsh@redhat.com,
        jmorris@redhat.com, latten@austin.ibm.com,
        Paul Moore <paul.moore@hp.com>, Joshua Brindle <jbrindle@tresys.com>
Subject: RE: Labeled networking packets
In-Reply-To: <36282A1733C57546BE392885C0618592015737C5@chaos.tcs.tcs-sec.com>
Message-ID: <Pine.LNX.4.64.0609251759010.27442@d.namei>
References: <36282A1733C57546BE392885C0618592015737C5@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Sep 2006, Venkat Yekkirala wrote:

> > > I thin the only real choices are:
> > > 1) Add a separate field to the sk_buff for use by labeled 
> > networking so
> > > that we don't have to overload secmark in this manner, or
> > 
> > This won't fly upstream.
> 
> Do you think the life-cycle management associated with a security
> pointer will unacceptable even when we do it ONLY in the
> SECURITY_NETWORK case?

Yep, it's been rejected before.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
