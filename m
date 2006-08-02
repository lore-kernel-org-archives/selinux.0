Message-ID: <44D0D516.5010906@trustedcs.com>
Date: Wed, 02 Aug 2006 11:38:46 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH 2/2] userland support for new range_transition statements
References: <44CA298B.7080706@trustedcs.com> <1154438074.23513.30.camel@twoface.columbia.tresys.com>
In-Reply-To: <1154438074.23513.30.camel@twoface.columbia.tresys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> On Fri, 2006-07-28 at 11:13 -0400, Darrel Goeddel wrote:
> 
>>Index: libsepol/include/sepol/policydb/policydb.h
>>===================================================================
>>--- libsepol/include/sepol/policydb/policydb.h  (revision 38)
>>+++ libsepol/include/sepol/policydb/policydb.h  (working copy)
> 
> 
>>+typedef struct range_trans_rule {
>>+       type_set_t stypes;
>>+       type_set_t ttypes;
>>+       class_perm_node_t *classes;     /* only class is used */
>>+       mls_range_t trange;
>>+       struct range_trans_rule *next;
>>+} range_trans_rule_t;
>>+
> 
> 
> Are we sure that mls_range_t is semantic enough to store the rule, even
> in a module situation where all the symbols are not present?

Hmmm...  I assume that you have MLS requirements in mind when you say that,
especially the '.' notation.  The problem is that if we specify "s4:c0.c12" as
the range, how do we know what will be between c0 and c12 (they are arbitrary
names).  Are you suggesting possibly storing the string and figuring the whole
thing out at expand time?

We could also make sensitivity and category names non-arbitrary and force the 
naming convention of s# and c# ;)  Translations take care of human-readable for
us now...

>>+static int expand_range_trans(expand_state_t *state,
>>range_trans_rule_t *rules)
>>+{
>>+       unsigned int i, j;
>>+       range_trans_t *rt, *lrt, *cur_rt;
>>+       range_trans_rule_t *rule;
>>+       class_perm_node_t *cp;
>>+
>>+       ebitmap_t stypes, ttypes;
>>+       ebitmap_node_t *snode, *tnode;
>>+
>>+       /* start appending at the end of the current list */
>>+       for (lrt = state->out->range_tr; lrt && lrt->next; lrt =
>>lrt->next)
>>+               ;
> 
> 
> I know the current code is like this, it was probably done that way to
> match the pre-module compiler behavior but we could probably change
> these to prepend, for simpler code.

I'll look at that.

>>+                                       rt = (range_trans_t
>>*)malloc(sizeof(range_trans_t));
>>+                                       if (!rt) {
>>+                                               ERR(state->handle,
>>"Out of memory!");
>>+                                               return -1;
>>+                                       }
>>+                                       memset(rt, 0,
>>sizeof(range_trans_t));
> 
> 
> It is my preference to have initializers for structs but even if not the
> current trend in this library is to turn malloc/memset into calloc.
> (Though I'd really prefer an initializer just so that these sites don't
> have to be audited when the struct changes)

I'll check on this as well - I'll at least change to calloc.

>>+               new_range->target_class = range->target_class;
>>+               if (mls_level_clone(&new_range->target_range.level[0],
>>+                                   &range->target_range.level[0]) ||
>>+                   mls_level_clone(&new_range->target_range.level[1],
>>+                                   &range->target_range.level[1])) {
> 
> 
> can we break these into separate calls? It is easier to read IMO

Yep.

>>        items = put_entry(buf, sizeof(uint32_t), 1, fp);
>>        if (items != 1)
>>                return -1;
>>        for (rt = p->range_tr; rt; rt = rt->next) {
>>-               buf[0] = cpu_to_le32(rt->dom);
>>-               buf[1] = cpu_to_le32(rt->type);
>>+               if (!new_rangetr && rt->target_class !=
>>SECCLASS_PROCESS)
>>+                       continue;
> 
> 
> I think this was mentioned in another email but a WARN() should probably
> be put here

Will do.

>>+       rule = malloc(sizeof(struct range_trans_rule));
>>+       if (!rule) {
>>+               yyerror("out of memory");
>>+               return -1;
>>+       }
>>+       memset(rule, 0, sizeof(struct range_trans_rule));
> 
> 
> init?

Sounds like a plan.

> In addition to the other comments this looks pretty good. I hope that
> we'll be able to use this format change to allow range_trans in modules.

Cool.  I hope to have a revision of the patch that includes your all of the
feedback received so far (except the mls_range_t in the range_trans_rule_t - I
think there will be more discussion there) by tomorrow afternoon.


-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
