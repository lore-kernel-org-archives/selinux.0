Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8SFMQF9022352
 for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2015 11:22:26 -0400
Received: by obcxm10 with SMTP id xm10so27607874obc.3
 for <selinux@tycho.nsa.gov>; Mon, 28 Sep 2015 08:22:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ff802942c34154cceee8ab2256d8c5ce6a665d21.1443366384.git.geliangtang@163.com>
References: <ff802942c34154cceee8ab2256d8c5ce6a665d21.1443366384.git.geliangtang@163.com>
Date: Mon, 28 Sep 2015 08:22:22 -0700
Message-ID: <CABXk95AvTKhd7r2Mh4H9rWK1CV2b+fog8GaHPYriD6JKBL+HvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: ioctl_has_perm should be static
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Geliang Tang <geliangtang@163.com>
Cc: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Acked-by: Jeff Vander Stoep <jeffv@google.com>

On Sun, Sep 27, 2015 at 8:10 AM, Geliang Tang <geliangtang@163.com> wrote:
> Fixes the following sparse warning:
>
>  security/selinux/hooks.c:3242:5: warning: symbol 'ioctl_has_perm' was
>  not declared. Should it be static?
>
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 84d21f9..5265c74 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3239,7 +3239,7 @@ static void selinux_file_free_security(struct file *file)
>   * Check whether a task has the ioctl permission and cmd
>   * operation to an inode.
>   */
> -int ioctl_has_perm(const struct cred *cred, struct file *file,
> +static int ioctl_has_perm(const struct cred *cred, struct file *file,
>                 u32 requested, u16 cmd)
>  {
>         struct common_audit_data ad;
> --
> 2.5.0
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
