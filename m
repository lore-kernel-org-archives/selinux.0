Subject: Re: libsepol and libselinux patches
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: SELinux-dev@tresys.com, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20060523154424.GA13237@sergelap>
References: <20060523154424.GA13237@sergelap>
Content-Type: text/plain
Date: Wed, 24 May 2006 15:43:46 -0400
Message-Id: <1148499826.24463.533.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-23 at 10:44 -0500, Serge E. Hallyn wrote:
> Starting my not-as-regular-as-i'd-like static analysis run of
> selinux-usr.  Here are a few patches to libsepol and libselinux.
> Hope to go through the rest later this week.
> 
> libselinux/src/matchmediacon.c:
> 	'found' initialized to -1, not 0
> libselinux/src/setrans_client.c:
> 	'ret_val' is being returned, but codpath makes it pretty clear
> 	the intent is to return ret.
> libsepol/src/expand.c:
> 	accessing new_level->level->cat when new_level->level could
> 	be NULL
> libsepol/src/hierarchy.c
> 	freeing parent before potential dereference in
> 	ERR.
> libsepol/src/nodes.c:
> 	jumping to 'omem' before addr_buf and mask_buf
> 	are declared, but they are used after 'omem:'.
> 	Testcase suggests these will not be initialized.
> libsepol/src/policydb.c:
> 	'c' is never freed in read_cons_helper?
> 	newc and newc->u.name are not freed in genfs_read
> 
> thanks,
> -serge

Thanks, everything up to the policydb.c ones look fine and I'll apply.
Comments below on the policydb.c ones, after looking to see what the
current state of the corresponding kernel security server code is.

> --- libsepol/src/policydb.c.orig	2006-05-23 07:48:58.000000000 -0500
> +++ libsepol/src/policydb.c	2006-05-23 08:36:50.000000000 -0500
> @@ -1435,22 +1435,28 @@ static int read_cons_helper(policydb_t *
>  		if (!c)
>  			return -1;
>  		buf = next_entry(fp, (sizeof(uint32_t) * 2));
> -		if (!buf)
> +		if (!buf) {
> +			free(c);
>  			return -1;
> +		}

This can be done more cleanly by linking c into the list early, and then
just relying on policydb_destroy() by the caller to clean it up, as with
much of the cleanup on failed policydb_read().  That appears to already
be the case in the kernel code.

> @@ -1949,23 +1963,23 @@ static int genfs_read (policydb_t *p, st
>                          }
>                          buf = next_entry(fp, sizeof(uint32_t));
>                          if (!buf)
> -                                goto bad;
> +                                goto bad_freenewc;

I'd think we could do this in the same way (link newc early, along with
its parent), although the kernel code appears to instead jump to an
error path that uses an ocontext_destroy() helper to handle all cases.

> +bad_context:
> +	context_destroy(&newc->context[0]);
> +bad_freename:
> +	free(newc->u.name);
> +bad_freenewc:
> +	free(newc);

These could be collapsed into a single error path, right?  Initial
calloc will put it into a valid state for all of this cleanup?

> @@ -2461,14 +2481,17 @@ static int avrule_block_read(policydb_t 
>                  num_decls = le32_to_cpu(buf[0]);
>                  while (num_decls > 0) {
>                          if ((curdecl = avrule_decl_create(0)) == NULL) {
> +				free(curblock);
>                                  return -1;
>                          }

Appears to miss the prior next_entry() error path, and we need to do
more here since we may now have linked avrule_decl's into the block.
avrule_block_destroy(), maybe.

>                          if (avrule_decl_read(p, curdecl, num_scope_syms, fp) == -1) {
> +				free(curblock);
>                                  return -1;
>                          }

Need to deal with the allocated decl (avrule_decl_destroy?) and then the
entire chain from the block.

>                          if (curdecl->enabled) {
>                                  if (curblock->enabled != NULL) {
>                                          /* probably a corrupt file */
> +					free(curblock);
>                                          return -1;
>                                  }

Same issue.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
