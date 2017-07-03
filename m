Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v63N3vrX007345
 for <selinux@tycho.nsa.gov>; Mon, 3 Jul 2017 19:03:57 -0400
Received: by mail-lf0-f67.google.com with SMTP id t72so16271084lff.0
 for <selinux@tycho.nsa.gov>; Mon, 03 Jul 2017 16:03:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498835756-7610-1-git-send-email-danielj@mellanox.com>
References: <1498835756-7610-1-git-send-email-danielj@mellanox.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Jul 2017 19:03:54 -0400
Message-ID: <CAHC9VhQcSfuMxZoAiTW8c-MNf6m0gLk_xArC7HkjR+5ZJgtgPA@mail.gmail.com>
Subject: Re: [PATCH] IB/core: Fix static analysis warning in
 ib_policy_change_task
To: Dan Jurgens <danielj@mellanox.com>
Cc: dan.carpenter@oracle.com, dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-rdma@vger.kernel.org, yevgenyp@mellanox.com
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 30, 2017 at 11:15 AM, Dan Jurgens <danielj@mellanox.com> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> ib_get_cached_subnet_prefix can technically fail, but the only way it
> could is not possible based on the loop conditions. Check the return
> value before using the variable sp to resolve a static analysis warning.
>
> Fixes: 8f408ab64be6 ("selinux lsm IB/core: Implement LSM notification
> system")
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/core/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 631eaa9..dabd9f9 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -376,7 +376,8 @@ static void ib_policy_change_task(struct work_struct *work)
>                         WARN_ONCE(ret,
>                                   "ib_get_cached_subnet_prefix err: %d, this should never happen here\n",
>                                   ret);
> -                       ib_security_cache_change(dev, i, sp);
> +                       if (ret)

Should this be "if (!ret)"?

> +                               ib_security_cache_change(dev, i, sp);
>                 }
>         }
>         up_read(&lists_rwsem);

-- 
paul moore
www.paul-moore.com
