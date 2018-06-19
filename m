Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5JHaJh6008500
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 13:36:19 -0400
Received: by mail-lf0-f65.google.com with SMTP id i15-v6so756016lfc.2
 for <selinux@tycho.nsa.gov>; Tue, 19 Jun 2018 10:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com>
 <20180612080912.7827-9-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-9-peter.enderborg@sony.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Jun 2018 13:34:53 -0400
Message-ID: <CAHC9VhQQ5KQW6Ee+4-NZtJRTC1wNDFPe=ZO7R1t8=-2CTG=pqw@mail.gmail.com>
To: peter.enderborg@sony.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 James Morris <jmorris@namei.org>, danielj@mellanox.com,
 dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH 08/13] selinux: Cleanup printk logging in netlink
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
>  security/selinux/netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
> index 828fb6a4e941..8a8a72507437 100644
> --- a/security/selinux/netlink.c
> +++ b/security/selinux/netlink.c
> @@ -94,7 +94,7 @@ static void selnl_notify(int msgtype, void *data)
>  out_kfree_skb:
>         kfree_skb(skb);
>  oom:
> -       printk(KERN_ERR "SELinux:  OOM in %s\n", __func__);
> +       pr_err("SELinux:  OOM in %s\n", __func__);
>         goto out;
>  }
>
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
