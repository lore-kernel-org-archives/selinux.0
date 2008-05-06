Subject: Re: [RFC] libsepol: allow genfscon statements in modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1210019807.3089.22.camel@localhost.localdomain>
References: <1210019807.3089.22.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 06 May 2008 11:17:27 -0400
Message-Id: <1210087047.25678.768.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 2008-05-05 at 16:36 -0400, Eric Paris wrote:
> Dan wants to be able to give types to booleans declared in modules.
> Since /selinux uses genfscon for its labeling we need to move the
> ability to declare such statements in modules.

(tmiller is no longer with Tresys, so dropping that address from the cc)

One issue to be aware of is that changes to genfscon don't automatically
propagate to in-core inodes that have already had their security state
populated upon the first d_instantiate/d_splice_alias.  So if a boolean
file has already been brought in core and you then insert a policy
module defining a genfscon for it, the new label won't take affect
until/unless the boolean file inode is evicted from memory and later
re-created upon subsequent lookup.

> Interesting things to notice is that inside the module we have no way to
> validate if the complete context is valid so I delay that checking until
> link time.
> 
> This could be the first step on the path to allowing other things which
> use full contexts (fs_uses) in modules.
> 
> Anyway, attack at will.  I still need to do more testing.  I haven't
> tested to verify that sorting is correct in the base policy, that things
> work if there are more than 1 FS in the base policy, or that we are
> inserting the shortest path from a module.  I'll test all of those
> before post a final.
> 
> -Eric
> 
> ---
>  src/link.c     |  197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  src/policydb.c |   25 ++++---
>  2 files changed, 210 insertions(+), 12 deletions(-)
> 
> diff -Naupr libsepol-2.0.26.orig/src/link.c libsepol-2.0.26/src/link.c
> --- libsepol-2.0.26.orig/src/link.c	2008-03-27 13:20:03.000000000 -0400
> +++ libsepol-2.0.26/src/link.c	2008-05-05 16:08:23.000000000 -0400
> @@ -34,6 +34,7 @@
>  #include <assert.h>
>  
>  #include "debug.h"
> +#include "context.h"
>  
>  #undef min
>  #define min(a,b) (((a) < (b)) ? (a) : (b))
> @@ -864,6 +865,10 @@ static int mls_level_convert(mls_semanti
>  	if (!mod->policy->mls)
>  		return 0;
>  
> +	/* Required not declared. */
> +	if (!src->sens)
> +		return 0;

I merged this as a separate bug fix.

> +
>  	assert(mod->map[SYM_LEVELS][src->sens - 1]);
>  	dst->sens = mod->map[SYM_LEVELS][src->sens - 1];
>  
> @@ -2120,6 +2125,183 @@ static int prepare_base(link_state_t * s
>  	return 0;
>  }
>  
> +static int context_copy_and_validate(link_state_t *state, context_struct_t *dst, context_struct_t *src)
> +{
> +	user_datum_t *base_user_datum;
> +	role_datum_t *base_role_datum;
> +	type_datum_t *base_type_datum;
> +	char *key;
> +	int ret;
> +
> +	key = state->cur->policy->p_user_val_to_name[src->user - 1];
> +	base_user_datum = hashtab_search(state->base->p_users.table, key);

Can this fail?  If not, assert it.  If so, check for it and handle it.

> +	dst->user = base_user_datum->s.value;
> +
> +	key = state->cur->policy->p_role_val_to_name[src->role - 1];
> +	base_role_datum = hashtab_search(state->base->p_roles.table, key);

Ditto.

> +	dst->role = base_role_datum->s.value;
> +
> +	key = state->cur->policy->p_type_val_to_name[src->type - 1];
> +	base_type_datum = hashtab_search(state->base->p_types.table, key);

Ditto.

> +	dst->type = base_type_datum->s.value;
> +
> +	ret = mls_context_cpy(dst, src);
> +	if (ret)
> +		return ret;
> +
> +	return context_is_valid(state->base, dst);
> +}
> +
> +/* merge 2 genfs sets with the same fstype */
> +static int genfs_merge(link_state_t *state, genfs_t *genfs, genfs_t *base_genfs)
> +{
> +	ocontext_t *con, *next_con, *base_con, *prev;
> +	int cmp;
> +
> +	assert(!strcmp(genfs->fstype, base_genfs->fstype));
> +
> +
> +	for(con = genfs->head; con; con = next_con) {

Coding style:  space between for and open parens.
Loop construct is a bit odd too (con = next_con w/ next_con set within
loop body).  If that's really the right model, I'd lean more towards a
while loop for it.

> +		next_con = con->next;
> +		base_con = base_genfs->head;
> +		if (!base_con) {
> +			base_genfs->head = con;
> +			continue;
> +		}
> +		cmp = strcmp(con->u.name, base_con->u.name);
> +		if (cmp < 0) {
> +			con->next = base_con;
> +			base_genfs->head = con;
> +			continue;

Need to be ordered by u.name length (longest prefix first so longest
matching prefix wins), not by strcmp ordering.

> +		} else if (cmp == 0)
> +			goto merge;
> +
> +		/* walk the list until we either need to insert between base_con
> +		 * and base_con->next or bomb cause of double/conflicting */
> +		while (base_con->next && (strcmp(con->u.name, base_con->next->u.name) > 0))
> +			base_con = base_con->next;
> +
> +		/* insert between base_con and base_con->next */
> +		if (!base_con->next || (strcmp(con->u.name, base_con->next->u.name) < 0)) {
> +			con->next = base_con->next;
> +			base_con->next = con;
> +			continue;

Ditto.

Stopped reading here.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
