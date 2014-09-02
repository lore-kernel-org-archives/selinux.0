Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s82CXv7m016156
 for <selinux@tycho.nsa.gov>; Tue, 2 Sep 2014 08:33:57 -0400
Message-ID: <5405B91F.7050306@tresys.com>
Date: Tue, 2 Sep 2014 08:33:35 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>, <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] libselinux: man: Add missing manpage links to
 security_load_policy.3
References: <1409505479-4875-1-git-send-email-bigon@debian.org>
In-Reply-To: <1409505479-4875-1-git-send-email-bigon@debian.org>
Content-Type: text/plain; charset="ISO-8859-1"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/31/2014 01:17 PM, Laurent Bigonville wrote:
> From: Laurent Bigonville <bigon@bigon.be>
> 
> Add the missing manpage link for selinux_init_load_policy(3) and
> selinux_mkload_policy(3) to security_load_policy(3)
> 
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=753803
> ---
>  libselinux/man/man3/selinux_init_load_policy.3 | 1 +
>  libselinux/man/man3/selinux_mkload_policy.3    | 1 +
>  2 files changed, 2 insertions(+)
>  create mode 100644 libselinux/man/man3/selinux_init_load_policy.3
>  create mode 100644 libselinux/man/man3/selinux_mkload_policy.3
> 
> diff --git a/libselinux/man/man3/selinux_init_load_policy.3 b/libselinux/man/man3/selinux_init_load_policy.3
> new file mode 100644
> index 0000000..94e8117
> --- /dev/null
> +++ b/libselinux/man/man3/selinux_init_load_policy.3
> @@ -0,0 +1 @@
> +.so man3/security_load_policy.3
> diff --git a/libselinux/man/man3/selinux_mkload_policy.3 b/libselinux/man/man3/selinux_mkload_policy.3
> new file mode 100644
> index 0000000..94e8117
> --- /dev/null
> +++ b/libselinux/man/man3/selinux_mkload_policy.3
> @@ -0,0 +1 @@
> +.so man3/security_load_policy.3
> 

Acked-by: Steve Lawrence <slawrence@tresys.com>
