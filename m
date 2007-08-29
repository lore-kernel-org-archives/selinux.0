Message-ID: <46D4EBEA.509@manicmethod.com>
Date: Tue, 28 Aug 2007 23:45:46 -0400
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
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <200708281151.07120.paul.moore@hp.com> <4C3962FB-2689-420B-B3E8-F07AF2A48255@nall.com> <200708281451.53650.paul.moore@hp.com> <B238200E-66B8-465E-9875-E50FEA7E1CA8@nall.com> <46D47C1E.9080307@manicmethod.com> <6F2B62D9-0D4D-4F22-8659-317E9EF65743@nall.com> <46D4BAE1.8010805@manicmethod.com>
In-Reply-To: <46D4BAE1.8010805@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Joe Nall wrote:
>>
>> On Aug 28, 2007, at 2:48 PM, Joshua Brindle wrote:
>>
>>> Joe Nall wrote:
>>>>
>>>> On Aug 28, 2007, at 1:51 PM, Paul Moore wrote:
>>>>
>>>>> On Tuesday, August 28 2007 12:18:05 pm Joe Nall wrote:
>>>>>>
>>>>>> Will interface aliases (eth0:1) be able to take on different 
>>>>>> labels from
>>>>>> their base interface?
>>>>>
>>>>> Not sure, it all depends on if an interface alias ends up creating 
>>>>> a separate
>>>>> net_device struct in the kernel, I don't have the answer to this 
>>>>> off the top
>>>>> of my head.  What is your preference?
>>>>
>>>> That interface aliases be independently labeled.
>>>
>>> I completely agree with Stephen here. Accessing the same physical 
>>> piece of hardware (on the same wire) through a different 'name' 
>>> provides basically nothing.
>>
>> Except convenience. Different IP address, different behavior. I can 
>> be happy either way.
>
> It is misusing an abstraction, the same way as(as Stephen said) having 
> different access control on two paths that refer to the same inode.
>
> It should be no surprise that I was just informed by the apparmor devs 
> that they do plan to allow differing access between interface aliases.
>

the more I think about this the less it matters. Doing labeling based on 
node is really the exact same thing as labeling based on interface aliases.

node 192.168.1.1/24  = net_foo_t
node 192.168.2.1/24  = net_bar_t

or

eth0:1 (which is 192.168.1.1 with /24 netmask) = net_foo_t
eth0:2 (which is 192.168.2.1 with /24 netmask) = net_bar_t

see, no difference :)

So if we allow node based then alias isn't any different. also netfilter 
lets you select on interface aliases so in some way we already allow 
this behavior.

>>
>>> Most people I've talked to aren't even comfortable using nics that 
>>> share the same chips on board (eg., dual nics on the motherboard).
>>
>> We had the same issue with quad port ethernet cards because they had 
>> a shared PCI interface chip. After looking at the driver, the concern 
>> was not wholly unfounded ...
>
> Well.. You still aren't buying anything by avoiding this situation, 
> the drivers are all in the same process space (even if they are 
> different drivers), the same network stack will be used, etc. You 
> might be able to sleep at night but what is the security gain?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
