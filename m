Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qA71ckpn005781
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2012 20:38:46 -0500
Message-ID: <5099BB81.6000506@schaufler-ca.com>
Date: Tue, 06 Nov 2012 17:38:09 -0800
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov, john.johansen@canonical.com, eparis@redhat.com,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v6] LSM: Multiple concurrent LSMs
References: <50986053.9060105@schaufler-ca.com> <201211062144.CFB09368.JOQMFHFFVSOLtO@I-love.SAKURA.ne.jp>
In-Reply-To: <201211062144.CFB09368.JOQMFHFFVSOLtO@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 11/6/2012 4:44 AM, Tetsuo Handa wrote:
> Overall, this version can eliminate overhead caused by unimplemented hooks.
> Then, I think we can afford allowing legal registration of trivial LKM-based
> LSM modules after the init process starts; LSM modules which wants to use
> lsm_blobs are limited to COMPOSER_MAX but LSM modules which do not need
> lsm_blobs are allowed to chain as many as the administrator wants.

So if an LSM includes no hooks that use blobs none would get
allocated. Yama, for example. There would have to be a separate
load order from blob slot number. I'm tempted to say it's too
rare a case to worry about, but we have the example of Yama
sitting there challenging that assertion.

I will consider this.

> Below are trivial checks.
>
>
> +struct lsm_list {
> +    struct list_head        list;
> +    struct security_operations    *ops;
> +};
>
> +static void lsm_delist(struct security_operations *ops, struct
> list_head *list)
> +{
> +#ifdef CONFIG_SECURITY_COMPOSER_DEBUG
> +    static int leaked;
> +#endif
> +    struct lsm_list *lp;
> +
> +    list_for_each_entry(lp, list, list) {
> +        if (lp->ops == ops) {
> +            list_del_init(&lp->list);
> +#ifdef CONFIG_SECURITY_COMPOSER_DEBUG
> +            leaked += sizeof(*lp);
> +            pr_warn("%s lsm %s leaking %d bytes\n", __func__,
> +                ops->name, leaked);
> +#endif
> +            return;
> +        }
> +    }
> +}
>
> sizeof(*lp) should be 32 rather than 12 on x86_32 unless CONFIG_SLOB=y .

So the reality is that I'd be happy to report the number of lsm_list
blobs rather than the size, if that would be more palatable. Or, not
report a quantity at all, just say "Leaked some bytes while delisting
an LSM" and be done. Do you feel strongly one way or the other? Does
anyone else care?


> Seems unsafe list deletion. I think we need to use _rcu version since somebody
> (kernel threads) may be walking on the list when lsm_delist_ops() is called by
> the init process.

Here's the question, and I don't know the answer. lsm_delist() gets called
under two conditions: an early memory allocation failure that will almost
certainly precede a fatal memory allocation error, or a call to
security_reset_ops(), which is strictly a one-time thing. Might it be
better to have a lock of some sort to deal with the unlikely case of a
call to lsm_delist than to use the _rcu versions? I honestly don't know
what the cost of using _rcu is, so it may not matter.

Of course, I'd be fine with a panic if the LSM list entry allocation
failed because it just should never happen. As far as security_reset_ops()
is concerned, I think we'd only have to sell one distribution on the
virtue of removing it. Maybe.

> Maybe we want noinline attribute, for inlining lsm_delist() into
> lsm_delist_ops() is a bloat. And so does noinline attribute to lsm_enlist().

I'm hesitant to try to second guess the compilers on this. If a
performance expert told me to do it, I would, but I'd hate to be too
clever.

> +extern struct security_operations *composer_ops[];
>
> No longer used variable.

Right you are.

>  void security_bprm_committed_creds(struct linux_binprm *bprm)
>  {
> -    security_ops->bprm_committed_creds(bprm);
> +    struct lsm_list *lp;
> +
> +    list_for_each_entry(lp, &lsm_bprm_committed_creds, list)
> +        lp->ops->bprm_committed_creds(bprm);
>  }
>
> Seems unsafe list traversal. I think we need to use _rcu version since somebody
> (kernel threads) may be walking on the list when lsm_delist_ops() is called by
> the init process.

As discussed above, I'm OK to switch to _rcu if the performance
doesn't matter. It would be unfortunate to add unnecessary overhead
for such an extremely special case.

> +            for (; successes >= 0; successes--)
> +                note[successes]->cred_free(cred);
>
> Seems wrong starting point.
>
> 	note[successes++] = lp->ops;
>
> wants to start from --successes, which can be simplified like
>
> 	while (successes)
> 		note[--successes]->cred_free(cred);

Yup. Will fix for the next version.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
