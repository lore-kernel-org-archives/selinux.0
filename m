Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k72EWAKT029982
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 10:32:10 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k72EW2eA004036
	for <selinux@tycho.nsa.gov>; Wed, 2 Aug 2006 14:32:03 GMT
Subject: Re: [PATCH 4/6] netfilter integration take 2: add netfilter
	contexts sorting
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1154457791.31522.150.camel@sgc.columbia.tresys.com>
References: <1154457791.31522.150.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 10:32:02 -0400
Message-Id: <1154529122.27457.56.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-08-01 at 14:43 -0400, Christopher J. PeBenito wrote:
> Add sorting function for netfilter contexts.
> 
>  libsemanage/src/direct_api.c     |    8 +
>  libsemanage/src/semanage_store.c |  192 +++++++++++++++++++++++++++++++++++++--
>  libsemanage/src/semanage_store.h |    6 +
>  3 files changed, 200 insertions(+), 6 deletions(-)
> 
> diff --exclude .svn -purN trunk/libsemanage/src/direct_api.c trunk2/libsemanage/src/direct_api.c
> --- trunk/libsemanage/src/direct_api.c	2006-07-31 13:28:30.102123500 -0400
> +++ trunk2/libsemanage/src/direct_api.c	2006-07-31 13:32:27.324949000 -0400
> @@ -581,6 +581,14 @@ static int semanage_direct_commit(semana
>  		}
>  
>  		/* Netfilter Contexts */
> +		/* Sort the netfilter contexts. */
> +		if (semanage_nc_sort
> +		    (sh, sepol_module_package_get_netfilter_contexts(base),
> +		     sepol_module_package_get_netfilter_contexts_len(base),
> +		     &sorted_nc_buffer, &sorted_nc_buffer_len) < 0) {
> +			goto cleanup;
> +		}
> +

This is very difficult to read. Please split into multiple lines so that
lindent doesn't do this.

Otherwise looks fine to me.

Karl

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
