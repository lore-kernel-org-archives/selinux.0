Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4O54IxQ020050
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 01:04:18 -0400
Received: from moutng.kundenserver.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4O54G8j017494
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 05:04:17 GMT
In-Reply-To: <200705230927.09084.paul.moore@hp.com>
References: <6AA1314E-2718-446E-BFC9-6961DE951E09@sf-net.com> <200705221524.28541.paul.moore@hp.com> <9ED0CEA1-908A-4166-960C-256407399AF0@sf-net.com> <200705230927.09084.paul.moore@hp.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E60164DE-429F-4B6A-8C3C-8405BF7AD41F@sf-net.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Subject: Re: AVC: IPv6 problems
Date: Thu, 24 May 2007 07:04:09 +0200
To: Paul Moore <paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 23.05.2007, at 15:27, Paul Moore wrote:

> On Wednesday, May 23 2007 8:21:27 am Stefan Schulze Frielinghaus  
> wrote:
>> On 22.05.2007, at 21:24, Paul Moore wrote:
>>> On Tuesday, May 22 2007 2:22:09 pm Stefan Schulze Frielinghaus  
>>> wrote:
>>>> periodically I receive the following AVC denial:
>>>>
>>>> audit(1179815459.477:213): avc:  denied  { rawip_send } for
>>>> saddr=fe80:0000:0000:0000:0211:d8ff:feea:XXXX
>>>> daddr=fe80:0000:0000:0000:0211:24ff:fee1:YYYY netif=eth0
>>>> scontext=system_u:system_r:kernel_t:s15:c0.c255
>>>> tcontext=system_u:object_r:link_local_node_t:s0 tclass=node
>>
>>> It's hard to say what the solution is because it most likely
>>> depends on what
>>> you are trying to do.  You might want to share your goals with the
>>> list and
>>> perhaps we can help, otherwise I would recommend you look at the MLS
>>> reference policy interfaces.
>>
>> That's even hard for me too. I can't reproduce the errors so I don't
>> know where and who is producing these errors. The AVC I've posted
>> where generated at 2 o'clock am and today I never saw any AVC
>> denials. Sometimes they come up periodically and some times only
>> sporadically. I will have a look at the denials and when they were
>> created maybe I can reproduce the AVCs.
>> I hoped that this is a problem who someone solved before. But as
>> already mentioned I will watch them and try to figure out who is
>> creating these denials.
>
> I'll take a guess and say it may be related to IPv6 router  
> advertisements,
> neighbor solicitations, or duplicate address detection but I can't  
> really be
> sure.  It's been a few years since I've done any real work with  
> IPv6 and I'm
> a bit rusty about which class of addresses get used for these  
> things, I
> believe it would be the link local address (what is seen in your  
> AVC denial)
> but I could be wrong.

Yes it's a link local address. SELinux is running on a central server  
machine
which also runs a RADVD daemon for "IPv6 DHCP like behaviour". The
last two days no AVC errors where created. So I will have to wait  
until a new
one comes up and maybe I will find the error.

I also guess that it's a RA, NS or DAD because you will only use link  
local
addresses for maintenance.

> Do you make use of IPv6 or is it simply enabled on your system?

Nearly all of my intranet traffic is IPv6. I really use that.


Best regards,
Stefan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
