Message-ID: <46D47C1E.9080307@manicmethod.com>
Date: Tue, 28 Aug 2007 15:48:46 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Joe Nall <joe@nall.com>
CC: Paul Moore <paul.moore@hp.com>, Darrel Goeddel <sedgoeddel@gmail.com>,
        Venkat Yekkirala <vyekkirala@TrustedCS.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>,
        Darrel Goeddel <DGoeddel@TrustedCS.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, kaigai@ak.jp.nec.com,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC 0/5] Static/fallback external labels for NetLabel
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <200708281151.07120.paul.moore@hp.com> <4C3962FB-2689-420B-B3E8-F07AF2A48255@nall.com> <200708281451.53650.paul.moore@hp.com> <B238200E-66B8-465E-9875-E50FEA7E1CA8@nall.com>
In-Reply-To: <B238200E-66B8-465E-9875-E50FEA7E1CA8@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
>
> On Aug 28, 2007, at 1:51 PM, Paul Moore wrote:
>
>> On Tuesday, August 28 2007 12:18:05 pm Joe Nall wrote:
>>>
>>> Will interface aliases (eth0:1) be able to take on different labels 
>>> from
>>> their base interface?
>>
>> Not sure, it all depends on if an interface alias ends up creating a 
>> separate
>> net_device struct in the kernel, I don't have the answer to this off 
>> the top
>> of my head.  What is your preference?
>
> That interface aliases be independently labeled.

I completely agree with Stephen here. Accessing the same physical piece 
of hardware (on the same wire) through a different 'name' provides 
basically nothing. Most people I've talked to aren't even comfortable 
using nics that share the same chips on board (eg., dual nics on the 
motherboard). Ofcourse those people are somehow mislead into believing 
that there is any security gain there since all the network data ends up 
in the same place eventually.

OTOH using a single nic with multiple ipsec associations (with different 
keys ofcourse) could provide a benefit, depending on what your 
requirements are.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
