Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7SMQR6Z014695
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 18:26:27 -0400
Received: from smtp102.sbc.mail.mud.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7SMQPKY025048
	for <selinux@tycho.nsa.gov>; Tue, 28 Aug 2007 22:26:26 GMT
In-Reply-To: <46D47C1E.9080307@manicmethod.com>
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <200708281151.07120.paul.moore@hp.com> <4C3962FB-2689-420B-B3E8-F07AF2A48255@nall.com> <200708281451.53650.paul.moore@hp.com> <B238200E-66B8-465E-9875-E50FEA7E1CA8@nall.com> <46D47C1E.9080307@manicmethod.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6F2B62D9-0D4D-4F22-8659-317E9EF65743@nall.com>
Cc: Paul Moore <paul.moore@hp.com>, Darrel Goeddel <sedgoeddel@gmail.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        Eric Paris <eparis@parisplace.org>
From: Joe Nall <joe@nall.com>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
Date: Tue, 28 Aug 2007 17:26:01 -0500
To: Joshua Brindle <method@manicmethod.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Aug 28, 2007, at 2:48 PM, Joshua Brindle wrote:

> Joe Nall wrote:
>>
>> On Aug 28, 2007, at 1:51 PM, Paul Moore wrote:
>>
>>> On Tuesday, August 28 2007 12:18:05 pm Joe Nall wrote:
>>>>
>>>> Will interface aliases (eth0:1) be able to take on different  
>>>> labels from
>>>> their base interface?
>>>
>>> Not sure, it all depends on if an interface alias ends up  
>>> creating a separate
>>> net_device struct in the kernel, I don't have the answer to this  
>>> off the top
>>> of my head.  What is your preference?
>>
>> That interface aliases be independently labeled.
>
> I completely agree with Stephen here. Accessing the same physical  
> piece of hardware (on the same wire) through a different 'name'  
> provides basically nothing.

Except convenience. Different IP address, different behavior. I can  
be happy either way.

> Most people I've talked to aren't even comfortable using nics that  
> share the same chips on board (eg., dual nics on the motherboard).

We had the same issue with quad port ethernet cards because they had  
a shared PCI interface chip. After looking at the driver, the concern  
was not wholly unfounded ...

joe

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
