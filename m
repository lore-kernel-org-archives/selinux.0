Subject: Re: [PATCH 2/2] userland support for new range_transition
	statements
From: Joshua Brindle <jbrindle@tresys.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>
In-Reply-To: <44CA298B.7080706@trustedcs.com>
References: <44CA298B.7080706@trustedcs.com>
Content-Type: text/plain
Date: Tue, 01 Aug 2006 09:14:34 -0400
Message-Id: <1154438074.23513.30.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-07-28 at 11:13 -0400, Darrel Goeddel wrote:
> Index: libsepol/include/sepol/policydb/policydb.h
> ===================================================================
> --- libsepol/include/sepol/policydb/policydb.h  (revision 38)
> +++ libsepol/include/sepol/policydb/policydb.h  (working copy)

> +typedef struct range_trans_rule {
> +       type_set_t stypes;
> +       type_set_t ttypes;
> +       class_perm_node_t *classes;     /* only class is used */
> +       mls_range_t trange;
> +       struct range_trans_rule *next;
> +} range_trans_rule_t;
> +

Are we sure that mls_range_t is semantic enough to store the rule, even
in a module situation where all the symbols are not present?

<snip>
>                 return -1;
> @@ -2835,7 +2970,8 @@
>         if ((p->policy_type == POLICY_KERN
>              && p->policyvers >= POLICYDB_VERSION_MLS)
>             || (p->policy_type == POLICY_BASE
> -               && p->policyvers >= MOD_POLICYDB_VERSION_MLS)) {
> +               && p->policyvers >= MOD_POLICYDB_VERSION_MLS
> +               && p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS)) {

man, this conditional is getting out of hand :\

<snip>
> +static int expand_range_trans(expand_state_t *state,
> range_trans_rule_t *rules)
> +{
> +       unsigned int i, j;
> +       range_trans_t *rt, *lrt, *cur_rt;
> +       range_trans_rule_t *rule;
> +       class_perm_node_t *cp;
> +
> +       ebitmap_t stypes, ttypes;
> +       ebitmap_node_t *snode, *tnode;
> +
> +       /* start appending at the end of the current list */
> +       for (lrt = state->out->range_tr; lrt && lrt->next; lrt =
> lrt->next)
> +               ;

I know the current code is like this, it was probably done that way to
match the pre-module compiler behavior but we could probably change
these to prepend, for simpler code.

<snip>

> +                                       rt = (range_trans_t
> *)malloc(sizeof(range_trans_t));
> +                                       if (!rt) {
> +                                               ERR(state->handle,
> "Out of memory!");
> +                                               return -1;
> +                                       }
> +                                       memset(rt, 0,
> sizeof(range_trans_t));

It is my preference to have initializers for structs but even if not the
current trend in this library is to turn malloc/memset into calloc.
(Though I'd really prefer an initializer just so that these sites don't
have to be audited when the struct changes)

<snip>
> +               new_range->target_class = range->target_class;
> +               if (mls_level_clone(&new_range->target_range.level[0],
> +                                   &range->target_range.level[0]) ||
> +                   mls_level_clone(&new_range->target_range.level[1],
> +                                   &range->target_range.level[1])) {

can we break these into separate calls? It is easier to read IMO

<snip>
>         items = put_entry(buf, sizeof(uint32_t), 1, fp);
>         if (items != 1)
>                 return -1;
>         for (rt = p->range_tr; rt; rt = rt->next) {
> -               buf[0] = cpu_to_le32(rt->dom);
> -               buf[1] = cpu_to_le32(rt->type);
> +               if (!new_rangetr && rt->target_class !=
> SECCLASS_PROCESS)
> +                       continue;

I think this was mentioned in another email but a WARN() should probably
be put here

<snip>
> +       rule = malloc(sizeof(struct range_trans_rule));
> +       if (!rule) {
> +               yyerror("out of memory");
> +               return -1;
> +       }
> +       memset(rule, 0, sizeof(struct range_trans_rule));

init?


In addition to the other comments this looks pretty good. I hope that
we'll be able to use this format change to allow range_trans in modules.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
