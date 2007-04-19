Message-ID: <4627B314.8050103@manicmethod.com>
Date: Thu, 19 Apr 2007 14:21:08 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: Re: [PATCH][RFC] selinux: preserve boolean values across policy reloads
References: <1177006579.27654.169.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1177006579.27654.169.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> At present, the userland policy loading code has to go through contortions to preserve
> boolean values across policy reloads, and cannot do so atomically.  
> As this is what we always want to do for reloads, let the kernel preserve them instead.
>
>   
Are there situation where you may want to reset the boolean state to 
policy defaults? I can't think of realistic scenarios but if one ever 
comes up do we want to provide that facility?

> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>
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
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
