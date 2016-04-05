Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u35Ioic5007808
 for <selinux@tycho.nsa.gov>; Tue, 5 Apr 2016 14:50:44 -0400
Received: by mail-qg0-f68.google.com with SMTP id y89so2065218qge.0
 for <selinux@tycho.nsa.gov>; Tue, 05 Apr 2016 11:50:38 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Jeff Vander Stoep <jeffv@google.com>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH v2] selinux: restrict kernel module loading
Date: Tue, 05 Apr 2016 14:50:36 -0400
Message-ID: <13650744.hlOWtXSZYW@sifl>
In-Reply-To: <1459720620-7987-1-git-send-email-jeffv@google.com>
References: <1459720620-7987-1-git-send-email-jeffv@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sunday, April 03, 2016 02:57:00 PM Jeff Vander Stoep wrote:
> Utilize existing kernel_read_file hook on kernel module load.
> Add module_load permission to the system class.
> 
> Enforces restrictions on kernel module origin when calling the
> finit_module syscall. The hook checks that source type has
> permission module_load for the target type.
> Example for finit_module:
> 
> allow foo bar_file:system module_load;
> 
> Similarly restrictions are enforced on kernel module loading when
> calling the init_module syscall. The hook checks that source
> type has permission module_load with itself as the target object
> because the kernel module is sourced from the calling process.
> Example for init_module:
> 
> allow foo foo:system module_load;
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>
> ---
> v2: The target type for init_module changed from SECINITSID_KERNEL
> to the same type as the source.
> 
>  security/selinux/hooks.c            | 52
> +++++++++++++++++++++++++++++++++++++ security/selinux/include/classmap.h |
>  2 +-
>  2 files changed, 53 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3fa3ca5..f870c4d 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3719,6 +3719,57 @@ static int selinux_kernel_module_request(char
> *kmod_name) SYSTEM__MODULE_REQUEST, &ad);
>  }
> 
> +static int selinux_kernel_module_from_file(struct file *file)
> +{
> +	struct common_audit_data ad;
> +	struct inode_security_struct *isec;
> +	struct file_security_struct *fsec;
> +	struct inode *inode;
> +	u32 sid = current_sid();
> +	int rc;
> +
> +	/* init_module */
> +	if (file == NULL) {
> +		rc = avc_has_perm(sid, sid, SECCLASS_SYSTEM,
> +					SYSTEM__MODULE_LOAD, NULL);
> +		goto out;

The real comment is below, this isn't the reason for rejecting the patch, but 
since we need one more change it would be nice to return directly instead of 
jumping to "out", example:

	if (file == NULL)
		return avc_has_perm(...);

> +	}
> +
> +	/* finit_module */
> +	ad.type = LSM_AUDIT_DATA_PATH;
> +	ad.u.path = file->f_path;
> +
> +	inode = file_inode(file);
> +	isec = inode->i_security;
> +	fsec = file->f_security;

I should have caught this on the v1 patch, but I missed it ... instead of 
looking up the isec directly from the inode, we should use one of the 
inode_security_*() functions to ensure the inode's label is revalidated if 
necessary.

We may also need to add a ss_initialized check at the top, but I can add that 
in later if needed; I'm working on related stuff right now so it's easy for me 
to test/patch later if you don't want to deal with that.

> +	if (sid != fsec->sid) {
> +		rc = avc_has_perm(sid, fsec->sid, SECCLASS_FD, FD__USE, &ad);
> +		if (rc)
> +			goto out;

Once again, just return, don't jump.

> +	}
> +
> +	rc = avc_has_perm(sid, isec->sid, SECCLASS_SYSTEM,
> +				SYSTEM__MODULE_LOAD, &ad);
> +out:
> +	return rc;
> +}

-- 
paul moore
www.paul-moore.com
