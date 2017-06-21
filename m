Message-ID: <1498056733.32258.1.camel@tycho.nsa.gov>
Subject: Re: [PATCH 3/3] python/sepolicy: remove definition of SYSCONFDIR
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Wed, 21 Jun 2017 10:52:13 -0400
In-Reply-To: <20170620202955.11587-3-nicolas.iooss@m4x.org>
References: <20170620202955.11587-1-nicolas.iooss@m4x.org>
 <20170620202955.11587-3-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-06-20 at 22:29 +0200, Nicolas Iooss wrote:
> This variable is not used in any Makefile in python/.
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied all three.

> ---
>  python/sepolicy/Makefile | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index 0d2bec2042b0..5a56e6c8122e 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -2,7 +2,6 @@ PYTHON ?= python
>  
>  # Installation directories.
>  PREFIX ?= $(DESTDIR)/usr
> -SYSCONFDIR ?= $(DESTDIR)/etc/sysconfig
>  LIBDIR ?= $(PREFIX)/lib
>  BINDIR ?= $(PREFIX)/bin
>  DATADIR ?= $(PREFIX)/share
