Message-ID: <43F4DBE0.3060204@trustedcs.com>
Date: Thu, 16 Feb 2006 14:09:04 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>
Subject: Re: [RFC] [PATCH]
References: <43F49805.2000109@trustedcs.com> <1140113563.12655.140.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1140113563.12655.140.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Thu, 2006-02-16 at 09:19 -0600, Darrel Goeddel wrote:
> 
>>This is still a work in progress (I'm guessing that the conversion of Dustin's
>>earlier work will point out some improvements to these interfaces).  I also
>>need to check the context of memory allocations.
> 
> 
> Needs to be GFP_ATOMIC when the policy rdlock is held.

Thanks.  Now I have to figure out how to propogate ENOMEM...

> 
>>I'm only allow == and != for type, role, and user because they seemed to be
>>the only ones that make sense, is that OK, or should I take them all even
>>though they may not do anything useful?  Does the general approach seem acceptable?
> 
> 
> Role dominance is another possibility, although I don't know if it would
> be used in practice.  Did you consider trying to leverage or factor
> common code with constraint_expr_eval?

True on role dominance.  No on constraint_expr_eval - I'll give it a look.

> 
>>+int selinux_audit_rule_init(u32 field, u32 op, const char *rulestr,
>>+                            void **rule);
> 
> 
> We could alternatively define an opaque struct type for the rule, and
> just keep the definition private to SELinux.  That allows proper type
> checking in the audit code when they are passed around and stored.
> 
> 
>>+int selinux_task_getsecid(struct task_struct *tsk);
> 
> 
> SID is an unsigned 32-bit quantity, but you return a signed int.  And
> typically it seems that it is preferred to return-by-argument and leave
> the return value as either an integer error status (0 or -errno) or void
> if no errors are possible.

I'll change to:

void selinux_task_ctxid(struct task_struct *tsk, u32 *ctxid)

Thats in-line with James' selinux_sk_ctxid

> 
>>diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
>>index d877cd1..480df81 100644
>>--- a/security/selinux/ss/services.c
>>+++ b/security/selinux/ss/services.c
>>@@ -1810,3 +1810,250 @@ out:
>> 	POLICY_RDUNLOCK;
>> 	return rc;
>> }
>>+
>>+struct selinux_audit_rule {
>>+	u32 au_skip;
> 
> 
> Not sure I understand when skipped rules get re-processed.

I'll add some comments for that.  A rule will get reprocessed when a new
policy is loaded (triggered by the seqno check in security_aurule_match).
That will then reset the au_skip field appropriately.  The idea behind this
is to allow a rule to be present for a type, role, etc. that does not exist
in the current policy, but they are never processed.  If the item is included
in a policy that is loaded later, the rule will be setup completely and
activated (au_skip = 0).  Conversely, if an item disappears, the rule is
just inactivated.

This give the same behavior as the other audit rule fields.  For example, a
rule can be there for a uid that is not used on the system and it will simply
never match.  If that uid is later used on the system, the rule will then be
used.  Same goes for inums that aren't used and probably most other fields...

> 
>>+static void aurule_init_context(struct selinux_audit_rule *aurule)
> 
> <snip>
> 
>>+	if (rc) {
>>+		aurule->au_skip = 1;
>>+		context_destroy(&aurule->au_ctxt);
>>+	} else {
>>+		/* we merely flags this rule to not be processed - the role,
>>+		   user, type, or level of the rule may not be valid now, but
>>+		   may be after a future policy reload. */
>>+		aurule->au_skip = 0;
>>+	}
> 
> 
> Hmm..seems like you'd want an error status returned all the way to
> userspace (auditctl) so that the user knows it isn't active.

The above comment hopefully explains my thinking on this one.  Steve Grubb had
the same question and seemed to buy into my explanation.

> 
>>+	if (!ss_initialized) {
>>+		tmprule->au_seqno = latest_granting;
>>+		tmprule->au_skip = 1;
>>+		*rule = tmprule;
>>+		return 0;
>>+	}
> 
> 
> I think we should just reject audit filters on contexts until policy is
> loaded, and not try to defer them.

True.  My previous "testing" did add rules before policy load with an __initcall in
the audit module - but I somehow don't think that will be standard practice...

> 
>>+int security_aurule_match(u32 ctxid, void *rule)
>>+{
> 
> <snip>
> 
>>+	POLICY_RDLOCK;
>>+
>>+	if (aurule->au_seqno < latest_granting) {
>>+		context_destroy(&aurule->au_ctxt);
>>+		aurule->au_seqno = latest_granting;
>>+		aurule_init_context(aurule);
>>+	}
> 
> 
> Interesting approach; I was expecting to have the audit system register
> an AVC callback for reloads (similar to netif table) and initiate the
> re-processing of its audit rules at that time.  And simply fail on
> filters with stale seqnos if there happened to be an interleaving with
> the policy reload.  I suppose that this is more robust.

I was hoping you'd agree on this one.  This idea seemed much simpler to me and
I think it avoids quite a bit of extra code for the rule rebuilding.

> 
>>+	if (aurule->au_skip)
>>+		goto out;
> 
> 
> Ok, but when does the skip flag ever get cleared?

See above comment on rule re-processing.

>>+	ctxt = sidtab_search(&sidtab, ctxid);
>>+	if (!ctxt) {
>>+		/* TODO: what to do? */
>>+		printk(KERN_ERR "security_aurule_match: unrecognized SID %d\n",
>>+		       ctxid);
>>+		match = -EINVAL;
>>+		goto out;
>>+	}
> 
> 
> Unlikely since sidtab_search remaps invalid SIDs to unlabeled to deal
> with invalidated SIDs due to reloads.

True.  I'm thinking this is a pretty bad one since it really shouldn't happen.
I'll have to see how the user intends to handle the return of this function
before a final patch will be ready.

> 
>>+		case AUDIT_LESS_THAN_OR_EQUAL:
>>+			match = (mls_level_eq(&aurule->au_ctxt.range.level[0],
>>+			                      level) ||
>>+			         mls_level_dom(&aurule->au_ctxt.range.level[0],
>>+			                       level));
>>+			break;
> 
> 
> Isn't checking both redundant?  Did you mean to force !mls_level_eq in
> the LESS_THAN case?
> 
> 
>>+		case AUDIT_GREATER_THAN:
>>+			match = mls_level_dom(level,
>>+			                      &aurule->au_ctxt.range.level[0]);
>>+			break;
>>+		case AUDIT_GREATER_THAN_OR_EQUAL:
>>+			match = (mls_level_eq(&aurule->au_ctxt.range.level[0],
>>+			                      level) ||
>>+			         mls_level_dom(level,
>>+			                      &aurule->au_ctxt.range.level[0]));
>>+			break;
> 
> 
> Ditto.

Yep to both.  I was thinking of the old mls_level_realtion function that would return
EQ before DOM...  You think I'd know better on that one ;)

Thanks for the feedback.  Next version will incorporate the changes.

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
