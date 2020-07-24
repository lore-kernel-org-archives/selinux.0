Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904E8C433DF
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 12:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521982065F
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 12:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XTEZhsl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGXMeS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMeR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 08:34:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800ACC0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 05:34:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o18so9790453eje.7
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 05:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=5mtFvun8xQJduLDciERpBrOfM6njRaGUiEjDVLxsJn4=;
        b=XTEZhsl9QkxKUgTfdMdyHAgBly1SUkec/11xyUS2Wsxvhsc1Q0WP/tLwQoBOv+c15r
         mkdYRoRvmM+AkvKe6DhH8t3KrWWeWv6RuYj2L7OjAiKHXBJHnRtvzDXh4i0SgaJtVmhz
         x2T1rAh187ruqosH69hTl8by4h768Ppx84OK4w4V9CNRx1uBNDXtAFtXS4chTB8uw5la
         C2nrzWOC20DLjyNqbwBmwpyb7DGVYY0HePqx4aqJDNgKP1lMV0NbKrT1JIq71jJ08rFq
         FZjTo4gm+qJJVmMPHtoy3yW2TIOE7yS9toCe+CHU574lYPxqzZhe9cvImlYcWovYBPQw
         nFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=5mtFvun8xQJduLDciERpBrOfM6njRaGUiEjDVLxsJn4=;
        b=AcLkdepFCzhpE5wtssLImXm2QQ0NS6ccbzG1LgZzrky/pfr8Dq5zzzQOql9m6dQFhk
         hMU6kqMarE3LGLMeN/UGkO4FCaffF4ZhCW53EGSpH76IVT/az3BciaYpvgFHC1nmyLLW
         FaH4bvYDid7KvxkqcRAZR5q5bZIaKLT+whn1+QTeeV5ny6r33JtfWabT5+sJfoGVAb6D
         OO7KDqR4tnaHvW+unQ0Ts3gJ9JjXFf4qTN7kkVDMMaXP20bZhqf6x19uPSg/IgLnae0H
         NcfshvDqFaVwSxbXR94putEHrFtz6xwYPdY0GdX/Ocl1gG1+gQXyWqMA+++r1aLBhRw6
         8TBw==
X-Gm-Message-State: AOAM530r0rixuGVn9p4o/+HelW2jt+ilFSex+3qU2WqiTKzb5/ulMo3o
        XXj1H8yqHlc6Zb5gc6DKKhWf3ppSuNPrOFIXVIZptY/t
X-Google-Smtp-Source: ABdhPJylpzQn19FebdPHaQlw0IRZoVybFuzSUpEudTlbK3Ma8CrSowTPUTOdFS2WTvLXR7rFjdVjDu0QpdTt17MmVSE=
X-Received: by 2002:a17:906:c0da:: with SMTP id bn26mr212947ejb.359.1595594055889;
 Fri, 24 Jul 2020 05:34:15 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 24 Jul 2020 14:34:05 +0200
Message-ID: <CAJ2a_DfV0M1zD=fjQOGq3KPcBtvQxrgtZHSbBKDcxuOX7pJygA@mail.gmail.com>
Subject: getcon family: returning success while context is NULL
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi list,

I stumbled over a systemd commit [1], handling the event where
getcon_raw returns 0 (success) and the returned context is NULL.
The commit points to the SELinux userland source lines [2].

Is this by design?
Or should either errno be set to ENODATA and ret to -1, or this case
be mentioned in the manpage?


[1]: https://github.com/systemd/systemd/commit/199a892218e1f36e7bd7d5da2d78de6b13f04488
[2]: https://github.com/SELinuxProject/selinux/blob/4246bb550dee5246c8567804325b7da206cd76cf/libselinux/src/procattr.c#L175
