Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA69wo2A026901
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 04:58:51 -0500
Received: from tyo202.gate.nec.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA69wmoO022631
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2007 09:58:49 GMT
Message-ID: <47303B32.1070001@ak.jp.nec.com>
Date: Tue, 06 Nov 2007 19:00:18 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Re: security context for SPD entries of labeled IPsec
References: <472FE68D.4030404@ak.jp.nec.com>
In-Reply-To: <472FE68D.4030404@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

KaiGai Kohei wrote:
> We have to set up several SPD entries with a security context
> to apply labeled IPsec, like as:
> 
>   spdadd 192.168.1.10 192.168.1.20 any
>   -ctx 1 1 "system_u:object_r:unconfined_t:s0"
>   -P in ipsec esp/transport//require;
> 
> What is the most appropriate context to be specified?
> Or, is the security policy to be modified?
> 
> In the current reference policy, several domain have permissions
> of association class for 'self' or 'unlabeled_t'.
> However, it can cause a matter when 'unconfined_t' processes tries
> to connect 'postgresql_t' process running on another host via labeled
> IPsec, for instance.
> 
> We can add additional permissions to avoid the matter, as follows:
>   allow postgresql_t unconfined_t : association { ... };
> 
> But IMO it makes a bit confusable to apply process's domain as
> a type of SPD entries, like unconfined_t and so on.
> 
> I prefer the following description to separate subject and object.
>   allow postgresql_t postgresql_spd_t : association { ... };
>   allow unconfined_t postgresql_spd_t : association { ... };

In policy/modules/system/ipsec.te, ipsec_spd_t is defined as a default
type for IPSEC SPD entries, as follows:

  # Default type for IPSEC SPD entries
  type ipsec_spd_t;
      :
  allow racoon_t ipsec_spd_t:association setcontext;
      :
  allow setkey_t ipsec_spd_t:association setcontext;
      :

However, setkey_t and racoon_t are the all which have any permission
on ipsec_spd_t.
Is it more preferable than applying a domain as a type of SPD entries?

Thanks,

> Is there any reason why SPD entries have same type with domains?
> 
> Thanks,

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
