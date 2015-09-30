Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8UHBT9Z007825
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 13:11:29 -0400
Received: by qgez77 with SMTP id z77so41268446qge.1
 for <selinux@tycho.nsa.gov>; Wed, 30 Sep 2015 10:11:25 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Geliang Tang <geliangtang@163.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selinux: ioctl_has_perm should be static
Date: Wed, 30 Sep 2015 13:11:24 -0400
Message-ID: <3451526.pn4qIvD1NX@sifl>
In-Reply-To: <ff802942c34154cceee8ab2256d8c5ce6a665d21.1443366384.git.geliangtang@163.com>
References: <ff802942c34154cceee8ab2256d8c5ce6a665d21.1443366384.git.geliangtang@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sunday, September 27, 2015 11:10:24 PM Geliang Tang wrote:
> Fixes the following sparse warning:
> 
>  security/selinux/hooks.c:3242:5: warning: symbol 'ioctl_has_perm' was
>  not declared. Should it be static?
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 84d21f9..5265c74 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3239,7 +3239,7 @@ static void selinux_file_free_security(struct file
> *file) * Check whether a task has the ioctl permission and cmd
>   * operation to an inode.
>   */
> -int ioctl_has_perm(const struct cred *cred, struct file *file,
> +static int ioctl_has_perm(const struct cred *cred, struct file *file,
>  		u32 requested, u16 cmd)
>  {
>  	struct common_audit_data ad;

-- 
paul moore
www.paul-moore.com
