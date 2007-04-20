Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3K0QJQY029225
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 20:26:19 -0400
Received: from mail2.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3K0QHp8011169
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 00:26:18 GMT
Date: Thu, 19 Apr 2007 20:26:15 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: selinux@tycho.nsa.gov, Eric Paris <eparis@parisplace.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Joshua Brindle <method@manicmethod.com>
Subject: Re: [PATCH][RFC] selinux: preserve boolean values across policy
 reloads
In-Reply-To: <1177006579.27654.169.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Line.LNX.4.64.0704192026090.12772@d.namei>
References: <1177006579.27654.169.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 19 Apr 2007, Stephen Smalley wrote:

> At present, the userland policy loading code has to go through contortions to preserve
> boolean values across policy reloads, and cannot do so atomically.  
> As this is what we always want to do for reloads, let the kernel preserve them instead.
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Applied.

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
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
