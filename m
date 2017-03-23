Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NKWN5V012241
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 16:32:23 -0400
Received: by mail-vk0-f66.google.com with SMTP id y16so14876782vky.1
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 13:32:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <66451d7e-f9ff-1d53-e919-d237a24ca8a2@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <66451d7e-f9ff-1d53-e919-d237a24ca8a2@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 16:32:02 -0400
Message-ID: <CAHC9VhRq053_HBeUnSLE6XutcrZDTj_YJpzTh9U0hW6jkExCJQ@mail.gmail.com>
Subject: Re: [PATCH 04/46] selinux: Use kmalloc_array() in hashtab_create()
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

On Sun, Jan 15, 2017 at 10:01 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 14 Jan 2017 12:06:13 +0100
>
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus use the corresponding function "kmalloc_array".
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/hashtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
> index 2cc496149842..dc99fff64ecb 100644
> --- a/security/selinux/ss/hashtab.c
> +++ b/security/selinux/ss/hashtab.c
> @@ -24,7 +24,7 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
>         p->nel = 0;
>         p->hash_value = hash_value;
>         p->keycmp = keycmp;
> -       p->htable = kmalloc(sizeof(*(p->htable)) * size, GFP_KERNEL);
> +       p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
>         if (p->htable == NULL) {
>                 kfree(p);
>                 return NULL;
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
