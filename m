Message-ID: <545A53A9.4060009@tycho.nsa.gov>
Date: Wed, 05 Nov 2014 11:43:21 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>, linux-unionfs@vger.kernel.org,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH 6/7] SELinux: The copy-up operation must have read
 permission on the lower file
References: <20141105154217.2555.578.stgit@warthog.procyon.org.uk>
 <20141105154318.2555.7052.stgit@warthog.procyon.org.uk>
In-Reply-To: <20141105154318.2555.7052.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/05/2014 10:43 AM, David Howells wrote:
> The copy-up operation must have read permission on the lower file for the task
> that caused the copy-up.  This helps prevent overlayfs from being used to
> access something it shouldn't.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  security/selinux/hooks.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f43f07fdc028..57f9c641779f 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3144,7 +3144,8 @@ static void selinux_inode_getsecid(const struct inode *inode, u32 *secid)
>  
>  static int selinux_inode_copy_up(struct dentry *src, struct dentry *dst)
>  {
> -	return 0;
> +	const struct cred *cred = current_cred();
> +	return dentry_has_perm(cred, src, FILE__OPEN | FILE__READ);
>  }

Won't this get checked anyway when overlayfs calls vfs helpers to open
the source and those vfs helpers call the security hooks and apply the
usual checks?

Or, if not, where do you check permissions for the destination?
