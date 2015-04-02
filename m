Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t32FYq63004547
 for <selinux@tycho.nsa.gov>; Thu, 2 Apr 2015 11:34:52 -0400
Received: by obbfy7 with SMTP id fy7so49551712obb.2
 for <selinux@tycho.nsa.gov>; Thu, 02 Apr 2015 08:34:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1427986808-845-1-git-send-email-sds@tycho.nsa.gov>
References: <1427986808-845-1-git-send-email-sds@tycho.nsa.gov>
Date: Thu, 2 Apr 2015 08:34:49 -0700
Message-ID: <CABXk95Bi-ZYRkK2+BHtPWv9mbuV-iRDFpL8n67War-mTOC_AFg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Fix build for Android.
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Acked-by: Jeff Vander Stoep <jeffv@google.com>

On Thu, Apr 2, 2015 at 8:00 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> The Android build does not like the symbol versioning introduced
> by commit 8147bc7; the build fails with:
> host SharedLib: libsepol (out/host/linux-x86/obj/lib/libsepol.so)
> prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8//x86_64-linux/bin/ld: error: symbol cil_build_policydb has undefined version
> prebuilts/gcc/linux-x86/host/x86_64-linux-glibc2.15-4.8//x86_64-linux/bin/ld: error: symbol cil_build_policydb has undefined version LIBSEPOL_1.1
> clang: error: linker command failed with exit code 1 (use -v to see invocation)
>
> The simplest fix appears to be to just drop the symver entries when
> building on Android.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  libsepol/Android.mk    | 1 +
>  libsepol/cil/src/cil.c | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/libsepol/Android.mk b/libsepol/Android.mk
> index 3e4700b..f84b0d7 100644
> --- a/libsepol/Android.mk
> +++ b/libsepol/Android.mk
> @@ -62,6 +62,7 @@ cil_src_files := \
>         cil/src/cil_verify.c
>
>  common_cflags := \
> +       -D_ANDROID_ \
>         -Wall -W -Wundef \
>         -Wshadow -Wmissing-noreturn \
>         -Wmissing-format-attribute
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index 1594be6..c13e8a4 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -51,6 +51,7 @@
>  #include "cil_policy.h"
>  #include "cil_strpool.h"
>
> +#ifndef _ANDROID_
>  asm(".symver cil_build_policydb_pdb,        cil_build_policydb@");
>  asm(".symver cil_build_policydb_create_pdb, cil_build_policydb@@LIBSEPOL_1.1");
>
> @@ -65,6 +66,7 @@ asm(".symver cil_selinuxusers_to_string_nopdb, cil_selinuxusers_to_string@@LIBSE
>
>  asm(".symver cil_filecons_to_string_pdb,   cil_filecons_to_string@");
>  asm(".symver cil_filecons_to_string_nopdb, cil_filecons_to_string@@LIBSEPOL_1.1");
> +#endif
>
>  int cil_sym_sizes[CIL_SYM_ARRAY_NUM][CIL_SYM_NUM] = {
>         {64, 64, 64, 1 << 13, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64, 64},
> --
> 1.9.3
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
