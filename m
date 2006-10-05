Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k95N5phJ006753
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 19:05:51 -0400
Received: from mail5.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k95N4cqJ013346
	for <selinux@tycho.nsa.gov>; Thu, 5 Oct 2006 23:04:38 GMT
Date: Thu, 5 Oct 2006 19:05:48 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: David Miller <davem@davemloft.net>, paul.moore@hp.com,
        netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        eparis@redhat.com, johnpol@2ka.mipt.ru, herbert@gondor.apana.org.au
Subject: RE: [PATCH 1/3] Fix for IPsec leakage with SELinux enabled - V.03
In-Reply-To: <36282A1733C57546BE392885C0618592015CFB65@chaos.tcs.tcs-sec.com>
Message-ID: <Pine.LNX.4.64.0610051903500.26861@d.namei>
References: <36282A1733C57546BE392885C0618592015CFB65@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 5 Oct 2006, Venkat Yekkirala wrote:

> > We're trying to fill the flow cache here.  In the case where we'd
> > have a match in both the sub-policy and main table, I think the
> > sub-policy is supposed to take precedence, and if you fail to get
> > this sub-policy you should fail the entire lookup.
> 
> Which is what's happening here correct?

Yes, the patch is correct for this.

The way sub-policy is used is during Mobile IP, where you have multiple 
policies composed, so it wouldn't make sense for one of the policies to be 
rejected and the other allowed and for packets to flow.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
