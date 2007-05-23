Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4ND8LE9011001
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2007 09:08:21 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4ND8Km0014980
	for <selinux@tycho.nsa.gov>; Wed, 23 May 2007 13:08:20 GMT
Message-ID: <46543CB8.6070507@redhat.com>
Date: Wed, 23 May 2007 09:08:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stefan Schulze Frielinghaus <stefan@sf-net.com>
CC: Paul Moore <paul.moore@hp.com>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: AVC: IPv6 problems
References: <6AA1314E-2718-446E-BFC9-6961DE951E09@sf-net.com> <200705221524.28541.paul.moore@hp.com> <9ED0CEA1-908A-4166-960C-256407399AF0@sf-net.com>
In-Reply-To: <9ED0CEA1-908A-4166-960C-256407399AF0@sf-net.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stefan Schulze Frielinghaus wrote:
>
> On 22.05.2007, at 21:24, Paul Moore wrote:
>
>> On Tuesday, May 22 2007 2:22:09 pm Stefan Schulze Frielinghaus wrote:
>>> periodically I receive the following AVC denial:
>>>
>>> audit(1179815459.477:213): avc:  denied  { rawip_send } for
>>> saddr=fe80:0000:0000:0000:0211:d8ff:feea:XXXX
>>> daddr=fe80:0000:0000:0000:0211:24ff:fee1:YYYY netif=eth0
>>> scontext=system_u:system_r:kernel_t:s15:c0.c255
>>> tcontext=system_u:object_r:link_local_node_t:s0 tclass=node
>>>
>>> My local rule-set:
>>>
>>> allow kernel_t link_local_node_t:node rawip_send;
>>> # another AVC denial which often raises up
>>> allow kernel_t compat_ipv4_node_t:node rawip_send;
>>>
>>> The rules seem to be ignored. Every day I receive some of the
>>> mentioned AVC denials despite the fact that the TE rules are loaded.
>>> Is this a known problem with IPv6 traffic in LANs? Is there even a
>>> solution out?
>>
>> The problem doesn't appear to be related to the TE rules, but rather 
>> with the
>> MLS sensitivity labels.  The kernel is running with a very high 
>> sensitivity
>> label (s15:c0.c255) and it trying to write/send to a node with a very 
>> low
>> sensitivity label (s0) which I believe violates the MLS constraints 
>> unless
>> the kernel_t domain or link_local_node_t object has a type attribute 
>> which
>> provides MLS overrides.
>
> Whoops your right. I've always only looked at the TE rules but not at 
> the MLS rules!
>
>>
>> It's hard to say what the solution is because it most likely depends 
>> on what
>> you are trying to do.  You might want to share your goals with the 
>> list and
>> perhaps we can help, otherwise I would recommend you look at the MLS
>> reference policy interfaces.
>
> That's even hard for me too. I can't reproduce the errors so I don't 
> know where and who is producing these errors. The AVC I've posted 
> where generated at 2 o'clock am and today I never saw any AVC denials. 
> Sometimes they come up periodically and some times only sporadically. 
> I will have a look at the denials and when they were created maybe I 
> can reproduce the AVCs.
> I hoped that this is a problem who someone solved before. But as 
> already mentioned I will watch them and try to figure out who is 
> creating these denials.
>
> Best regards,
> Stefan
AVC denials can be caused by one of three things.  Missing TE rules. 
Missing RBAC Rules or violation of constraints.  audit2allow only 
translates TE rules.  audit2why will look at a log file and tell you if 
there is a constraint violation.  If you see SELINUX_ERR you probably 
have a RBAC Failure.
>
> -- 
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
