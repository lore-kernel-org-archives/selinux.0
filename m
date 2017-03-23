Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NKOc6R009249
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 16:24:39 -0400
Received: by mail-vk0-f68.google.com with SMTP id z204so13845432vkd.2
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 13:24:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <68a423a9-2f89-55f9-fb4c-97dd4df4bb1d@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <68a423a9-2f89-55f9-fb4c-97dd4df4bb1d@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 16:24:34 -0400
Message-ID: <CAHC9VhSmRJzKZnGCiytijY-wuZqPGFOdEfecPgy5D3TciPCCgA@mail.gmail.com>
Subject: Re: [PATCH 01/46] selinux: Use kmalloc_array() in
 cond_init_bool_indexes()
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

On Sun, Jan 15, 2017 at 9:56 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 10:48:28 +0100
>
> * A multiplication for the size determination of a memory allocation
>   indicated that an array data structure should be processed.
>   Thus use the corresponding function "kmalloc_array".
>
>   This issue was detected by using the Coccinelle software.
>
> * Replace the specification of a data type by a pointer dereference
>   to make the corresponding size determination a bit safer according to
>   the Linux coding style convention.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/conditional.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Merged, thanks.  Sorry for the delay.

> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 34afeadd9e73..fcfab2635c11 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -176,8 +176,9 @@ void cond_policydb_destroy(struct policydb *p)
>  int cond_init_bool_indexes(struct policydb *p)
>  {
>         kfree(p->bool_val_to_struct);
> -       p->bool_val_to_struct =
> -               kmalloc(p->p_bools.nprim * sizeof(struct cond_bool_datum *), GFP_KERNEL);
> +       p->bool_val_to_struct = kmalloc_array(p->p_bools.nprim,
> +                                             sizeof(*p->bool_val_to_struct),
> +                                             GFP_KERNEL);
>         if (!p->bool_val_to_struct)
>                 return -ENOMEM;
>         return 0;
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
