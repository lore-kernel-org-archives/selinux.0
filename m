Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u1JLYmAA027066
 for <selinux@tycho.nsa.gov>; Fri, 19 Feb 2016 16:34:51 -0500
Received: by mail-qk0-f177.google.com with SMTP id s5so36192747qkd.0
 for <selinux@tycho.nsa.gov>; Fri, 19 Feb 2016 13:34:45 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov
Subject: Re: [PATCH] selinux: Don't sleep inside inode_getsecid hook
Date: Fri, 19 Feb 2016 16:34:44 -0500
Message-ID: <1572416.CTbVzmqk7R@sifl>
In-Reply-To: <1455793448-26143-1-git-send-email-agruenba@redhat.com>
References: <1455793448-26143-1-git-send-email-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, February 18, 2016 12:04:08 PM Andreas Gruenbacher wrote:
> The inode_getsecid hook is called from contexts in which sleeping is not
> allowed, so we cannot revalidate inode security labels from there. Use
> the non-validating version of inode_security() instead.
> 
> Reported-by: Benjamin Coddington <bcodding@redhat.com>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.  I've applied this to the stable-4.5 branch and I'll send this up to 
James as soon as I've done some sanity checks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f8110cf..f1ab715 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3249,7 +3249,7 @@ static int selinux_inode_listsecurity(struct inode
> *inode, char *buffer, size_t
> 
>  static void selinux_inode_getsecid(struct inode *inode, u32 *secid)
>  {
> -	struct inode_security_struct *isec = inode_security(inode);
> +	struct inode_security_struct *isec = inode_security_novalidate(inode);
>  	*secid = isec->sid;
>  }

-- 
paul moore
www.paul-moore.com
