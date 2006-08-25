Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7PEQC3S022577
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 10:26:12 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7PEPaut004214
	for <selinux@tycho.nsa.gov>; Fri, 25 Aug 2006 14:25:37 GMT
Date: Fri, 25 Aug 2006 10:26:04 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chad Hanson <chanson@TrustedCS.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [PATCH 0/3] secid reconciliation-v01: Repost patchset with up
 dates
In-Reply-To: <36282A1733C57546BE392885C0618592014C066C@chaos.tcs.tcs-sec.com>
Message-ID: <Pine.LNX.4.64.0608251025120.23473@d.namei>
References: <36282A1733C57546BE392885C0618592014C066C@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 25 Aug 2006, Venkat Yekkirala wrote:

> > I like these changes, but wondering why you haven't supplied 
> > code for the 
> > outbound case ?
> > 
> > 
> > - James
> 
> The code for the outbound is still in the works. I hope to have it
> out in a week or so.

Ok, I guess we should wait until then before incorporating the patches 
(also, for Paul Moore to return and comment re. CIPSO).


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
