Subject: Re: [PATCH][RFC] selinux: preserve boolean values across policy
	reloads
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1177006579.27654.169.camel@moss-spartans.epoch.ncsc.mil>
References: <1177006579.27654.169.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 19 Apr 2007 14:34:10 -0400
Message-Id: <1177007650.21732.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-19 at 14:16 -0400, Stephen Smalley wrote:
> At present, the userland policy loading code has to go through contortions to preserve
> boolean values across policy reloads, and cannot do so atomically.  
> As this is what we always want to do for reloads, let the kernel preserve them instead.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> 

Looks good to me.

Karl

> ---
> 
>  security/selinux/ss/services.c |   38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1249,6 +1249,7 @@ bad:
>  }
>  
>  extern void selinux_complete_init(void);
> +static int security_preserve_bools(struct policydb *p);
>  
>  /**
>   * security_load_policy - Load a security policy configuration.
> @@ -1325,6 +1326,12 @@ int security_load_policy(void *data, size_t len)
>  		goto err;
>  	}
>  
> +	rc = security_preserve_bools(&newpolicydb);
> +	if (rc) {
> +		printk(KERN_ERR "security:  unable to preserve booleans\n");
> +		goto err;
> +	}
> +
>  	/* Clone the SID table. */
>  	sidtab_shutdown(&sidtab);
>  	if (sidtab_map(&sidtab, clone_sid, &newsidtab)) {
> @@ -1882,6 +1889,37 @@ out:
>  	return rc;
>  }
>  
> +static int security_preserve_bools(struct policydb *p)
> +{
> +	int rc, nbools = 0, *bvalues = NULL, i;
> +	char **bnames = NULL;
> +	struct cond_bool_datum *booldatum;
> +	struct cond_node *cur;
> +
> +	rc = security_get_bools(&nbools, &bnames, &bvalues);
> +	if (rc)
> +		goto out;
> +	for (i = 0; i < nbools; i++) {
> +		booldatum = hashtab_search(p->p_bools.table, bnames[i]);
> +		if (booldatum)
> +			booldatum->state = bvalues[i];
> +	}
> +	for (cur = p->cond_list; cur != NULL; cur = cur->next) {
> +		rc = evaluate_cond_node(p, cur);
> +		if (rc)
> +			goto out;
> +	}
> +
> +out:
> +	if (bnames) {
> +		for (i = 0; i < nbools; i++)
> +			kfree(bnames[i]);
> +	}
> +	kfree(bnames);
> +	kfree(bvalues);
> +	return rc;
> +}
> +
>  /*
>   * security_sid_mls_copy() - computes a new sid based on the given
>   * sid and the mls portion of mls_sid.
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
