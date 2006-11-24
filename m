Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAO1aQ3s019420
	for <selinux@tycho.nsa.gov>; Thu, 23 Nov 2006 20:36:26 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAO1ZhwO029843
	for <selinux@tycho.nsa.gov>; Fri, 24 Nov 2006 01:35:44 GMT
Subject: Re: [PATCH 10/13] NetLabel: use cipso_v4_doi_search() for local
	CIPSOv4 functions
From: Eric Paris <eparis@parisplace.org>
To: paul.moore@hp.com
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        Alexander Viro <aviro@redhat.com>
In-Reply-To: <20061117224336.711076000@hp.com>
References: <20061117223842.399078000@hp.com>
	 <20061117224336.711076000@hp.com>
Content-Type: text/plain
Date: Thu, 23 Nov 2006 20:24:34 -0500
Message-Id: <1164331474.2079.39.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-11-17 at 17:38 -0500, paul.moore@hp.com wrote:

> Index: net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
> ===================================================================
> --- net-2.6.20_netlabel-base-work.orig/net/ipv4/cipso_ipv4.c
> +++ net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
> @@ -1136,7 +1136,7 @@ int cipso_v4_validate(unsigned char **op
>  	}
>  
>  	rcu_read_lock();
> -	doi_def = cipso_v4_doi_getdef(ntohl(*((__be32 *)&opt[2])));
> +	doi_def = cipso_v4_doi_search(ntohl(*((u32 *)&opt[2])));
>  	if (doi_def == NULL) {
>  		err_offset = 2;
>  		goto validate_return_locked;


This appears to reverse the previous endian work by Al Viro, was this
intended?

http://www.kernel.org/git/?p=linux/kernel/git/davem/net-2.6.20.git;a=commitdiff;h=8d7d47b647d7bc05443f1a8a5012e6b41be1c827

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
