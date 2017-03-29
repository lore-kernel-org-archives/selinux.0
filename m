Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFmZld011496
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:48:35 -0400
Received: by mail-vk0-f67.google.com with SMTP id y16so2790447vky.1
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:48:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e12da517-36fb-2247-e9b4-488708d6cda7@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <e12da517-36fb-2247-e9b4-488708d6cda7@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:48:29 -0400
Message-ID: <CAHC9VhSgWhY-CwU3zcaEqDYmmusT22c=Uvq=Yc2KvVcKG+YYnA@mail.gmail.com>
Subject: Re: [PATCH 44/46] selinux: Adjust two checks for null pointers
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

On Sun, Jan 15, 2017 at 10:44 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 13:30:20 +0100
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> The script "checkpatch.pl" pointed information out like the following.
>
> Comparison to NULL could be written !…
>
> Thus fix affected source code places.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/ss/sidtab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Merged.

Definitely code churn, but arguably there is some minor value in
making checkpatch.pl happy.  In the future changes like this should be
bundled with more significant changes to make them more appealing.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index c9533b21942b..f6915f257486 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -54,7 +54,7 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
>         }
>
>         newnode = kmalloc(sizeof(*newnode), GFP_ATOMIC);
> -       if (newnode == NULL) {
> +       if (!newnode) {
>                 rc = -ENOMEM;
>                 goto out;
>         }
> @@ -98,7 +98,7 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
>         if (force && cur && sid == cur->sid && cur->context.len)
>                 return &cur->context;
>
> -       if (cur == NULL || sid != cur->sid || cur->context.len) {
> +       if (!cur || sid != cur->sid || cur->context.len) {
>                 /* Remap invalid SIDs to the unlabeled SID. */
>                 sid = SECINITSID_UNLABELED;
>                 hvalue = SIDTAB_HASH(sid);
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
