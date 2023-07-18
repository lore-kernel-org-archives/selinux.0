Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854BBEB64DC
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjGRWCY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjGRWBw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:52 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4D91FE0
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:28 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40398ccdaeeso33181161cf.3
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717687; x=1692309687;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+zatc7oqvLk5obRhVfXqqPnIpkVhIdJiNW+25Wuf33w=;
        b=E6dTjBs/NNUMFYeff9FDj653zrrm7BuKv8mwVAK1i+jHmRQH3dmNaOfep5OisY+mIE
         43FdAvt2CYKFHdOhnxbl+8B+hO70u/DcQoprw+GkZJxJGJefOk/dHthXwuxh83y259BR
         XtngKQQ3NNSzfLn3oRSOOUr+s/ulxHqSWRcH3pdD8Yo9c3XMwBWyQ7STCO6o+kJDs4SL
         vFCDOxLowTVbmXixt/cFpwLDKfYqO5xwopPXM8QEh0xEQUge82nAlQbzEG8J5eucrn3K
         ZDbtww8HkyBBk/4ee3utMroEBJXa2ly5lVbPlwFgVwJWvC3kXDX9JXz5lY+hXak+MEhq
         mpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717687; x=1692309687;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zatc7oqvLk5obRhVfXqqPnIpkVhIdJiNW+25Wuf33w=;
        b=jlvV+IbpFpdWTxKg2eOVdANvYKtHt/4ODJ7cVuBh/x6nwZs85IMwxhbXD0KIAo91RN
         R3tcPeS1UdOh/zVewFAFgxW4JH7OebXHo3uwP9igLOfQkXNMQD5/CmdWEDdl0OrB1jrO
         uiyEBvInDrCRHAkVwLPO+T2S78tHTbCz6SQjamDf8V2feOg9RO3L+tdxGuHYg6Oto6JM
         XTPqHCvoi0OGzxRdf3VtOAMyn+fsoM295m4xIg318MHjv29A56wRpdTUP9aeYGAafUiF
         mApYUWYxelaj3CZxY8dWHqw4ZNOTtG55jpOkJ/KHH9rIgsNFhnzm5hXsGsB2yB1LVbc0
         5oaA==
X-Gm-Message-State: ABy/qLZBOYH+vVBTj1UrxECTAYpda9k77lJhjGwXDsAoE4MHQQAMN+ic
        dBvxUDSJFUBTsY/TWlh03i0x
X-Google-Smtp-Source: APBJJlGARi+hdc8R26OMEnPJuHGzshKNJHvcEG2B6RuRDbL7kksjNzSJ3TXN/aDv8WVnLmtSjHALdg==
X-Received: by 2002:a05:622a:115:b0:403:e8df:2381 with SMTP id u21-20020a05622a011500b00403e8df2381mr1070440qtw.23.1689717687410;
        Tue, 18 Jul 2023 15:01:27 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x25-20020ac84d59000000b004036bcfb1b5sm908632qtv.65.2023.07.18.15.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:26 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:26 -0400
Message-ID: <16efe82100e3de75391ebdd3b0ad59ca.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 16/20] selinux: symtab: implicit conversion
References: <20230706132337.15924-16-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-16-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> hashtab_init() takes an u32 as size parameter type.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/symtab.c | 2 +-
>  security/selinux/ss/symtab.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks.

--
paul-moore.com
