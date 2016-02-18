Subject: Re: [PATCH] selinux: Don't sleep inside inode_getsecid hook
To: Andreas Gruenbacher <agruenba@redhat.com>,
 Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov
References: <1455793448-26143-1-git-send-email-agruenba@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56C5CCCF.4000400@tycho.nsa.gov>
Date: Thu, 18 Feb 2016 08:53:19 -0500
MIME-Version: 1.0
In-Reply-To: <1455793448-26143-1-git-send-email-agruenba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/18/2016 06:04 AM, Andreas Gruenbacher wrote:
> The inode_getsecid hook is called from contexts in which sleeping is not
> allowed, so we cannot revalidate inode security labels from there. Use
> the non-validating version of inode_security() instead.
>
> Reported-by: Benjamin Coddington <bcodding@redhat.com>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Offending caller is ima_match_rules?

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
>   security/selinux/hooks.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f8110cf..f1ab715 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3249,7 +3249,7 @@ static int selinux_inode_listsecurity(struct inode *inode, char *buffer, size_t
>
>   static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
>   {
> -	struct inode_security_struct *isec = inode_security(inode);
> +	struct inode_security_struct *isec = inode_security_novalidate(inode);
>   	*secid = isec->sid;
>   }
>
>
