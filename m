Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k96HhA8C001933
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 13:43:10 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k96HfuQW027990
	for <selinux@tycho.nsa.gov>; Fri, 6 Oct 2006 17:41:57 GMT
Message-ID: <452695AC.2000803@hp.com>
Date: Fri, 06 Oct 2006 13:43:08 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        redhat-lspp@redhat.com, Chad Hanson <chanson@TrustedCS.com>
Subject: Re: Labeled Networking For LSPP: Where we are and where we need t
 o go	(quickly)
References: <36282A1733C57546BE392885C0618592015CFC4C@chaos.tcs.tcs-sec.com>
In-Reply-To: <36282A1733C57546BE392885C0618592015CFC4C@chaos.tcs.tcs-sec.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat Yekkirala wrote:
> Paul Moore wrote:
> 
>>Eric Paris wrote:
>>
>>>Last night I built a new test kernel for labeled networking in RHEL5
>>>kernels.  That kernel can be found at 
>>>
>>>http://people.redhat.com/sgrubb/files/lspp
>>>
>>>and you want the lspp kernel 51.
>>>
> 
> <snip>
> 
>>>Patch3: find and fix current issues with unlabeled_t 
>>
>>packets that can't
>>
>>>be explained (Paul Moore and Venkat)
>>
>>I'm working on this but it's taking time getting all the 
>>right policy bits
>>sorted so I can differentiate between SECINITSID_UNLABELED 
>>and SECINITSID_NETMSG
>>as they will both show up as "unlabeled_t" in all the 
>>released policies (at
>>least I think so).
>>
>>Venkat, if you have a policy rpm/clean-patch/tarball 
>>something it would be a
>>help if you could post that or send it to me (I saw your 
>>earlier postings, but
>>only the constraints were really in patch form).  Or if you 
>>could verify the
>>lspp.51 kernel w/o the NetLabel/secid patch (turn off patch 
>>25008, if you want I
>>can send you a diff to the spec file - it's only two lines).  
>>So far I have not
>>seen any differences between the stock lspp.51 kernel and the 
>>lspp.51 kernel
>>without the NetLabel/secid patch.
>  
> As for the policy, I don't have anything more than what I posted
> earlier. To distinguish between the SECINITSID_NULL and NETMSG,
> see the policy patch I posted, sepcifically, policy/domains/kernel/kernel.te
> where you will see that NETMSG is being set to network_t. You should
> be able to apply at least that one bit of patch.

Yes, I was hoping to have something I could just rpm/yum onto the machine so
there would be no issues about specific version I was using.  However, if it's
not possibile, it's not possibile.

One thing that does cause me to wonder is that Joshua said he was using the
targeted policy from Rawhide, which doesn't have SECINITSID_NETMSG assigned to
network_t I don't believe ...

> ALso, are you seeing the following denials without NetLabel/secid?
> 
> [Pasted from Jashua's email]
> 
> avc:  denied  { flow_in } for  pid=1815 comm="avahi-daemon"
> scontext=system_u:object_r:unlabeled_t:s0
> tcontext=system_u:system_r:avahi_t:s0 tclass=packet

[NOTE: this is with the 2.3.7-2 mls policy - I know, it's really old]

Here is what I have seen using lspp.51:

type=AVC msg=audit(1160150058.918:61): avc:  denied  { flow_in } for  pid=2296
comm="avahi-daemon" scontext=system_u:object_r:unlabeled_t:s15:c0.c255
tcontext=system_u:object_r:unlabeled_t:s15:c0.c255 tclass=packet

type=AVC msg=audit(1160150058.918:61): avc:  denied  { flow_out } for  pid=2296
comm="avahi-daemon" saddr=10.0.0.255 src=5353 daddr=224.0.0.251 dest=5353
netif=eth0 scontext=root:staff_r:staff_t:s0-s15:c0.c255
tcontext=system_u:object_r:unlabeled_t:s15:c0.c255 tclass=packet

Here is what I have seen using lspp.51 without the NetLabel/secid patch:

type=AVC msg=audit(1160149828.291:105): avc:  denied  { flow_in } for  pid=2429
comm="avahi-daemon" scontext=system_u:object_r:unlabeled_t:s15:c0.c255
tcontext=system_u:object_r:unlabeled_t:s15:c0.c255 tclass=packet

type=AVC msg=audit(1160149828.291:105): avc:  denied  { flow_out } for  pid=2429
comm="avahi-daemon" saddr=10.0.0.255 src=5353 daddr=224.0.0.251 dest=5353
netif=eth0 scontext=root:staff_r:staff_t:s0-s15:c0.c255
tcontext=system_u:object_r:unlabeled_t:s15:c0.c255 tclass=packet

So no real visible difference in the contexts, I'm going to keep working on this
but if you haven't already started looking into this yourself it might be a good
idea considering the time crunch.  One tidbit worth noting, I never saw any
"recv" denials; I'm not sure if the daemon just didn't receive any packets or if
 the permission was already allowed ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
