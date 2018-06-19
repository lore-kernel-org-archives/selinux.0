Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5JHfSpO008888
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 13:41:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 419Fcc730vz2Vp8r
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 17:41:04 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 419Fcc4TZTz2Vp8q
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 17:41:04 +0000 (UTC)
Received: by mail-lf0-f45.google.com with SMTP id a13-v6so722100lfk.12
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 10:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-10-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-10-peter.enderborg@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Jun 2018 13:39:52 -0400
Message-ID: <CAHC9VhRoWbhTERzcwtEX2GkXQRfPG8itYV+yxkz74qugrotZUw@mail.gmail.com>
To: peter.enderborg@sony.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, danielj@mellanox.com,
 dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 09/13] selinux: Cleanup printk logging in sidtab
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> Replace printk with pr_* to avoid checkpatch warnings.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/ss/sidtab.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index 5be31b7af225..fd75a12fa8fc 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -214,8 +214,7 @@ int sidtab_context_to_sid(struct sidtab *s,
>                 }
>                 sid = s->next_sid++;
>                 if (context->len)
> -                       printk(KERN_INFO
> -                      "SELinux:  Context %s is not valid (left unmapped).\n",
> +                       pr_info("SELinux:  Context %s is not valid (left unmapped).\n",
>                                context->str);
>                 ret = sidtab_insert(s, sid, context);
>                 if (ret)
> @@ -253,7 +252,7 @@ void sidtab_hash_eval(struct sidtab *h, char *tag)
>                 }
>         }
>
> -       printk(KERN_DEBUG "%s:  %d entries and %d/%d buckets used, longest "
> +       pr_debug("%s:  %d entries and %d/%d buckets used, longest "
>                "chain length %d\n", tag, h->nel, slots_used, SIDTAB_SIZE,
>                max_chain_len);
>  }
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
