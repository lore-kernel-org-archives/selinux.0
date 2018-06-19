Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5JHmrha009413
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 13:48:53 -0400
Received: by mail-lf0-f66.google.com with SMTP id z207-v6so779981lff.9
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 10:48:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-13-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-13-peter.enderborg@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Jun 2018 13:48:38 -0400
Message-ID: <CAHC9VhQ3xrVfGo0T-HdHbdM3p1k38NwfEP7qmNZDO_b_8a++UA@mail.gmail.com>
To: peter.enderborg@sony.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, danielj@mellanox.com,
 dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 12/13] selinux: Cleanup printk logging in avc
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
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index f3aedf077509..635e5c1e3e48 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -650,7 +650,7 @@ static int avc_latest_notif_update(struct selinux_avc *avc,
>         spin_lock_irqsave(&notif_lock, flag);
>         if (is_insert) {
>                 if (seqno < avc->avc_cache.latest_notif) {
> -                       printk(KERN_WARNING "SELinux: avc:  seqno %d < latest_notif %d\n",
> +                       pr_warn("SELinux: avc:  seqno %d < latest_notif %d\n",
>                                seqno, avc->avc_cache.latest_notif);
>                         ret = -EAGAIN;
>                 }
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
