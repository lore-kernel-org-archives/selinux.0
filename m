Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8KFSR8d017110
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 11:28:27 -0400
Received: from e36.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8KFRPNK019545
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 15:27:28 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8KFSKNT021459
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 11:28:20 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8KFSKVO276144
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 09:28:20 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8KFSJq3004690
	for <selinux@tycho.nsa.gov>; Wed, 20 Sep 2006 09:28:20 -0600
Date: Wed, 20 Sep 2006 10:16:43 -0500
From: Joy Latten <latten@austin.ibm.com>
Message-Id: <200609201516.k8KFGh1I018437@faith.austin.ibm.com>
To: vyekkirala@TrustedCS.com
Subject: RE: [redhat-lspp] ipsec acquire has security context although I a m not using it.
Cc: davem@davemloft.net, jmorris@namei.org, netdev@vger.kernel.org,
        redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Venkat,

>This doesn't look right since kzalloc would already have zeroed the
>structure out. Are you sure you are getting garbage in the acquire
>from the kernel? If you are, I strongly doubt that this would be the
>one causing it (unless kzalloc on this arch misbehaved).
>Or is this a racoon bug?

Yes, you are correct! Thanks for pointing this out to me
as I missed it! It is racoon that has the bug.
Will fix and post correct fix shortly. Please ignore
attached fix as it is incorrect.

Again, thanks!

Regards,
Joy

>> When using ipsec while selinux is enabled in my kernel, 
>> my racoon daemon fails to establish an SA. I believe the
>> ACQUIRE sent from kernel has a security context although I 
>> am not using this feature with ipsec. As a result, racoon
>> fails to establish the SA, because it is looking for a policy
>> with security context. I noticed the security context 
>> contains garbage. 
>> 
>> I am using a pseries, power5, ppc64 box, and it appears
>> that since policy->security structure is not really initialized
>> or zero'd out when not using, it is possible it may contain garbage
>> on my pseries and a call such as "if (policy->security)" may 
>> come back as true such that security context is included in
>> my acquire message although I believe it should not be. 
>> 
>> Hopefully, the below patch is acceptable. I have compiled and
>> tested it.
>> 
>> Regards,
>> Joy Latten
>> 
>> 
>> diff -urpN linux-2.6.17.orig/net/xfrm/xfrm_policy.c 
>> linux-2.6.17.patch/net/xfrm/xfrm_policy.c
>> --- linux-2.6.17.orig/net/xfrm/xfrm_policy.c	2006-09-19 
>> 02:11:33.000000000 -0500
>> +++ linux-2.6.17.patch/net/xfrm/xfrm_policy.c	2006-09-19 
>> 04:33:50.000000000 -0500
>> @@ -319,6 +319,7 @@ struct xfrm_policy *xfrm_policy_alloc(gf
>>  		init_timer(&policy->timer);
>>  		policy->timer.data = (unsigned long)policy;
>>  		policy->timer.function = xfrm_policy_timer;
>> +		policy->security = NULL;
>>  	}
>>  	return policy;
>>  }
>> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
