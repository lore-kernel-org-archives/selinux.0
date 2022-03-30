Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E6BC433FE
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 15:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348062AbiC3PS7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348130AbiC3PST (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 11:18:19 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BD81480F2
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 08:16:33 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t21so17472730oie.11
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ctLAFJP74QSx1OjJbRAQDli0eWzSCOSfiPZsyqmZXA=;
        b=KoSyx7CQyCVTYVtGQY/5PpDcfRuZjVttAcvM9x+DpZ9SViirrgUyRzd3qevj5KaAXk
         bfTA5bQhwJSrXV/IxBlp+FV1Jt2RoBncFo01zEGjoyBYJbDlWE+ZVdVlZztkE2ThmvfS
         Gx8AfaG+Un6i8WGRUy1AfDu3RDfLVKudwtPPiSVbcFAhDrlo7hobIjciJISOX0g/Cpm6
         Q2JeeXwL4AjxBEfO3hvxLE1Fr5ykV5eHluEcRVX/Ir7ZXsPUYGmPn/w7NumzoWblqeQo
         yqjy6vNvFj4wOXypC9c/v5ISbrTLb5V1LnlnhmNyQ+Lz4MawbNQkVBsuYfPLPNal3o9f
         Q6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ctLAFJP74QSx1OjJbRAQDli0eWzSCOSfiPZsyqmZXA=;
        b=SdrDnfoK1JtcRujCDZ54oI3SAZJnO0VeGrOuTelrxjinrRuLCXUPGw5bpRgC7OhLyL
         thpnZvWNJbzLx2bmUPQt9PlCYWe5CdHd7UcuMjEkP7ydqVfZ76TipKDr38Pt4REJhHx7
         9jzNx3fJ9o5U4szuLKcuy+cSDTmFoOWocG/QS/J9hJcLoSMQC9bBIxVc1E/leRNZzPD9
         Qck1vw70N1yogbPAM5M/3w8gvfTFMvxo/LuPGzB+ZOgoyMCfs+0XYhMs1AD4FAi84MNg
         F4BoNT1FbyMBMjJIUAQV5oaBSfcHhP1iWcEppgFtUHNJ3VCViDRYQjRGo3zhKNEz9VNy
         tTng==
X-Gm-Message-State: AOAM533c1dD935QuTMT24zabMiVBLDEV1Agsanl8MBfwNid4O9WtSOlx
        L/zTUWkWh8oYH+wePxyMfLWwpSPpLCHHSBJxDK8=
X-Google-Smtp-Source: ABdhPJybk1BYaofVB3xIiDPUm/uxglitEtfmf6D54S3bfAVv49fR6C/oq/I9XYFAKhsWTjOoKX3FU3ezPPJ5DmGe8Vc=
X-Received: by 2002:a05:6808:210b:b0:2d9:a6d3:b029 with SMTP id
 r11-20020a056808210b00b002d9a6d3b029mr60208oiw.182.1648653393040; Wed, 30 Mar
 2022 08:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <87pmm43dfc.fsf@redhat.com>
In-Reply-To: <87pmm43dfc.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 30 Mar 2022 11:16:21 -0400
Message-ID: <CAP+JOzTnOW9A7iyDeysC6pNcZA9sAqJxP1UhMYJx3-Umk6R3Ag@mail.gmail.com>
Subject: Re: Lets start with 3.4 userspace release
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 29, 2022 at 3:06 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Hello,
>
> after 142 commits and 5 months since last SELinux userspace release,
> it's time to think about another release.
>
> The current backlog of patches is bellow. Please take a look.
>
> This time, I'd like to release rcX every 14 days -
> rc1 - 04-06-2022
> rc2 - 04-20-2022
> ...
>
> I'll try send patches with the release number change on Mondays before every
> release.
>
>
> Also when rc1 is out, please consider postponing non-bugfix patches
> after the release or provide a comment that the change is not necessary
> for this release.
>
>
>
> * https://patchwork.kernel.org/patch/12617693/ New [v2] Support static-only builds
>
> - v2 of https://lore.kernel.org/selinux/87lf1scgd6.fsf@alyssa.is/
> - waits for another review
>
> * https://patchwork.kernel.org/patch/12639767/ New libsepol: free ebitmap on end of function
>
This is part of the notself patches which will not be ready for this release.

> * https://patchwork.kernel.org/project/selinux/list/?series=590259 add not-self neverallow support
>
Still working, but not for this release.

> * https://patchwork.kernel.org/patch/12672523/ New [v2] secilc: kernel policy language is infix
>
This one fell off my radar. I can ack and merge it.

> * https://patchwork.kernel.org/project/selinux/list/?series=604679  libsepol: Adding support for not-self rules
>
Still working, but not for this release.

> * https://patchwork.kernel.org/patch/12718352/ New [libselinux] libselinux: make threadsafe for discover_class_cache
>
> * https://patchwork.kernel.org/patch/12726783/ New libselinux: Prevent cached context giving wrong results
>
> * https://patchwork.kernel.org/project/selinux/list/?series=616731 libsepol: add sepol_av_perm_to_string |
>
> """
> Since most of these functions are used in either checkpolicy or
> audit2why (or both), it is probably fine to export these, but I would
> appreciate any thoughts that Chris and others might have.
> """
>
I need to think about this one.

> * https://patchwork.kernel.org/patch/12775701/ New libsepol/cil: Write a message when a log message is truncated
>
I will merge this.

> * https://patchwork.kernel.org/patch/12780657/ New libsepol: Use calloc when initializing bool_val_to_struct array
>
I will merge this.

> * https://patchwork.kernel.org/patch/12783189/ New libsepol: Validate conditional expressions
>
I will merge this.

> * https://patchwork.kernel.org/patch/12790631/ New [v3] libsemanage: Fall back to semanage_copy_dir when rename() fails
>
I don't know if Ondrej was planning on ack'ing it, but it seems like
he is satisfied.

Jim


>
>
> Petr
>
