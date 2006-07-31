Message-ID: <44CE51C8.6080805@trustedcs.com>
Date: Mon, 31 Jul 2006 13:54:00 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
CC: "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>,
        Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [PATCH 2/2] userland support for new range_transition	statements
References: <44CA298B.7080706@trustedcs.com> <1154370592.26550.144.camel@localhost.localdomain>
In-Reply-To: <1154370592.26550.144.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Karl MacMillan wrote:
> On Fri, 2006-07-28 at 10:13 -0500, Darrel Goeddel wrote:
> <snip>
> 
>>+typedef struct range_trans_rule {
>>+	type_set_t stypes;
>>+	type_set_t ttypes;
>>+	class_perm_node_t *classes;	/* only class is used */
> 
> 
> Is class_perm_node_t the correct choice? What about an ebitmap for the
> classes? It is easier to manage and you don't end up wasting space for
> perms when they aren't used.

Using an ebitmap for classes does seem much nicer.  I looked at the type transition
rules before writing this and the list of classes from the avtab rules stuck with
me.  I'll make the change and see how it looks.

> <snip>
> 
>>+static int expand_range_trans(expand_state_t *state, range_trans_rule_t *rules)
>>+{
>>+	unsigned int i, j;
>>+	range_trans_t *rt, *lrt, *cur_rt;
>>+	range_trans_rule_t *rule;
>>+	class_perm_node_t *cp;
>>+
>>+	ebitmap_t stypes, ttypes;
>>+	ebitmap_node_t *snode, *tnode;
>>+
>>+	/* start appending at the end of the current list */
>>+	for (lrt = state->out->range_tr; lrt && lrt->next; lrt = lrt->next)
>>+		;
>>+
>>+	for (rule = rules; rule; rule = rule->next) {
>>+		ebitmap_init(&stypes);
>>+		ebitmap_init(&ttypes);
>>+
>>+		/* expand the type sets */
>>+		if (expand_convert_type_set(state->out, state->typemap,
>>+		                            &rule->stypes, &stypes, 1)) {
>>+			ERR(state->handle, "Out of memory!");
>>+			return -1;
>>+		}
>>+		if (expand_convert_type_set(state->out, state->typemap,
>>+		                            &rule->ttypes, &ttypes, 1)) {
>>+			ERR(state->handle, "Out of memory!");
>>+			return -1;
>>+		}
>>+
>>+		/* loop on source type */
>>+		ebitmap_for_each_bit(&stypes, snode, i) {
>>+			if (!ebitmap_node_get_bit(snode, i))
>>+				continue;
>>+			/* loop on target type */
>>+			ebitmap_for_each_bit(&ttypes, tnode, j) {
>>+				if (!ebitmap_node_get_bit(tnode, j))
>>+					continue;
>>+				/* loop on target class */
>>+				for (cp = rule->classes; cp; cp = cp->next) {
>>+
>>+					/* check for duplicates/conflicts */
>>+					for (cur_rt = state->out->range_tr; cur_rt; cur_rt = cur_rt->next) {
>>+						if ((cur_rt->source_type == i + 1) &&
>>+						    (cur_rt->target_type == j + 1) &&
>>+						    (cur_rt->target_class == cp->class)) {
>>+							if (mls_range_eq(&cur_rt->target_range, &rule->trange)) {
>>+								/* duplicate */
>>+								break;
>>+							} else {
>>+								/* conflict */
>>+								ERR(state->handle,
>>+								    "Conflicting range trans rule %s %s : %s",
>>+								    state->out->p_type_val_to_name[i],
>>+								    state->out->p_type_val_to_name[j],
>>+								    state->out->p_class_val_to_name[cp->class]);
>>+								return -1;
>>+							}
>>+						}
>>+					}
>>+					if (cur_rt) /* this is a dup - skip */
>>+						continue;
>>+
>>+					rt = (range_trans_t *)malloc(sizeof(range_trans_t));
>>+					if (!rt) {
>>+						ERR(state->handle, "Out of memory!");
>>+						return -1;
>>+					}
>>+					memset(rt, 0, sizeof(range_trans_t));
>>+					rt->source_type = i + 1;
>>+					rt->target_type = j + 1;
>>+					rt->target_class = cp->class;
>>+					if (mls_range_cpy(&rt->target_range, &rule->trange)) {
>>+						ERR(state->handle, "Out of memory!");
>>+						return -1;
>>+					}
>>+					if (lrt) {
>>+						lrt->next = rt;
>>+					} else {
>>+						state->out->range_tr = rt;
>>+					}
>>+					lrt = rt;
>>+				}
>>+			}
>>+		}
>>+
>>+		ebitmap_destroy(&stypes);
>>+		ebitmap_destroy(&ttypes);
>>+	}
>>+
>>+	return 0;
>>+}
>>+
> 
> 
> Splitting this into some helper functions would make it more readable. 

Yeah. I tried some breakups before but I really didn't find much that helped.
I'll try again.  I still code at the console sometimes and I hate yelling at
myself for things like this ;)

> <snip>
> 
>>Index: libsepol/src/write.c
>>===================================================================
>>--- libsepol/src/write.c	(revision 38)
>>+++ libsepol/src/write.c	(working copy)
>>@@ -39,6 +39,7 @@
>> #include <sepol/policydb/policydb.h>
>> #include <sepol/policydb/conditional.h>
>> #include <sepol/policydb/expand.h>
>>+#include <sepol/policydb/flask.h>
>> 
>> #include "debug.h"
>> #include "private.h"
>>@@ -1124,21 +1125,36 @@
>> {
>> 	size_t nel, items;
>> 	struct range_trans *rt;
>>-	uint32_t buf[32];
>>+	uint32_t buf[2];
>>+	int new_rangetr = (p->policy_type == POLICY_KERN &&
>>+	                   p->policyvers >= POLICYDB_VERSION_RANGETRANS);
>> 	nel = 0;
>>-	for (rt = p->range_tr; rt; rt = rt->next)
>>-		nel++;
>>+	for (rt = p->range_tr; rt; rt = rt->next) {
>>+		/* all range_transitions are written for the new format, only
>>+		   process related range_transitions are written for the old
>>+		   format, so count accordingly */
>>+		if (new_rangetr || rt->target_class == SECCLASS_PROCESS)
>>+			nel++;
>>+	}
> 
> 
> So there is no warning or indication that rules are being dropped? At
> some point it would be nice to let the user know that they are compiling
> a policy aimed at the new format but outputting an older policy.

Correct.  I think you inadvertently pointed out some tests I forgot to run -
I have not compiled/tested monolithic policies with this patchset.  I am
assuming that you can still specify an older output format when compiling
monolithically unlike the modular case where it always writes the newest
formats.  There we would be able to print out a warning about unsupported
bits being discarded.  The case I have tested with this code path is
libselinux downgrading a version 21 policy to version 20 for use in an older
kernel.  In that case, I really don't see an appropriate feedback mechanism.
Any thoughts on that case?  Warn about policy downgrades in some manner?

> Overall this looks good - again, thanks for taking the time to make it
> more complete. Seems like once we can require MLS symbols in modules it
> won't be too difficult to get range trans working with this change.

Cool.  Thanks for taking at look at that.

> Karl

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
