Subject: Re: [PATCH] refpolicy: Fix range_transition rules in the
	init_ranged_system_domain interface in system/init.if
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1193678512.2796.14.camel@moss-lions.epoch.ncsc.mil>
References: <1193678512.2796.14.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 29 Oct 2007 17:59:43 -0400
Message-Id: <1193695183.4641.2.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-10-29 at 13:21 -0400, James Carter wrote:
> The interface init_ranged_system_domain is not currently used, so maybe it can be just deleted.

Merged.

> Index: policy/modules/system/init.if
> ===================================================================
> --- policy/modules/system/init.if	(revision 2474)
> +++ policy/modules/system/init.if	(working copy)
> @@ -242,11 +242,11 @@
>  	init_system_domain($1,$2)
>  
>  	ifdef(`enable_mcs',`
> -		range_transition initrc_t $2 $3;
> +		range_transition initrc_t $2:process $3;
>  	')
>  
>  	ifdef(`enable_mls',`
> -		range_transition initrc_t $2 $3;
> +		range_transition initrc_t $2:process $3;
>  	')
>  ')
>  
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
