Subject: Re: [RFC] [Patch 4/4] integrity: SELinux LIM calls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: selinux@tycho.nsa.gov, zohar@us.ibm.com, safford@watson.ibm.com,
        sailer@us.ibm.com
In-Reply-To: <1190383522.11091.31.camel@localhost.localdomain>
References: <1190383522.11091.31.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 21 Sep 2007 10:48:00 -0400
Message-Id: <1190386080.17518.48.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-21 at 10:05 -0400, Mimi Zohar wrote:
> [RFC]integrity: SELinux patch
> 
> This patch verifies and measures file integrity, by adding
> the new Linux Integrity Modules(LIM) API calls to SElinux.
> 
> This patch defines a new 'integrity' class with the permission 
> 'measure'.  Measurement calls are made in selinux_file_mmap(), 
> selinux_bprm_check_security, and selinux_inode_permission(),
> based on policy.  (Additional calls might be required.)

I'd like to see a more detailed description of how this is supposed to
work in practice, including how one sets up a system that actually uses
these services, how a real integrity module that does verification and
measurement would work, an example of how one might apply the
verification and measurement services usefully, what implications this
would have for administering the system, software updates, etc.

Things to consider:
1) After further discussion internally, there is some doubt that the
decision on measurement should be expressed directly in SELinux policy.
Instead, it has been suggested that there should be a separate integrity
measurement policy that takes into account the SELinux label as one
possible input.  In the past, we have suggested separate cryptographic
usage policies, network usage policies, etc that use MAC information as
inputs but are separable from the MAC policy.  That would also allow
greater decomposition between SELinux and the integrity subsystem while
still allowing the integrity subsystem to leverage properties of the MAC
policy.

2) The current set of measure calls seems a bit haphazard and doesn't
give a lot of confidence that the right set of measurements are being
done, or that they are being done from the right places.  Example:  Why
measure from both mmap and bprm_check_security?  Did you mean to always
measure in mmap or only on PROT_EXEC?  Is it useful to measure
separately from the consumer of the data, as is done in inode_permission
(open-time check, data may change before use, using policy to make the
data immutable likely isn't practical in a real system and creates a
fragile coupling between the access control policy and the measurement
policy), or should the measurement happen closer to the consumer (which
in some cases means userspace instrumentation, with its problems of
trust and scale)?  What about measuring policy or kernel modules at load
time?  etc.  Be less concerned about invasiveness than about whether you
are doing it right. 

3) There is some concern that this kind of static load-time-only
measurement is too limited, and that any integrity measurement
architecture that gets integrated upstream should incorporate support
for a dynamic model as well.

> 
> Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> ---
> Index: linux-2.6.23-rc6-mm1/security/selinux/hooks.c
> ===================================================================
> --- linux-2.6.23-rc6-mm1.orig/security/selinux/hooks.c
> +++ linux-2.6.23-rc6-mm1/security/selinux/hooks.c
> @@ -69,6 +69,7 @@
>  #include <linux/audit.h>
>  #include <linux/string.h>
>  #include <linux/selinux.h>
> +#include <linux/integrity.h>
>  #include <linux/mutex.h>
>  
>  #include "avc.h"
> @@ -844,6 +845,7 @@ static int inode_doinit_with_dentry(stru
>  	char *context = NULL;
>  	unsigned len = 0;
>  	int rc = 0;
> +	int status;
>  
>  	if (isec->initialized)
>  		goto out;
> @@ -888,34 +890,12 @@ static int inode_doinit_with_dentry(stru
>  		}
>  
>  		len = INITCONTEXTLEN;
> -		context = kmalloc(len, GFP_KERNEL);
> -		if (!context) {
> -			rc = -ENOMEM;
> +		rc = integrity_verify_metadata(dentry, XATTR_NAME_SELINUX,
> +				       &context, &len, &status);
> +		if (rc == -ENOMEM) {
>  			dput(dentry);
>  			goto out_unlock;
>  		}
> -		rc = inode->i_op->getxattr(dentry, XATTR_NAME_SELINUX,
> -					   context, len);
> -		if (rc == -ERANGE) {
> -			/* Need a larger buffer.  Query for the right size. */
> -			rc = inode->i_op->getxattr(dentry, XATTR_NAME_SELINUX,
> -						   NULL, 0);
> -			if (rc < 0) {
> -				dput(dentry);
> -				goto out_unlock;
> -			}
> -			kfree(context);
> -			len = rc;
> -			context = kmalloc(len, GFP_KERNEL);
> -			if (!context) {
> -				rc = -ENOMEM;
> -				dput(dentry);
> -				goto out_unlock;
> -			}
> -			rc = inode->i_op->getxattr(dentry,
> -						   XATTR_NAME_SELINUX,
> -						   context, len);
> -		}
>  		dput(dentry);
>  		if (rc < 0) {
>  			if (rc != -ENODATA) {
> @@ -929,6 +909,14 @@ static int inode_doinit_with_dentry(stru
>  			sid = sbsec->def_sid;
>  			rc = 0;
>  		} else {
> +			if (status == INTEGRITY_FAIL) {
> +				printk(KERN_WARNING "%s: verify_metadata "
> +				       "failed for dev=%s ino=%ld\n",
> +					__FUNCTION__,
> +					inode->i_sb->s_id, inode->i_ino);
> +				kfree(context);
> +				goto out_unlock;
> +			}
>  			rc = security_context_to_sid_default(context, rc, &sid,
>  			                                     sbsec->def_sid);
>  			if (rc) {
> @@ -1698,9 +1686,87 @@ static int selinux_bprm_set_security(str
>  	return 0;
>  }
>  
> -static int selinux_bprm_check_security (struct linux_binprm *bprm)
> +static int selinux_verify_metadata(struct dentry *dentry)
>  {
> -	return secondary_ops->bprm_check_security(bprm);
> +	int rc, status;
> +
> +	if (!dentry)
> +		return 0;
> +
> +	rc = integrity_verify_metadata(dentry, NULL, NULL, NULL, &status);
> +	if (rc == -EOPNOTSUPP)
> +		return 0;
> +	if (rc < 0)
> +		goto out;
> +
> +	if (status != INTEGRITY_PASS) 	/* FAIL | NO_LABEL */
> +		rc = -EACCES;
> +out:
> +	return rc;
> +}
> +
> +static int selinux_verify_data(struct dentry *dentry, struct file *file)
> +{
> +	int rc, status;
> +
> +	if (!dentry && !file)
> +		return 0;
> +
> +	rc = integrity_verify_data(dentry, file, &status);
> +	if (rc < 0)
> +		return 0;
> +
> +	if (status != INTEGRITY_PASS)
> +		rc = -EACCES;
> +
> +	return rc;
> +}
> +
> +/*
> + * Measure based on new 'integrity' class policy
> + */
> +static void selinux_measure(struct inode *inode, struct dentry *dentry,
> +				struct file *file, char *filename,
> +				int mask)
> +{
> +	int rc = 1;
> +	struct inode_security_struct *isec = inode->i_security;
> +	struct task_security_struct *tsec = current->security;
> +	struct av_decision avd;
> +
> +	if (!S_ISREG(inode->i_mode))
> +		return;
> +
> +	rc = avc_has_perm_noaudit(tsec->sid, isec->sid, SECCLASS_INTEGRITY,
> +				  INTEGRITY__MEASURE, AVC_STRICT, &avd);
> +	if (rc == 0)
> +		integrity_measure(inode, dentry, file, filename, mask);
> +	return;
> +}
> +
> +/* The OS protects against an executable file, already open for write,
> + * from being executed in deny_write_access() and an executable file
> + * already open for execute, from being modified in get_write_access().
> + * So we can be certain that what we verify and measure here is actually
> + * what is being executed.
> + */
> +static int selinux_bprm_check_security(struct linux_binprm *bprm)
> +{
> +	struct dentry *dentry = bprm->file->f_dentry;
> +	int rc;
> +
> +	rc = secondary_ops->bprm_check_security(bprm);
> +	if (rc != 0)
> +		return rc;
> +
> +	rc = selinux_verify_metadata(dentry);
> +	if (rc == 0) {
> +		rc = selinux_verify_data(dentry, bprm->file);
> +		if (rc == 0)
> +			selinux_measure(dentry->d_inode, dentry, bprm->file,
> +					bprm->filename, MAY_EXEC);
> +	}
> +	return rc;
>  }
>  
> 
> @@ -2252,6 +2318,30 @@ static int selinux_inode_follow_link(str
>  	return dentry_has_perm(current, NULL, dentry, FILE__READ);
>  }
>  
> +static char *get_fname(struct dentry *dentry, struct vfsmount *mnt,
> +			char **buf)
> +{
> +	char *fname = NULL;
> +	char *path = NULL;
> +
> +	path = (char *)__get_free_page(GFP_KERNEL);
> +	if (path) {
> +		fname = d_path(dentry, mnt, path, PAGE_SIZE);
> +		*buf = path;
> +	}
> +
> +	if (!fname)	/* no choice, use short name */
> +		fname = (!dentry->d_name.name) ?
> +		    (char *)dentry->d_iname : (char *)dentry->d_name.name;
> +	return fname;
> +}
> +
> +static void free_fname(char *path)
> +{
> +	if (path)
> +		free_page((unsigned long)path);
> +}
> +
>  static int selinux_inode_permission(struct inode *inode, int mask,
>  				    struct nameidata *nd)
>  {
> @@ -2266,8 +2356,29 @@ static int selinux_inode_permission(stru
>  		return 0;
>  	}
>  
> -	return inode_has_perm(current, inode,
> +	rc = inode_has_perm(current, inode,
>  			       file_mask_to_av(inode->i_mode, mask), NULL);
> +	if (rc != 0)
> +		return rc;
> +
> +	if (mask & ~MAY_EXEC) { /* measure executables later */
> +		struct dentry *dentry = NULL;
> +		char *path = NULL;
> +		char *fname = NULL;
> +
> +		/* The file name is not required, but only a hint.
> +		 * When possible, supply a fully qualified path name.
> +		 */
> +		if (nd) {
> +			dentry = nd->dentry;
> +			fname = get_fname(nd->dentry, nd->mnt, &path);
> +		}
> +
> +		selinux_measure(inode, dentry, NULL, fname, mask);
> +		if (path)
> +			free_fname(path);
> +	}
> +	return rc;
>  }
>  
>  static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
> @@ -2588,8 +2699,18 @@ static int selinux_file_mmap(struct file
>  	if (selinux_checkreqprot)
>  		prot = reqprot;
>  
> -	return file_map_prot_check(file, prot,
> -				   (flags & MAP_TYPE) == MAP_SHARED);
> +	rc = file_map_prot_check(file, prot, (flags & MAP_TYPE) == MAP_SHARED);
> +	if (file && file->f_dentry && rc == 0) {
> +		rc = selinux_verify_metadata(file->f_dentry);
> +		if (rc == 0) {
> +			rc = selinux_verify_data(NULL, file);
> +			if (rc == 0)
> +				selinux_measure(file->f_dentry->d_inode,
> +						  file->f_dentry, file,
> +						  NULL, MAY_EXEC);
> +		}
> +	}
> +	return rc;
>  }
>  
>  static int selinux_file_mprotect(struct vm_area_struct *vma,
> @@ -2631,7 +2752,6 @@ static int selinux_file_mprotect(struct 
>  			return rc;
>  	}
>  #endif
> -
>  	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
>  }
>  
> Index: linux-2.6.23-rc6-mm1/security/selinux/include/av_permissions.h
> ===================================================================
> --- linux-2.6.23-rc6-mm1.orig/security/selinux/include/av_permissions.h
> +++ linux-2.6.23-rc6-mm1/security/selinux/include/av_permissions.h
> @@ -824,3 +824,4 @@
>  #define DCCP_SOCKET__NODE_BIND                    0x00400000UL
>  #define DCCP_SOCKET__NAME_CONNECT                 0x00800000UL
>  #define MEMPROTECT__MMAP_ZERO                     0x00000001UL
> +#define INTEGRITY__MEASURE                        0x00000001UL
> Index: linux-2.6.23-rc6-mm1/security/selinux/include/av_perm_to_string.h
> ===================================================================
> --- linux-2.6.23-rc6-mm1.orig/security/selinux/include/av_perm_to_string.h
> +++ linux-2.6.23-rc6-mm1/security/selinux/include/av_perm_to_string.h
> @@ -159,3 +159,4 @@
>     S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NODE_BIND, "node_bind")
>     S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NAME_CONNECT, "name_connect")
>     S_(SECCLASS_MEMPROTECT, MEMPROTECT__MMAP_ZERO, "mmap_zero")
> +   S_(SECCLASS_INTEGRITY, INTEGRITY__MEASURE, "measure")
> Index: linux-2.6.23-rc6-mm1/security/selinux/include/flask.h
> ===================================================================
> --- linux-2.6.23-rc6-mm1.orig/security/selinux/include/flask.h
> +++ linux-2.6.23-rc6-mm1/security/selinux/include/flask.h
> @@ -50,6 +50,7 @@
>  #define SECCLASS_KEY                                     58
>  #define SECCLASS_DCCP_SOCKET                             60
>  #define SECCLASS_MEMPROTECT                              61
> +#define SECCLASS_INTEGRITY                               62
>  
>  /*
>   * Security identifier indices for initial entities
> Index: linux-2.6.23-rc6-mm1/security/selinux/include/class_to_string.h
> ===================================================================
> --- linux-2.6.23-rc6-mm1.orig/security/selinux/include/class_to_string.h
> +++ linux-2.6.23-rc6-mm1/security/selinux/include/class_to_string.h
> @@ -64,3 +64,4 @@
>      S_(NULL)
>      S_("dccp_socket")
>      S_("memprotect")
> +    S_("integrity")
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
