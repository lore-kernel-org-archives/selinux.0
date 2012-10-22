Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q9MHmQWB009173
	for <selinux@tycho.nsa.gov>; Mon, 22 Oct 2012 13:48:26 -0400
Message-ID: <508586B4.9070802@schaufler-ca.com>
Date: Mon, 22 Oct 2012 10:47:32 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
CC: jmorris@namei.org, linux-security-module@vger.kernel.org,
        john.johansen@canonical.com, selinux@tycho.nsa.gov,
        keescook@chromium.org, Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH v5] LSM: Multiple concurrent LSMs
References: <5081B30F.6090009@schaufler-ca.com> <201210211206.DEI34330.FLFQMtFOOSJOHV@I-love.SAKURA.ne.jp> <201210211337.DAF60411.FMHOVSJOQOFtFL@I-love.SAKURA.ne.jp>
In-Reply-To: <201210211337.DAF60411.FMHOVSJOQOFtFL@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 10/20/2012 9:37 PM, Tetsuo Handa wrote:
> What about adding "struct security_operations *next;" to
> "struct security_operations" like below?

This would address the memory leak introduced by my
version of security_reset_ops.

What is doesn't address is all of the checks to see if
a particular LSM provides a hook. For that there needs
to be a list in each hook. A list per hook would complicate
registration and reset. It would allow cleaner handling
of the capability hooks.

My inclination is to have a shot at making the changes in
security.c to do the lists at that level. It's more work,
but I think it would be a better result.

>
>  struct security_operations {
>  	char name[SECURITY_NAME_MAX + 1];
> + 	int index; /* Index number used by lsm_get_blob()/lsm_set_blob(). */
> + 	struct security_operations *next; /* Next LSM to call if not NULL. */
>  	int foo();
>  	int bar_alloc();
>  	void bar_free();
>  };
>
> I think the basic change looks like
>
>  int security_foo()
>  {
> -	return security_ops->foo();
> +	struct security_operations *ops = security_ops;
> +	for (ops = security_ops; ops; ops = ops->next)
> +		if (ops->foo) {
> +			int rc = ops->foo();
> +			if (rc)
> +				return rc;
> +		}
> +	return 0;

Standard list macros should be used. Not that I think they
add all that much value in this case, but you never know.

I still think that we want to "call all" rather than
"bail on fail".

>  }
>
>  int security_bar_alloc()
>  {
> -	return security_ops->bar_alloc();
> +	int rc;
> +	struct security_operations *ops;
> +	struct security_operations *tmp;
> +	for (ops = security_ops; ops; ops = ops->next)
> +		if (ops->bar_alloc) {
> +			rc = ops->bar_alloc();
> +			if (rc)
> +				goto undo;
> +		}
> +	return 0;
> +undo:
> +	for (tmp = security_ops; tmp != ops; tmp = tmp->next)
> +		if (tmp->bar_free)
> +			tmp->bar_free();
> +	return rc;

Looks about right.

>  }
>
>  void security_bar_free()
>  {
> -	security_ops->bar_free();
> +	struct security_operations *ops;
> +	for (ops = security_ops; ops; ops = ops->next)
> +		if (ops->bar_free)
> +			ops->bar_free();
>  }

Same for any "void" hook.

>
> and unregistration will look like
>
>  int remove_security_ops(struct security_operations *lsm)
>  {
>  	struct security_operations *ops = security_ops;
>  	struct security_operations *prev = ops;
>  	do {
>  		if (ops == lsm) {
>  			prev->next = lsm->next;
>  			return 0;
>  		}
>  		prev = ops;
>  		ops = ops->next;
>  	} while (ops);
>  	return -ENOENT;
>  }

Very clean, but it's not important that this be clean.

>
> and registration will look like
>
>  int add_security_ops(struct security_operations *lsm)
>  {
>  	static int index;
>  	struct security_operations *ops = security_ops;
>  	while (1) {
>  		if (ops == lsm)
>  			return 0;
>  		if (!ops->next)
>  			break;
>  		ops = ops->next;
>  	}
>  	if (index == COMPOSER_MAX - 1)
>  		return -ENOSPC;
>  	lsm->index = index++;
>  	ops->next = lsm;
>  	return 0;
>  }

Plus conflict checking. Again, it's not really important how
clean this operation is.

>
> .
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
