Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34EDC433F5
	for <selinux@archiver.kernel.org>; Thu, 20 Jan 2022 22:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378027AbiATWMw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Jan 2022 17:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378018AbiATWMv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Jan 2022 17:12:51 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5987DC061574
        for <selinux@vger.kernel.org>; Thu, 20 Jan 2022 14:12:51 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id x21-20020a4a2a55000000b002ddf492c201so2748165oox.6
        for <selinux@vger.kernel.org>; Thu, 20 Jan 2022 14:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhJuQFSXqtxGoWbjCo5HCzT7wEijicueRoZXbefKNv4=;
        b=iVcVs+uLbn+pKZauS8A9tVrtZaCsiPjmdIbMll6f2/8xkrpVIyf4EXeJ7tttVEhzF4
         De2QljTkO3+4M3frpBBg1+fACUGNlIJvzRxkChadE0OO1RUkcmfxyHvKKBiaCAfWGOOc
         jtFUip7xdYmJ/O3zluW9Yil46SSD4lHc52Mr9Ukp54H1sF0Q6gfunIXJ1a4/8npF5EDm
         18w9zoVt5rp/x38zxyDutY+Qv4f9ksqe+MG9lEjsLD/1fDD/URSuLfmdrl5uOnY9m4nl
         Gx/oa6cAAd5fYuGjyj0cP4fPXj34MvnchMOzWpHfUwHUIW2hvtUSPhTBjmKeFVWkvY96
         1QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhJuQFSXqtxGoWbjCo5HCzT7wEijicueRoZXbefKNv4=;
        b=OF5BAhsX0Vw0l9tmyh463x8h40FAkzlK7ouNJ/9rj4Rd4z9LWMf9V67ivQCYpNVagH
         4hGKTiTvfxCKAwfjB2kdu0In+vXlWmSmTJK53a02LgNDLjOIyI0V2v+3rRumAXQvChpK
         zkSQIoulRPW6HrenF/Eo/oHrGu1xYRQR4JBe/63eXgZoWG4ULMh2mQMYnvi9LisuKDkJ
         xGyA92EFgK6fLBWIgSoFs11t6MerxluNZ4Y7gP9QXSquNjNCkrLNjT1cL96AiBWY+JTE
         pyoe/cxuHucxPf1JszXFAF9J1nQ2GR5tYloTavn7rUywlm0ruvGI3lDGj3gK8jwoGvxg
         xLEg==
X-Gm-Message-State: AOAM530+NV0jTmD9swZBcQwvy3trWCzEbYhDNeSvUHz1sTGZkW36D6c9
        EsdCeGe3OLyXzVVPLj7gMVBTHk3ZgQ22DXABJGTjL3vl
X-Google-Smtp-Source: ABdhPJzI3GV+kGdcncgIJbDZZIdSPMz611lR79bUW13KOfTXR/yPUJ7Sx9cnEKuB+cV8U/17M02tgpmtyGWxj7ndW5Q=
X-Received: by 2002:a4a:b689:: with SMTP id v9mr708248ooo.50.1642716770727;
 Thu, 20 Jan 2022 14:12:50 -0800 (PST)
MIME-Version: 1.0
References: <20220113143935.195125-1-omosnace@redhat.com> <20220113143935.195125-6-omosnace@redhat.com>
In-Reply-To: <20220113143935.195125-6-omosnace@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 20 Jan 2022 17:12:40 -0500
Message-ID: <CAP+JOzQDn9yHjCf3FY6O1XmKuutj2D5WF8DjwBbCHwdOWqUr2w@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 5/5] semodule: add command-line option to
 detect module changes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 13, 2022 at 6:36 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Add a new command-line option "--smart" (for the lack of a better
> name...) to control the newly introduced check_ext_changes libsemanage
> flag.
>
> For example, running `semodule -B --smart` will ensure that any
> externally added/removed modules (e.g. by an RPM transaction) are
> reflected in the compiled policy, while skipping the most expensive part
> of the rebuild if no module change was deteceted since the last
> libsemanage transaction.
>

I tested "semodule -B" followed by "semodule -B --smart" and "semodule
-DB" followed by "semodule -DB --smart" and both worked as expected.

Thanks,
Jim


> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policycoreutils/semodule/semodule.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index a5b71fc4..638edb39 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -47,6 +47,7 @@ static int verbose;
>  static int reload;
>  static int no_reload;
>  static int build;
> +static int check_ext_changes;
>  static int disable_dontaudit;
>  static int preserve_tunables;
>  static int ignore_module_cache;
> @@ -149,6 +150,8 @@ static void usage(char *progname)
>         printf("  -c, --cil extract module as cil. This only affects module extraction.\n");
>         printf("  -H, --hll extract module as hll. This only affects module extraction.\n");
>         printf("  -m, --checksum   print module checksum (SHA256).\n");
> +       printf("      --smart      force policy rebuild if module content changed since\n"
> +              "                   last rebuild (based on checksum)\n");
>  }
>
>  /* Sets the global mode variable to new_mode, but only if no other
> @@ -180,6 +183,7 @@ static void set_mode(enum client_modes new_mode, char *arg)
>  static void parse_command_line(int argc, char **argv)
>  {
>         static struct option opts[] = {
> +               {"smart", 0, NULL, '\0'},
>                 {"store", required_argument, NULL, 's'},
>                 {"base", required_argument, NULL, 'b'},
>                 {"help", 0, NULL, 'h'},
> @@ -207,15 +211,26 @@ static void parse_command_line(int argc, char **argv)
>         };
>         int extract_selected = 0;
>         int cil_hll_set = 0;
> -       int i;
> +       int i, longind;
>         verbose = 0;
>         reload = 0;
>         no_reload = 0;
> +       check_ext_changes = 0;
>         priority = 400;
>         while ((i =
> -               getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cHm", opts,
> -                           NULL)) != -1) {
> +               getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cHm",
> +                           opts, &longind)) != -1) {
>                 switch (i) {
> +               case '\0':
> +                       switch(longind) {
> +                       case 0: /* --smart */
> +                               check_ext_changes = 1;
> +                               break;
> +                       default:
> +                               usage(argv[0]);
> +                               exit(1);
> +                       }
> +                       break;
>                 case 'b':
>                         fprintf(stderr, "The --base option is deprecated. Use --install instead.\n");
>                         set_mode(INSTALL_M, optarg);
> @@ -813,6 +828,8 @@ cleanup_disable:
>                         semanage_set_reload(sh, 0);
>                 if (build)
>                         semanage_set_rebuild(sh, 1);
> +               if (check_ext_changes)
> +                       semanage_set_check_ext_changes(sh, 1);
>                 if (disable_dontaudit)
>                         semanage_set_disable_dontaudit(sh, 1);
>                 else if (build)
> --
> 2.34.1
>
