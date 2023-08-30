Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACF7C83F19
	for <selinux@archiver.kernel.org>; Wed, 30 Aug 2023 18:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbjH3SrO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245731AbjH3QF2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Aug 2023 12:05:28 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA24193
        for <selinux@vger.kernel.org>; Wed, 30 Aug 2023 09:05:24 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58fb73e26a6so65303407b3.1
        for <selinux@vger.kernel.org>; Wed, 30 Aug 2023 09:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1693411524; x=1694016324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6wWR6vPSewXdystMdP/BcryutnZfkXis7EkLLpd/jjA=;
        b=NwNavoqzJ5tpUrXjnFg7a3TCF4E3SA9elR+qNrZAESoUsfJCPgJhzrzOoMgligrHwB
         xzxcBVgBJk7cLVmjncAd/tnnL9DtjiOhkl20TJ6kYxDoDvYmVuKOv8YXLne1f2oHEBRr
         fucWKR2NB93ZCuuL8yx0qBxBOiaqy3o7VIRCQK8aALyxKIbVs3aV6/6gOOhB0A8G2CfQ
         NAyiBYsmOHGt5009CAvnI6lF/vWxL1iZyA11/I7ykAoS7/yuB4DiPzmlCJ4Sm1+b2g0A
         vrq8vly6AAs1PEOWVLLEAr4ms78A8pn0TSAMEyrkV9eq2vQf2DZEGBhyy/yEsUj6/w67
         pT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693411524; x=1694016324;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wWR6vPSewXdystMdP/BcryutnZfkXis7EkLLpd/jjA=;
        b=jhY6/OAbfocBnNlXLRWQAc+QFJDT2EXxU2d6iUjC+sIvDPC58Mt5ZMd5N4/0kFcsTj
         XCt81c73DugI1/U7OPrF87GRVVJQBGlalGir//ZLEF9WaVXcjwN2pj0CN0e6M/psvbXv
         2ifdK4+BNgsGMoqNf1z1ujoE+J4lzty38//SGWT1NDuVbB2ohyQRUTXnb7BkNThmDyf5
         JVuLq7Uxhxchq2KM7kTH/Sxtug5C/jdwQaSQAej/Mo85ILxZDs9xcGrqVh0JuzhG+Nor
         ffn9uJVDM+9z9RvTXLvoTfNoTbq0W/CW4DMfy4VCQKyriVe2lI2g1lvxJgaMkhmHVPjS
         qmWA==
X-Gm-Message-State: AOJu0YyMXLTtTvEGD5CXKsWPl0ZEZ+xjKF2L8EODd/xujJ+zqEInX+RN
        YTaTpWjUDqox+8CINQJxr8/mpvRHEu4sPzzD9jpT
X-Google-Smtp-Source: AGHT+IG6O2vD9Ui9R6aID4YcLbGDbyy3BOVdDWgdUShKy6tkG2weeuIdcj1Dzsn85ebN3Q5Fbo4k8brbkjhEGBtNmqQ=
X-Received: by 2002:a0d:e483:0:b0:595:2de4:c991 with SMTP id
 n125-20020a0de483000000b005952de4c991mr2549978ywe.29.1693411523984; Wed, 30
 Aug 2023 09:05:23 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 30 Aug 2023 12:05:13 -0400
Message-ID: <CAHC9VhQr2cpes2W0oWa8OENPFAgFKyGZQu3_m7-hjEdib_3s3Q@mail.gmail.com>
Subject: LSM hook ordering in shmem_mknod() and shmem_tmpfile()?
To:     linux-mm@kvack.org, linux-security-module@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

While looking at some recent changes in mm/shmem.c I noticed that the
ordering between simple_acl_create() and
security_inode_init_security() is different between shmem_mknod() and
shmem_tmpfile().  In shmem_mknod() the ACL call comes before the LSM
hook, and in shmem_tmpfile() the LSM call comes before the ACL call.

Perhaps this is correct, but it seemed a little odd to me so I wanted
to check with all of you to make sure there is a good reason for the
difference between the two functions.  Looking back to when
shmem_tmpfile() was created ~2013 I don't see any explicit mention as
to why the ordering is different so I'm looking for a bit of a sanity
check to see if I'm missing something obvious.

My initial thinking this morning is that the
security_inode_init_security() call should come before
simple_acl_create() in both cases, but I'm open to different opinions
on this.

-- 
paul-moore.com
