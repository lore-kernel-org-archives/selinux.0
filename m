Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CB5C04FF3
	for <selinux@archiver.kernel.org>; Mon, 24 May 2021 17:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D926613EC
	for <selinux@archiver.kernel.org>; Mon, 24 May 2021 17:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhEXRZI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 May 2021 13:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhEXRZI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 May 2021 13:25:08 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32057C061574
        for <selinux@vger.kernel.org>; Mon, 24 May 2021 10:23:39 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gb17so24952301ejc.8
        for <selinux@vger.kernel.org>; Mon, 24 May 2021 10:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=iQAvrY84Ev63sotKjQ8XF378hGXrkLjyLXQlVL/CA00=;
        b=gOe6t1zMDLpe1KD8nft2Dm94wbE0oxJCeuQD1AkUyFsh2QYiIgNIqVuaLsEwGEaCtY
         ZbzZ4PJrh4mz2uxtvKz0/XjvhPix+/bTE7SZrwBLKjulZfvRTD+GJVh4Ow7jJ6d833J1
         2jlipTdMd0qfbfZnM95COILIwl51aK1ibB7kcz4+lqgl4oUoXLrCbWE2ykiZcht13XGn
         5/0OOi/JWMOrZ9GMD+wAyWn8nTI39g4m+UOi/YvyZ5W4BAjtFcJd4SVGQhFwLAy1gTLh
         VIijvMHVRZa0WZDwcj2+T5KptbnIqn4jG7Nj+htbEuh3GM1HuIwyKUbL0SJo+ju6sUoP
         KxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=iQAvrY84Ev63sotKjQ8XF378hGXrkLjyLXQlVL/CA00=;
        b=Sno3scdUGPDbm1T9KN6WYHRyITFszZaofjqg05HQvy69yxpnRBOTt3Zl56tGpYOFXx
         4IM+cm2HBQPJbEJU5Jp4SeeMBxEgL6HYoaGNNwUmMqy8O+DZVwIVDuKQPmzLxZf/mBfl
         WThRgPdUsDQmXWVzg/e2VCValXbIbpNXIt3i7lmWnHuJbvR67LqLgXgPAvqQq8hrs0hT
         +DaiuQbojtruYGqkqFbY4STEcfJvM2Wn/zQkl2tyb7SN9LDPHhhpfuSOklHBUGOFUx0h
         KCCdgo/B6XWTv6Uniwltgf+xhp5FVH56KTVyXoJ9A7dMA0l7siRmQEJkLSBW9G0YU9qh
         /thw==
X-Gm-Message-State: AOAM530kv4Ba260gSOiaOyqplFbAwHjOmH8o4HSG+M8wiygSYB7V/1R0
        jAPoGzjBcNH6805zm+VTpZd57kb+AAtXDZHcaWkAuUghJWPHPw==
X-Google-Smtp-Source: ABdhPJwyIfjzoAAoJOyPaQwMMsDgosFiDREG4pD9K0GQJHC6G/cO/wq/6jL/nN5gaAhYaA55NICRa8oMe1krtrvUgd4=
X-Received: by 2002:a17:906:4089:: with SMTP id u9mr24330124ejj.18.1621877017245;
 Mon, 24 May 2021 10:23:37 -0700 (PDT)
MIME-Version: 1.0
From:   Seth Moore <sethmo@google.com>
Date:   Mon, 24 May 2021 10:23:26 -0700
Message-ID: <CAJsHiNyV2K2g90YsiiY5HZkONHuprTHGq+65Bs-TiCf988NBGA@mail.gmail.com>
Subject: selinux_check_access is not thread-safe
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Originally posted here: https://github.com/SELinuxProject/selinux/issues/287

By default, selinux_check_access does not appear to be thread-safe. It
calls avc_open, which then calls avc_init, passing NULL for all
callback function tables. The result is that no locking is done for
the AVC, which can corrupt the cache if multiple threads are calling
selinux_check_access.

It looks like calling avc_init, supplying lock callbacks, is the
"easy" answer. However, the avc_init man page says that avc_init is
deprecated. There's a new function for setting callbacks,
selinux_set_callback, but it does not seem to support locking.

I see a few possible solutions:
1. Update selinux_set_callback to support AVC lock functions.
2. Update the man pages to indicate selinux is not intended to be
thread-safe anymore.
3. Update the avc_init man page, indicating it's safe to use (un-deprecate?)

Note that we have observed buggy behavior with Android keystore2. Our
quick-n-dirty fix was a serializing lock around all selinux calls:
https://android.googlesource.com/platform/system/security/+/ff188d3a6ca38919e568f0c89f74d90c011526e9

My prefered fix is either #1 or #3, as they provide slightly
finger-grained locking than our fix.

Cheers,
Seth
