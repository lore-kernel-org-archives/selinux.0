Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA6HccK7008172
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 12:38:38 -0500
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA6HcPhJ015796
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 17:38:30 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Subject: RE: security context for SPD entries of labeled IPsec
Date: Tue, 6 Nov 2007 12:37:21 -0500
Message-ID: <D709A20F2164C84E8B7014B0301F5EF87C71DD@HAVOC.tcs-sec.com>
From: "Venkat Yekkirala" <vyekkirala@TrustedCS.com>
To: "KaiGai Kohei" <kaigai@ak.jp.nec.com>, <cpebenito@tresys.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov 
> [mailto:owner-selinux@tycho.nsa.gov]On Behalf Of KaiGai Kohei
> Sent: Tuesday, November 06, 2007 4:00 AM
> To: cpebenito@tresys.com
> Cc: selinux@tycho.nsa.gov
> Subject: Re: security context for SPD entries of labeled IPsec
> 
> 
> KaiGai Kohei wrote:
> > We have to set up several SPD entries with a security context
> > to apply labeled IPsec, like as:
> > 
> >   spdadd 192.168.1.10 192.168.1.20 any
> >   -ctx 1 1 "system_u:object_r:unconfined_t:s0"
> >   -P in ipsec esp/transport//require;
> > 
> > What is the most appropriate context to be specified?

First of all, you don't have one SPD rule for each domain. You
would typically have one SPD rule labeled with ipsec_spd_t,
for example and have all the domains that need to use that
SPD rule to perform labeled IPsec communication to have
association.polmatch access to ipsec_spd_t. So, the policy defines
one context ipsec_spd_t that you can use for all your SPD rules,
unless you need to distinguish between different SPD rules based
on the label, in which case you can have more than one specified
for the same host pair and have different domains polmatch'ing
to the appropriate rules so the corresponding IPSec policy is
enforced.

Joshua Brindle has an article including labeled-ipsec at:
http://securityblog.org/brindle/2007/05/28/secure-networking-with-selinux/

> > Or, is the security policy to be modified?
> > 
> > In the current reference policy, several domain have permissions
> > of association class for 'self' or 'unlabeled_t'.
> > However, it can cause a matter when 'unconfined_t' processes tries
> > to connect 'postgresql_t' process running on another host 
> via labeled
> > IPsec, for instance.

There are 2 aspects:

1. IPsec policy matching discussed above:
   allow domain-that-should-use-labeled-ipsec ipsec_spd_t:association { polmatch };

2. Use of IPsec associations themselves:

   For sending:
   allow domain-that-should-use-labeled-ipsec-to-label-its-packets self:association { sendto };

   For receiving:
   allow domain-that-should-received-from-peer  peer-domain self:association { recvfrom };

> > 
> > We can add additional permissions to avoid the matter, as follows:
> >   allow postgresql_t unconfined_t : association { ... };
> > 
> > But IMO it makes a bit confusable to apply process's domain as
> > a type of SPD entries, like unconfined_t and so on.

Definitely so, which is the reason there's ipsec_spd_t defined in the policy
to be used for all SPD rules that should perform labeled IPsec.

> > 
> > I prefer the following description to separate subject and object.
> >   allow postgresql_t postgresql_spd_t : association { ... };
> >   allow unconfined_t postgresql_spd_t : association { ... };
> 
> In policy/modules/system/ipsec.te, ipsec_spd_t is defined as a default
> type for IPSEC SPD entries, as follows:
> 
>   # Default type for IPSEC SPD entries
>   type ipsec_spd_t;
>       :
>   allow racoon_t ipsec_spd_t:association setcontext;
>       :
>   allow setkey_t ipsec_spd_t:association setcontext;
>       :
> 
> However, setkey_t and racoon_t are the all which have any permission
> on ipsec_spd_t.
> Is it more preferable than applying a domain as a type of SPD entries?

Yes. Hope the above helps.

> 
> Thanks,
> 
> > Is there any reason why SPD entries have same type with domains?
> > 
> > Thanks,
> 
> -- 
> OSS Platform Development Division, NEC
> KaiGai Kohei <kaigai@ak.jp.nec.com>
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
