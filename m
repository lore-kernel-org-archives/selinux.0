Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SHNjsH022278
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 13:23:45 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SHNiFZ011142
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 17:23:44 GMT
Received: by wr-out-0506.google.com with SMTP id c8so1180832wra
        for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 10:23:44 -0700 (PDT)
Message-ID: <46D45A1C.9090703@gmail.com>
Date: Tue, 28 Aug 2007 12:23:40 -0500
From: Darrel Goeddel <sedgoeddel@gmail.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        kaigai@ak.jp.nec.com, joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <46D43808.4050008@gmail.com> <200708281151.07120.paul.moore@hp.com>
In-Reply-To: <200708281151.07120.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Tuesday, August 28 2007 10:58:16 am Darrel Goeddel wrote:
>> Venkat Yekkirala wrote:
>> <snip>
>>
>>>> From: Paul Moore [mailto:paul.moore@hp.com]
>>>> Yes, but you're not really distinguishing between a ssh_t
>>>> peer and a http_t
>>>> peer, e.g. ssh -p 80, which is what troubles me about port
>>>> level granularity.
>>>> I sent another mail earlier which I believe described these
>>>> concerns a bit
>>>> better.
>>> I missed it earlier. We have been brainstorming on this among
>>> myself, Chad and Darrel and our current thinking (assuming I am
>>> putting it forward correctly) is that if one limits trust to the
>>> interface, it actually seems to make sense to allow defaults at
>>> just the interface level and further it seems to make sense to
>>> have the same level of granularity for both the fallback and the
>>> filtering case. At least for MLS, it seems enough to have the ability
>>> to define fallbacks as also perform filtering at just the interface
>>> level. The question to be debated is if for TE, we need granularity
>>> beyond the interface for fallbacks and flow-control.
>> We batted around a bunch of ideas and it almost always seemed that the
>> granularity of fallback labels should match the granularity of the flow
>> control checks.  As Venkat stated, anything past the netif is really
>> extending turst on our part, whether it is for applying a fallback label
>> or performing an access check.  If we apply fallbacks at the host level,
>> we should also allow flow control at the host level.  It doesn't seem to
>> make sense that we would say "info from 1.2.3.4 is SECRET", but not be
>> able to "info going to 1.2.3.4 should be SECRET).  I personally don't
>> see a current need to go past host for either, and even host *could* be
>> argued away in my eyes.  That being said, I would never be opposed to
>> flexibility.
> 
> Hmm, so in summary, you (TCS) don't see a need for flow control of fallback 
> labels with granularity greater then a single host and if really pushed 
> interface level granularity would most likely suffice.  I'll venture that 
> host/network level granularity might be nice for normal users who only have 
> one interface which connects to multiple networks, e.g. the person sitting at 
> home on a private home network which also connects to the big-bad-internet 
> via a nat box provided by their ISP.

I don't see the need for the granularity of flow control mechanisms to 
go beyond the host level.  I also don't see the need to apply fallback 
labels at a granularity greater than host level.  Note that they are 
separate items, not just flow control for fallback labels (as phrased in 
your response), but flow control for all labels.

I agree that the ability to define fallback labels at the host level is 
useful as well, just not absolutely *necessary* (so they are still 
debatable).  Seems easy enough, so we should probably do it.  The only 
really super cool thing with netif only fallback labels and flow checks 
is that the netif rules (unused in the non-compat_net case) already have 
an interface label and a msg label.  Oh the possibilities...

> This now has me rethinking the need for a full featured netfilter based 
> mechanism for flow control (SECFILTER).  I'm wondering if we would be better 
> served by simple hooks in the network device layer for in/out and possible 
> forward.  As James pointed out in the off-list discussion, the whole 
> netfilter mechanism seems like a bit much for what we actually need.

I agree here as well.  It was necessary when I was talking about 
"re-purposing" SECMARK, but not that SECMARK makes it though unscathed, 
I'm not sure it is necessary (hopefully I won't have an epiphany after 
hitting send...).  However, if we are assigning fallback labels at a 
host level granularity, should we restrict flow at the same level?  If 
so, is the iptables mechanism the easiest route (the default unlabeled 
check cimplicates this), or would we want to do a netif flow check and a 
host flow check (using the existing nodecon rules?).

As long as forwarded traffic hit both the in and out flow checks, I 
don't think we need a separate forward check.  The forward check would 
really have to be one of those weird "triplet" checks that would take in 
the peer label, the incoming interface label, and the outgoing interface 
label.  The flow_out check is obvious in postroute_last.  We have a spot 
around xfrm_policy_check where the flow_in check fits nicely and catches 
forwarded traffic as well as locally bound traffic.

>> NOTE that I said almost in my first sentence...  The only "opposing"
>> scenario that seemed intuitive to me was apply fallbacks using
>> network/netmask only and apply flow checks at interface only.  An
>> example of operation would be:
>>
>> netif access rules:
>> eth1	SECRET	10.0.1.0/24
>> eth2	TS	10.0.2.0/24
>>
>> host fallback labels:
>> 10.0.1.100/32	SYSHI
>> 10.0.1.0/24	SECRET
>> 10.0.2.0/24	TS
>>
>> That CON host would obviously get denied coming in if it was not using
>> some on-the-wire labeling because it would be assigned a label of SYSHI,
>> which would be blocked at the netif flow check.  I'm sure something is
>> wrong with the host label/netif access check idea, but I can't put my
>> finger on it...  Too much trust in the IP address and routing?
> 
> Well, we kinda have to trust that IP works correctly as it is beyond our 
> control - we only get to effect the box, not the networks it attached to.  If 
> you can't trust the network make use of something like IPsec which can at 
> least provide you data confidentiality/integrity/auth.
> 
>> Paul, why the netif/host combo in the original netlabel fallback patch?
>>   Why not just hosts (or really network/netmask)?
> {patched in from the other email}
>> Can we make the netif optional or add a wildcard netif?  That would allow
>> for a truly generic fallback if desired.  Currently if you add a new
>> interface, you need to go back and add a new rule (I think, could be wrong
>> since I haven't actually tried it). 
> 
> Sure, I can add a default netif which is used if a match isn't found.  I 
> originally considered adding one (the NetLabel domain mapping mechanism has a 
> default rule match) but it seemed a little "dangerous" at the time, although 
> I think I was just being too cautious.

Cool.  That would give the flexibility to define netif only based 
fallbacks (using 0.0.0.0/0) and host only fallbacks (using the defalut 
if) or some combo of the two.

eth0:0.0.0.0/0		confidential
eth1:0.0.0.0/0		secret
eth2:0.0.0.0/0		ts
any:0.0.0.0/0		systemhigh

or...

any:10.0.1.0/24		confidential
any:10.0.2.0/24		secret
any:10.0.3.0/24		ts
any:0.0.0.0/0		systemhigh

That would work, right?

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
