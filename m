Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r11KxVbg024768
	for <selinux@tycho.nsa.gov>; Fri, 1 Feb 2013 15:59:31 -0500
Received: by mail-lb0-f177.google.com with SMTP id go11so4869729lbb.22
        for <selinux@tycho.nsa.gov>; Fri, 01 Feb 2013 12:59:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <C1432A7484D61749AF22A060C2B03C5D1632046A2B@StaEx7mb3.telecom.sna.samsung.com>
References: <C1432A7484D61749AF22A060C2B03C5D1632046A1B@StaEx7mb3.telecom.sna.samsung.com>
	<50EC37E2.2000705@tycho.nsa.gov>
	<C1432A7484D61749AF22A060C2B03C5D1632046A2B@StaEx7mb3.telecom.sna.samsung.com>
Date: Fri, 1 Feb 2013 15:59:27 -0500
Message-ID: <CACLa4ptb6y9G8xEvFvzuMiUdjz8yJ+0K2e1JLEd+B=SgKULFVQ@mail.gmail.com>
Subject: Re: Fixing external/libsepol issues found by Klocwork
From: Eric Paris <eparis@parisplace.org>
To: Alice Chu <alice.chu@sta.samsung.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Alice Chu <alice.chu@sta.samsung.com>
> Date: Wed, 9 Jan 2013 18:34:32 -0800
> Subject: [PATCH] Fix memory leak issues found by Klocwork

> diff --git a/src/link.c b/src/link.c
> index 01d3231..4d36132 100644
> --- a/src/link.c
> +++ b/src/link.c

> @@ -1301,7 +1303,8 @@ static int copy_avrule_list(avrule_t * list, avrule_t ** dst,
>                         if (new_rule->perms == NULL) {
>                                 new_rule->perms = new_perm;
>                         } else {
> -                               tail_perm->next = new_perm;
> +                               if (tail_perm) /* make sure no dereferencing of NULL pointer*/
> +                                       tail_perm->next = new_perm;
>                         }
>                         tail_perm = new_perm;
>                         cur_perm = cur_perm->next;

I actually made this assert(tail_perm); If we did hit the case where
this was null, someone changed the code flow and broke it.  I don't
want to silently hide that fact.

> diff --git a/src/policydb.c b/src/policydb.c
> index ff292f6..fd9b57b 100644
> --- a/src/policydb.c
> +++ b/src/policydb.c
> @@ -3448,7 +3448,8 @@ static int avrule_block_read(policydb_t * p,
>                         if (curblock->branch_list == NULL) {
>                                 curblock->branch_list = curdecl;
>                         } else {
> -                               last_decl->next = curdecl;
> +                               if (last_decl != NULL)
> +                                       last_decl->next = curdecl;
>                         }
>                         last_decl = curdecl;
>                         num_decls--;

Same

> @@ -3457,7 +3458,8 @@ static int avrule_block_read(policydb_t * p,
>                 if (*block == NULL) {
>                         *block = curblock;
>                 } else {
> -                       last_block->next = curblock;
> +                       if (last_block != NULL)
> +                               last_block->next = curblock;
>                 }
>                 last_block = curblock;

Similar, but not quite the same.  Since we rely on the caller setting
*block to NULL. I actually added 2 asserts.  One here on last_block
and one at the top on *block == NULL.

>
> diff --git a/src/policydb_convert.c b/src/policydb_convert.c
> index 32832bb..3fc40cb 100644
> --- a/src/policydb_convert.c
> +++ b/src/policydb_convert.c
> @@ -20,6 +20,7 @@ int policydb_from_image(sepol_handle_t * handle,
>         pf.handle = handle;
>
>         if (policydb_read(policydb, &pf, 0)) {
> +               policydb_destroy(policydb);
>                 ERR(handle, "policy image is invalid");
>                 errno = EINVAL;
>                 return STATUS_ERR;

No.  All of the callers seem to do init() and then destroy() on error.
 If we called destroy() as well it would be a double free.  Destroy
does not reset everything to nulls, it just frees the memory.


You should seem most of these patches in the next upstream push.  (Or
at least something like these fixes)

Thanks so much!

-Eric

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
