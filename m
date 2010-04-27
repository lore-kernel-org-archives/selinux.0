Subject: Re: [PATCH 1/3] SELinux: standardize return code handling in
 policydb.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100422173632.23830.10834.stgit@paris.rdu.redhat.com>
References: <20100422173632.23830.10834.stgit@paris.rdu.redhat.com>
Content-Type: text/plain
Date: Tue, 27 Apr 2010 11:12:15 -0400
Message-Id: <1272381135.25840.95.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-04-22 at 13:36 -0400, Eric Paris wrote:
> policydb.c has lots of different standards on how to handle return paths on
> error.  For the most part transition to
> 
> 	rc=errno
> 	if (failure)
> 		goto out;
> [...]
> out:
> 	cleanup()
> 	return rc;
> 
> Instead of doing cleanup mid function, or having multiple returns or other
> options.  This doesn't do that for every function, but most of the complex
> functions which have cleanup routines on error.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  security/selinux/ss/policydb.c |  590 +++++++++++++++++++---------------------
>  1 files changed, 282 insertions(+), 308 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index 4f584fb..c58f733 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
<snip>
> @@ -961,37 +953,37 @@ static int perm_read(struct policydb *p, struct hashtab *h, void *fp)
>  	__le32 buf[2];
>  	u32 len;
>  
> +	rc = -ENOMEM;
>  	perdatum = kzalloc(sizeof(*perdatum), GFP_KERNEL);
> -	if (!perdatum) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	if (!perdatum)
> +		goto bad;
>  
>  	rc = next_entry(buf, fp, sizeof buf);
> -	if (rc < 0)
> +	if (rc)
>  		goto bad;
>  
>  	len = le32_to_cpu(buf[0]);
>  	perdatum->value = le32_to_cpu(buf[1]);
>  
> +	rc = -ENOMEM;
>  	key = kmalloc(len + 1, GFP_KERNEL);
> -	if (!key) {
> -		rc = -ENOMEM;
> +	if (!key)
>  		goto bad;
> -	}
> +
>  	rc = next_entry(key, fp, len);
> -	if (rc < 0)
> +	if (rc)
>  		goto bad;
>  	key[len] = '\0';
>  
>  	rc = hashtab_insert(h, key, perdatum);
>  	if (rc)
>  		goto bad;
> -out:
> -	return rc;
> +
> +	return 0;
>  bad:
> -	perm_destroy(key, perdatum, NULL);
> -	goto out;
> +	if (perdatum)
> +		perm_destroy(key, perdatum, NULL);

Perhaps it would be better to make all the _destroy() functions just
handle the case where any of their arguments are NULL cleanly.

> @@ -1795,14 +1777,17 @@ int policydb_read(struct policydb *p, void *fp)
>  	p->reject_unknown = !!(le32_to_cpu(buf[1]) & REJECT_UNKNOWN);
>  	p->allow_unknown = !!(le32_to_cpu(buf[1]) & ALLOW_UNKNOWN);
>  
> +	rc = -EINVAL;
>  	if (p->policyvers >= POLICYDB_VERSION_POLCAP &&
>  	    ebitmap_read(&p->policycaps, fp) != 0)
>  		goto bad;
>  
> +	rc = -EINVAL;
>  	if (p->policyvers >= POLICYDB_VERSION_PERMISSIVE &&
>  	    ebitmap_read(&p->permissive_map, fp) != 0)
>  		goto bad;

You didn't introduce this bug, but ebitmap_read may fail for reasons
other than invalid input (e.g. ENOMEM is possible).

> @@ -2202,10 +2174,12 @@ int policydb_read(struct policydb *p, void *fp)
>  	for (i = 0; i < p->p_types.nprim; i++) {
>  		ebitmap_init(&p->type_attr_map[i]);
>  		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
> +			rc = -EINVAL;
>  			if (ebitmap_read(&p->type_attr_map[i], fp))
>  				goto bad;
>  		}
>  		/* add the type itself as the degenerate case */
> +		rc = -EINVAL;
>  		if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
>  				goto bad;

Likwise here (for both ebitmap_read and ebitmap_set_bit).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
