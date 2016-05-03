Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u43G2AqC003773
 for <selinux@tycho.nsa.gov>; Tue, 3 May 2016 12:02:12 -0400
Received: by mail-oi0-f48.google.com with SMTP id x19so31594540oix.2
 for <selinux@tycho.nsa.gov>; Tue, 03 May 2016 09:02:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1462291125-28934-1-git-send-email-sds@tycho.nsa.gov>
References: <1462291125-28934-1-git-send-email-sds@tycho.nsa.gov>
From: enh <enh@google.com>
Date: Tue, 3 May 2016 09:01:43 -0700
Message-ID: <CAJgzZorJ=XVWLNvDMSaEGMdjK66GcyT0G5uumLZFMRtUGR_iHQ@mail.gmail.com>
Subject: Re: [PATCH] libsepol, checkpolicy,
 secilc: Replace #ifdef DARWIN with __APPLE__.
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

lgtm. thanks!

On Tue, May 3, 2016 at 8:58 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> As per discussion in https://android-review.googlesource.com/#/c/221980,
> we should be using #ifdef __APPLE__ rather than our own custom-defined
> DARWIN for building on MacOS X.
>
> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> ---
>  checkpolicy/Android.mk      | 4 ----
>  checkpolicy/checkpolicy.c   | 2 +-
>  checkpolicy/policy_define.c | 2 +-
>  libsepol/Android.mk         | 4 ----
>  libsepol/src/genbools.c     | 4 ++--
>  libsepol/src/genusers.c     | 4 ++--
>  libsepol/src/node_record.c  | 4 ++--
>  libsepol/src/private.h      | 4 ++--
>  secilc/Android.mk           | 4 ----
>  9 files changed, 10 insertions(+), 22 deletions(-)
>
> diff --git a/checkpolicy/Android.mk b/checkpolicy/Android.mk
> index 98f5168..3b7ff8a 100644
> --- a/checkpolicy/Android.mk
> +++ b/checkpolicy/Android.mk
> @@ -12,10 +12,6 @@ common_cflags := \
>         -Wall -Wshadow -O2 \
>         -pipe -fno-strict-aliasing \
>
> -ifeq ($(HOST_OS),darwin)
> -common_cflags += -DDARWIN
> -endif
> -
>  common_includes := \
>         $(LOCAL_PATH)/ \
>         $(LOCAL_PATH)/../libsepol/include/ \
> diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
> index 7947c20..2d68316 100644
> --- a/checkpolicy/checkpolicy.c
> +++ b/checkpolicy/checkpolicy.c
> @@ -73,7 +73,7 @@
>  #include <errno.h>
>  #include <sys/mman.h>
>
> -#ifdef DARWIN
> +#ifdef __APPLE__
>  #include <ctype.h>
>  #endif
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 2068b71..100e517 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -5140,7 +5140,7 @@ int define_ipv6_node_context(void)
>
>         memset(newc, 0, sizeof(ocontext_t));
>
> -#ifdef DARWIN
> +#ifdef __APPLE__
>         memcpy(&newc->u.node6.addr[0], &addr.s6_addr[0], 16);
>         memcpy(&newc->u.node6.mask[0], &mask.s6_addr[0], 16);
>  #else
> diff --git a/libsepol/Android.mk b/libsepol/Android.mk
> index 5d2c96b..6d89f17 100644
> --- a/libsepol/Android.mk
> +++ b/libsepol/Android.mk
> @@ -69,10 +69,6 @@ common_cflags := \
>         -Wshadow -Wmissing-noreturn \
>         -Wmissing-format-attribute
>
> -ifeq ($(HOST_OS), darwin)
> -common_cflags += -DDARWIN
> -endif
> -
>  common_includes := \
>         $(LOCAL_PATH)/include/ \
>         $(LOCAL_PATH)/src/ \
> diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c
> index 6a06ec9..c81e848 100644
> --- a/libsepol/src/genbools.c
> +++ b/libsepol/src/genbools.c
> @@ -79,7 +79,7 @@ static int load_booleans(struct policydb *policydb, const char *path,
>         if (boolf == NULL)
>                 goto localbool;
>
> -#ifdef DARWIN
> +#ifdef __APPLE__
>          if ((buffer = (char *)malloc(255 * sizeof(char))) == NULL) {
>            ERR(NULL, "out of memory");
>           return -1;
> @@ -111,7 +111,7 @@ static int load_booleans(struct policydb *policydb, const char *path,
>         boolf = fopen(localbools, "r");
>         if (boolf != NULL) {
>
> -#ifdef DARWIN
> +#ifdef __APPLE__
>
>           while(fgets(buffer, 255, boolf) != NULL) {
>  #else
> diff --git a/libsepol/src/genusers.c b/libsepol/src/genusers.c
> index 7826b71..0b98a76 100644
> --- a/libsepol/src/genusers.c
> +++ b/libsepol/src/genusers.c
> @@ -7,7 +7,7 @@
>
>  #include <sepol/policydb/policydb.h>
>
> -#ifndef DARWIN
> +#ifndef __APPLE__
>  #include <stdio_ext.h>
>  #endif
>
> @@ -47,7 +47,7 @@ static int load_users(struct policydb *policydb, const char *path)
>         if (fp == NULL)
>                 return -1;
>
> -#ifdef DARWIN
> +#ifdef __APPLE__
>         if ((buffer = (char *)malloc(255 * sizeof(char))) == NULL) {
>           ERR(NULL, "out of memory");
>           return -1;
> diff --git a/libsepol/src/node_record.c b/libsepol/src/node_record.c
> index bd48ba0..21043b6 100644
> --- a/libsepol/src/node_record.c
> +++ b/libsepol/src/node_record.c
> @@ -70,7 +70,7 @@ static int node_parse_addr(sepol_handle_t * handle,
>                                 return STATUS_ERR;
>                         }
>
> -#ifdef DARWIN
> +#ifdef __APPLE__
>                         memcpy(addr_bytes, in_addr.s6_addr, 16);
>  #else
>                         memcpy(addr_bytes, in_addr.s6_addr32, 16);
> @@ -162,7 +162,7 @@ static int node_expand_addr(sepol_handle_t * handle,
>                 {
>                         struct in6_addr addr;
>                         memset(&addr, 0, sizeof(struct in6_addr));
> -#ifdef DARWIN
> +#ifdef __APPLE__
>                         memcpy(&addr.s6_addr[0], addr_bytes, 16);
>  #else
>                         memcpy(&addr.s6_addr32[0], addr_bytes, 16);
> diff --git a/libsepol/src/private.h b/libsepol/src/private.h
> index 8a6d4bb..9c700c9 100644
> --- a/libsepol/src/private.h
> +++ b/libsepol/src/private.h
> @@ -5,7 +5,7 @@
>  #include <sepol/policydb/policydb.h>
>
>
> -#ifdef DARWIN
> +#ifdef __APPLE__
>  #include <sys/types.h>
>  #include <machine/endian.h>
>  #else
> @@ -16,7 +16,7 @@
>  #include <errno.h>
>  #include <dso.h>
>
> -#ifdef DARWIN
> +#ifdef __APPLE__
>  #define __BYTE_ORDER  BYTE_ORDER
>  #define __LITTLE_ENDIAN  LITTLE_ENDIAN
>  #endif
> diff --git a/secilc/Android.mk b/secilc/Android.mk
> index 3dd9023..6c7b9d3 100644
> --- a/secilc/Android.mk
> +++ b/secilc/Android.mk
> @@ -6,10 +6,6 @@ common_cflags := \
>         -Wall -Wshadow -O2 \
>         -pipe -fno-strict-aliasing \
>
> -ifeq ($(HOST_OS), darwin)
> -common_cflags += -DDARWIN
> -endif
> -
>  common_includes := \
>         $(LOCAL_PATH)/../libsepol/cil/include/ \
>         $(LOCAL_PATH)/../libsepol/include/ \
> --
> 2.5.5
>



-- 
Elliott Hughes - http://who/enh - http://jessies.org/~enh/
Android native code/tools questions? Mail me/drop by/add me as a reviewer.
