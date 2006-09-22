Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MLh19U003161
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 17:43:01 -0400
Message-ID: <36282A1733C57546BE392885C0618592015735C7@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>, Joshua Brindle <jbrindle@tresys.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Karl MacMillan
	 <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>, Paul Moore <paul.moore@hp.com>,
        latten@austin.ibm.com, jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson
	 <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
Date: Fri, 22 Sep 2006 17:42:36 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> On Fri, 22 Sep 2006, Joshua Brindle wrote:
> 
> > Once again, I don't think the "ts data coming into a secret 
> SA" makes
> > sense.

Where did I suggest this? All that we are trying to enforce are
flow control checks to *prevent* this from happening, for added
assurance.

> If that happens your policy is broken,

Not necessarily. Consider the forwarding scenario where data is
coming in thru a Top Secret interface and leaving thru a
 Secret interface. Currenlty you have *nothing* to prvent that.

> this data shouldn't be
> > allowed in at all
> let alone having magic level changes to 
> let it happen.

Nice combination of words :), but "magic level changes to let it happen"
isn't happening at all. In fact the whole effort here is to prevent this
among others.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
