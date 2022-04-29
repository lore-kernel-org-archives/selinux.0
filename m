Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9A3C433F5
	for <selinux@archiver.kernel.org>; Fri, 29 Apr 2022 04:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237839AbiD2E56 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 Apr 2022 00:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiD2E55 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 Apr 2022 00:57:57 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D50BE3B
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 21:54:40 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ef5380669cso73817387b3.9
        for <selinux@vger.kernel.org>; Thu, 28 Apr 2022 21:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqqX3ka8zJReoZtiWcnDAcedEDd+UEm6RzIL1DYOGvQ=;
        b=byzgI0KGWf10i8tYtMgDmaATKLEHBWPh1aXvwQGXRHQsws2xOU/hs1TaR4+GmsEozD
         9HRzx1z4K+uZp6HSlu7cN6+Iulb6zDClI20WoDj7g5LWTjkO1DdJN50hTeXlgDaceObw
         Ks6TySoJsA/YxOg2cs7QVZKfJPHMVSlVoDRpY6UbNWz96fUOiYAjzY9hB14wldJ4ZsgY
         7EsxgKbicyFk7lt9QDgMCjd8zftSEtfMNZn6yg/4lgJZNDMbQ277sKT/ZhpbpRufA4XQ
         optSw4oH+QOGD3K0aMQedbhOMpF9otQz3DpN2NhDiAIMV7tU7HB8hrVyUNH2nufip5f8
         ZrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqqX3ka8zJReoZtiWcnDAcedEDd+UEm6RzIL1DYOGvQ=;
        b=Kh7+aRPOPcWtQieS2S3zyNaFPguNHVwTwRxwryuYYK8QdCuQcCaKz1Tq35piRJUeOc
         HAUbntISkj7sl+qXhZHmn1pNB0Gk91gtO1Dx/ZvVAWE9B3Oo7fMywFA15Ht+69ee4Cak
         4cqCQ4/B4BF2CvLfsaN/f/Gi96+ufyIuYStmhj/55mGcBE3zeToE6tV9Ai54K1/gujmW
         ZOEo5vp0XagpwwOUuybL2QBUlV1W/hyUyJxtumaXqTI+3JGW8+3eLaKegaoZ7R8/qNUl
         WmmrT+36Af6caPRa/XFQLdoYvE0GnqMjIyUH11rLZbrj/i5on3mP97WH3FDt8xns545Q
         CGDA==
X-Gm-Message-State: AOAM533xzFd7m9umhXszHcyR9nAB6Gozch41TOzQJ4PHHXc3NADHFDz7
        3qwCTJBrJ0sdbOZlpGWK/rlS8+7KHxdGZW+iJSQZbA==
X-Google-Smtp-Source: ABdhPJwPtGEnA1JIR1D+p6mHm5yrwHpeKq99JiuwPNn3idfjaVfAdwt9EfvbRLOpvZv5HNO9cZTVT51pFT3RNp37Ea8=
X-Received: by 2002:a0d:e296:0:b0:2f7:c169:126f with SMTP id
 l144-20020a0de296000000b002f7c169126fmr30851860ywe.431.1651208079823; Thu, 28
 Apr 2022 21:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220428061707.768468-1-tweek@google.com> <YmpQOSf0bdOcIZSU@kroah.com>
In-Reply-To: <YmpQOSf0bdOcIZSU@kroah.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Fri, 29 Apr 2022 14:54:24 +1000
Message-ID: <CA+zpnLcV40ciweXMr+W+qT0xGgKAsUq47x26JGYaiOiQYcshfg@mail.gmail.com>
Subject: Re: [PATCH v3] firmware_loader: use kernel credentials when reading firmware
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <jstultz@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> As stated before, should this go to stable kernels?  If so, how far
> back?

Yes, it should go to stable kernels. It should apply cleanly on 5.10.
Ideally, up to 4.19 but it will require a fixup. I can send a
backported patch for 5.4 and 4.19 branches once it lands in the main
tree.

>
> And you forgot to cc: John?

Done
Thanks
