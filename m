Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45270C433F5
	for <selinux@archiver.kernel.org>; Sat, 15 Jan 2022 17:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiAORiM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 15 Jan 2022 12:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiAORiM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 15 Jan 2022 12:38:12 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1638C061574
        for <selinux@vger.kernel.org>; Sat, 15 Jan 2022 09:38:11 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id x193so17149997oix.0
        for <selinux@vger.kernel.org>; Sat, 15 Jan 2022 09:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uCB0bW5xJmfO6zyTjgShZI7Rdq2+zsCc29/NQ3e/Be8=;
        b=DdWQm7VAwgNp6YZU7bEVsOXs6lvrdmr5hqHO8KE0Vs+gAQzNMWJ6W1eWwo7G0eWI6t
         O5CWIO2LkOOywbUb+HL2rHyFi35aMx0SzOgVI4lESPHuhGwMN45mv4GFUcpK7Y7cLdtk
         VCzCj/oohONhLO03Ryi52XFyldCQGnlte2l2vVrtw9uf9v+en5dXD/aBIHTtO9TJXNh9
         DecDvz8crNMJ2bD0ddaCDNPgIlS95iSyFmA1wyCt1MwMc+0Q/q9hY4lkZwBQKMh0KZ/v
         f68cvS22krMmQ1riyDIMKni0bd4S0V1xEqkWdcaZ3ENl6Y3v9ekM4vSX4Dng6srHlLpf
         16mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uCB0bW5xJmfO6zyTjgShZI7Rdq2+zsCc29/NQ3e/Be8=;
        b=vU0YxdOA2HOsW2pRdhU2BcvgGZu/4qlfMVyuxL73tm6EXZcI2JPJ+TM8UWM0m5NOXR
         z1XWvyZCB4m7QHRX1/s+ANcgGdFPB2OPuUsosZFinp1R9irTGCT/c6zE8oTikAAJ+f+R
         n023PSS6OUxSsSAfX7VA+Lnu8oTL5xLBs3HJVyIgZzdjshY0gJpBxQ/1bA1JVxKcAp4n
         8Jd9NiC1IL9UnyfDkh5ZDLKCBGyvQ4cxu4dxrq1mDS+5GP/qkp8gdFhbTro5LtePDamz
         MAtodY360jK0lA0nA3Bfgc/NdZRVevOrutHb1Xdd9ndijGO9s6VDhE1COmBk0m14zJbE
         tTLw==
X-Gm-Message-State: AOAM530s8NJHo5Sa8Y4IVDlgmMH1twaY+DGxk2/9FBft9tNlRyBRJC9c
        P2wyGfB8lFQeUilZDrRu3M/CnPwjeTfOhJeHH5pIp7inkCA=
X-Google-Smtp-Source: ABdhPJw580iXiDtQxj3rvu2qxdqPkwgBWDSMwewA9TYWvkUTVg9NLXkl/EUFQCTloEdstmIiOabzOvWYymcJIz3tVkE=
X-Received: by 2002:a05:6808:130a:: with SMTP id y10mr11997150oiv.32.1642268291047;
 Sat, 15 Jan 2022 09:38:11 -0800 (PST)
MIME-Version: 1.0
References: <20220113143935.195125-1-omosnace@redhat.com> <20220113143935.195125-6-omosnace@redhat.com>
In-Reply-To: <20220113143935.195125-6-omosnace@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Sat, 15 Jan 2022 18:38:00 +0100
Message-ID: <CAJ2a_Det151ui=84of_0B8a8HazfkySeCmMGnRy5jwE5mkM7+A@mail.gmail.com>
Subject: Re: [RFC PATCH userspace 5/5] semodule: add command-line option to
 detect module changes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 13 Jan 2022 at 15:39, Ondrej Mosnacek <omosnace@redhat.com> wrote:
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

Some other naming suggestions:

incremental
on-update
on-change
changed-only
updated-only

Also maybe describe with `force policy rebuild only if ...`, cause
otherwise one might think without --smart modules are never rebuild.

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
