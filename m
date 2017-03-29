Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TFrlnO013223
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 11:53:55 -0400
Received: by mail-vk0-f67.google.com with SMTP id j137so2816451vke.0
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 08:53:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9c268e0b-a323-5f72-e445-dbf247f274d8@users.sourceforge.net>
References: <ca34123f-ced6-d2bc-363b-690858618827@users.sourceforge.net>
 <9c268e0b-a323-5f72-e445-dbf247f274d8@users.sourceforge.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 11:53:41 -0400
Message-ID: <CAHC9VhS_DZg4fUaKP8=-rocQ1ozzb5Sa+yHySvBWjkVAipidWA@mail.gmail.com>
Subject: Re: [PATCH 46/46] selinuxfs: Use seq_puts() in
 sel_avc_stats_seq_show()
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

On Sun, Jan 15, 2017 at 10:46 AM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 15 Jan 2017 14:04:53 +0100
>
> A string which did not contain data format specifications should be put
> into a sequence. Thus use the corresponding function "seq_puts".
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  security/selinux/selinuxfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 55345f84f17d..0d81ebf7ff23 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1445,10 +1445,10 @@ static int sel_avc_stats_seq_show(struct seq_file *seq, void *v)
>  {
>         struct avc_cache_stats *st = v;
>
> -       if (v == SEQ_START_TOKEN)
> -               seq_printf(seq, "lookups hits misses allocations reclaims "
> -                          "frees\n");
> -       else {
> +       if (v == SEQ_START_TOKEN) {
> +               seq_puts(seq,
> +                        "lookups hits misses allocations reclaims frees\n");
> +       } else {
>                 unsigned int lookups = st->lookups;
>                 unsigned int misses = st->misses;
>                 unsigned int hits = lookups - misses;
> --
> 2.11.0
>



-- 
paul moore
www.paul-moore.com
