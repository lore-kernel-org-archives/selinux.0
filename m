Subject: Re: [PATCH 1/2] SELinux: move genfs read to a separate function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100721165057.5820.23176.stgit@paris.rdu.redhat.com>
References: <20100721165057.5820.23176.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 22 Jul 2010 10:41:17 -0400
Message-ID: <1279809677.11197.36.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-07-21 at 12:50 -0400, Eric Paris wrote:
> move genfs read functionality out of policydb_read() and into a new
> function called genfs_read()
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen D. Smalley <sds@tycho.nsa.gov>

> ---
> 
>  security/selinux/ss/policydb.c |  238 ++++++++++++++++++++++------------------
>  1 files changed, 133 insertions(+), 105 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index a39d38a..4ea073e 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -655,6 +655,9 @@ static int range_tr_destroy(void *key, void *datum, void *p)
>  
>  static void ocontext_destroy(struct ocontext *c, int i)
>  {
> +	if (!c)
> +		return;
> +
>  	context_destroy(&c->context[0]);
>  	context_destroy(&c->context[1]);
>  	if (i == OCON_ISID || i == OCON_FS ||
> @@ -1773,6 +1776,131 @@ out:
>  	return rc;
>  }
>  
> +static int genfs_read(struct policydb *p, void *fp)
> +{
> +	int i, j, rc;
> +	u32 nel, nel2, len, len2;
> +	__le32 buf[1];
> +	struct ocontext *l, *c;
> +	struct ocontext *newc = NULL;
> +	struct genfs *genfs_p, *genfs;
> +	struct genfs *newgenfs = NULL;
> +
> +	rc = next_entry(buf, fp, sizeof(u32));
> +	if (rc)
> +		goto out;
> +	nel = le32_to_cpu(buf[0]);
> +
> +	for (i = 0; i < nel; i++) {
> +		rc = next_entry(buf, fp, sizeof(u32));
> +		if (rc)
> +			goto out;
> +		len = le32_to_cpu(buf[0]);
> +
> +		rc = -ENOMEM;
> +		newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
> +		if (!newgenfs)
> +			goto out;
> +
> +		rc = -ENOMEM;
> +		newgenfs->fstype = kmalloc(len + 1, GFP_KERNEL);
> +		if (!newgenfs->fstype)
> +			goto out;
> +
> +		rc = next_entry(newgenfs->fstype, fp, len);
> +		if (rc)
> +			goto out;
> +
> +		newgenfs->fstype[len] = 0;
> +
> +		for (genfs_p = NULL, genfs = p->genfs; genfs;
> +		     genfs_p = genfs, genfs = genfs->next) {
> +			rc = -EINVAL;
> +			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
> +				printk(KERN_ERR "SELinux:  dup genfs fstype %s\n",
> +				       newgenfs->fstype);
> +				goto out;
> +			}
> +			if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
> +				break;
> +		}
> +		newgenfs->next = genfs;
> +		if (genfs_p)
> +			genfs_p->next = newgenfs;
> +		else
> +			p->genfs = newgenfs;
> +		genfs = newgenfs;
> +		newgenfs = NULL;
> +
> +		rc = next_entry(buf, fp, sizeof(u32));
> +		if (rc)
> +			goto out;
> +
> +		nel2 = le32_to_cpu(buf[0]);
> +		for (j = 0; j < nel2; j++) {
> +			rc = next_entry(buf, fp, sizeof(u32));
> +			if (rc)
> +				goto out;
> +			len = le32_to_cpu(buf[0]);
> +
> +			rc = -ENOMEM;
> +			newc = kzalloc(sizeof(*newc), GFP_KERNEL);
> +			if (!newc)
> +				goto out;
> +
> +			rc = -ENOMEM;
> +			newc->u.name = kmalloc(len + 1, GFP_KERNEL);
> +			if (!newc->u.name)
> +				goto out;
> +
> +			rc = next_entry(newc->u.name, fp, len);
> +			if (rc)
> +				goto out;
> +			newc->u.name[len] = 0;
> +
> +			rc = next_entry(buf, fp, sizeof(u32));
> +			if (rc)
> +				goto out;
> +
> +			newc->v.sclass = le32_to_cpu(buf[0]);
> +			rc = context_read_and_validate(&newc->context[0], p, fp);
> +			if (rc)
> +				goto out;
> +
> +			for (l = NULL, c = genfs->head; c;
> +			     l = c, c = c->next) {
> +				rc = -EINVAL;
> +				if (!strcmp(newc->u.name, c->u.name) &&
> +				    (!c->v.sclass || !newc->v.sclass ||
> +				     newc->v.sclass == c->v.sclass)) {
> +					printk(KERN_ERR "SELinux:  dup genfs entry (%s,%s)\n",
> +					       genfs->fstype, c->u.name);
> +					goto out;
> +				}
> +				len = strlen(newc->u.name);
> +				len2 = strlen(c->u.name);
> +				if (len > len2)
> +					break;
> +			}
> +
> +			newc->next = c;
> +			if (l)
> +				l->next = newc;
> +			else
> +				genfs->head = newc;
> +			newc = NULL;
> +		}
> +	}
> +	rc = 0;
> +out:
> +	if (newgenfs)
> +		kfree(newgenfs->fstype);
> +	kfree(newgenfs);
> +	ocontext_destroy(newc, OCON_FSUSE);
> +
> +	return rc;
> +}
> +
>  /*
>   * Read the configuration data from a policy database binary
>   * representation file into a policy database structure.
> @@ -1781,12 +1909,12 @@ int policydb_read(struct policydb *p, void *fp)
>  {
>  	struct role_allow *ra, *lra;
>  	struct role_trans *tr, *ltr;
> -	struct ocontext *l, *c, *newc;
> -	struct genfs *genfs_p, *genfs, *newgenfs;
> +	struct ocontext *l, *c;
>  	int i, j, rc;
>  	__le32 buf[4];
>  	u32 nodebuf[8];
> -	u32 len, len2, nprim, nel, nel2;
> +	u32 len, nprim, nel;
> +
>  	char *policydb_str;
>  	struct policydb_compat_info *info;
>  
> @@ -2099,107 +2227,9 @@ int policydb_read(struct policydb *p, void *fp)
>  		}
>  	}
>  
> -	rc = next_entry(buf, fp, sizeof(u32));
> -	if (rc < 0)
> +	rc = genfs_read(p, fp);
> +	if (rc)
>  		goto bad;
> -	nel = le32_to_cpu(buf[0]);
> -	genfs_p = NULL;
> -	rc = -EINVAL;
> -	for (i = 0; i < nel; i++) {
> -		rc = next_entry(buf, fp, sizeof(u32));
> -		if (rc < 0)
> -			goto bad;
> -		len = le32_to_cpu(buf[0]);
> -		newgenfs = kzalloc(sizeof(*newgenfs), GFP_KERNEL);
> -		if (!newgenfs) {
> -			rc = -ENOMEM;
> -			goto bad;
> -		}
> -
> -		newgenfs->fstype = kmalloc(len + 1, GFP_KERNEL);
> -		if (!newgenfs->fstype) {
> -			rc = -ENOMEM;
> -			kfree(newgenfs);
> -			goto bad;
> -		}
> -		rc = next_entry(newgenfs->fstype, fp, len);
> -		if (rc < 0) {
> -			kfree(newgenfs->fstype);
> -			kfree(newgenfs);
> -			goto bad;
> -		}
> -		newgenfs->fstype[len] = 0;
> -		for (genfs_p = NULL, genfs = p->genfs; genfs;
> -		     genfs_p = genfs, genfs = genfs->next) {
> -			if (strcmp(newgenfs->fstype, genfs->fstype) == 0) {
> -				printk(KERN_ERR "SELinux:  dup genfs "
> -				       "fstype %s\n", newgenfs->fstype);
> -				kfree(newgenfs->fstype);
> -				kfree(newgenfs);
> -				goto bad;
> -			}
> -			if (strcmp(newgenfs->fstype, genfs->fstype) < 0)
> -				break;
> -		}
> -		newgenfs->next = genfs;
> -		if (genfs_p)
> -			genfs_p->next = newgenfs;
> -		else
> -			p->genfs = newgenfs;
> -		rc = next_entry(buf, fp, sizeof(u32));
> -		if (rc < 0)
> -			goto bad;
> -		nel2 = le32_to_cpu(buf[0]);
> -		for (j = 0; j < nel2; j++) {
> -			rc = next_entry(buf, fp, sizeof(u32));
> -			if (rc < 0)
> -				goto bad;
> -			len = le32_to_cpu(buf[0]);
> -
> -			newc = kzalloc(sizeof(*newc), GFP_KERNEL);
> -			if (!newc) {
> -				rc = -ENOMEM;
> -				goto bad;
> -			}
> -
> -			newc->u.name = kmalloc(len + 1, GFP_KERNEL);
> -			if (!newc->u.name) {
> -				rc = -ENOMEM;
> -				goto bad_newc;
> -			}
> -			rc = next_entry(newc->u.name, fp, len);
> -			if (rc < 0)
> -				goto bad_newc;
> -			newc->u.name[len] = 0;
> -			rc = next_entry(buf, fp, sizeof(u32));
> -			if (rc < 0)
> -				goto bad_newc;
> -			newc->v.sclass = le32_to_cpu(buf[0]);
> -			if (context_read_and_validate(&newc->context[0], p, fp))
> -				goto bad_newc;
> -			for (l = NULL, c = newgenfs->head; c;
> -			     l = c, c = c->next) {
> -				if (!strcmp(newc->u.name, c->u.name) &&
> -				    (!c->v.sclass || !newc->v.sclass ||
> -				     newc->v.sclass == c->v.sclass)) {
> -					printk(KERN_ERR "SELinux:  dup genfs "
> -					       "entry (%s,%s)\n",
> -					       newgenfs->fstype, c->u.name);
> -					goto bad_newc;
> -				}
> -				len = strlen(newc->u.name);
> -				len2 = strlen(c->u.name);
> -				if (len > len2)
> -					break;
> -			}
> -
> -			newc->next = c;
> -			if (l)
> -				l->next = newc;
> -			else
> -				newgenfs->head = newc;
> -		}
> -	}
>  
>  	rc = range_read(p, fp);
>  	if (rc)
> @@ -2227,8 +2257,6 @@ int policydb_read(struct policydb *p, void *fp)
>  	rc = 0;
>  out:
>  	return rc;
> -bad_newc:
> -	ocontext_destroy(newc, OCON_FSUSE);
>  bad:
>  	if (!rc)
>  		rc = -EINVAL;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
