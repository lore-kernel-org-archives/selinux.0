Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k48CTDUV017184
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 08:29:13 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k48CT9tw000034
	for <selinux@tycho.nsa.gov>; Mon, 8 May 2006 12:29:12 GMT
Subject: Re: [PATCH] fix warnings in selinux-usr
From: Karl MacMillan <kmacmillan@tresys.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <445CF147.1000300@cornell.edu>
References: <1146845884.2208.15.camel@jackjack.columbia.tresys.com>
	 <445CF147.1000300@cornell.edu>
Content-Type: text/plain
Date: Mon, 08 May 2006 08:26:34 -0400
Message-Id: <1147091194.32719.4.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-05-06 at 14:56 -0400, Ivan Gyurdiev wrote:
> Karl MacMillan wrote:
> > Steve,
> >
> > Attached is a patch that fixes many warnings that have crept into the
> > selinux-usr code over time, making it difficult to ascertain whether
> > code changes have introduced new warnings.
> >   
> record_policydb_table_t SEMANAGE_PORT_POLICYDB_RTABLE = {
> 
>  	.add         = NULL, 
> -	.modify      = sepol_port_modify,
> +	.modify      = (record_policydb_table_modify_t)sepol_port_modify,
>  	.set         = NULL, 
> -	.query       = sepol_port_query,
> -        .count       = sepol_port_count,
> -	.exists      = sepol_port_exists,
> -	.iterate     = sepol_port_iterate,
> +	.query       = (record_policydb_table_query_t)sepol_port_query,
> +        .count       = (record_policydb_table_count_t)sepol_port_count,
> +	.exists      = (record_policydb_table_exists_t)sepol_port_exists,
> +	.iterate     = (record_policydb_table_iterate_t)sepol_port_iterate,
>  };
> 
> 
> The semanage <--> sepol record key/data are not necessarily identical, 
> and that's why warnings occur on query, modify, etc... 
> Changing the type to void* removes the warning, without fixing the 
> potential problem. The cast is marked unsafe, because it is unsafe.

Not certain if you are objecting to adding the casts or would prefer a
void* cast. I prefer the casts as the patch has them because it makes it
clear in the source that something unsafe is being done without
completely punting with void*.

>  A 
> better solution would be to add conversion functions from semanage 
> key/record to sepol key/record and vice versa.

Sure, conversions would solve the problem, though removing some of this
duplication would be even better. Any chance you will have a chance to
take care of this?

Thanks,

Karl


-- 
Karl MacMillan
Tresys Technology
www.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
