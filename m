Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5JHkxFu009224
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 13:46:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC11.oob.disa.mil (Postfix) with SMTP id 419FlP2sjwzg47p
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 17:46:57 +0000 (UTC)
Received: from UPBD19PA11.eemsg.mil (unknown [192.168.18.17])
 by UPDCF3IC11.oob.disa.mil (Postfix) with ESMTP id 419FlN1zcCzg47R
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 17:46:56 +0000 (UTC)
Received: by mail-lf0-f54.google.com with SMTP id p23-v6so761443lfh.11
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 10:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-12-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-12-peter.enderborg@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Jun 2018 13:46:42 -0400
Message-ID: <CAHC9VhQhvDFMrJVazcsiMzbnf1Nfg5CBaBNF_kiws15j-oBdUw@mail.gmail.com>
To: peter.enderborg@sony.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, danielj@mellanox.com,
 dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 11/13] selinux: Cleanup printk logging in netif
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
>  security/selinux/netif.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/netif.c b/security/selinux/netif.c
> index ac65f7417413..8c738c189942 100644
> --- a/security/selinux/netif.c
> +++ b/security/selinux/netif.c
> @@ -145,9 +145,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
>
>         dev = dev_get_by_index(ns, ifindex);
>         if (unlikely(dev == NULL)) {
> -               printk(KERN_WARNING
> -                      "SELinux: failure in sel_netif_sid_slow(),"
> -                      " invalid network interface (%d)\n", ifindex);
> +               pr_warn("SELinux: failure in %s(), invalid network interface (%d)\n",
> +                       __func__, ifindex);
>                 return -ENOENT;
>         }
>
> @@ -177,10 +176,8 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
>         spin_unlock_bh(&sel_netif_lock);
>         dev_put(dev);
>         if (unlikely(ret)) {
> -               printk(KERN_WARNING
> -                      "SELinux: failure in sel_netif_sid_slow(),"
> -                      " unable to determine network interface label (%d)\n",
> -                      ifindex);
> +               pr_warn("SELinux: failure in %s(), unable to determine network interface label (%d)\n",
> +                       __func__, ifindex);
>                 kfree(new);
>         }
>         return ret;
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
