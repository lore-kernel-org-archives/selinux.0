Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F89BC433F5
	for <selinux@archiver.kernel.org>; Sat, 16 Oct 2021 18:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38CFC61152
	for <selinux@archiver.kernel.org>; Sat, 16 Oct 2021 18:43:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244579AbhJPSp3 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sat, 16 Oct 2021 14:45:29 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:36310 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244569AbhJPSpZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 16 Oct 2021 14:45:25 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 45B915605C4
        for <selinux@vger.kernel.org>; Sat, 16 Oct 2021 20:43:15 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id t21so476436plr.6
        for <selinux@vger.kernel.org>; Sat, 16 Oct 2021 11:43:15 -0700 (PDT)
X-Gm-Message-State: AOAM533SDEZzfqZWVj4PEZebcLBpQPNXHJTZivqiEQExbbdGJ9VXdG9d
        jR36XbKCn/dnw/+M1x123kR8X8+sgwpq/ZsNtRU=
X-Google-Smtp-Source: ABdhPJz0zkkcTGLdDM7cHOUsgFum+JPbOXWoW8xp00q7aMZ01O9jVqceiqNJWL5v5arO4DreITBhiHXFRNuDPyFvMTo=
X-Received: by 2002:a17:902:e843:b0:13f:2212:d64c with SMTP id
 t3-20020a170902e84300b0013f2212d64cmr17848758plg.16.1634409793669; Sat, 16
 Oct 2021 11:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20211015123100.15785-1-cgzones@googlemail.com>
In-Reply-To: <20211015123100.15785-1-cgzones@googlemail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sat, 16 Oct 2021 20:43:02 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=nUJOScc+gSLd6xLouFm69iW9-a8WrvxCPZxCO34YABpQ@mail.gmail.com>
Message-ID: <CAJfZ7=nUJOScc+gSLd6xLouFm69iW9-a8WrvxCPZxCO34YABpQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: use dummy variable to silence glibc 2.34 warnings
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sat Oct 16 20:43:15 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 15, 2021 at 2:31 PM Christian Göttsche
<cgzones@googlemail.com> wrote:
>
> Glibc 2.34 added an access function attribute to pthread_setspecific(3).
> This leads to the following GCC warnings:
>
>     In file included from matchpathcon.c:5:
>     matchpathcon.c: In function ‘matchpathcon_init_prefix’:
>     selinux_internal.h:38:25: error: ‘pthread_setspecific’ expecting 1 byte in a region of size 0 [-Werror=stringop-overread]
>        38 |                         pthread_setspecific(KEY, VALUE);        \
>           |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     matchpathcon.c:359:9: note: in expansion of macro ‘__selinux_setspecific’
>       359 |         __selinux_setspecific(destructor_key, (void *)1);
>           |         ^~~~~~~~~~~~~~~~~~~~~
>     In file included from selinux_internal.h:2,
>                      from matchpathcon.c:5:
>     /usr/include/pthread.h:1167:12: note: in a call to function ‘pthread_setspecific’ declared with attribute ‘access (none, 2)’
>      1167 | extern int pthread_setspecific (pthread_key_t __key,
>           |            ^~~~~~~~~~~~~~~~~~~
>
> The actual value and the validity of the passed pointer is irrelevant,
> since it does not gets accessed internally by glibc and
> pthread_getspecific(3) is not used.
> Use a pointer to a (temporary) valid object to please GCC.
>
> Closes: https://github.com/SELinuxProject/selinux/issues/311
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/matchpathcon.c   | 4 +++-
>  libselinux/src/procattr.c       | 4 +++-
>  libselinux/src/setrans_client.c | 4 +++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
> index 1e7f8890..b0ec1e8b 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -352,11 +352,13 @@ static void matchpathcon_init_once(void)
>
>  int matchpathcon_init_prefix(const char *path, const char *subset)
>  {
> +       int dummy;
> +
>         if (!mycanoncon)
>                 mycanoncon = default_canoncon;
>
>         __selinux_once(once, matchpathcon_init_once);
> -       __selinux_setspecific(destructor_key, (void *)1);
> +       __selinux_setspecific(destructor_key, &dummy);
>
>         options[SELABEL_OPT_SUBSET].type = SELABEL_OPT_SUBSET;
>         options[SELABEL_OPT_SUBSET].value = subset;
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index 6552ee01..24cee323 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -68,7 +68,9 @@ void  __attribute__((destructor)) procattr_destructor(void)
>  static inline void init_thread_destructor(void)
>  {
>         if (destructor_initialized == 0) {
> -               __selinux_setspecific(destructor_key, (void *)1);
> +               int dummy;
> +
> +               __selinux_setspecific(destructor_key, &dummy);
>                 destructor_initialized = 1;
>         }
>  }
> diff --git a/libselinux/src/setrans_client.c b/libselinux/src/setrans_client.c
> index 52a8ba78..515d2d4d 100644
> --- a/libselinux/src/setrans_client.c
> +++ b/libselinux/src/setrans_client.c
> @@ -272,7 +272,9 @@ static inline void init_thread_destructor(void)
>         if (!has_setrans)
>                 return;
>         if (destructor_initialized == 0) {
> -               __selinux_setspecific(destructor_key, (void *)1);
> +               int dummy;
> +
> +               __selinux_setspecific(destructor_key, &dummy);
>                 destructor_initialized = 1;
>         }
>  }
> --
> 2.33.0
>

Hello,
Thanks for working on this. While this patch fixes the precise
warning, I fear that future improvements on the analysis performed by
compilers (or by static analysis tools) will lead to future warnings,
as we are still abusing the pthread_setspecific interface after your
patch: "dummy" is not initialized (so a tool could report a "use of
uninitialized variable"), and is destroyed after the scope of the
functions (so a tool could report a "use after free" or a "use of a
stack pointer beyond its scope").

These issues can be fixed by making dummy "static char dummy;" for
example. What do you think?

Thanks,
Nicolas

