Message-ID: <54EE138A.8010009@tycho.nsa.gov>
Date: Wed, 25 Feb 2015 13:25:14 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Emre Can Kucukoglu <eckucukoglu@gmail.com>, selinux@tycho.nsa.gov
Subject: Re: Cross-compile for arm architecture
References: <CA+2y117Qsyy1EVqioo6e1r44mOBK5GiEDRAQczngkhQpRgmD9Q@mail.gmail.com>
In-Reply-To: <CA+2y117Qsyy1EVqioo6e1r44mOBK5GiEDRAQczngkhQpRgmD9Q@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/25/2015 10:42 AM, Emre Can Kucukoglu wrote:
> Hello,
> 
> I want to use SELinux for my experimental vanilla kernel distribution in
> Pandaboard ES. To achieve that I have configured my kernel for SELinux
> support. Then, I have recently cloned selinux userspace repository to
> cross-compile it for arm architecture. I use arm-linux-gnueabi toolchain
> in Ubuntu 14.04 workstation. 
> 
> $ export ARCH=arm
> $ export CROSS_COMPILE=arm-linux-gnueabi-
> 
> As mentioned in readme instruction, 
> 
> $ make DESTDIR=~/obj install install-pywrap
> 
> command is used, however due to -Werror flags in various Makefile's,
> error is thrown: 
> 
> dispol.c: In function ‘main’:
> dispol.c:452:8: error: ignoring return value of ‘fgets’, declared with
> attribute warn_unused_result [-Werror=unused-result]
>    fgets(ans, sizeof(ans), stdin);
>         ^
> dispol.c:479:9: error: ignoring return value of ‘fgets’, declared with
> attribute warn_unused_result [-Werror=unused-result]
>     fgets(ans, sizeof(ans), stdin);
>          ^
> dispol.c:490:9: error: ignoring return value of ‘fgets’, declared with
> attribute warn_unused_result [-Werror=unused-result]
>     fgets(ans, sizeof(ans), stdin);
>          ^
> dispol.c:517:9: error: ignoring return value of ‘fgets’, declared with
> attribute warn_unused_result [-Werror=unused-result]
>     fgets(OutfileName, sizeof(OutfileName), stdin);
>          ^
> cc1: all warnings being treated as errors
> make[2]: *** [dispol.o] Error 1
> 
> I did this modification to get over this error which is caused by
> -Werror flag:
> 
> char *fgetsret; /* error is given, because return value is not captured */
> fgetsret = fgets(...);
> if (!fgetsret) { /* if fgetsret is not used, another error comes from
> warning */
> // some exit message
> exit(1);
> }
> 
> Did I miss something about SELinux cross-compilation for an arm
> architecture, since constantly I'm taking errors.

Hmm...that's interesting.  Builds just fine on Fedora 20.  I do however
get the same error building on Ubuntu 14.04 (which is not something we
typically test on; most SELinux developers work on Fedora).

Willing to accept patches to fix it, but it is merely a test/debugging
program that you can even exclude from your build if you like.
