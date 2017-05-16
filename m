Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4GIWe6E018313
 for <selinux@tycho.nsa.gov>; Tue, 16 May 2017 14:32:44 -0400
Received: by mail-lf0-f68.google.com with SMTP id m18so977538lfj.0
 for <selinux@tycho.nsa.gov>; Tue, 16 May 2017 11:32:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <61cd20e9-211e-b974-3525-fcb5fdf8fa7e@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <5704e656-708a-b611-5611-70fc65dc67e8@users.sourceforge.net>
 <61cd20e9-211e-b974-3525-fcb5fdf8fa7e@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 16 May 2017 14:32:38 -0400
Message-ID: <CAHC9VhQWbepC3Ba4zyXKOG5JpY-RA1vFCdMi+J1527HJTX10pA@mail.gmail.com>
Subject: Re: [PATCH 2/3] selinux: Return an error code only as a constant in
 sidtab_insert()
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

On Tue, Apr 4, 2017 at 7:14 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 4 Apr 2017 11:33:53 +0200
>
> * Return an error code without storing it in an intermediate variable.
>
> * Delete the local variable "rc" and the jump label "out" which became
>   unnecessary with this refactoring.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/sidtab.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)

Merged.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index f6915f257486..c5f436b15d19 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -32,13 +32,11 @@ int sidtab_init(struct sidtab *s)
>
>  int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>  {
> -       int hvalue, rc = 0;
> +       int hvalue;
>         struct sidtab_node *prev, *cur, *newnode;
>
> -       if (!s) {
> -               rc = -ENOMEM;
> -               goto out;
> -       }
> +       if (!s)
> +               return -ENOMEM;
>
>         hvalue = SIDTAB_HASH(sid);
>         prev = NULL;
> @@ -48,21 +46,17 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>                 cur = cur->next;
>         }
>
> -       if (cur && sid == cur->sid) {
> -               rc = -EEXIST;
> -               goto out;
> -       }
> +       if (cur && sid == cur->sid)
> +               return -EEXIST;
>
>         newnode = kmalloc(sizeof(*newnode), GFP_ATOMIC);
> -       if (!newnode) {
> -               rc = -ENOMEM;
> -               goto out;
> -       }
> +       if (!newnode)
> +               return -ENOMEM;
> +
>         newnode->sid = sid;
>         if (context_cpy(&newnode->context, context)) {
>                 kfree(newnode);
> -               rc = -ENOMEM;
> -               goto out;
> +               return -ENOMEM;
>         }
>
>         if (prev) {
> @@ -78,8 +72,7 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>         s->nel++;
>         if (sid >= s->next_sid)
>                 s->next_sid = sid + 1;
> -out:
> -       return rc;
> +       return 0;
>  }
>
>  static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
> --
> 2.12.2
>



-- 
paul moore
www.paul-moore.com
