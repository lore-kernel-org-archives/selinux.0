Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SJB2md000420
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 15:11:02 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7SJB0FZ004469
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 19:11:01 GMT
In-Reply-To: <200708281451.53650.paul.moore@hp.com>
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <200708281151.07120.paul.moore@hp.com> <4C3962FB-2689-420B-B3E8-F07AF2A48255@nall.com> <200708281451.53650.paul.moore@hp.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B238200E-66B8-465E-9875-E50FEA7E1CA8@nall.com>
Cc: Darrel Goeddel <sedgoeddel@gmail.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        Eric Paris <eparis@parisplace.org>
From: Joe Nall <joe@nall.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 14:10:36 -0500
To: Paul Moore <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Aug 28, 2007, at 1:51 PM, Paul Moore wrote:

> On Tuesday, August 28 2007 12:18:05 pm Joe Nall wrote:
>>
>> Will interface aliases (eth0:1) be able to take on different  
>> labels from
>> their base interface?
>
> Not sure, it all depends on if an interface alias ends up creating  
> a separate
> net_device struct in the kernel, I don't have the answer to this  
> off the top
> of my head.  What is your preference?

That interface aliases be independently labeled.

joe


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
