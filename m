Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9D8C433EF
	for <selinux@archiver.kernel.org>; Tue, 28 Jun 2022 21:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbiF1VHc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiF1VHa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Jun 2022 17:07:30 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402143A70A
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 14:07:29 -0700 (PDT)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 55A075647D4
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 23:01:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m4x.org; s=svoboda;
        t=1656450090; bh=NS84iI7MySItbb1XT/Jg8w18SCfvzqbTh4PRU5MZGzU=;
        h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc;
        b=02MBzSUob7anfZh3AVhdCUghmoFaODPhIG+CNPgFAEGs4POW8j1w7y6BamQdMWenZ
         qoRkeMO4c9Spm7Tt1v2dy77e6K8O+2yB9oK9D5GcvJvngMZ+azfCKvFzRzLD6NnWb0
         zWq9ccRcUN/Y1J2WrAwNJFpZZlsyD10Y2E7cNTo8=
Received: by mail-pl1-f179.google.com with SMTP id m14so12172219plg.5
        for <selinux@vger.kernel.org>; Tue, 28 Jun 2022 14:01:30 -0700 (PDT)
X-Gm-Message-State: AJIora8uUIk5YqM5t5gZ86jSskTGtkwia9XUIMGxZKEBQ/Gg50XGPz4Z
        N/Mbk7PHS3wI/F/johUegA9qVt1MWZzr5xluGvk=
X-Google-Smtp-Source: AGRyM1vj2P5lNC6ZXaEXYV+/lZUuY0gG5lH2f58Getl3FRmVoS7Pt3VYwt0bOpIOlmuRe5oTAaXWYVRx7j9uA2EAytQ=
X-Received: by 2002:a17:902:ea47:b0:16b:997b:5fd6 with SMTP id
 r7-20020a170902ea4700b0016b997b5fd6mr2234503plg.16.1656450089014; Tue, 28 Jun
 2022 14:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220608170954.114668-1-omosnace@redhat.com> <20220608170954.114668-2-omosnace@redhat.com>
In-Reply-To: <20220608170954.114668-2-omosnace@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 28 Jun 2022 23:01:17 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==gbwH8-SaNxEVRU0CCnP-HaDemC7GqhK9CmkYG+p05vA@mail.gmail.com>
Message-ID: <CAJfZ7==gbwH8-SaNxEVRU0CCnP-HaDemC7GqhK9CmkYG+p05vA@mail.gmail.com>
Subject: Re: [PATCH userspace 1/2] libsemanage: always write kernel policy
 when check_ext_changes is specified
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jun 28 23:01:30 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 8, 2022 at 7:23 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> For the use case of rebuilding the policy afte package updates, we need
> the check_ext_changes operation to always do at least the do_write_kernel
> step, because the various semanage dbs may have also changed content
> relative to the current binary policy. As this step is itself relatively
> fast, we can do it unconditionally.
>
> Fixes: 286a679fadc4 ("libsemanage: optionally rebuild policy when modules are changed externally")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Hello,
This patch and the next one ("semodule: rename
--rebuild-if-modules-changed to --refresh") look good to me. Has
anyone also taken a look at them?

If nobody objects, I will merge it tomorrow, with a small misspelling
fix in the commit message (afte -> after).

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

> ---
>  libsemanage/include/semanage/handle.h | 2 +-
>  libsemanage/src/direct_api.c          | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
> index 0157be4f..4cf30815 100644
> --- a/libsemanage/include/semanage/handle.h
> +++ b/libsemanage/include/semanage/handle.h
> @@ -67,7 +67,7 @@ extern void semanage_set_reload(semanage_handle_t * handle, int do_reload);
>  extern void semanage_set_rebuild(semanage_handle_t * handle, int do_rebuild);
>
>  /* set whether to rebuild the policy on commit when potential changes
> - * to module files since last rebuild are detected,
> + * to store files since last rebuild are detected,
>   * 1 for yes (default), 0 for no */
>  extern void semanage_set_check_ext_changes(semanage_handle_t * handle, int do_check);
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 7206483a..7aa081ab 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1437,13 +1437,15 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>          * Determine what else needs to be done.
>          * We need to write the kernel policy if we are rebuilding
>          * or if any other policy component that lives in the kernel
> -        * policy has been modified.
> +        * policy has been modified. We also want to force it when
> +        * check_ext_changes was specified as the various dbases may have
> +        * changes as well.
>          * We need to install the policy files if any of the managed files
>          * that live under /etc/selinux (kernel policy, seusers, file contexts)
>          * will be modified.
>          */
> -       do_write_kernel = do_rebuild | ports_modified | ibpkeys_modified |
> -               ibendports_modified |
> +       do_write_kernel = do_rebuild | sh->check_ext_changes |
> +               ports_modified | ibpkeys_modified | ibendports_modified |
>                 bools->dtable->is_modified(bools->dbase) |
>                 ifaces->dtable->is_modified(ifaces->dbase) |
>                 nodes->dtable->is_modified(nodes->dbase) |
> --
> 2.36.1
>

