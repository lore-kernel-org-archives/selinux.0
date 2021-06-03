Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46B8C47082
	for <selinux@archiver.kernel.org>; Thu,  3 Jun 2021 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9574A610C9
	for <selinux@archiver.kernel.org>; Thu,  3 Jun 2021 17:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhFCRIR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Jun 2021 13:08:17 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:42931 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhFCRIQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Jun 2021 13:08:16 -0400
Received: by mail-ot1-f54.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so1994435oth.9
        for <selinux@vger.kernel.org>; Thu, 03 Jun 2021 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xIzwe0EI0NwVYf1HKK1lnKsu2urPME2FbeDvij/21u0=;
        b=MDx7naHZ3NgXR2zyroXJQuzmt9iJtGMvdbDSYqRg3DEsfed4YtIHEpvock/vFhRDBi
         xexrhWCLARHvw15jYkYbxeDmuUpITms2XQrJKyI6icmvyGn5xVpxqIAUq2jxHK/TcVzU
         CQNbgRDtuFZ6byL0nHWnGZhUCuLKiISqD3d7Klyzdx4pGCKBaT7HUC93/ZJzlMg7q9oA
         nPM6MTspXtFSPfY+DUOGF7r6OX44KDdg8YNqUy2DBDvi/cp98LUHMcY98ANT6TsLpNN3
         GLj1JotXGGRCUdbO/2IRoCtEteKfC5E617i984gFAS3BFOnbjOe0pH5cEAShmZ2Pb34H
         nyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xIzwe0EI0NwVYf1HKK1lnKsu2urPME2FbeDvij/21u0=;
        b=YCgvP++xNz+e5qcQuYjaHASbf03gH8kZiYCaBDnl16WR/D5I9JGfiBKK8cjSC6ObTa
         gdvXRlL6L3vRDQIMC0MhRJok6vdiSIPvx0nHvhPVuai+woDyonbtBgr38wXQM1braeMi
         xZnRL+WsSOTFfTrYdnWNjZh7C/cH61lmJyK0qjzQhyWrBo4wNQcgNI4QfK8uOm6GdHZZ
         u1oKIMvv49GH2UKbMORgIjjIOoFjff68RIsaU9qUFHEILGi7QtlP/HlIk/6FqhHLJhI0
         510MSDUM9O6q9498p/nuoe66dhGl3/N6kILts5LtGbWopF5VjgFTQQZn+vC7BKY/gH32
         96xw==
X-Gm-Message-State: AOAM5325wx/lotISUDTqiD0KFh4Pxmvwwyz4g0fphRqL7P2jQD7eTlKL
        UCxsusPUKNoRKmWwHhd0k3ULS955BqNTax68DjyyrOANWxY=
X-Google-Smtp-Source: ABdhPJxWnLEW2KGUd8KB/wKTx99Ax8LWe78g9LkAsaSjT56sQh8L7ffUp/JjR1Q29LLKFCm4LAnFWf06a7fgbco2RhM=
X-Received: by 2002:a05:6830:2011:: with SMTP id e17mr222041otp.295.1622739931340;
 Thu, 03 Jun 2021 10:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210513185254.559588-1-jwcart2@gmail.com>
In-Reply-To: <20210513185254.559588-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 3 Jun 2021 13:05:20 -0400
Message-ID: <CAP+JOzQkcAdJVB5K11EFtPFcY111qX0k_Onza7okuOKHF0N4KQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] More secilc-fuzzer problems fixed
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 13, 2021 at 2:53 PM James Carter <jwcart2@gmail.com> wrote:
>
> Patches 1-4 fix bug found directly by the secilc-fuzzer.
> Patch 6 is the same class of bug as that fixed with patch 4.
> Patch 5 fixes problems found while investigating patch 4 and 6.
>
> James Carter (6):
>   libsepol/cil: Handle disabled optional blocks in earlier passes
>   libsepol/cil: Destroy the permission nodes when exiting with an error
>   libsepol/cil: Limit the number of open parenthesis allowed
>   libsepol/cil: Resolve anonymous class permission sets only once
>   libsepol/cil: Pointers to datums should be set to NULL when resetting
>   libsepol/cil: Resolve anonymous levels only once
>
>  libsepol/cil/src/cil_build_ast.c   |  2 +
>  libsepol/cil/src/cil_parser.c      |  7 +++-
>  libsepol/cil/src/cil_reset_ast.c   | 56 +++++++++++++++++++++++++--
>  libsepol/cil/src/cil_resolve_ast.c | 62 +++++++++++++++++-------------
>  4 files changed, 97 insertions(+), 30 deletions(-)
>
> --
> 2.26.3
>

There haven't been any comments on this series, and it has been three
weeks, so I plan on merging it tomorrow.
Jim
