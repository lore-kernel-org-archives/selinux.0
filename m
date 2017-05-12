Message-ID: <1494606653.9454.7.camel@tycho.nsa.gov>
Subject: Re: [RFC][PATCH] selinux: add a map permission check for mmap
From: Stephen Smalley <sds@tycho.nsa.gov>
To: paul@paul-moore.com
Cc: selinux@tycho.nsa.gov
Date: Fri, 12 May 2017 12:30:53 -0400
In-Reply-To: <20170505131448.8718-1-sds@tycho.nsa.gov>
References: <20170505131448.8718-1-sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-05-05 at 09:14 -0400, Stephen Smalley wrote:
> Add a map permission check on mmap so that we can distinguish memory
> mapped
> access (since it has different implications for revocation). When a
> file
> is opened and then read or written via syscalls like
> read(2)/write(2),
> we revalidate access on each read/write operation via
> selinux_file_permission() and therefore can revoke access if the
> process context, the file context, or the policy changes in such a
> manner that access is no longer allowed. When a file is opened and
> then
> memory mapped via mmap(2) and then subsequently read or written
> directly
> in memory, we presently have no way to revalidate or revoke access.
> The purpose of a separate map permission check on mmap(2) is to
> permit
> policy to prohibit memory mapping of specific files for which we need
> to ensure that every access is revalidated, particularly useful for
> scenarios where we expect the file to be relabeled at runtime in
> order
> to reflect state changes (e.g. cross-domain solution, assured
> pipeline
> without data copying).
> 
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>

Unless you have any comments/objections, feel free to apply this as is
- I believe it is good to go, and I have also posted the corresponding
selinux-testsuite patch.

> ---
> NB I chose not to define a new policy capability for this permission,
> since it is adequately covered by handle_unknown for compatibility
> and
> others seemed to agree that this does not fall into the category of
> changes requiring a new policy capability.  I also chose to define
> the
> permission for socket classes in addition to file classes and let it
> be checked for both.
> 
>  security/selinux/hooks.c            | 12 ++++++++++++
>  security/selinux/include/classmap.h |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e67a526..5432628 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3550,6 +3550,18 @@ static int selinux_mmap_addr(unsigned long
> addr)
>  static int selinux_mmap_file(struct file *file, unsigned long
> reqprot,
>  			     unsigned long prot, unsigned long
> flags)
>  {
> +	struct common_audit_data ad;
> +	int rc;
> +
> +	if (file) {
> +		ad.type = LSM_AUDIT_DATA_FILE;
> +		ad.u.file = file;
> +		rc = inode_has_perm(current_cred(),
> file_inode(file),
> +				    FILE__MAP, &ad);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	if (selinux_checkreqprot)
>  		prot = reqprot;
>  
> diff --git a/security/selinux/include/classmap.h
> b/security/selinux/include/classmap.h
> index 1e0cc9b..3e49a78 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -1,7 +1,7 @@
>  #include <linux/capability.h>
>  
>  #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
> -    "getattr", "setattr", "lock", "relabelfrom", "relabelto",
> "append"
> +    "getattr", "setattr", "lock", "relabelfrom", "relabelto",
> "append", "map"
>  
>  #define COMMON_FILE_PERMS COMMON_FILE_SOCK_PERMS, "unlink", "link",
> \
>      "rename", "execute", "quotaon", "mounton", "audit_access", \
