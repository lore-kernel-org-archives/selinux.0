Subject: Re: [PATCH 2/4] SELinux: move genfs read to a separate function
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100611163711.18445.85854.stgit@paris.rdu.redhat.com>
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
	 <20100611163711.18445.85854.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Jun 2010 10:18:51 -0400
Message-ID: <1276697931.17827.3.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-06-11 at 12:37 -0400, Eric Paris wrote:
> move genfs read functionality out of policydb_read() and into a new
> function called genfs_read()
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> ---
> 
>  security/selinux/ss/policydb.c |  236 ++++++++++++++++++++++------------------
>  1 files changed, 131 insertions(+), 105 deletions(-)
> 
> diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> index a39d38a..66e217b 100644
> --- a/security/selinux/ss/policydb.c
> +++ b/security/selinux/ss/policydb.c
> @@ -1773,6 +1776,129 @@ out:
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
> +	if (rc < 0)
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
> +		if (rc < 0)
> +			goto out;
> +
> +		newgenfs->fstype[len] = 0;
> +
> +		for (genfs_p = NULL, genfs = p->genfs; genfs;
> +		     genfs_p = genfs, genfs = genfs->next) {
> +			rc = -EEXIST;
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
> +				if (!strcmp(newc->u.name, c->u.name) &&
> +				    (!c->v.sclass || !newc->v.sclass ||
> +				     newc->v.sclass == c->v.sclass)) {
> +					printk(KERN_ERR "SELinux:  dup genfs entry (%s,%s)\n",
> +					       genfs->fstype, c->u.name);
> +					goto out;

rc wasn't set.

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
> @@ -1781,12 +1907,12 @@ int policydb_read(struct policydb *p, void *fp)
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
> @@ -2099,107 +2225,9 @@ int policydb_read(struct policydb *p, void *fp)
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
> @@ -2227,8 +2255,6 @@ int policydb_read(struct policydb *p, void *fp)
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
