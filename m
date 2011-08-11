Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p7BE5Eax030487
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 10:05:14 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p7BE5DCo004591
	for <selinux@tycho.nsa.gov>; Thu, 11 Aug 2011 14:05:13 GMT
Message-ID: <4E43E195.5090202@tresys.com>
Date: Thu, 11 Aug 2011 10:05:09 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Harry Ciao <qingtao.cao@windriver.com>
CC: <cpebenito@tresys.com>, <method@manicmethod.com>, <selinux@tycho.nsa.gov>
Subject: Re: [v0 PATCH 1/1] Only call role_fix_callback for base.p_roles during
 expansion.
References: <1312279433-2866-1-git-send-email-qingtao.cao@windriver.com> <1312279433-2866-2-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1312279433-2866-2-git-send-email-qingtao.cao@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/02/2011 06:03 AM, Harry Ciao wrote:
> expand_role_attributes() would merge the sub role attribute's roles
> ebitmap into that of the parent, then clear it off from the parent's
> roles ebitmap. This supports the assertion in role_fix_callback() that
> any role attribute's roles ebitmap contains just regular roles.
> 
> expand_role_attribute() works on base.p_roles table but not any
> block/decl's p_roles table, so the above assertion in role_fix_callback
> could fail when it is called for block/decl and some role attribute is
> added into another.
> 
> Since the effect of get_local_role() would have been complemented by
> the populate_roleattributes() at the end of the link phase, there is
> no needs(and wrong) to call role_fix_callback() for block/decl in the
> expand phase.
> 
> Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
> ---
>  libsepol/src/expand.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> index b42acbe..96ed473 100644
> --- a/libsepol/src/expand.c
> +++ b/libsepol/src/expand.c
> @@ -2832,9 +2832,6 @@ int expand_module(sepol_handle_t * handle,
>  		if (hashtab_map
>  		    (decl->p_roles.table, role_copy_callback, &state))
>  			goto cleanup;
> -		if (hashtab_map
> -		    (decl->p_roles.table, role_fix_callback, &state))
> -			goto cleanup;
>  
>  		/* copy users */
>  		if (hashtab_map

This looks good, and I'm fine with committing this.

However, I did find what appears to be an unrelated problem. It looks
like the role attributes are getting written to the policy db as if they
were roles. I don't think this will break anything (I think), but
considering that the kernel doesn't know anything about role_attributes,
it seems odd to me that they are in the binary.

Note: I found this by looking at a downgraded policy.24 in apol, so this
could potentially be a downgrade issue. But from looking at the code, I
believe role attributes are being written as if they're roles.

- Steve

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
