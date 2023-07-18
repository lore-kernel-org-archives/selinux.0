Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC579EB64DC
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjGRWCL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjGRWBl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:41 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C141B1FC0
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:26 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-765a5b93b5bso565416985a.3
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717685; x=1692309685;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r0u9TRtvPN85YoE0zcDntr23xKKV4yPsatOmaM1fBF0=;
        b=FIrh1bs/b0Emc5CZM+IsjnREXK3Fg70nVv2Gh4m+pBbzqd/jijcHCBWPyyQXaErtnt
         H4F8Vnkhslu1VLVGnCLumMKVqh4oqyW/hqhgwDYZl4I/BShREi7CQyE7CSKSmt5xOpep
         wqY2kfYFFqh5PdyxhvmyOu5t27rEU83CZk68CIhttiwVpTpjivkZzmskfCyKPm/UHd6+
         iEgdL22uRhjm61H3dP7Sts9WzoP4sdeyBtMbX7qKim+gIXTr8oHk2emmqv4GnmW3kfQb
         k5vBiI83+8Kc7D5rFd/1yEbJmB61nOkslaC9yNp2nVwfzRMRBUVaOVI3wtJSu2Ysqq1j
         nKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717685; x=1692309685;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r0u9TRtvPN85YoE0zcDntr23xKKV4yPsatOmaM1fBF0=;
        b=HzhkQnasI2I5fGuvUVS5rHqAGDP3zQbbBRqIMxewo7Xgzz0eC+62BflSyX/V/V8WxA
         TTaQ+Fk1mYAgynPQjMbGbz5Y38ZKndvHXVBNoO1gz+ck72nefnB5j0WjCnQOMhUCRC1v
         fdFNwELBa9ADDZUCub3V1dQwJRUCzyNFqeBxaHSpBg/GgwciqcdBp+/rWzJ4tQTJU1IS
         FNzmaOvYXa8icdZhr12r3rdCZcDPNc+z6RBhW5hheCNsh2F4aqSRCdk19x6wcTHSHmns
         D/culngRwC2TXpIuAyC3lp7U6YhUtOToN32uWu6nHSVChyNPvNyOlf3lCKs7KLDnIJUL
         LmiQ==
X-Gm-Message-State: ABy/qLYM8xcfhlDk74hBURpEF5H9vIFjUGMUeTkcFOqaL5mvn7OTnlj3
        0OfUwFf40Met+OEIH3wZgKwA
X-Google-Smtp-Source: APBJJlHWFmyXEDcJCVd1mNcgtzgar96TyAApokpQEb7PfORZM66oLsMoq5KVIU4/HiWcN2rAybhZQQ==
X-Received: by 2002:ac8:5814:0:b0:401:dfb5:9056 with SMTP id g20-20020ac85814000000b00401dfb59056mr20136563qtg.0.1689717685267;
        Tue, 18 Jul 2023 15:01:25 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id k10-20020ac8474a000000b004033c3948f9sm925394qtp.42.2023.07.18.15.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:24 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:24 -0400
Message-ID: <d3ca51aa2e03213b075ae00f9e5ca65b.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 14/20] selinux: use consistent type for AV rule  specifier
References: <20230706132337.15924-14-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-14-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> The specifier for avtab keys is always supplied with a type of u16,
> either as a macro to security_compute_sid() or the member specified of
> the struct avtab_key.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c    | 2 +-
>  security/selinux/ss/avtab.h    | 2 +-
>  security/selinux/ss/services.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
