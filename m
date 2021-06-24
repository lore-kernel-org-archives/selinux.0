Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F1DC49EA6
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 14:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C686611CB
	for <selinux@archiver.kernel.org>; Thu, 24 Jun 2021 14:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFXOdX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 24 Jun 2021 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhFXOdW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 24 Jun 2021 10:33:22 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDF7C061574
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 07:31:03 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id u11so7557372oiv.1
        for <selinux@vger.kernel.org>; Thu, 24 Jun 2021 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYUbeOsL3R/6X7xbHipEk9QxBl6JMfEXNY/6DxfBgL4=;
        b=bbBm5W8bl2Ir/HtFT3lBsqv+/BZS+JBa4YO/o7hccwgpTHp2YijqId8r65HmX/YmxB
         /cEW2golSujgaV9TaWODvE9ZpPWkd3ECZxOc7EdhpYjRvIp00B4cyAji6IMoJlGwFj4D
         ziQ16r6f6Rh0JiRnp4uXl9GcU/r2bxPlLD5aUtVQEnE3ajYTvHyDyZTC40pX2QUR5og2
         JGSWSX55yBzBq79lWrlgoJZCmrp3QcGaihDl8+1P/L/9OVRs3i0obIQpAjvADD9gQG4C
         8BNcaE1hccIbSLTQtGCPaPEdj27h9qMvmNJ4ic3/k3xtZdrQvDjYf4GGJ0TRlK740B6o
         mGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYUbeOsL3R/6X7xbHipEk9QxBl6JMfEXNY/6DxfBgL4=;
        b=tu0vDp4vuGDEBcztlhhQNtl2QLAJpcn1fEcuQK1K2MGtHg79J2IY/3KUdMtEuv5i9l
         hm5C12yBFazVRZljp+ZtfTJhhtkor1CKkb2jJZBQ3ojjvL0sU9TQ2ts7veO4wQiYw65p
         QRiZ6kOwMXRJp9Km2HDkocaidz2bREtW6+GQS60VhK4ugkKaVhrM0feCsOGpowT40akT
         xUwqzDzBfDg+pQvoKnjRkzauzavSO9v+IjdS+CXX/ZLM9PcaqFf72XbaZT9k0dVqZHnk
         nRk70HNpEWWsBMRc6JHUliM7N7LoO5LVsrNNvK6CcjiVgXvaBdsnrij7vCSnELJUzpad
         ksHQ==
X-Gm-Message-State: AOAM532INB9SJ1T7vFqcll1KMgxnLRbfIOd7Rn8NHY7kAUcpvP9KFrJS
        lhjtLM6gHi1YHkFX+VTQKD9P7Ivpse8BFNUdQWMBW6UFT6Q=
X-Google-Smtp-Source: ABdhPJx/6wqNQusX2vDQMG5avJZCK7CHS76+q777xRLtr7NNKmZP/tuWzS5Cga7Q2oshaj8mDwy7zbujVT8UUE0exk8=
X-Received: by 2002:aca:1c0d:: with SMTP id c13mr7683931oic.128.1624545063286;
 Thu, 24 Jun 2021 07:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210621191833.282874-1-jwcart2@gmail.com> <CAJfZ7=moLtL4fneXKXFRe_nuy4i4wXDjwUAhwG3jDsvSN2HDTQ@mail.gmail.com>
In-Reply-To: <CAJfZ7=moLtL4fneXKXFRe_nuy4i4wXDjwUAhwG3jDsvSN2HDTQ@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 24 Jun 2021 10:30:52 -0400
Message-ID: <CAP+JOzQyStqG1W4VpQj0U+nX83JN5bbeJJxc9LWmv+m3o-OH5w@mail.gmail.com>
Subject: Re: [PATCH 0/5 v2] Another round of secilc-fuzzer problems fixed
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 23, 2021 at 3:32 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Mon, Jun 21, 2021 at 9:18 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > Patch 1 fixes the check for self-referential loops that didn't work in all cases
> > Patches 2 and 3 fix a couple of bugs
> > Patches 4 and 5 make it harder to create small policies that expand into large
> > policies that consume all of a system's memory.
> >
> > Only patches 2 and 5 are changed in v2.
> >
> > James Carter (5):
> >   libsepol/cil: Properly check for loops in sets
> >   libsepol/cil: Fix syntax checking of defaultrange rule
> >   libsepol/cil: Check for empty list when marking neverallow attributes
> >   libsepol/cil: Reduce the initial symtab sizes for blocks
> >   libsepol/cil: Improve degenerate inheritance check
> >
> >  libsepol/cil/src/cil.c             |   2 +-
> >  libsepol/cil/src/cil_build_ast.c   |  10 ++
> >  libsepol/cil/src/cil_internal.h    |   5 +-
> >  libsepol/cil/src/cil_post.c        |   4 +
> >  libsepol/cil/src/cil_resolve_ast.c | 226 +++++++++++++++++++----------
> >  libsepol/cil/src/cil_verify.c      |  48 ++++--
> >  6 files changed, 198 insertions(+), 97 deletions(-)
> >
> > --
> > 2.26.3
>
> Hello,
>
> These patches look good to me:
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

This series has been merged.
Jim

> Thanks!
> Nicolas
>
