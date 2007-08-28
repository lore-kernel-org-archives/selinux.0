Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SGIVII013973
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 12:18:31 -0400
Received: from smtp111.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7SGITFZ026588
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 16:18:30 GMT
In-Reply-To: <200708281151.07120.paul.moore@hp.com>
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <46D43808.4050008@gmail.com> <200708281151.07120.paul.moore@hp.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4C3962FB-2689-420B-B3E8-F07AF2A48255@nall.com>
Cc: Darrel Goeddel <sedgoeddel@gmail.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        Eric Paris <eparis@parisplace.org>
From: Joe Nall <joe@nall.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 11:18:05 -0500
To: Paul Moore <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Aug 28, 2007, at 10:51 AM, Paul Moore wrote:
>
> Hmm, so in summary, you (TCS) don't see a need for flow control of  
> fallback
> labels with granularity greater then a single host and if really  
> pushed
> interface level granularity would most likely suffice.  I'll  
> venture that
> host/network level granularity might be nice for normal users who  
> only have
> one interface which connects to multiple networks, e.g. the person  
> sitting at
> home on a private home network which also connects to the big-bad- 
> internet
> via a nat box provided by their ISP.

This matches my CMW experience. Interface labeling is a must. Per  
host/net
default labeling is very useful, but isn't a show-stopper. Per host/net
default labeling is particularly useful when testing since most of us  
don't
have a a dozen physical interfaces and associated infrastructure for  
test.

Will interface aliases (eth0:1) be able to take on different labels from
their base interface?

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
