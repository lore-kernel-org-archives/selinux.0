Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NKSB3P010799
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 16:28:12 -0400
Received: by mail-vk0-f66.google.com with SMTP id j137so799125vke.0
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 13:28:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <86979267-24ac-ce16-a150-43677ac78a0b@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <86979267-24ac-ce16-a150-43677ac78a0b@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 16:28:05 -0400
Message-ID: <CAHC9VhTKBR-JPGKah6fgiPhcOG_6uXu6R4DO4Z7j03=sfHWzTw@mail.gmail.com>
Subject: Re: [PATCH 02/46] selinux: Delete an unnecessary return statement in
 cond_compute_av()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sun, Jan 15, 2017 at 9:58 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 11:00:23 +0100
>
> The script "checkpatch.pl" pointed information out like the following.
>
> WARNING: void function return statements are not generally useful
>
> Thus remove such a statement in the affected function.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/conditional.c | 1 -
>  1 file changed, 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index fcfab2635c11..4a3bf29f7565 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -664,5 +664,4 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key,
>                                 (node->key.specified & AVTAB_XPERMS))
>                         services_compute_xperms_drivers(xperms, node);
>         }
> -       return;
>  }
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
paul moore
www.paul-moore.com
