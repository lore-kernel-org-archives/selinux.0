Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4GIf9LL021569
 for <selinux@tycho.nsa.gov>; Tue, 16 May 2017 14:41:09 -0400
Received: by mail-lf0-f65.google.com with SMTP id q24so4013352lfb.1
 for <selinux@tycho.nsa.gov>; Tue, 16 May 2017 11:41:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <38273216-97ad-7955-941a-68485534d39f@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
 <38273216-97ad-7955-941a-68485534d39f@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 May 2017 14:41:05 -0400
Message-ID: <CAHC9VhQY7-Ls5bX_wbna1S6PjV2Ck_1+AR5R8Pngn1tivXxCdg@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: Use an other error code for an input
 validation failure in sidtab_insert()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 William Roberts <william.c.roberts@intel.com>,
 linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Apr 4, 2017 at 7:16 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 4 Apr 2017 12:23:41 +0200
>
> The error code "-ENOMEM" was also returned so far when the parameter "s"
> of this function contained a null pointer.
> Now I find that the code "-EINVAL" is more appropriate in this case.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/sidtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Have you tested this to determine any impact it may have on the
SELinux userspace?  I would agree that EINVAL is probably more
appropriate in this case, but changing this return code has very
little value and may disrupt userspace if it assumes EINVAL means
something else when the policy load fails.  Without a demonstration
that all the code paths have been tested I'm not inclined to merge
this patch.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index c5f436b15d19..2eb2a54b88d2 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -36,7 +36,7 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>         struct sidtab_node *prev, *cur, *newnode;
>
>         if (!s)
> -               return -ENOMEM;
> +               return -EINVAL;
>
>         hvalue = SIDTAB_HASH(sid);
>         prev = NULL;
> --
> 2.12.2

-- 
paul moore
www.paul-moore.com
