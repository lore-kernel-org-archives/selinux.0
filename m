Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6SIr2I9002567
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 14:53:02 -0400
Received: from atlrel9.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6SIqwPi017704
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 18:52:58 GMT
Message-ID: <44CA5D00.4010405@hp.com>
Date: Fri, 28 Jul 2006 14:52:48 -0400
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@epoch.ncsc.mil,
        jmorris@redhat.com, pratt@argus-systems.com
Subject: Re: [PATCH 1/7] NetLabel: documentation
References: <20060717155224.060020000@hp.com>	<20060717155821.600856000@hp.com> <20060728.005104.78711481.davem@davemloft.net>
In-Reply-To: <20060728.005104.78711481.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

David Miller wrote:
> From: paul.moore@hp.com
> Date: Mon, 17 Jul 2006 11:52:25 -0400
> 
> 
>>+CIPSOv4 Variables:
>>+
>>+cipso_cache_enable - BOOLEAN
> 
>  ...
> 
>>+cipso_cache_bucket_size - INTEGER
> 
>  ...
> 
>>+cipso_rbm_optfmt - BOOLEAN
> 
>  ...
> 
>>+cipso_rbm_structvalid - BOOLEAN
> 
>  ...
> 
> We need some more information for these entries.
> 
> First, list the default value these sysctls will have.
> This is consistent with other entries in this file.  If
> there is a compelling argument to support the default
> value, please mention it.
> 
> Second, cipso_cache_bucket_size is still opaque, there is
> nothing in the description with describes the units this
> value is specified in, nor in fact what it really controls.
> Does it say how deep the hash chains of the hash table are
> allowed to grow to?  Otherwise, what does it control and what
> are the consequences of using different values?
> 

Okay, I'll work on the doc so to try and take care of these issues.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
