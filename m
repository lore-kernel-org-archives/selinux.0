Subject: Re: [PATCH 2/2] userland support for new range_transition
	statements
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "'SELinux List'" <SELinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <44CA298B.7080706@trustedcs.com>
References: <44CA298B.7080706@trustedcs.com>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 12:40:31 -0400
Message-Id: <1154364031.1447.127.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-07-28 at 10:13 -0500, Darrel Goeddel wrote:
> Index: libsepol/src/policydb.c
> ===================================================================
> --- libsepol/src/policydb.c	(revision 38)
> +++ libsepol/src/policydb.c	(working copy)
<snip>
> +static int range_trans_rule_read(range_trans_rule_t **r, struct policy_file *fp)
> +{
> +	uint32_t *buf, nel, nclass;
> +	unsigned int i, j;
> +	range_trans_rule_t *rt, *lrt = NULL;
> +	class_perm_node_t *cp, *lcp = NULL;
> +
> +	buf = next_entry(fp, sizeof(uint32_t));
> +	if (!buf)
> +		return -1;
> +	nel = le32_to_cpu(buf[0]);
> +	for (i = 0; i < nel; i++) {
> +		rt = malloc(sizeof(range_trans_rule_t));
> +		if (!rt) {
> +			return -1;
> +		}
> +		range_trans_rule_init(rt);
> +
> +		if (type_set_read(&rt->stypes, fp))
> +			return -1;

Leaks rt.  I'd suggest linking rt into the list earlier as we do
elsewhere, so that it can be freed upon policydb_destroy.

> +		nclass = le32_to_cpu(buf[0]);
> +		rt->classes = NULL;
> +		lcp = NULL;
> +		for (j = 0; j < nclass; j++) {
> +			cp = (class_perm_node_t *)malloc(
> +			                             sizeof(class_perm_node_t));
> +			if (!cp)
> +				return -1;
> +			class_perm_node_init(cp);
> +
> +			buf = next_entry(fp, sizeof(uint32_t));
> +			if (!buf) {
> +				free(cp);

Or just move the code to link it into the list prior to this, so that it
can be freed on the policydb_destroy path.

> Index: libsepol/src/expand.c
> ===================================================================
> --- libsepol/src/expand.c	(revision 38)
> +++ libsepol/src/expand.c	(working copy)
> @@ -958,6 +958,99 @@
>  	return 0;
>  }
>  
> +static int expand_range_trans(expand_state_t *state, range_trans_rule_t *rules)
> +{
> +	unsigned int i, j;
> +	range_trans_t *rt, *lrt, *cur_rt;
> +	range_trans_rule_t *rule;
> +	class_perm_node_t *cp;
> +
> +	ebitmap_t stypes, ttypes;
> +	ebitmap_node_t *snode, *tnode;
> +
> +	/* start appending at the end of the current list */
> +	for (lrt = state->out->range_tr; lrt && lrt->next; lrt = lrt->next)
> +		;
> +
> +	for (rule = rules; rule; rule = rule->next) {
> +		ebitmap_init(&stypes);
> +		ebitmap_init(&ttypes);
> +
> +		/* expand the type sets */
> +		if (expand_convert_type_set(state->out, state->typemap,
> +		                            &rule->stypes, &stypes, 1)) {
> +			ERR(state->handle, "Out of memory!");
> +			return -1;
> +		}
> +		if (expand_convert_type_set(state->out, state->typemap,
> +		                            &rule->ttypes, &ttypes, 1)) {
> +			ERR(state->handle, "Out of memory!");

Leaks stypes.  Need an error exit path that does clean up.

> +			return -1;
> +		}
> +
> +		/* loop on source type */
> +		ebitmap_for_each_bit(&stypes, snode, i) {
> +			if (!ebitmap_node_get_bit(snode, i))
> +				continue;
> +			/* loop on target type */
> +			ebitmap_for_each_bit(&ttypes, tnode, j) {
> +				if (!ebitmap_node_get_bit(tnode, j))
> +					continue;
> +				/* loop on target class */
> +				for (cp = rule->classes; cp; cp = cp->next) {
> +
> +					/* check for duplicates/conflicts */
> +					for (cur_rt = state->out->range_tr; cur_rt; cur_rt = cur_rt->next) {
> +						if ((cur_rt->source_type == i + 1) &&
> +						    (cur_rt->target_type == j + 1) &&
> +						    (cur_rt->target_class == cp->class)) {
> +							if (mls_range_eq(&cur_rt->target_range, &rule->trange)) {
> +								/* duplicate */
> +								break;
> +							} else {
> +								/* conflict */
> +								ERR(state->handle,
> +								    "Conflicting range trans rule %s %s : %s",
> +								    state->out->p_type_val_to_name[i],
> +								    state->out->p_type_val_to_name[j],
> +								    state->out->p_class_val_to_name[cp->class]);
> +								return -1;

Leaks stypes and ttypes.

> +						return -1;
> +					}
> +					memset(rt, 0, sizeof(range_trans_t));
> +					rt->source_type = i + 1;
> +					rt->target_type = j + 1;
> +					rt->target_class = cp->class;
> +					if (mls_range_cpy(&rt->target_range, &rule->trange)) {
> +						ERR(state->handle, "Out of memory!");

Leaks stypes, ttypes, and rt.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
