Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9GMZfTa028186
 for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2017 18:35:41 -0400
Received: by mail-lf0-f66.google.com with SMTP id b190so18696122lfg.9
 for <selinux@tycho.nsa.gov>; Mon, 16 Oct 2017 15:35:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171014124655.32438-1-colin.king@canonical.com>
References: <20171014124655.32438-1-colin.king@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Oct 2017 18:35:34 -0400
Message-ID: <CAHC9VhRT8WRfc4MvHs_4bN-gi3L7b8kqiuJ9=rTX=zbLgtWoYA@mail.gmail.com>
To: Colin King <colin.king@canonical.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: remove redundant assignment to str
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Oct 14, 2017 at 8:46 AM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> str is being assigned to an empty string but str is never being
> read after that, so the assignment is redundant and can be removed.
> Moving the declaration of str to a more localised block, cleans up
> clang warning: "Value stored to 'str' is never read"
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/selinux/hooks.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 07f35f3b4a13..3daf3369c3b4 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3177,18 +3177,17 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
>                 if (!has_cap_mac_admin(true)) {
>                         struct audit_buffer *ab;
>                         size_t audit_size;
> -                       const char *str;
>
>                         /* We strip a nul only if it is at the end, otherwise the
>                          * context contains a nul and we should audit that */
>                         if (value) {
> -                               str = value;
> +                               const char *str = value;
> +
>                                 if (str[size - 1] == '\0')
>                                         audit_size = size - 1;
>                                 else
>                                         audit_size = size;
>                         } else {
> -                               str = "";
>                                 audit_size = 0;
>                         }
>                         ab = audit_log_start(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR);
> --
> 2.14.1
>



-- 
paul moore
www.paul-moore.com
