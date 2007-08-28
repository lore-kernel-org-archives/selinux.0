Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SEwNVx007484
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 10:58:27 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7SEwLbH010871
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 14:58:21 GMT
Received: by wr-out-0506.google.com with SMTP id c8so1143252wra
        for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 07:58:18 -0700 (PDT)
Message-ID: <46D43808.4050008@gmail.com>
Date: Tue, 28 Aug 2007 09:58:16 -0500
From: Darrel Goeddel <sedgoeddel@gmail.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
CC: Paul Moore <paul.moore@hp.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        joe@nall.com, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com>
In-Reply-To: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
<snip>
>> From: Paul Moore [mailto:paul.moore@hp.com]
>> Yes, but you're not really distinguishing between a ssh_t 
>> peer and a http_t 
>> peer, e.g. ssh -p 80, which is what troubles me about port 
>> level granularity.  
>> I sent another mail earlier which I believe described these 
>> concerns a bit 
>> better.
> 
> I missed it earlier. We have been brainstorming on this among
> myself, Chad and Darrel and our current thinking (assuming I am
> putting it forward correctly) is that if one limits trust to the
> interface, it actually seems to make sense to allow defaults at
> just the interface level and further it seems to make sense to
> have the same level of granularity for both the fallback and the
> filtering case. At least for MLS, it seems enough to have the ability
> to define fallbacks as also perform filtering at just the interface level.
> The question to be debated is if for TE, we need granularity
> beyond the interface for fallbacks and flow-control.

We batted around a bunch of ideas and it almost always seemed that the 
granularity of fallback labels should match the granularity of the flow 
control checks.  As Venkat stated, anything past the netif is really 
extending turst on our part, whether it is for applying a fallback label 
or performing an access check.  If we apply fallbacks at the host level, 
we should also allow flow control at the host level.  It doesn't seem to 
make sense that we would say "info from 1.2.3.4 is SECRET", but not be 
able to "info going to 1.2.3.4 should be SECRET).  I personally don't 
see a current need to go past host for either, and even host *could* be 
argued away in my eyes.  That being said, I would never be opposed to 
flexibility.

NOTE that I said almost in my first sentence...  The only "opposing" 
scenario that seemed intuitive to me was apply fallbacks using 
network/netmask only and apply flow checks at interface only.  An 
example of operation would be:

netif access rules:
eth1	SECRET	10.0.1.0/24
eth2	TS	10.0.2.0/24

host fallback labels:
10.0.1.100/32	SYSHI
10.0.1.0/24	SECRET
10.0.2.0/24	TS

That CON host would obviously get denied coming in if it was not using 
some on-the-wire labeling because it would be assigned a label of SYSHI, 
which would be blocked at the netif flow check.  I'm sure something is 
wrong with the host label/netif access check idea, but I can't put my 
finger on it...  Too much trust in the IP address and routing?

Paul, why the netif/host combo in the original netlabel fallback patch? 
  Why not just hosts (or really network/netmask)?  Can we make the

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
