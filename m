Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8MKjElJ001226
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 16:45:14 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8MKiCEW006947
	for <selinux@tycho.nsa.gov>; Fri, 22 Sep 2006 20:44:14 GMT
Date: Fri, 22 Sep 2006 16:45:07 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Joshua Brindle <jbrindle@tresys.com>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@epoch.ncsc.mil>, Paul Moore <paul.moore@hp.com>,
        latten@austin.ibm.com, jmorris@redhat.com, dwalsh@redhat.com,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Chad Hanson <chanson@TrustedCS.com>, selinux@tycho.nsa.gov
Subject: RE: Labeled networking packets
In-Reply-To: <1158951141.17541.53.camel@twoface.columbia.tresys.com>
Message-ID: <Pine.LNX.4.64.0609221644350.10058@d.namei>
References: <36282A1733C57546BE392885C061859201573525@chaos.tcs.tcs-sec.com>
 <1158951141.17541.53.camel@twoface.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 22 Sep 2006, Joshua Brindle wrote:

> Once again, I don't think the "ts data coming into a secret SA" makes
> sense. If that happens your policy is broken, this data shouldn't be
> allowed in at all let alone having magic level changes to let it happen.

Exactly.  Stop making things so complicated.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
