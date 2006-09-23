Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8NEtHFQ020366
	for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2006 10:55:17 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k8NEsH55007713
	for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2006 14:54:18 GMT
Message-ID: <45154AC3.6040109@gentoo.org>
Date: Sat, 23 Sep 2006 10:54:59 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
Subject: Re: FC5 policy
References: <200609240034.08217.russell@coker.com.au>
In-Reply-To: <200609240034.08217.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> http://www.coker.com.au/selinux/fc5/
>
> At the above URL I have my latest packages of FC5 policy with patch and 
> source.  They compile the policy with amavis and clamav policy in base (which 
> can't be included in an FC5 update as the tools are broken and don't support 
> policy moving from a module to base), they have Postgrey policy compiled in, 
> and they have a few other policy changes (such as allowing unconfined_t to 
> kill unlabeled_t processes).
>
>   
um? in what way are the tools broken? It is quite easy to move a module 
to base:

semodule -r clamav -i base-with-clamav.pp

> Also my patch removes some unnecessary and inappropriate access from some 
> domains.  I know that most people don't like removing access from processes, 
> but I think we need to use the principle of least-privilege more seriously.
>   
Who doesn't like removing access from processes? I think we are all on 
the same side here..


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
