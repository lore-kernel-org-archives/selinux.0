Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2QA7wIe013451
 for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2015 06:08:04 -0400
Received: by oicf142 with SMTP id f142so35614056oic.3
 for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2015 03:08:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1427158895.16851.70.camel@perches.com>
References: <1427158895.16851.70.camel@perches.com>
Date: Thu, 26 Mar 2015 06:08:01 -0400
Message-ID: <CAHC9VhQ7VinEbxX71ZALL7aSqyRej3OixCKKtOVa9uSQ5XFwpA@mail.gmail.com>
Subject: Re: [PATCH] selinuxfs: Fix sel_write_enforce broken return value
From: Paul Moore <paul@paul-moore.com>
To: Joe Perches <joe@perches.com>
Content-Type: text/plain; charset=UTF-8
Cc: James Morris <james.l.morris@oracle.com>, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Stephen Smalley <sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Mon, Mar 23, 2015 at 9:01 PM, Joe Perches <joe@perches.com> wrote:
> Return a negative error value like the rest
> of the entries in this function.
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> Maybe this should be stable, it goes back to
> commit b77a493b1dc8 ("SELinux: standardize return code
> handling in selinuxfs.c") back in Nov 2010, but it's
> guarded by a #ifdef CONFIG_SECURITY_SELINUX_DEVELOP
> so it probably doesn't matter much.
>
>  security/selinux/selinuxfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

My apologies, I hit reply and not reply-all to Stephen's ACK
mentioning that it might take me a day or two to merge this ...
regardless, it's merged now and marked for -stable; I also just sent a
pull request to James with this patch for v3.20.

Thanks for the fix.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 1684bcc..5fde343 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -152,7 +152,7 @@ static ssize_t sel_write_enforce(struct file *file, const char __user *buf,
>                 goto out;
>
>         /* No partial writes. */
> -       length = EINVAL;
> +       length = -EINVAL;
>         if (*ppos != 0)
>                 goto out;
>
>
>



-- 
paul moore
www.paul-moore.com
