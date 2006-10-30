Subject: Re: [PATCH] libsepol users in non-mls policy bugfix
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1162216762.3236.3.camel@twoface.columbia.tresys.com>
References: <1162216762.3236.3.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 30 Oct 2006 13:26:00 -0500
Message-Id: <1162232760.29732.26.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-10-30 at 08:59 -0500, Joshua Brindle wrote:
> This patch fixes a bug where adding a user in a non-mls module would
> cause a segfault at link time.
> 
> 
> diff -pruN trunk/libsepol/src/link.c user_mls_fix/libsepol/src/link.c
> --- trunk/libsepol/src/link.c	2006-10-28 15:35:26.000000000 -0400
> +++ user_mls_fix/libsepol/src/link.c	2006-10-28 15:26:44.000000000 -0400
> @@ -994,11 +994,15 @@ static int user_fix_callback(hashtab_key
>  		goto cleanup;
>  	}
>  
> -	if (mls_range_convert(&user->range, &new_user->range, mod))
> -		goto cleanup;
> +	if (mod->policy->mls) {
>  
> -	if (mls_level_convert(&user->dfltlevel, &new_user->dfltlevel, mod))
> -		goto cleanup;
> +		if (mls_range_convert(&user->range, &new_user->range, mod))
> +			goto cleanup;
> +
> +		if (mls_level_convert(&user->dfltlevel, &new_user->dfltlevel, mod))
> +			goto cleanup;
> +
> +	}
>  
>  	return 0;
>  
> 

This patch looks ok, but shouldn't we also stop the segfault in
mls_level_convert? The use of assert there looks like it is catching
what should be a runtime error that should cause an error message rather
than bailing.

Otherwise:

Acked by: Karl MacMillan <kmacmillan@mentalrootkit.com>

> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
