Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9C7QwA2017183
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 03:26:58 -0400
Received: from mail1.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9C7QIhT012876
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 07:26:18 GMT
Date: Thu, 12 Oct 2006 03:26:53 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: Paul Moore <paul.moore@hp.com>, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Venkat Yekkirala <vyekkirala@tcsfw4.tcs-sec.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
Subject: RE: [PATCH 00/11] The _entire_ secid reconciliation patchset (tada!)
In-Reply-To: <001101c6ed6a$43ae71e0$cc0a010a@tcssec.com>
Message-ID: <Pine.LNX.4.64.0610120321200.25038@d.namei>
References: <001101c6ed6a$43ae71e0$cc0a010a@tcssec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 11 Oct 2006, Venkat Yekkirala wrote:

> > Outstanding items include resolving the igmp skb hook issue 
> > generally, 
> > testing to verify both the design and implementation, and 
> > ensuring that 
> > all the related policy changes are merged upstream first.
> > 
> Regarding the igmp hook issue, we could do a generic hook
> like Paul suggested. Would that be more palatable you think?

It needs to be investigated to see if anything else in the kernel is doing 
the same thing, and then most likely, a generic hook for 
classifying non-socket packets (you could pass the protocol as a hook 
parameter).


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
