Subject: Re: [RFC] [PATCH]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Linux Audit Discussion <linux-audit@redhat.com>,
   James Morris <jmorris@namei.org>
In-Reply-To: <43F49805.2000109@trustedcs.com>
References: <43F49805.2000109@trustedcs.com>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 13:12:43 -0500
Message-Id: <1140113563.12655.140.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-02-16 at 09:19 -0600, Darrel Goeddel wrote:
> This is still a work in progress (I'm guessing that the conversion of Dustin's
> earlier work will point out some improvements to these interfaces).  I also
> need to check the context of memory allocations.

Needs to be GFP_ATOMIC when the policy rdlock is held.

> I'm only allow == and != for type, role, and user because they seemed to be
> the only ones that make sense, is that OK, or should I take them all even
> though they may not do anything useful?  Does the general approach seem acceptable?

Role dominance is another possibility, although I don't know if it would
be used in practice.  Did you consider trying to leverage or factor
common code with constraint_expr_eval?

> +int selinux_audit_rule_init(u32 field, u32 op, const char *rulestr,
> +                            void **rule);

We could alternatively define an opaque struct type for the rule, and
just keep the definition private to SELinux.  That allows proper type
checking in the audit code when they are passed around and stored.

> +int selinux_task_getsecid(struct task_struct *tsk);

SID is an unsigned 32-bit quantity, but you return a signed int.  And
typically it seems that it is preferred to return-by-argument and leave
the return value as either an integer error status (0 or -errno) or void
if no errors are possible.

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index d877cd1..480df81 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1810,3 +1810,250 @@ out:
>  	POLICY_RDUNLOCK;
>  	return rc;
>  }
> +
> +struct selinux_audit_rule {
> +	u32 au_skip;

Not sure I understand when skipped rules get re-processed.

> +static void aurule_init_context(struct selinux_audit_rule *aurule)
<snip>
> +	if (rc) {
> +		aurule->au_skip = 1;
> +		context_destroy(&aurule->au_ctxt);
> +	} else {
> +		/* we merely flags this rule to not be processed - the role,
> +		   user, type, or level of the rule may not be valid now, but
> +		   may be after a future policy reload. */
> +		aurule->au_skip = 0;
> +	}

Hmm..seems like you'd want an error status returned all the way to
userspace (auditctl) so that the user knows it isn't active.

> +	if (!ss_initialized) {
> +		tmprule->au_seqno = latest_granting;
> +		tmprule->au_skip = 1;
> +		*rule = tmprule;
> +		return 0;
> +	}

I think we should just reject audit filters on contexts until policy is
loaded, and not try to defer them.

> +int security_aurule_match(u32 ctxid, void *rule)
> +{
<snip>
> +	POLICY_RDLOCK;
> +
> +	if (aurule->au_seqno < latest_granting) {
> +		context_destroy(&aurule->au_ctxt);
> +		aurule->au_seqno = latest_granting;
> +		aurule_init_context(aurule);
> +	}

Interesting approach; I was expecting to have the audit system register
an AVC callback for reloads (similar to netif table) and initiate the
re-processing of its audit rules at that time.  And simply fail on
filters with stale seqnos if there happened to be an interleaving with
the policy reload.  I suppose that this is more robust.

> +	if (aurule->au_skip)
> +		goto out;

Ok, but when does the skip flag ever get cleared?

> +	ctxt = sidtab_search(&sidtab, ctxid);
> +	if (!ctxt) {
> +		/* TODO: what to do? */
> +		printk(KERN_ERR "security_aurule_match: unrecognized SID %d\n",
> +		       ctxid);
> +		match = -EINVAL;
> +		goto out;
> +	}

Unlikely since sidtab_search remaps invalid SIDs to unlabeled to deal
with invalidated SIDs due to reloads.

> +		case AUDIT_LESS_THAN_OR_EQUAL:
> +			match = (mls_level_eq(&aurule->au_ctxt.range.level[0],
> +			                      level) ||
> +			         mls_level_dom(&aurule->au_ctxt.range.level[0],
> +			                       level));
> +			break;

Isn't checking both redundant?  Did you mean to force !mls_level_eq in
the LESS_THAN case?

> +		case AUDIT_GREATER_THAN:
> +			match = mls_level_dom(level,
> +			                      &aurule->au_ctxt.range.level[0]);
> +			break;
> +		case AUDIT_GREATER_THAN_OR_EQUAL:
> +			match = (mls_level_eq(&aurule->au_ctxt.range.level[0],
> +			                      level) ||
> +			         mls_level_dom(level,
> +			                      &aurule->au_ctxt.range.level[0]));
> +			break;

Ditto.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
