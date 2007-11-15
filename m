Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAF2rKo8027634
	for <selinux@tycho.nsa.gov>; Wed, 14 Nov 2007 21:53:20 -0500
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAF2rHWO007795
	for <selinux@tycho.nsa.gov>; Thu, 15 Nov 2007 02:53:18 GMT
Message-ID: <473BB437.3070005@ak.jp.nec.com>
Date: Thu, 15 Nov 2007 11:51:35 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: [PATCH] IPsec SPD default security context (Re: security	context
 for SPD entries of labeled IPsec)
References: <D709A20F2164C84E8B7014B0301F5EF87C72FA@HAVOC.tcs-sec.com>	 <47331BAB.8040107@kaigai.gr.jp>  <473872F8.7000208@ak.jp.nec.com>	 <1195055160.13737.33.camel@gorn.columbia.tresys.com>	 <473B23F9.4080506@ak.jp.nec.com> <1195064402.13737.42.camel@gorn.columbia.tresys.com>
In-Reply-To: <1195064402.13737.42.camel@gorn.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Thu, 2007-11-15 at 01:36 +0900, KaiGai Kohei wrote:
>> Christopher J. PeBenito wrote:
>>> On Tue, 2007-11-13 at 00:36 +0900, KaiGai Kohei wrote:
>>>> Did you notice that a patch was attached in my previous posting?
>>>> Because I put a description about this patch on the bottom of the message,
>>>> it might be easy to overlook it.
>>>>
>>>> Could you review it? It is desirable for me to enable to communicate
>>>> between different domains via labeled ipsec.
>>> I committed an alternate version,
>>>
>>> http://oss.tresys.com/projects/refpolicy/changeset/2499
>>> http://oss.tresys.com/projects/refpolicy/changeset/2500
>>>
>> Thanks to apply them,
>>
>> However, it does not contain any permissions which allows
>> users and daemons domain to communicate via labeled ipsec.
>>
>> In my patch, these permissions were allowed at system/init.if
>> and system/userdomain.if. Do you consider these permissions
>> should not be allowed implicitly inside these interfaces?
>>
>> Currently, it is not enough for SE-PostgreSQL to communicate
>> peers using a SPD with default security context.
>> They are requiring a bit more permissions.
> 
> I reject the blanket permissions that you had in your previous patch.

OK, I can agree.

I also suggest two minor improvement toward these updates.

1. Is it considerable to add "allow $1 self : association { sendto };"
   at ipsec_match_default_spd interface of ipsec.if?

   I think it should be packed with polmatch permission to the default
   SPD context, because any domain which want to communicate others using
   SPD with default context always have to have 'sendto' permission to
   itself.

2. Is it considerable to add "ipsec_match_default_spd($1_t)"
   in the userdom_basic_networking_template of userdomain.if?

   This interface allows a given userdomain widespread basic networking
   permissions. But it is not enough yet, if the networking tunnel
   is configured with labeled ipsec.
   I think it can be contained in the basic networking permissions
   to use ipsec SPD with default context.

> I'll consider a patch that adds it to a postresql interface.  Perhaps
> postgresql_tcp_connect should be un-deprecated.

I think similar interfaces are necessary for any other daemon-domain which
provides networking-services, even if they don't use getpeercon().

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
