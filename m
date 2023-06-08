Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EB7C7EE29
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 00:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjFHA2Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 20:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbjFHA2X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jun 2023 20:28:23 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C731D2682
        for <selinux@vger.kernel.org>; Wed,  7 Jun 2023 17:28:22 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-565a6837a0bso76927b3.3
        for <selinux@vger.kernel.org>; Wed, 07 Jun 2023 17:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1686184102; x=1688776102;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SjHbksShdKUc96XErESLsDPFS9b2BZzPiy47z90/B2k=;
        b=AYgTMwQCW43rOLFalGB6KPxqpKdlrC8/xaeQBJxD7vgv5XkpIAvpQd/o75maqPJymA
         3baIPsYwAB3ru48MFPD7aqst+XKsdEYrjm3O9NWWHnF7bQnyKTpKEWjH7mRH0xW/jIXq
         RnwGt17luMMtOY/f9BSbRfap2RVUIWEWrR3SbA/I4NBXyJT4Mn9w7Oymyi2erz3kGXFC
         NH2t9jsftR8C4qL+k5SvBb54bQsCwsD443JHzvkZVZO5VIfvE51PgBf6jy8xjl/3u4MI
         GHZupille7JnJcal9ABTyKvqXV0Kb13WQLQk3wquBCNOZZLLNrB48C3YLCBwAo8X60BF
         nS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686184102; x=1688776102;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SjHbksShdKUc96XErESLsDPFS9b2BZzPiy47z90/B2k=;
        b=LfUGRjfOCQqhXoUDwsvyVS+PHkhGQAT+CFRj96d4FI9jWRjmK2KpnAFA1PEkxaJw7M
         1bsatEw6i7LsRxvTH2igqVT88y0Sup6WY0P3eioGgw8JhbfqC7QgKmDMbP6mumf/gyN0
         wQ+Yp9KT6rwdH3/awBjUyTzpFD4kT1c79zWzIPxjc97s6e1qZcL7/pwxvZsnEJs2aMuX
         7q94OGCJLGNAN675ri0C5iox1XRcIuLiFuI/DejvsvnzZVs+C38rJyWxUpz76O+CMvXM
         UVrtHp1wIE8EbeZQNqSATuJgT0gwMC/3loi5VGsNIuVC9QoQwGyJ1G0srMoLOT+XGkFm
         cIpg==
X-Gm-Message-State: AC+VfDwDp12+gvJiWmsJpE40q9lEH79sFax8xHsMEZCSm8+QJjkr2BZl
        0xGNzo5aGUPXtL6z2s7Sk72kmSKbLEpCrX736nSNAsO4FHil1fk=
X-Google-Smtp-Source: ACHHUZ5G3yzArbV1oPD5eCFv1h26ramBAE0RXDDM1tsabXZ/IslvJVnvBVLPFsyRiP8cTrSvwCdTHlZLPUfTy7Lq5ks=
X-Received: by 2002:a81:498b:0:b0:565:ef60:3f2f with SMTP id
 w133-20020a81498b000000b00565ef603f2fmr8618093ywa.44.1686184101796; Wed, 07
 Jun 2023 17:28:21 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 7 Jun 2023 20:28:11 -0400
Message-ID: <CAHC9VhR0Lm0WmSPQkieNwzG3DBbmChsXZJPysWjqhZzG2y2ftw@mail.gmail.com>
Subject: ANN: SELinux and stable kernel changes
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello all,

After a discussion with the stable kernel maintainers, I've learned
that they have a list of subsystems where only commits that are
explicitly marked for the stable kernels are backported to the stable
kernels.  As this has always made more sense to me than the current
approach of simply backporting everything with a 'Fixes:' tag, I've
asked the stable kernel maintainers to add the SELinux subsystem to
that list.

I don't view this as a significant change for SELinux since I have
been explicitly marking stable candidate commits as part of the normal
merge process, but it is something to keep in mind.  My hope is that
this should help reduce unnecessary, and risky, backports.

--
paul-moore.com
