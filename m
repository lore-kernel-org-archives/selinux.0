Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72DQKck027631
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 09:26:20 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72DQ9a2009355
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 13:26:10 GMT
Subject: Re: [PATCH 2/6] netfilter integration take 2: add netfilter
	contexts package section
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1154457788.31522.148.camel@sgc.columbia.tresys.com>
References: <1154457788.31522.148.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 09:26:16 -0400
Message-Id: <1154525176.27457.40.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 14:43 -0400, Christopher J. PeBenito wrote:
> Add a section to the package for netfilter contexts.
> 
>  libsepol/include/sepol/module.h          |   10 ++
>  libsepol/include/sepol/policydb/module.h |    2
>  libsepol/src/module.c                    |  119 +++++++++++++++++++++++++++++++
>  3 files changed, 131 insertions(+)
> 
> diff --exclude .svn -purN trunk/libsepol/include/sepol/module.h netfilter-integration/libsepol/include/sepol/module.h
> --- trunk/libsepol/include/sepol/module.h	2006-07-03 10:42:01.031370000 -0400
> +++ netfilter-integration/libsepol/include/sepol/module.h	2006-07-14 11:15:32.923435000 -0400
> @@ -40,6 +40,16 @@ extern size_t sepol_module_package_get_u
>  extern int sepol_module_package_set_user_extra(sepol_module_package_t * p,
>  					       char *data, size_t len);
>  
> +extern char *sepol_module_package_get_netfilter_contexts(sepol_module_package_t
> +							 * p);
> +

No space in front of p -> *p.

> +extern size_t
> +sepol_module_package_get_netfilter_contexts_len(sepol_module_package_t * p);
> +

Same - this is all throughout. Otherwise fine.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
