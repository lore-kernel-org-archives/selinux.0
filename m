Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42C5C433E1
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE1820838
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="o0AGEyMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgHXN43 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXN43 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:56:29 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4EAC061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:56:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a26so12053653ejc.2
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTZ1o4Ab3wtaiH7vG3sb9QfrERYiubeXWBWnrtWNoaw=;
        b=o0AGEyMWVlGCd1k3rG/s7V/ToRWcdorlCusMjgdhp8eV7IStb85NukK/f0gnrryiSb
         /e78G/VQuoMKJ+QprBNgnVXLvC2gBC9ZcXjVcX1MOYayhyLaJLAE7z0UxFhynkXZLiT0
         H6p+JqPwNdaM5Jm5qeZOPDRW1k8iFk0Zmd6D0ASQv953cMD+d3jQyx1KJFYuoJyq9TFR
         84FUmikF1tYCYdlMYtqsoQsddaX1vacznDPFKp2IwmlMvMUEnH/ziG584m4GuEqpVX/C
         REYy447UN99O8VmtERkbL0WiQqMZ9XXVtauLAzoqPPtyvYX2ZoVB4PApaRWsjYm31xXk
         1UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTZ1o4Ab3wtaiH7vG3sb9QfrERYiubeXWBWnrtWNoaw=;
        b=Fwcd+ccy5+aBaURVuJWZGq8Kye38hgzhVCl7rGCozUaJXN0rFHlZeffe9VsE5AV5cM
         VHLAb+YK21vfa+jK1yqx0aO9Drr3RcR29oakdp8OKv73ansCf9PCUWF7fEMid+oJraiE
         LbdRZCAEaAa7unMp2TRCphsGYHueNPUGZKNPwymBzthpIjEdJunCCXyM6RhiHRAPjHy/
         JKwYlGVxZvJhFrxJFxbhGTBlcpklZ2L+BLslTO7OHvgZ/qNJ7JXOhlHdjunzPWYbaNza
         b9D+OP8jM/D6s93NmpDax+fgX+M9eOZuI4mRI6TmhxDbFQzr6t0e0ei0AxxgG3yEof2P
         XZYw==
X-Gm-Message-State: AOAM531pbiNKn1cf9YR7OopEaW+3pzPhbe/UYltnjyHNjuYELisRU1Ux
        b+NSrJJdxk7lI8D3r5auGjbHFCLMhUJf/ixAJ1wu
X-Google-Smtp-Source: ABdhPJyTRc53X8h2j3MSdnsUgmlw85deK155yifPMySxIeVbhDEQJZCqd7SrQ4UeqhuaMmN1awSuGej16vsY8biTW/M=
X-Received: by 2002:a17:906:c1d8:: with SMTP id bw24mr5582405ejb.91.1598277386747;
 Mon, 24 Aug 2020 06:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200811132941.4942-1-toiwoton@gmail.com>
In-Reply-To: <20200811132941.4942-1-toiwoton@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Aug 2020 09:56:15 -0400
Message-ID: <CAHC9VhSXNARoV-MmyYrqoWhf7RtM3ZcRJ8AAwQJ6j8q+r-hMWA@mail.gmail.com>
Subject: Re: [PATCH v5] Improve network_support.md
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 11, 2020 at 9:29 AM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> List all access control methods available for networking and provide
> examples for each.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
>
> ---
> v2: address comments from Richard Haines
> v3: address comments from Paul Moore
> v4: address further comments from Paul Moore
> v5: address comments from bauen1
> ---
>  src/network_statements.md |   2 +-
>  src/network_support.md    | 240 +++++++++++++++++++++++++++++++++-----
>  2 files changed, 215 insertions(+), 27 deletions(-)

Thanks for your patience and continued work on this topic in the
notebook, I really appreciate it.

I think we could probably keep going back and forth with edits,
tweaks, etc. on this, but I think the current version is a definite
improvement as it currently stands so went ahead and merged it.  If
anyone has any additional tweaks please make them against the existing
main branch.

Thanks!

-- 
paul moore
www.paul-moore.com
