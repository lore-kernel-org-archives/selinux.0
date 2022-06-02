Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66057C433EF
	for <selinux@archiver.kernel.org>; Thu,  2 Jun 2022 13:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiFBN4O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiFBN4O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jun 2022 09:56:14 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076E829ADC6
        for <selinux@vger.kernel.org>; Thu,  2 Jun 2022 06:56:13 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w130so6681303oig.0
        for <selinux@vger.kernel.org>; Thu, 02 Jun 2022 06:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8D2jNGjhL8dKVqowwHUurILUv0s7yIHnllpm1Evzm6I=;
        b=etrVBlkxWsoOmPd0rG/f2OvXGIhqrSR0Mub7R2BOvvoRguL3i1eWJiKHvHyux+0v/4
         o8XGEMo9LBKaOJQHQZzC3ZU5PC80S4NwS5Qzm4A9LfXjm5OT6e1Fm+RvpG6xWIqPZTEu
         TIBWi8pVkGZNdcQJ9GHWfC44t/SiN8BmineFoqPX+fL1h89Ar0mljNuKApR+a43cucBf
         PY7pzUTQlF1Y0XzANvmAzF6w5PyZcMipDUuSltlloK0tM+sz1nMXr5YLLmvCwt9RcszR
         qy+pcf2chIW8FZpZ3ACPkHi23cK4Hd5OCxTEilNvVT8qBYFcP3sj+Wvf0Rcjyv2CI0tE
         C8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8D2jNGjhL8dKVqowwHUurILUv0s7yIHnllpm1Evzm6I=;
        b=V+gdiWfLhYDG3MrjzHVddqw30exsIcOSiwpDgD896ralBkn4L3tYEE0E3WZ0DCv2pm
         RMNDoqPBBi3pP8KjKeXscDeC038qqKlkSQfCUeY+Ao4WzAIk4LdkPY6JKNsIR3jk/CUr
         UuW84aS6rOtq5LozzIYXju7e0atRE6LVWEcNlQ35KlB/V3Cviy2XUpcLCjFCtRNilRtE
         oNk+83wJNprV6hkV87T+PxdP4rS7iZvtomNa6bXPd/1x6REWBwmeE7FRbrhX2ucNSKgv
         5F+UcJQ6m8479kZom8uhd1Cx7CkS8GE9JwSztXBiKeEcI3z9ewNLtt/QMNSUiLlwLAcC
         gj+Q==
X-Gm-Message-State: AOAM5301eIvOH39MFkAiSIG1dKD/6/ZDVtgL26rmbhqaAi2tn5oM5ltm
        e530O23v9Tj0JWbLjiFD8Pm0vC1FfNTfefSLAtc=
X-Google-Smtp-Source: ABdhPJz8oJHQicUNHvovcPMVOOIKDGvTklymHYqdDkp+689ibwDD0yr3MOowyqWkR7BU2rnb29LgFskjfjSFOeN9KSQ=
X-Received: by 2002:a05:6808:ec5:b0:2f9:a7fb:4dfb with SMTP id
 q5-20020a0568080ec500b002f9a7fb4dfbmr18455715oiv.156.1654178172328; Thu, 02
 Jun 2022 06:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220529180111.408899-1-nicolas.iooss@m4x.org>
In-Reply-To: <20220529180111.408899-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 2 Jun 2022 09:56:01 -0400
Message-ID: <CAP+JOzQ4+PWSQUjb+TjfaPEa7FYEimXeYbJLU-u4npWD0TyZJw@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux: do not return the cached prev_current
 value when using getpidcon()
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>, jsegitz@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 30, 2022 at 3:09 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> libselinux implements a cache mechanism for get*con() functions, such
> that when a thread calls setcon(...) then getcon(...), the context is
> directly returned. Unfortunately, getpidcon(pid, &context) uses the same
> cached variable, so when a program uses setcon("something"), all later
> calls to getpidcon(pid, ...) returns "something". This is a bug.
>
> Here is a program which illustrates this bug:
>
>     #include <stdio.h>
>     #include <selinux/selinux.h>
>
>     int main() {
>         char *context = "";
>         if (getpidcon(1, &context) < 0) {
>             perror("getpidcon(1)");
>         }
>         printf("getpidcon(1) = %s\n", context);
>
>         if (getcon(&context) < 0) {
>             perror("getcon()");
>         }
>         printf("getcon() = %s\n", context);
>         if (setcon(context) < 0) {
>             perror("setcon()");
>         }
>         if (getpidcon(1, &context) < 0) {
>             perror("getpidcon(1)");
>         }
>         printf("getpidcon(1) = %s\n", context);
>
>         return 0;
>     }
>
> On an Arch Linux system using unconfined user, this program displays:
>
>     getpidcon(1) = system_u:system_r:init_t
>     getcon() = unconfined_u:unconfined_r:unconfined_t
>     getpidcon(1) = unconfined_u:unconfined_r:unconfined_t
>
> With this commit, this program displays:
>
>     getpidcon(1) = system_u:system_r:init_t
>     getcon() = unconfined_u:unconfined_r:unconfined_t
>     getpidcon(1) = system_u:system_r:init_t
>
> This bug was present in the first commit of
> https://github.com/SELinuxProject/selinux git history. It was reported
> in https://lore.kernel.org/selinux/20220121084012.GS7643@suse.com/ and a
> patch to fix it was sent in
> https://patchwork.kernel.org/project/selinux/patch/20220127130741.31940-1-jsegitz@suse.de/
> without a clear explanation. This patch added pid checks, which made
> sense but were difficult to read. Instead, it is possible to change the
> way the functions are called so that they directly know which cache
> variable to use.
>
> Moreover, as the code is not clear at all (I spent too much time trying
> to understand what the switch did and what the thread-local variable
> contained), this commit also reworks libselinux/src/procattr.c to:
> - not use hard-to-understand switch/case constructions on strings (they
>   are replaced by a new argument filled by macros)
> - remove getpidattr_def macro (it was only used once, for pidcon, and
>   the code is clearer with one less macro)
> - remove the pid parameter of setprocattrcon() and setprocattrcon_raw()
>   (it is always zero)
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> Cc: Johannes Segitz <jsegitz@suse.de>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/procattr.c | 147 +++++++++++++-------------------------
>  1 file changed, 50 insertions(+), 97 deletions(-)
>
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index 142fbf3a80e0..6f4cfb82479d 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -11,11 +11,14 @@
>
>  #define UNSET (char *) -1
>
> +/* Cached values so that when a thread calls set*con() then gen*con(), the value
> + * which was set is directly returned.
> + */
>  static __thread char *prev_current = UNSET;
> -static __thread char * prev_exec = UNSET;
> -static __thread char * prev_fscreate = UNSET;
> -static __thread char * prev_keycreate = UNSET;
> -static __thread char * prev_sockcreate = UNSET;
> +static __thread char *prev_exec = UNSET;
> +static __thread char *prev_fscreate = UNSET;
> +static __thread char *prev_keycreate = UNSET;
> +static __thread char *prev_sockcreate = UNSET;
>
>  static pthread_once_t once = PTHREAD_ONCE_INIT;
>  static pthread_key_t destructor_key;
> @@ -111,43 +114,18 @@ out:
>         return fd;
>  }
>
> -static int getprocattrcon_raw(char ** context,
> -                             pid_t pid, const char *attr)
> +static int getprocattrcon_raw(char **context, pid_t pid, const char *attr,
> +                             const char *prev_context)
>  {
>         char *buf;
>         size_t size;
>         int fd;
>         ssize_t ret;
>         int errno_hold;
> -       char * prev_context;
>
>         __selinux_once(once, init_procattr);
>         init_thread_destructor();
>
> -       switch (attr[0]) {
> -               case 'c':
> -                       prev_context = prev_current;
> -                       break;
> -               case 'e':
> -                       prev_context = prev_exec;
> -                       break;
> -               case 'f':
> -                       prev_context = prev_fscreate;
> -                       break;
> -               case 'k':
> -                       prev_context = prev_keycreate;
> -                       break;
> -               case 's':
> -                       prev_context = prev_sockcreate;
> -                       break;
> -               case 'p':
> -                       prev_context = NULL;
> -                       break;
> -               default:
> -                       errno = ENOENT;
> -                       return -1;
> -       }
> -
>         if (prev_context && prev_context != UNSET) {
>                 *context = strdup(prev_context);
>                 if (!(*context)) {
> @@ -194,13 +172,13 @@ static int getprocattrcon_raw(char ** context,
>         return ret;
>  }
>
> -static int getprocattrcon(char ** context,
> -                         pid_t pid, const char *attr)
> +static int getprocattrcon(char **context, pid_t pid, const char *attr,
> +                         const char *prev_context)
>  {
>         int ret;
>         char * rcontext;
>
> -       ret = getprocattrcon_raw(&rcontext, pid, attr);
> +       ret = getprocattrcon_raw(&rcontext, pid, attr, prev_context);
>
>         if (!ret) {
>                 ret = selinux_raw_to_trans_context(rcontext, context);
> @@ -210,45 +188,24 @@ static int getprocattrcon(char ** context,
>         return ret;
>  }
>
> -static int setprocattrcon_raw(const char * context,
> -                             pid_t pid, const char *attr)
> +static int setprocattrcon_raw(const char *context, const char *attr,
> +                             char **prev_context)
>  {
>         int fd;
>         ssize_t ret;
>         int errno_hold;
> -       char **prev_context, *context2 = NULL;
> +       char *context2 = NULL;
>
>         __selinux_once(once, init_procattr);
>         init_thread_destructor();
>
> -       switch (attr[0]) {
> -               case 'c':
> -                       prev_context = &prev_current;
> -                       break;
> -               case 'e':
> -                       prev_context = &prev_exec;
> -                       break;
> -               case 'f':
> -                       prev_context = &prev_fscreate;
> -                       break;
> -               case 'k':
> -                       prev_context = &prev_keycreate;
> -                       break;
> -               case 's':
> -                       prev_context = &prev_sockcreate;
> -                       break;
> -               default:
> -                       errno = ENOENT;
> -                       return -1;
> -       }
> -
>         if (!context && !*prev_context)
>                 return 0;
>         if (context && *prev_context && *prev_context != UNSET
>             && !strcmp(context, *prev_context))
>                 return 0;
>
> -       fd = openattr(pid, attr, O_RDWR | O_CLOEXEC);
> +       fd = openattr(0, attr, O_RDWR | O_CLOEXEC);
>         if (fd < 0)
>                 return -1;
>         if (context) {
> @@ -279,8 +236,8 @@ out:
>         }
>  }
>
> -static int setprocattrcon(const char * context,
> -                         pid_t pid, const char *attr)
> +static int setprocattrcon(const char *context, const char *attr,
> +                         char **prev_context)
>  {
>         int ret;
>         char * rcontext;
> @@ -288,62 +245,58 @@ static int setprocattrcon(const char * context,
>         if (selinux_trans_to_raw_context(context, &rcontext))
>                 return -1;
>
> -       ret = setprocattrcon_raw(rcontext, pid, attr);
> +       ret = setprocattrcon_raw(rcontext, attr, prev_context);
>
>         freecon(rcontext);
>
>         return ret;
>  }
>
> -#define getselfattr_def(fn, attr) \
> +#define getselfattr_def(fn, attr, prev_context) \
>         int get##fn##_raw(char **c) \
>         { \
> -               return getprocattrcon_raw(c, 0, #attr); \
> +               return getprocattrcon_raw(c, 0, attr, prev_context); \
>         } \
>         int get##fn(char **c) \
>         { \
> -               return getprocattrcon(c, 0, #attr); \
> +               return getprocattrcon(c, 0, attr, prev_context); \
>         }
>
> -#define setselfattr_def(fn, attr) \
> +#define setselfattr_def(fn, attr, prev_context) \
>         int set##fn##_raw(const char * c) \
>         { \
> -               return setprocattrcon_raw(c, 0, #attr); \
> +               return setprocattrcon_raw(c, attr, &prev_context); \
>         } \
>         int set##fn(const char * c) \
>         { \
> -               return setprocattrcon(c, 0, #attr); \
> +               return setprocattrcon(c, attr, &prev_context); \
>         }
>
> -#define all_selfattr_def(fn, attr) \
> -       getselfattr_def(fn, attr)        \
> -       setselfattr_def(fn, attr)
> +#define all_selfattr_def(fn, attr, prev_context) \
> +       getselfattr_def(fn, attr, prev_context)  \
> +       setselfattr_def(fn, attr, prev_context)
>
> -#define getpidattr_def(fn, attr) \
> -       int get##fn##_raw(pid_t pid, char **c)  \
> -       { \
> -               if (pid <= 0) { \
> -                       errno = EINVAL; \
> -                       return -1; \
> -               } else { \
> -                       return getprocattrcon_raw(c, pid, #attr); \
> -               } \
> -       } \
> -       int get##fn(pid_t pid, char **c)        \
> -       { \
> -               if (pid <= 0) { \
> -                       errno = EINVAL; \
> -                       return -1; \
> -               } else { \
> -                       return getprocattrcon(c, pid, #attr); \
> -               } \
> -       }
> +all_selfattr_def(con, "current", prev_current)
> +    getselfattr_def(prevcon, "prev", NULL)
> +    all_selfattr_def(execcon, "exec", prev_exec)
> +    all_selfattr_def(fscreatecon, "fscreate", prev_fscreate)
> +    all_selfattr_def(sockcreatecon, "sockcreate", prev_sockcreate)
> +    all_selfattr_def(keycreatecon, "keycreate", prev_keycreate)
>
> -all_selfattr_def(con, current)
> -    getpidattr_def(pidcon, current)
> -    getselfattr_def(prevcon, prev)
> -    all_selfattr_def(execcon, exec)
> -    all_selfattr_def(fscreatecon, fscreate)
> -    all_selfattr_def(sockcreatecon, sockcreate)
> -    all_selfattr_def(keycreatecon, keycreate)
> +int getpidcon_raw(pid_t pid, char **c)
> +{
> +       if (pid <= 0) {
> +               errno = EINVAL;
> +               return -1;
> +       }
> +       return getprocattrcon_raw(c, pid, "current", NULL);
> +}
>
> +int getpidcon(pid_t pid, char **c)
> +{
> +       if (pid <= 0) {
> +               errno = EINVAL;
> +               return -1;
> +       }
> +       return getprocattrcon(c, pid, "current", NULL);
> +}
> --
> 2.36.1
>
