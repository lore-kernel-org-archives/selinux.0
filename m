Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u811Z57Z003626
 for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2016 21:35:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id t127so6430634oie.1
 for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2016 18:35:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469800416-125043-4-git-send-email-danielj@mellanox.com>
References: <1469800416-125043-1-git-send-email-danielj@mellanox.com>
 <1469800416-125043-4-git-send-email-danielj@mellanox.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 Aug 2016 21:35:02 -0400
Message-ID: <CAHC9VhQsuu-KkzWiUYA-z1gZST68_t65_y_z6vJjz6BwTk-sEg@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] selinux lsm IB/core: Implement LSM notification
 system
To: Dan Jurgens <danielj@mellanox.com>
Cc: chrisw@sous-sol.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, dledford@redhat.com,
 sean.hefty@intel.com, hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 29, 2016 at 9:53 AM, Dan Jurgens <danielj@mellanox.com> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> Add a generic notificaiton mechanism in the LSM. Interested consumers
> can register a callback with the LSM and security modules can produce
> events.
>
> Because access to Infiniband QPs are enforced in the setup phase of a
> connection security should be enforced again if the policy changes.
> Register infiniband devices for policy change notification and check all
> QPs on that device when the notification is received.
>
> Add a call to the notification mechanism from SELinux when the AVC
> cache changes or setenforce is cleared.
>
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>
> ---
> v2:
> - new patch that has the generic notification, replaces selinux and
>   IB/core patches related to the ib_flush callback. Yuval Shaia and Paul
>   Moore
>
> v3:
> - use notifier chains. Paul Moore
>
>  drivers/infiniband/core/device.c | 53 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/security.h         |  8 ++++++
>  security/security.c              | 20 +++++++++++++++
>  security/selinux/hooks.c         |  5 ++--
>  security/selinux/selinuxfs.c     |  2 ++
>  5 files changed, 86 insertions(+), 2 deletions(-)

One small comment below, I also assume you've seen the test robot's
email regarding build problems on IA64?

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a86d537..7c22703 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -159,13 +159,14 @@ static int selinux_peerlbl_enabled(void)
>         return (selinux_policycap_alwaysnetwork || netlbl_enabled() || selinux_xfrm_enabled());
>  }
>
> -static int selinux_netcache_avc_callback(u32 event)
> +static int selinux_cache_avc_callback(u32 event)
>  {
>         if (event == AVC_CALLBACK_RESET) {
>                 sel_netif_flush();
>                 sel_netnode_flush();
>                 sel_netport_flush();
>                 synchronize_net();
> +               call_lsm_notifier(LSM_POLICY_CHANGE, NULL);
>         }
>         return 0;
>  }

We are getting down to the small details now ... I think I would
prefer if the "call_lsm_notifier(...)" call was done from its own AVC
callback instead of hanging off the existing netcache callback.

-- 
paul moore
www.paul-moore.com
