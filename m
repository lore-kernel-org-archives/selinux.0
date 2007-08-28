Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SGDOkj013532
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 12:13:24 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SGDMFZ025907
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 16:13:23 GMT
Message-ID: <D709A20F2164C84E8B7014B0301F5EF8521401@HAVOC.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Paul Moore <paul.moore@hp.com>, Darrel Goeddel <sedgoeddel@gmail.com>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: RE: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 12:13:03 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

(snip)
> Hmm, so in summary, you (TCS) don't see a need for flow 
> control of 
> fallback 

or generically peer (right?; just trying to make sure I am not missing
anything subtle here ...)

> labels with granularity greater then a single host and if 
> really pushed 
> interface level granularity would most likely suffice.  I'll 
> venture that 
> host/network level granularity might be nice for normal users 
> who only have 
> one interface which connects to multiple networks, e.g. the 
> person sitting at 
> home on a private home network which also connects to the 
> big-bad-internet 
> via a nat box provided by their ISP.

You are right. I think the whole thing boils down to what you trust and
this can theoretically vary from case to case. For example, if one trusts
a host to compartmentalize/segregate/mac services appropriately but cannot
do OTW labeling, and they trust the network path to it (say by use of
IPSec),
it's conceivable that they may want the ability to fallback per-port
(granted
it could get challenging with the use of ephemeral ports by clients) and
further
flow-control per-port as well. But I guess we could always start with the
current ideas on what can *reasonably* and *commonly* be trusted, which it
looks like would be the netif and the node (usually using IPSec as you
mention below)
and see how far that will take us in the real world. At least this should
meet
our current needs. I would be curious to see specifically what other current
users such as Joe Nall, Ted Toth and others would like to see. IOW, will
this
meet their needs. An explicit (N)ACK would be great.

> 
> This now has me rethinking the need for a full featured 
> netfilter based 
> mechanism for flow control (SECFILTER).  I'm wondering if we 
> would be better 
> served by simple hooks in the network device layer for in/out 
> and possible 
> forward.  As James pointed out in the off-list discussion, the whole 
> netfilter mechanism seems like a bit much for what we actually need.

Agreed.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
