Subject: Re: [PATCH v3 1/7] selinux: Remove unused variable in
 selinux_inode_init_security
To: Andreas Gruenbacher <agruenba@redhat.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 ocfs2-devel@oss.oracle.com
References: <1445894128-6765-1-git-send-email-agruenba@redhat.com>
 <1445894128-6765-2-git-send-email-agruenba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <562F77E6.7000602@tycho.nsa.gov>
Date: Tue, 27 Oct 2015 09:11:02 -0400
MIME-Version: 1.0
In-Reply-To: <1445894128-6765-2-git-send-email-agruenba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/26/2015 05:15 PM, Andreas Gruenbacher wrote:
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index e4369d8..fc8f626 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2756,13 +2756,11 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>   				       void **value, size_t *len)
>   {
>   	const struct task_security_struct *tsec = current_security();
> -	struct inode_security_struct *dsec;
>   	struct superblock_security_struct *sbsec;
>   	u32 sid, newsid, clen;
>   	int rc;
>   	char *context;
>
> -	dsec = dir->i_security;
>   	sbsec = dir->i_sb->s_security;
>
>   	sid = tsec->sid;
>
