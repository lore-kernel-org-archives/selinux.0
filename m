Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v65E8EJ6030634
 for <selinux@tycho.nsa.gov>; Wed, 5 Jul 2017 10:08:14 -0400
Received: by mail-lf0-f65.google.com with SMTP id t72so21079851lff.0
 for <selinux@tycho.nsa.gov>; Wed, 05 Jul 2017 07:08:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499260521-5294-1-git-send-email-danielj@mellanox.com>
References: <1499260521-5294-1-git-send-email-danielj@mellanox.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 5 Jul 2017 10:08:03 -0400
Message-ID: <CAHC9VhQkmhP4hK17QHqdt2gkLZb+9vOHgyqOomAU0dT2PnoCPg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] IB/core: Fix static analysis warning in
 ib_policy_change_task
To: Dan Jurgens <danielj@mellanox.com>
Cc: dan.carpenter@oracle.com, dledford@redhat.com, selinux@tycho.nsa.gov,
 linux-rdma@vger.kernel.org, yevgenyp@mellanox.com
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Jul 5, 2017 at 9:15 AM, Dan Jurgens <danielj@mellanox.com> wrote:
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
>
> -v1:
> - Fix check to !ret. Paul Moore
> ---
>  drivers/infiniband/core/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks for the update, merged.  I'm doing a sanity build right now,
assuming all goes well I'll send this up tomorrow.

> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index 631eaa9..a5dfab6 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -376,7 +376,8 @@ static void ib_policy_change_task(struct work_struct *work)
>                         WARN_ONCE(ret,
>                                   "ib_get_cached_subnet_prefix err: %d, this should never happen here\n",
>                                   ret);
> -                       ib_security_cache_change(dev, i, sp);
> +                       if (!ret)
> +                               ib_security_cache_change(dev, i, sp);
>                 }
>         }
>         up_read(&lists_rwsem);
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
