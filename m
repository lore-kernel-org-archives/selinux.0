Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0JLJcok019470
 for <selinux@tycho.nsa.gov>; Tue, 19 Jan 2016 16:19:39 -0500
Received: by mail-qk0-f194.google.com with SMTP id u128so3045460qkh.1
 for <selinux@tycho.nsa.gov>; Tue, 19 Jan 2016 13:19:37 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>
Subject: Re: [PATCH v2 1/1] selinux: use absolute path to include directory
Date: Tue, 19 Jan 2016 16:19:34 -0500
Message-ID: <2400530.bhohIrbhWL@sifl>
In-Reply-To: <1453223272-120888-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1453223272-120888-1-git-send-email-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, January 19, 2016 07:07:52 PM Andy Shevchenko wrote:
> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index ad5cd76..b850811 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -13,7 +13,7 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
> 
>  selinux-$(CONFIG_NETLABEL) += netlabel.o
> 
> -ccflags-y := -Isecurity/selinux -Isecurity/selinux/include
> +ccflags-y := -I$(srctree)security/selinux I$(srctree)/security/...

You are missing a "/" after "$(srctree)".

Please make sure that your patches compile and pass basic functionality before 
submitting; I don't care how trivial they may be, we all make the occasional 
mistake, and a basic compile/boot test does wonders for catching a lot of 
these stupid mistakes.

>  $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h

-- 
paul moore
www.paul-moore.com
