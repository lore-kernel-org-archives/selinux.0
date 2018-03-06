Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w26MWr18017647
 for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2018 17:32:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 3zws3l0XgRz63cL
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 22:32:51 +0000 (UTC)
Received: from UPDC3CPA12_EEMSG_MP28.eemsg.mil (unknown [192.168.18.23])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 3zws3k22kqz63cG
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 22:32:50 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id 37-v6so348901lfs.7
 for <selinux@tycho.nsa.gov>; Tue, 06 Mar 2018 14:32:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <152037526427.18953.14013300464173153064.stgit@chester>
References: <152037526427.18953.14013300464173153064.stgit@chester>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Mar 2018 17:32:47 -0500
Message-ID: <CAHC9VhR4FzwsAEO9O9Pnpkm2jOBajwZUkn_i0FqOMR_4ycag2g@mail.gmail.com>
To: Paul Moore <pmoore@redhat.com>
Cc: netdev@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] net: don't unnecessarily load kernel modules in
 dev_ioctl()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Mar 6, 2018 at 5:27 PM, Paul Moore <pmoore@redhat.com> wrote:
> From: Paul Moore <paul@paul-moore.com>
>
> Starting with v4.16-rc1 we've been seeing a higher than usual number
> of requests for the kernel to load networking modules, even on events
> which shouldn't trigger a module load (e.g. ioctl(TCGETS)).  Stephen
> Smalley suggested the problem may lie in commit 44c02a2c3dc5
> ("dev_ioctl(): move copyin/copyout to callers") which moves changes
> the network dev_ioctl() function to always call dev_load(),
> regardless of the requested ioctl.
>
> This patch moves the dev_load() calls back into the individual ioctls
> while preserving the rest of the original patch.
>
> Reported-by: Dominick Grift <dac.override@gmail.com>
> Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  net/core/dev_ioctl.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

In the interest of full disclosure, I've compiled this code but I
haven't booted it yet (test kernel building now).  I just wanted to
post this sooner rather than later in case the networking folks, or
Al, had a different solution they would prefer.

> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index 0ab1af04296c..a04e1e88bf3a 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -402,8 +402,6 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
>         if (colon)
>                 *colon = 0;
>
> -       dev_load(net, ifr->ifr_name);
> -
>         /*
>          *      See which interface the caller is talking about.
>          */
> @@ -423,6 +421,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
>         case SIOCGIFMAP:
>         case SIOCGIFINDEX:
>         case SIOCGIFTXQLEN:
> +               dev_load(net, ifr->ifr_name);
>                 rcu_read_lock();
>                 ret = dev_ifsioc_locked(net, ifr, cmd);
>                 rcu_read_unlock();
> @@ -431,6 +430,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
>                 return ret;
>
>         case SIOCETHTOOL:
> +               dev_load(net, ifr->ifr_name);
>                 rtnl_lock();
>                 ret = dev_ethtool(net, ifr);
>                 rtnl_unlock();
> @@ -447,6 +447,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
>         case SIOCGMIIPHY:
>         case SIOCGMIIREG:
>         case SIOCSIFNAME:
> +               dev_load(net, ifr->ifr_name);
>                 if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
>                         return -EPERM;
>                 rtnl_lock();
> @@ -494,6 +495,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
>                 /* fall through */
>         case SIOCBONDSLAVEINFOQUERY:
>         case SIOCBONDINFOQUERY:
> +               dev_load(net, ifr->ifr_name);
>                 rtnl_lock();
>                 ret = dev_ifsioc(net, ifr, cmd);
>                 rtnl_unlock();
> @@ -518,6 +520,7 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
>                     cmd == SIOCGHWTSTAMP ||
>                     (cmd >= SIOCDEVPRIVATE &&
>                      cmd <= SIOCDEVPRIVATE + 15)) {
> +                       dev_load(net, ifr->ifr_name);
>                         rtnl_lock();
>                         ret = dev_ifsioc(net, ifr, cmd);
>                         rtnl_unlock();
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
paul moore
www.paul-moore.com
