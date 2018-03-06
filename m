Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w26NxQTg012756
 for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2018 18:59:26 -0500
Received: by mail-pl0-f66.google.com with SMTP id w22-v6so277804pll.2
 for <selinux@tycho.nsa.gov>; Tue, 06 Mar 2018 15:59:23 -0800 (PST)
Date: Tue, 6 Mar 2018 15:59:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Paul Moore <pmoore@redhat.com>
Cc: netdev@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Dominick
 Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Message-ID: <20180306155920.7b6379ac@xeon-e3>
In-Reply-To: <152037526427.18953.14013300464173153064.stgit@chester>
References: <152037526427.18953.14013300464173153064.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [PATCH] net: don't unnecessarily load kernel modules in
 dev_ioctl()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 06 Mar 2018 17:27:44 -0500
Paul Moore <pmoore@redhat.com> wrote:

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
> 
> diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
> index 0ab1af04296c..a04e1e88bf3a 100644
> --- a/net/core/dev_ioctl.c
> +++ b/net/core/dev_ioctl.c
> @@ -402,8 +402,6 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr, bool *need_c
>  	if (colon)
>  		*colon = 0;
>  
> -	dev_load(net, ifr->ifr_name);

Actually dev_load by ethernet name is really a legacy thing that should just die,

It was kept around so that some very tunnel configuration using special names.

	# ifconfig sit0

which probably several web pages still tell users to do...
We have much better control now with ip commands so that this is just
baggage.
