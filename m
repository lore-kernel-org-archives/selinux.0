Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0SG142B020786
 for <selinux@tycho.nsa.gov>; Thu, 28 Jan 2016 11:01:05 -0500
Received: by mail-oi0-f67.google.com with SMTP id y78so2155573oif.3
 for <selinux@tycho.nsa.gov>; Thu, 28 Jan 2016 08:01:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453985956-133448-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1453985956-133448-1-git-send-email-andriy.shevchenko@linux.intel.com>
Date: Thu, 28 Jan 2016 11:01:02 -0500
Message-ID: <CAHC9VhRLdSfWCkG2dNN406XoZKYOdc6nrkTJk+jqA-dvwetUwg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] selinux: use absolute path to include directory
From: Paul Moore <paul@paul-moore.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 James Morris <james.l.morris@oracle.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jan 28, 2016 at 7:59 AM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Compiler warns us a lot that it can't find include folder because it's provided
> in relative form.
>
>   CC      security/selinux/netlabel.o
> cc1: warning: security/selinux/include: No such file or directory [-Wmissing-include-dirs]
> cc1: warning: security/selinux/include: No such file or directory [-Wmissing-include-dirs]
> cc1: warning: security/selinux/include: No such file or directory [-Wmissing-include-dirs]
> cc1: warning: security/selinux/include: No such file or directory [-Wmissing-include-dirs]
>
> Add $(srctree) prefix to the path.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  security/selinux/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

> diff --git a/security/selinux/Makefile b/security/selinux/Makefile
> index ad5cd76..3411c33 100644
> --- a/security/selinux/Makefile
> +++ b/security/selinux/Makefile
> @@ -13,7 +13,7 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) += xfrm.o
>
>  selinux-$(CONFIG_NETLABEL) += netlabel.o
>
> -ccflags-y := -Isecurity/selinux -Isecurity/selinux/include
> +ccflags-y := -I$(srctree)/security/selinux -I$(srctree)/security/selinux/include
>
>  $(addprefix $(obj)/,$(selinux-y)): $(obj)/flask.h
>
> --
> 2.7.0.rc3

-- 
paul moore
www.paul-moore.com
