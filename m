Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6GJTjp5010700
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 15:29:45 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6GJTi1q029810
	for <selinux@tycho.nsa.gov>; Mon, 16 Jul 2007 19:29:44 GMT
From: Paul Moore <paul.moore@hp.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [RFC]integrity: SELinux patch
Date: Mon, 16 Jul 2007 15:23:39 -0400
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com
References: <1184594240.5860.5.camel@localhost.localdomain>
In-Reply-To: <1184594240.5860.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707161523.39706.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, July 16 2007 9:57:20 am Mimi Zohar wrote:
> Index: linux-2.6.22-rc6-mm1/security/selinux/hooks.c
> ===================================================================
> --- linux-2.6.22-rc6-mm1.orig/security/selinux/hooks.c
> +++ linux-2.6.22-rc6-mm1/security/selinux/hooks.c
> @@ -932,6 +917,19 @@ static int inode_doinit_with_dentry(stru
>  			sid = sbsec->def_sid;
>  			rc = 0;
>  		} else {
> +			/* Log integrity failures, if integrity enforced
> +			 * behave like for any other failure.
> +			 */
> +			if (status == INTEGRITY_FAIL) {
> +				printk(KERN_WARNING "%s: verify_metadata "
> +				       "failed for dev=%s ino=%ld\n",
> +					__FUNCTION__,
> +					inode->i_sb->s_id, inode->i_ino);

Should this event be audited via the audit subsystem?  Or is it audited 
elsewhere and I'm just missing it (I only saw a disabled block w/audit code).

> @@ -1701,9 +1699,109 @@ static int selinux_bprm_set_security(str
>  	return 0;
>  }
>
> -static int selinux_bprm_check_security (struct linux_binprm *bprm)
> +static inline int is_kernel_thread(struct task_struct *tsk)
> +{
> +	return (!tsk->mm) ? 1 : 0;
> +}
> +
> +static int selinux_verify_metadata(struct dentry *dentry)
> +{
> +	int rc, status;
> +
> +	if (!dentry)
> +		return 0;
> +
> +	rc = integrity_verify_metadata(dentry, NULL, NULL, NULL, &status);
> +	if (rc == -EOPNOTSUPP)
> +		return 0;
> +
> +	if (rc < 0) {
> +		printk(KERN_INFO "%s: verify_metadata %s failed"
> +				"(rc: %d - status: %d)\n", __FUNCTION__,
> +				dentry->d_name.name, rc, status);

Same comment about audit here ...

> +static int selinux_verify_and_measure(struct dentry *dentry,
> +					struct file *file,
> +					char *filename, int mask)
> +{
> +	int rc, status;
> +
> +	if (!dentry && !file)
> +		return 0;
> +
> +	rc = integrity_verify_data(dentry, file, &status);
> +	if (rc < 0) {
> +		printk(KERN_INFO "%s: %s verify_data failed "
> +		       "(rc: %d - status: %d)\n", __FUNCTION__,
> +			filename, rc, status);

... and here ...

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
