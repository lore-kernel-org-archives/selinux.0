Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5JHiPmi009053
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 13:44:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC11.oob.disa.mil (Postfix) with SMTP id 419FhR27cMzg47R
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 17:44:23 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC11.oob.disa.mil (Postfix) with ESMTP id 419FhQ0VPkzg47G
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 17:44:22 +0000 (UTC)
Received: by mail-lf0-f48.google.com with SMTP id a13-v6so741154lfk.12
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 10:44:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-11-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-11-peter.enderborg@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Jun 2018 13:44:10 -0400
Message-ID: <CAHC9VhQXk4tMZ_fp=rbygEs2ZyT2O07PJB4jdKKY7+eO3wSC5g@mail.gmail.com>
To: peter.enderborg@sony.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, danielj@mellanox.com,
 dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 10/13] selinux: Cleanup printk logging in netport
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
>  security/selinux/netport.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index 9ed4c5064a5e..7a141cadbffc 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -173,9 +173,8 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
>  out:
>         spin_unlock_bh(&sel_netport_lock);
>         if (unlikely(ret)) {
> -               printk(KERN_WARNING
> -                      "SELinux: failure in sel_netport_sid_slow(),"
> -                      " unable to determine network port label\n");
> +               pr_warn("SELinux: failure in %s(), unable to determine network port label\n",
> +                       __func__);
>                 kfree(new);
>         }
>         return ret;
> --
> 2.15.1

-- 
paul moore
www.paul-moore.com
