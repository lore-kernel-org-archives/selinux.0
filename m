Return-Path: <SRS0=l4yV=AS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C676C433DF
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 15:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA3E2075B
	for <selinux@archiver.kernel.org>; Tue,  7 Jul 2020 15:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgOvu/zI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGGPng (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgGGPng (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jul 2020 11:43:36 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9E0C061755
        for <selinux@vger.kernel.org>; Tue,  7 Jul 2020 08:43:35 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 12so28723254oir.4
        for <selinux@vger.kernel.org>; Tue, 07 Jul 2020 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIJ+7M88+k2tjH1icMdmzrjMV/R4sy64TsFtfMvefeA=;
        b=cgOvu/zINUltItkW9i4ayHs8U/x21JfnvngY+F6leWHhTurlpaxGKSdA4UW+RRcexO
         h2OLxEgJzSkJUeexa0lw0I6yXNx9L9sT0gv8CulJrBiLztA2qd+FYgI7xUcARqAXnuHW
         wecNcaNUpfyuYjGHxnq3NqrrwuP8HcmR59w4NY7h4CEqdim7qhQrXXLBzF4nmptb1hW/
         7k/vFrMwW2dEdExQaSe2b/GqeyJyfDKVvX8OREUkiVGJcMy8pYogcobfRcQJf93JnUpi
         hQGZwLSA5V15dbLFlLy/M9NTDR6wyB/qS30lK0yLYuce3xCHTeBanWx2quxXa14ZMSXn
         3gzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIJ+7M88+k2tjH1icMdmzrjMV/R4sy64TsFtfMvefeA=;
        b=uKuLy5vgucfYU/Oh8p2IFJbhm0ePSSeI7amg3ZLsC7vi60KCb6qmUX7qb5yOEbKtcO
         xJXNA0DIoUmNMXpwL8jSiBcy79l0JKnohEbMPXAkbSANl7/Lq0Z26rPuuXrzfDgkCdx+
         Bz70GI2IqoLlXcFsz9HqbqT3LyHoJZhuKiwixrSiHzvyEM84hNED7gkfkHdGga2pJj85
         yCRCZTOKrxz3VHZCoA2EOEDB/c2Eh8Z2AUni+9yLMEpBpDePwhmp0/ByvNoyd6uJ4Tc/
         XVnqjZt3pKiTwAbD9eKmiCTggyfMH50P5sF/c8J7YzDgIJUEFpIdyyrZq5Vufz6LgGjM
         sANg==
X-Gm-Message-State: AOAM531eH/NqbXh6cNtLOELYNiT/IZwt0VV+akMy85C8swv43ePDprDX
        n28QluVmuxSqhliI4NpRwhJdDCdgCjhh0SzPY7I=
X-Google-Smtp-Source: ABdhPJz55ZuuLF/E0ds5ChAQ/Sy7R0zXC1OlZ7ioVns7WJo9P8KAs8JFX3EFvWDIZheR1Zwk7qJZKOIOytbXN/gjt6A=
X-Received: by 2002:aca:c4cc:: with SMTP id u195mr3548203oif.160.1594136615343;
 Tue, 07 Jul 2020 08:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200707143501.670785-1-antoine.tenart@bootlin.com>
In-Reply-To: <20200707143501.670785-1-antoine.tenart@bootlin.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 7 Jul 2020 11:43:24 -0400
Message-ID: <CAEjxPJ6_447nPv__1cfcDzj9ybqbaPzTn1Pn3e-JKT0op5578w@mail.gmail.com>
Subject: Re: [PATCH v2] policycoreutils: setfiles: do not restrict checks
 against a binary policy
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        matthew.weber@rockwellcollins.com, thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 7, 2020 at 10:35 AM Antoine Tenart
<antoine.tenart@bootlin.com> wrote:
>
> The -c option allows to check the validity of contexts against a
> specified binary policy. Its use is restricted: no pathname can be used
> when a binary policy is given to setfiles. It's not clear if this is
> intentional as the built-in help and the man page are not stating the
> same thing about this (the man page document -c as a normal option,
> while the built-in help shows it is restricted).
>
> When generating full system images later used with SELinux in enforcing
> mode, the extended attributed of files have to be set by the build
> machine. The issue is setfiles always checks the contexts against a
> policy (ctx_validate = 1) and using an external binary policy is not
> currently possible when using a pathname. This ends up in setfiles
> failing early as the contexts of the target image are not always
> compatible with the ones of the build machine.
>
> This patch reworks a check on optind only made when -c is used, that
> enforced the use of a single argument to allow 1+ arguments, allowing to
> use setfiles with an external binary policy and pathnames. The following
> command is then allowed, as already documented in the man page:
>
>   $ setfiles -m -r target/ -c policy.32 file_contexts target/
>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
