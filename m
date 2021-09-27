Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88DEC433F5
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 09:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87AEE6058D
	for <selinux@archiver.kernel.org>; Mon, 27 Sep 2021 09:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhI0JFI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Sep 2021 05:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54429 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233526AbhI0JFI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Sep 2021 05:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632733410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KkR5t8MHnnhfS1IgvkgNF1o7IYRUfjfGbEHqCcahP2M=;
        b=GUtfEqYH5HBwsv28Izj0sUicoyVvNrpVCiS+kbvDpnWUAt3axs2m087rR7FGHQ5OMZDQsD
        Hdct50NOmF0q5VHNSvjUfFVksdgN1a9quTyVGGN4TLMCjYca2g470CS2pUr6h+YrqrJxki
        o9gQ67XU5VBuraPdHAdrACHu3qAr068=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-dMGJ1VvfP2KQ_cI_nrRMjw-1; Mon, 27 Sep 2021 05:03:28 -0400
X-MC-Unique: dMGJ1VvfP2KQ_cI_nrRMjw-1
Received: by mail-yb1-f199.google.com with SMTP id f8-20020a2585480000b02905937897e3daso14849867ybn.2
        for <selinux@vger.kernel.org>; Mon, 27 Sep 2021 02:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkR5t8MHnnhfS1IgvkgNF1o7IYRUfjfGbEHqCcahP2M=;
        b=p2bKxb02sWGlKBdJmrvNwKqNxTMJIxhRc6U16d/BrG2OEJIiaUGXmuRPv3HL8fxMpS
         H2YNRYnzUE8qwjDjC/WULVj982o0VGOVu3CSsKDY2ApDeesuP6WL+99MYmE5QVbHa9RH
         Sg0uoSI2E35ZzSvcJbTja7wJyb88FR5/Lz4f7IzCET1ZdOfoOxFoXMjDOigXPYa6+TCb
         BHI72lXVW6H/sAgY5uy+OYmhCOyPYbbGrtog8uT4AbHQTEqHVTYrzXSyqeU5cGHdVUar
         PgExsdxY2YDTAn8dnq+wWHTBKJ0HC1s8P1Jxun+p1xDsgWNAz36RNar9B1RDn8ADbbtP
         s9xw==
X-Gm-Message-State: AOAM5334BnzN/t+o9i5nTqOsacRccSkM5SuXcDe98mv+liWsxKTA5dTC
        GxB5lvK/XXYc0jLunntB0FufWTaON1dpivJ6ltiq/LlLRdYFwabnlP+ezerhSDrx/XaotwFRLB/
        ++HZeeFmFWXL2AlxSmAAL9uZotkJBkQkZXg==
X-Received: by 2002:a25:6913:: with SMTP id e19mr28866503ybc.25.1632733408031;
        Mon, 27 Sep 2021 02:03:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyw10zUN3FFuufXPm3FTI4GLbsrqhKN/cu7+cVEgfPVp7HRrTDTig81/YVsY4qi0G0PSXMrbm+aKxHDBxiseOc=
X-Received: by 2002:a25:6913:: with SMTP id e19mr28866477ybc.25.1632733407783;
 Mon, 27 Sep 2021 02:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210927080634.4668-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210927080634.4668-1-nicolas.iooss@m4x.org>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 27 Sep 2021 11:03:16 +0200
Message-ID: <CAFqZXNucwVdeRf5hsjGraMRL060ninZOp=QbKWS=vofSBzmQLg@mail.gmail.com>
Subject: Re: [PATCH userspace] GitHub Actions: do not use macOS latest runner
 for now
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 27, 2021 at 10:06 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> GitHub is currently migrating its macos-latest runner to macOS 11:
> https://github.com/actions/virtual-environments/issues/4060
>
> Unfortunately, installing VirtualBox and Vagrant on this new version of
> macOS is not easy, and the current macos-11 runner does not support
> running virtual machines using Vagrant. This issue is being fixed on
> https://github.com/actions/virtual-environments/pull/4010 .
>
> Until this Pull Request is merged, use macos-10.15 runner instead of
> macos-latest, to continue using Vagrant to run the SELinux testsuite in
> a virtual machine.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

It seems to me there is a decent chance that the PR will be merged
before the migration takes effect, but I guess it's better to be safe
than sorry :)

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

> ---
>
> For information, I tested this patch on
> https://github.com/fishilico/selinux/actions/runs/1273275936
>
>  .github/workflows/vm_testsuite.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.github/workflows/vm_testsuite.yml b/.github/workflows/vm_testsuite.yml
> index af2fad1e73f5..601276ddcf50 100644
> --- a/.github/workflows/vm_testsuite.yml
> +++ b/.github/workflows/vm_testsuite.yml
> @@ -6,7 +6,8 @@ jobs:
>    vm_testsuite:
>
>      # Use VirtualBox+vagrant on macOS, as described in https://github.com/actions/virtual-environments/issues/433
> -    runs-on: macos-latest
> +    # Use an old version of macOS until https://github.com/actions/virtual-environments/pull/4010 is merged.
> +    runs-on: macos-10.15
>
>      steps:
>      - uses: actions/checkout@v2
> --
> 2.32.0
>


--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

