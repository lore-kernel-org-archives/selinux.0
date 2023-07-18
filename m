Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF1FEB64DD
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjGRWBj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjGRWBV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:21 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9E919B3
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:18 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-636801fada1so36848076d6.3
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717678; x=1692309678;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OhqKt40L8OqcLw8LjCrBqzYCuugFm8zkJphxDeUn8N4=;
        b=A74w8Ia/08u2KKgpEdKm/cB4wUc5lgnl5inl+w0GbhySy3LhwF2EATnxn98ZomdjxB
         y2yNP67zyDrxPfJbQCYtTp+36LSm2pvCZrTjyV/wY+z4hWumu/Ezy1AjpKk10cz/hwnr
         GHgTCEgzCf4NtjeHWFtoDhLM27ptVAWfvQa58bBTZcdkBIQcxd0YQBFkV60ya6fZ8mda
         nFGWuKE+lG2hRQ+WXuL9liQI34NpzlIvMLpiHcZ4PMf00y5DG66d8cYdFuI+srohbxyv
         VxAFONU2x71W3v1dlIaQMQNyffv9x2+nScWklSjvaMbw4RbOfMjoAE+Bs95dgyFmsgmw
         LqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717678; x=1692309678;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OhqKt40L8OqcLw8LjCrBqzYCuugFm8zkJphxDeUn8N4=;
        b=lhdQ3T7jrFfypS6udVdd405FGjpx3CDxZGDjdMsB0d0t7ubOs0NMVlwUVdlRBByjeF
         gfgJXCavgwuNEPubbpwep88jyGxJOD2cB6RqmngUD6G95ueBwHM+bkvS60RKI1duV05B
         s3bDSljAVnpLD6uedWNEegscJ9QC9gOubGgIE3glzAMojZD11nSuNJbplvlWnNJGNbV8
         sc4PR6JFU+p6jzNskWO2KmSRLNbUDeZdmHOaa4K18uJb/IsqTFQxuP0WNkccbGi/sN/B
         qDgRRitvKfKNT30L5VeNdBZ4R3glUqGcNyPsOgWG+jjdj/E+gO0Qz7+0XWjSPb18ov0C
         hC1w==
X-Gm-Message-State: ABy/qLZBWiUJkNuaQ5jJ8xK4xPTWpTHuAv8XLBKxbyyZ+JeIkvAZgzwL
        iQnYbQidFRWmGbvKNoGYTKYz/gjDqJCYtyKPYQ==
X-Google-Smtp-Source: APBJJlFM2D/vWvk/N3b7jmz6SpkkmDM8jnnTUOWslc/8qaPiP91FO1WU3tPpR8EmnPZ02vnOKZTaAg==
X-Received: by 2002:a0c:be8b:0:b0:636:a9a3:9035 with SMTP id n11-20020a0cbe8b000000b00636a9a39035mr12896162qvi.42.1689717677899;
        Tue, 18 Jul 2023 15:01:17 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id l18-20020a0c9792000000b006379c3f7895sm1036919qvd.52.2023.07.18.15.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:17 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:16 -0400
Message-ID: <aedacdf95535c7147e6add61419c2cab.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 6/20] selinux: mls: avoid implicit conversions
References: <20230706132337.15924-6-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-6-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use u32 for ebitmap bits.
> 
> Use char for the default range of a class.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/mls.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Two words: "loop iterators"

--
paul-moore.com
