Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1D2C5519F
	for <selinux@archiver.kernel.org>; Fri, 13 Nov 2020 00:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C20120B80
	for <selinux@archiver.kernel.org>; Fri, 13 Nov 2020 00:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="iEQ9zYRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgKMAy0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 12 Nov 2020 19:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKMAy0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 12 Nov 2020 19:54:26 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31DC0613D1
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 16:54:26 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id s25so10826960ejy.6
        for <selinux@vger.kernel.org>; Thu, 12 Nov 2020 16:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEcJp8+cYPFqd4RZa++b11FMH3Sp/vorN9mj3J18H9Y=;
        b=iEQ9zYRtzGDqmcaa/3aNzf1CXxc15ZuofXAmqk8gnn6LWiGB5FcJ/3GWYzSMIEUX7N
         szRByzkW0GvvdauRo7xgaRFHEAi95i5g2kT6UuHtjma+k7OCMztyaeODTrJf+1iaG8m/
         CRt7QMRva6lb7qqp+zwgM6HMMsnHs8m94KY4VeuUVKr3ujEhNPFHFa2P5gZVtGDSPKJc
         /FwSK2Oufk2RgYCtFuzej2QjLHKx8x+wxv+XUQI0tjgPXe7j5zQkJB9F7ZtStDbIUnQV
         tUiNawmj3ih6duyLMC3Z+ywt1i9tHYXh0kxInKxUsPyBaPoYzSS3V3U7JzZA8dqtzyo1
         ZyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEcJp8+cYPFqd4RZa++b11FMH3Sp/vorN9mj3J18H9Y=;
        b=i5CQHm5gLczB6AGWK/Kpe0a048vVfLZfD1xlKQVvV0qKyEBUUl/nwA46ONpvWnZ0op
         hIizjfnz/necOAE2vtkHDmXLSG04WvOWwW9h6AXP7totMr3W08l3bmVa7BfwyyGoPv9k
         bW7j5W0zTAc2mTHLu681kUQx/rp7STrVBJOgO11TPu6gkk4c/aIlZZdOeCoCuJA8rpbC
         b0coqU1JKNPLxyH0HB3cHlD+ApekppzSF7/RzutBEtkq1wD05o3nyYDF44fl29lEsomh
         yIxJcCrcpBRt8jvbSiiWtPm6QjTOEZLZa6EOhEA+tmswRFAKjZtR9CI88/sQrdL1FtdF
         1gAw==
X-Gm-Message-State: AOAM533jpWVCdQHjOlDL6dkZRz1h5cD6RqQQ+R9VMPLrQvHkAkLktLWc
        BUtbTBQCZ2dQXiaAdSKkzi/mI4oyL0PqD/qTMqDw
X-Google-Smtp-Source: ABdhPJxy1IteUdr4V/BP9b+TBvWUeLrDVlCjI7ZlGBX7atMdIc9b/nYXLN/FIZCQ8BOENtmik4yYky4vMU4nyMp/thk=
X-Received: by 2002:a17:906:114b:: with SMTP id i11mr1965820eja.106.1605228865122;
 Thu, 12 Nov 2020 16:54:25 -0800 (PST)
MIME-Version: 1.0
References: <20201104120110.886431-1-omosnace@redhat.com>
In-Reply-To: <20201104120110.886431-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 12 Nov 2020 19:54:14 -0500
Message-ID: <CAHC9VhTqz7ao0o5Nn36yLBe4ae-3FEOwpSZa82mje56_+u_oeA@mail.gmail.com>
Subject: Re: [PATCH] selinux: drop super_block backpointer from superblock_security_struct
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 4, 2020 at 7:01 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> It appears to have been needed for selinux_complete_init() in the past,
> but today it's useless.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/hooks.c          | 5 ++---
>  security/selinux/include/objsec.h | 1 -
>  2 files changed, 2 insertions(+), 4 deletions(-)

Merged into selinux/next, thanks!

-- 
paul moore
www.paul-moore.com
