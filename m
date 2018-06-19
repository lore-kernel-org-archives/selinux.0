Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5JHosVP009637
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 13:50:55 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC07.oob.disa.mil (Postfix) with SMTP id 419Fqt0zgjz1wyK6
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 17:50:50 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC07.oob.disa.mil (Postfix) with ESMTP id 419Fqs30f0z1wyJY
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 17:50:49 +0000 (UTC)
Received: by mail-lf0-f51.google.com with SMTP id t2-v6so800226lfd.6
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 10:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-14-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-14-peter.enderborg@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Jun 2018 13:50:36 -0400
Message-ID: <CAHC9VhROjW4r7Ls35aX8M+j1BMn13OuUsN8prg9JnKWyHS1wzg@mail.gmail.com>
To: peter.enderborg@sony.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, danielj@mellanox.com,
 dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 13/13] selinux: Cleanup printk logging in netnode
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
>  security/selinux/netnode.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 6dd89b89bc1f..afa0d432436b 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -238,9 +238,8 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
>  out:
>         spin_unlock_bh(&sel_netnode_lock);
>         if (unlikely(ret)) {
> -               printk(KERN_WARNING
> -                      "SELinux: failure in sel_netnode_sid_slow(),"
> -                      " unable to determine network node label\n");
> +               pr_warn("SELinux: failure in %s(), unable to determine network node label\n",
> +                       __func__);
>                 kfree(new);
>         }
>         return ret;
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
