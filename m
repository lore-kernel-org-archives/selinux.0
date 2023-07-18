Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD76C04A94
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 22:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjGRWBV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 18:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGRWBR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 18:01:17 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E2198E
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:15 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-765942d497fso565566085a.1
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689717674; x=1692309674;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q0cxD0bDSBI3iXwBbGCEOOB62CAlIgStj1niGo6wUfs=;
        b=BEjayJIVSjPLP6rBRHfpaDVYX4HBSO9IEJ7V8XaZQecA/tokegyGgh/hWaMya6lmgM
         f4MAHmrEhKWn1W12y01ExDcysvIfQZd9vwHJ6d6lsgjFcH/wBrOvLlogCe65uopXU7Bi
         wGLw7XlWSdo+Td4SmXwckU1U2KdjdXzJhNI8YgGm/rJMjZczcUT26s7K1h/TEsYcNLBC
         EySKNW/Se5SBqTp/CLDPrBLhi8PBkCuSn/B5sQJ5TF+Z1qMxzIAB2eG9Z9/D7rMDxJkb
         j+tgLC6JnqiKJ3M/VRR1gUhBz884H+a2G4bJGOzMOYq6vRQ2c0mzcte5AzudV5efuVG9
         5UmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689717674; x=1692309674;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0cxD0bDSBI3iXwBbGCEOOB62CAlIgStj1niGo6wUfs=;
        b=T7ShiRbagGPkMT7tLgFgd5Ym55DTez1N6k3gpCtKTM280iEhPc3fDvCQQI3d2cC6xs
         3NxQfAMNC5nSHWK/aXq5U7R58COID+/ekq5yFr6K7T3jUAog/FTrNbM7EvE2/+wUnb7z
         kjU4iFFKGlEnU1eGr+mj7E69QgXE+hV+OJqqkV84z92OaYvFi61p2/i4LIhsAzy0D+FD
         QmbDUK1jaqDp2DQqVHuodgT5pOWTstP6AMohqrUUOPbSvj8K1w98TXJjik3G4ByPFSuM
         2BVpQldZOIdShpjLMRBld+2g/BkIaAbtxmV0Vabqye2q1NZNoJ1/YidzqAmZ4vAq6Jzp
         u5xw==
X-Gm-Message-State: ABy/qLZuzNrgRMlDw5YYGBN4FK45pqN9NpLFTmh9HAgYXg9B5QwoOT9m
        lo1E7R2UxEiB+pv3PKhGlP9G
X-Google-Smtp-Source: APBJJlEtgaOZvqlrgGbcYhiLUehU1+h01BWuQ7CUTaLh/SAIqW1VqePSRHvS4qtWm2e2Xyn8g8sqBA==
X-Received: by 2002:a05:620a:2d87:b0:768:14ee:234c with SMTP id tr7-20020a05620a2d8700b0076814ee234cmr9010116qkn.50.1689717674012;
        Tue, 18 Jul 2023 15:01:14 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d23-20020a05620a159700b00767c8308329sm893121qkk.25.2023.07.18.15.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 15:01:13 -0700 (PDT)
Date:   Tue, 18 Jul 2023 18:01:13 -0400
Message-ID: <50ff9fb2fb463d74065580e41c4cc194.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/20] selinux: avtab: avoid implicit conversions
References: <20230706132337.15924-2-cgzones@googlemail.com>
In-Reply-To: <20230706132337.15924-2-cgzones@googlemail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Jul  6, 2023 =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com> wrote:
> 
> Return u32 from avtab_hash() instead of int, since the hashing is done
> on u32 and the result is used as an index on the hash array.
> 
> Use the type of the limit in for loops.
> 
> Avoid signed to unsigned conversion of multiplication result in
> avtab_hash_eval().
> 
> Use unsigned loop iterator for index operations, to avoid sign
> extension.
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c | 38 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)

See my previous comment about loop iterators.

--
paul-moore.com
