Message-ID: <46D59F48.6050409@manicmethod.com>
Date: Wed, 29 Aug 2007 12:31:04 -0400
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
References: <D709A20F2164C84E8B7014B0301F5EF8521359@HAVOC.tcs-sec.com> <200708281151.07120.paul.moore@hp.com> <4C3962FB-2689-420B-B3E8-F07AF2A48255@nall.com> <200708281451.53650.paul.moore@hp.com> <B238200E-66B8-465E-9875-E50FEA7E1CA8@nall.com> <46D47C1E.9080307@manicmethod.com> <6F2B62D9-0D4D-4F22-8659-317E9EF65743@nall.com> <46D4BAE1.8010805@manicmethod.com> <46D4EBEA.509@manicmethod.com> <46D4F1E2.4050503@manicmethod.com> <EBD2E826-9E36-4864-965E-2A5A134DF3B2@nall.com> <46D57D0B.3020005@manicmethod.com> <0FFB12A4-D5D8-4742-AD4A-9B4ADDC57EA5@nall.com>
In-Reply-To: <0FFB12A4-D5D8-4742-AD4A-9B4ADDC57EA5@nall.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe Nall wrote:
>
> On Aug 29, 2007, at 9:04 AM, Joshua Brindle wrote:
>
>> Joe Nall wrote:
>>>
>>> On Aug 28, 2007, at 11:11 PM, Joshua Brindle wrote:
>>>>>
>>>>> the more I think about this the less it matters. Doing labeling 
>>>>> based on node is really the exact same thing as labeling based on 
>>>>> interface aliases.
>>>>>
>>>>> node 192.168.1.1/24  = net_foo_t
>>>>> node 192.168.2.1/24  = net_bar_t
>>>>>
>>>>> or
>>>>>
>>>>> eth0:1 (which is 192.168.1.1 with /24 netmask) = net_foo_t
>>>>> eth0:2 (which is 192.168.2.1 with /24 netmask) = net_bar_t
>>>>>
>>>>> see, no difference :)
>>>>>
>>>>> So if we allow node based then alias isn't any different. also 
>>>>> netfilter lets you select on interface aliases so in some way we 
>>>>> already allow this behavior.
>>>>
>>>> Ok, I think my brain is still catching up on this thread. Because 
>>>> of what I said above I think we should 1) not do node based 
>>>> fallbacks and 2) not do nic alias-level fallbacks. This is the safe 
>>>> option (as already pointed out) and minimizes trust in 
>>>> untrustworthy things (eg., addresses coming from the network).
>>>
>>> If we install and maintain a router (in a locked box with IP admin 
>>> disabled), we are allowed to trust (label based on) the router's IP 
>>> address. If we put a single PC behind the router and NAT or route to 
>>> it specifically, we are allowed to trust the IP address of the PC 
>>> (since it is provided by the router). So there are circumstances 
>>> where the IP address of an untrustworthy OS is itself trustworthy in 
>>> the eyes of our accreditors.
>>>
>>
>> eh? Except not. anything on the same lan as the router can pretend to 
>> be said router via both mac address and ip. ip is absolutely not 
>> reliable unless its going over ipsec (in which case you'd just use 
>> ipsec labeling) or the network is completely isolated (in which case 
>> you'd just use interface labeling).
>
> Switches with MAC filters, physical security on the switches and 
> fiber, no IP admin on the switches and alerts when a port gets locked. 
> $$$$ to install and admin.

Yes, I mentioned such switches in a different post. It doesn't matter, 
Paul already convinced me that host based labeling is useful in some 
situations and can be an acceptable risk :) You win.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
