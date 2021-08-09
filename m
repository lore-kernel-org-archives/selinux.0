Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF7B1C4338F
	for <selinux@archiver.kernel.org>; Mon,  9 Aug 2021 13:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9398460E76
	for <selinux@archiver.kernel.org>; Mon,  9 Aug 2021 13:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbhHINrJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Aug 2021 09:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234155AbhHINrJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Aug 2021 09:47:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD37C0613D3
        for <selinux@vger.kernel.org>; Mon,  9 Aug 2021 06:46:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c16so34066959lfc.2
        for <selinux@vger.kernel.org>; Mon, 09 Aug 2021 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jr+dZ5TGn4fWDUaEkly4il27cBi9KYWsiBfaKftxee4=;
        b=AyU9GiFzryD/LDVl/MP2qsi4m3TbkjEw9H8kZFRHSrZ0unvsbc81qpFJegzeuYCQJ9
         //AMMwrMl+/eEnAJVfrtfxYRuHiqHLLHPiLA8EvN0C+YIAgHvNXlb/pm+lhNKi/4Z+Ki
         SLKVNh8PE7lWEO1xHFTHjbX6TE7uINvm/6D5kfob6qhIVH+B1tHmHE53ya4Rg9PIcaZL
         LpbgRA1mEO8S6ZT5cKyT/89ooC/Cj9JX47E8Y1ruyOIDG1zBnm+b0cZM5nZ+tqzQLB73
         igCcsNUVR8J/gCPv2I77oiZ7B2VbJ+gdp6ediqmQ/BFea2t8LS3NRk8x4mpCSLF5geU8
         7GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jr+dZ5TGn4fWDUaEkly4il27cBi9KYWsiBfaKftxee4=;
        b=OuonLs+sVt0cLkx0M1yTyiD6YDqrloSWkW5Er9sPX7xUVF0FwzhLsEvd2tZpIcCsqu
         E/eJugnVfcVXdrratlwebc28qnP8a+pIe+H/hKeTH3eOGQ9XtlWS6gRDyfea40Xrab9w
         ab+6Tu8mllve0EPdhVFLdxOADASrFGGf6H1ZRHzZmhJWKu1gc2d6k3l9O7AikorTnDZb
         gkUN3kwXOAZ3UFQnt2uMfNL3yZrmciB6ozWf1fxliG6qSVjT9Ap7xJGShHxyOFGW+M3m
         aPmk1H1E81OP3dBTacociOksTtlJ0dxMcS7Jx5jzqSBWlaUsKYiJ7UQMjIxJF6Rp3Iat
         em6g==
X-Gm-Message-State: AOAM530MAK1CbiUoaywildwwTpM26wdfSriBQUgAA9L7RM2w+OXCrO/9
        hOlTbwCHIAWHYqj8eN7K8nSNxBakevTEUTrJU00=
X-Google-Smtp-Source: ABdhPJw+uVA1M+H4zIrQnVrp/ZrYrJo7V35rJQx09bc/40m2bbwqDrvUZLYf6iqFg6D01XC9PszgoTFUEJUoryBcYW0=
X-Received: by 2002:a05:6512:ad2:: with SMTP id n18mr12009395lfu.334.1628516806465;
 Mon, 09 Aug 2021 06:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210809105209.12705-1-cgzones@googlemail.com>
In-Reply-To: <20210809105209.12705-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 9 Aug 2021 09:46:35 -0400
Message-ID: <CAEjxPJ6G+6tgQfW0L-1Sgm2w3CypiAshCC5+r34+rpc0Nsj0XA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] libselinux: replace strerror by %m
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 9, 2021 at 6:54 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The standard function `strerror(3)` is not thread safe.  This does not
> only affect the concurrent usage of libselinux itself but also with
> other `strerror(3)` linked libraries.
> Use the thread safe GNU extension format specifier `%m`[1].
>
> libselinux already uses the GNU extension format specifier `%ms`.
>
> [1]: https://www.gnu.org/software/libc/manual/html_node/Other-Output-Conv=
ersions.html
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Just FYI, we want libselinux to work with not only glibc but also
Android's bionic and ideally other major libc implementations like
musl.
In this case, it appears that they all support the %m extension these
days so I think this change is safe.
