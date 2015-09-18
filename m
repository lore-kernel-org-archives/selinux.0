Subject: Re: [PATCH v2] selinux: do not check open perm on ftruncate call
To: Jeff Vander Stoep <jeffv@google.com>, selinux@tycho.nsa.gov
References: <1442605186-24800-1-git-send-email-jeffv@google.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <55FC6A87.6090902@tycho.nsa.gov>
Date: Fri, 18 Sep 2015 15:48:23 -0400
MIME-Version: 1.0
In-Reply-To: <1442605186-24800-1-git-send-email-jeffv@google.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/18/2015 03:39 PM, Jeff Vander Stoep wrote:
> Use the ATTR_FILE attribute to distinguish between truncate()
> and ftruncate() system calls. The two other cases where
> do_truncate is called with a filp (and therefore ATTR_FILE is set)
> are for coredump files and for open(O_TRUNC). In both of those cases
> the open permission has already been checked during file open and
> therefore does not need to be repeated.
> 
> Commit 95dbf739313f ("SELinux: check OPEN on truncate calls")
> fixed a major issue where domains were allowed to truncate files
> without the open permission. However, it introduced a new bug where
> a domain with the write permission can no longer ftruncate files
> without the open permission, even when they receive an already open
> file.
> 
> Signed-off-by: Jeff Vander Stoep <jeffv@google.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
> V2 fixes mistakes in commit message
> 
>  security/selinux/hooks.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f4be0a1..b32f1e1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2934,7 +2934,8 @@ static int selinux_inode_setattr(struct dentry *dentry, struct iattr *iattr)
>  			ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_TIMES_SET))
>  		return dentry_has_perm(cred, dentry, FILE__SETATTR);
>  
> -	if (selinux_policycap_openperm && (ia_valid & ATTR_SIZE))
> +	if (selinux_policycap_openperm && (ia_valid & ATTR_SIZE)
> +			&& !(ia_valid & ATTR_FILE))
>  		av |= FILE__OPEN;
>  
>  	return dentry_has_perm(cred, dentry, av);
> 
