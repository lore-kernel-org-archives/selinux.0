Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4LH26kr006999
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 13:02:06 -0400
Received: from mail7.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4LH259R022529
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2007 17:02:05 GMT
Date: Mon, 21 May 2007 13:02:02 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
cc: sds@tycho.nsa.gov, jmorris@redhat.com, eparis@redhat.com,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/4] selinux: add support for querying object classes
 and permissions from the running policy
In-Reply-To: <11797619172804-git-send-email-cpebenito@tresys.com>
Message-ID: <Line.LNX.4.64.0705211253190.17008@d.namei>
References: <11797619161088-git-send-email-cpebenito@tresys.com>
 <11797619172804-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 21 May 2007, Christopher J. PeBenito wrote:

>  int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
>  
> +int security_get_classes(char ***classes, int *nclasses);
> +int security_get_permissions(char *class, char ***perms, int *nperms);
> +
>  #define SECURITY_FS_USE_XATTR		1 /* use xattr */
>  #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
>  #define SECURITY_FS_USE_TASK		3 /* use task SIDs, e.g. pipefs/sockfs */
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 40660ff..4196c66 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1996,6 +1996,99 @@ out:
>  	return rc;
>  }
>  
> +static int get_classes_callback(void *k, void *d, void *args)
> +{
> +	struct class_datum *datum = d;
> +	char *name = k, **classes = args;
> +	int value = datum->value - 1;
> +
> +	classes[value] = kstrdup(name,GFP_KERNEL);

Coding style: spaces after commas (needs to be fixed throughout).

> +

Probably don't need this blank line.

> +	if (classes[value] == NULL)
> +		return -ENOMEM;

I'd suggest

	if (!foo)

to remain consistent.

> +
> +	return 0;
> +}
> +
> +int security_get_classes(char ***classes, int *nclasses)
> +{
> +	int rc = -ENOMEM;
> +
> +	POLICY_RDLOCK;
> +
> +	*nclasses = policydb.p_classes.nprim;
> +	*classes = kzalloc(*nclasses*sizeof(*classes),GFP_KERNEL);

Use kcalloc().

Needs to be GFP_ATOMIC because you're holding a spinlock.

> +	if (!*classes)
> +		goto out;
> +
> +	rc = hashtab_map(policydb.p_classes.table,get_classes_callback,*classes);
> +	if (rc < 0) {
> +		int i;
> +		for (i = 0; i < *nclasses; i++)
> +			kfree((*classes)[i]);
> +		kfree(*classes);
> +	}
> +	
> +out:
> +	POLICY_RDUNLOCK;
> +	return rc;
> +}
> +
> +static int get_permissions_callback(void *k, void *d, void *args)
> +{
> +	struct perm_datum *datum = d;
> +	char *name = k, **perms = args;
> +	int value = datum->value - 1;
> +
> +	perms[value] = kstrdup(name,GFP_KERNEL);

Ditto.

(Have you tested this with all of the lock debugging enabled ?)

> +
> +	if (perms[value] == NULL)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +int security_get_permissions(char *class, char ***perms, int *nperms)
> +{
> +	int rc = -ENOMEM, i;
> +	struct class_datum *match;
> +
> +	POLICY_RDLOCK;
> +
> +	match = hashtab_search(policydb.p_classes.table,class);
> +	if (match == NULL) {
> +		printk(KERN_ERR "%s:  unrecognized class %s\n",__FUNCTION__,class);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	*nperms = match->permissions.nprim;
> +	*perms = kzalloc(*nperms*sizeof(*perms),GFP_KERNEL);

Ditto.

> +	if (!*perms)
> +		goto out;
> +
> +	if (match->comdatum) {
> +		rc = hashtab_map(match->comdatum->permissions.table,get_permissions_callback,*perms);
> +		if (rc < 0)
> +			goto err;
> +	}
> +
> +	rc = hashtab_map(match->permissions.table,get_permissions_callback,*perms);
> +	if (rc < 0)
> +		goto err;
> +
> +out:
> +	POLICY_RDUNLOCK;
> +	return rc;
> +
> +err:
> +	POLICY_RDUNLOCK;
> +	for (i = 0; i < *nperms; i++)
> +		kfree((*perms)[i]);
> +	kfree(*perms);
> +	return rc;
> +}
> +
>  struct selinux_audit_rule {
>  	u32 au_seqno;
>  	struct context au_ctxt;
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
