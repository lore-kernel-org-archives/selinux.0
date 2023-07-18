Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2FFEB64DD
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGRWBW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjGRWBT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:19 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBBF19A4
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:17 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-6348a8045a2so38362986d6.1
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717677; x=1692309677;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hmCPaUsgqe0iU0sELPvLMfmcM27GoKLl14VslK7Sk/k=;
        b=agAH95nuPyZd3BnKh4aoyXd9E22JPaZ3u4lrK7/JdXrTVC4iI4QOT4fkC4CXBkyYxQ
         eYxvQMnGShXl7lbD5zp9RTjm0Dq4E13iiuydaox57US4G1UZuHkuhcw9jmWHCN+l12+o
         +OAqVoACmitiIB0f7UyNoQ4dOspITn1HfMEZ0pKMDcaZIqoNeeTdFnGWKaKxRWYcicA5
         /0REr087Sk3v7abrpF70XWqpH5n2LhAsNxTRHGOAX1RpeR6/HatmMy4zFo/ntZN8cPGF
         /tBu7uAKKNu7dnQcITvpKJ7/nCFT77PsRvyPh+jTf8HdTvpBZi84LKSfsTRO6HlfANft
         RSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717677; x=1692309677;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmCPaUsgqe0iU0sELPvLMfmcM27GoKLl14VslK7Sk/k=;
        b=C0lj1s++XrTBMXw//gl/ygXATURcorJUCy6xtmjEPKjddA0bLTZBrnd0uioUDdCa5v
         rG11tp11i0IcjArYv2QKBkZkfZmRHnaAAFWFpc3lGJhA/7ltUeJ5ARd2ZH8gJKtvwgzk
         IPt6oORPpZa3b+ac52BuH++dBqO4NeTx4J/RmosYvfianN4E7HiOCFejFHrSMjmZjOFs
         /unxw512dxGZeUpg/Zj0reP0YHikBqx/3+42SoV2ZTnNF4JAdYQFgCPw7KMucIczrpZD
         OwlrMCSVkaKomp9ykroZGO1QwQktqC8daCn/UTI+Dzazi/DbBkz9oqIo9dAzWkZEg5ZM
         6PrA==
X-Gm-Message-State: ABy/qLYyb9XemQ7IJdElVeh49lyqrb8BF1gbHDB+F07kqYSBD6NoTzsx
        OegPrW0m4lahJTrIQBncWO4/
X-Google-Smtp-Source: APBJJlHyg/J3QN6NN93RY6kgpACZZx+SIVR52LijD7BHSLz0P6IehiuiwNjdqFR4wJxXax7wSg91PQ==
X-Received: by 2002:a0c:f1d3:0:b0:630:16ac:945a with SMTP id u19-20020a0cf1d3000000b0063016ac945amr14924071qvl.59.1689717676839;
        Tue, 18 Jul 2023 15:01:16 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id x8-20020a0cc508000000b006166d870243sm1023620qvi.43.2023.07.18.15.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:16 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:16 -0400
Message-ID: <5006016464638ff788697d794137903e.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 5/20] selinux: hashtab: use identical iterator type
References: <20230706132337.15924-5-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-5-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Use the identical type u32 for the loop iterator.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/hashtab.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

No to the loop iterators declared in the loop.

--
paul-moore.com
