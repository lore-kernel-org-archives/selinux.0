Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C465C433E6
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 16:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B72164E92
	for <selinux@archiver.kernel.org>; Thu, 11 Feb 2021 16:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhBKQZE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Feb 2021 11:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhBKQXB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Feb 2021 11:23:01 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEC2C06178A
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 08:22:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s5so7531967edw.8
        for <selinux@vger.kernel.org>; Thu, 11 Feb 2021 08:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fISj0lmkxJdlwfMzfLy68mXwNSfKyBopPBtH1GZjGf4=;
        b=pDRPB2crfCbWgwL7PclTalQA4xOKIGosH40ru57sr0bcpkMUiBErkqVunCrTWtmpPZ
         7IVrA+UUB6qLc5115fRf3TtHGbhKREsmrSwznla/XQDnWUjrwt+9Q9+cyjZu1zc/L7RC
         n1dG/qh9EMEr4FFolSct+bC/hDjjx7NYq7XxHEu2fdNWfmLV069hohVOZ+eJzm1C9uCG
         VEkUJBKJEKMGW0Pow2PkUD0Dagy1OA0a7QwlI4G36C2684s8Xr6tSyfk/mrd7MyzjsUK
         RoQu5nwnnAhoK5tiDjffLwziK2tUxWyTvF5eAX5Kyyyz9mmf0PxVeskyT3Y4YInrOq5Y
         PPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fISj0lmkxJdlwfMzfLy68mXwNSfKyBopPBtH1GZjGf4=;
        b=Y0lj1Bs7FwhpFMJlv/b8CygafzrnuGkrhyF98KKWWrmPaCZjc9HSSdgWD8voicj7S/
         jAtaBBGuBf5f5znhjyTvsY+zj7KwC9yOmdbNJz6QzFFKbOs73QA9ZX5hN1e5sHfpXCLK
         21SS4KKlja3f5fdiRQeFJwntojGKr22rW+Avt3j44PnMbhnijAYwMzjaX5V2JQa41Na1
         D4LeYW+fjLrtm0gt0kqN7QLmW5/I/nFA9A0der/lDT+6l1VYl4NoGfuvZ38UdbredrZ0
         K3DdLvWr7J0QRuxiJTj5baFpbQ33FkYdBGDJdysgqtCCGkwajJDv9EXUaN9M+lY7BUKa
         dgKA==
X-Gm-Message-State: AOAM532qC25vC8oid4YLu9jV15Szuj6ZJLYqLhy/jpCfB17xlATdFn2i
        UIwl727Nv2ul8JB8kDWMjMUTYCMtFBo=
X-Google-Smtp-Source: ABdhPJy9b0ZgrnA9k3Tf71m1HUwk2y1g7pWm/ZKYfnT2ZrcafFgXCFKxwKD0h5a0OnYOVjuokSg5jQ==
X-Received: by 2002:a50:fd0b:: with SMTP id i11mr9146990eds.387.1613060539492;
        Thu, 11 Feb 2021 08:22:19 -0800 (PST)
Received: from ?IPv6:2001:a61:340e:e601:8a:719c:9bc1:dcee? ([2001:a61:340e:e601:8a:719c:9bc1:dcee])
        by smtp.gmail.com with ESMTPSA id 35sm4421734edp.85.2021.02.11.08.22.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 08:22:19 -0800 (PST)
From:   bauen1 <j2468h@googlemail.com>
X-Google-Original-From: bauen1 <j2468h@gmail.com>
To:     selinux <selinux@vger.kernel.org>
Subject: alternative to glblub defaultrange
Message-ID: <8cb71055-5bce-768d-860b-9b9c1be92ce5@gmail.com>
Date:   Thu, 11 Feb 2021 17:22:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi,

While working on my own policy, I've come across the glblub mode for defaultrange.
It almost does what I need, but not quite. So I wanted to ask if a patch for a new "glblub2" (with a different name) mode has potential to be accepted:

glblub current behavior:

 For the new context low level use the greatest intersection of source and target sensitivity and the lowest intersection of categories.
 For the new context high level use the lowest intersection of source and target level.

 or in pseudo code:

 context_new.low.sens = max(source.low.sens, target.low.sens)
 context_new.low.cats = and(source.low.cats, target.low.cats)
 context_new.high.sens = min(source.high.sens, source.high.sens)
 context_new.high.cats = and(source.low.cats, target.high.cats)

glblub2, what I want:

 For the new context low level use the greatest intersection of source and target low level.
 For the new context high level use the lowest intersection of source and target high level.

 or in pseudo code (not the change to context_new.low.cats):

 context_new.low.sens = max(source.low.sens, target.low.sens)
 context_new.low.cats = or(source.low.cats, target.low.cats)
 context_new.high.sens = min(source.high.sens, source.high.sens)
 context_new.high.cats = and(source.low.cats, target.high.cats)

A bit longer explanation why I need it:

My policy only uses categories, no sensitivities, with the low level for confidentiality and the high level as integrity.

A non-exhaustive list of rules:

* A process can only transition to a lower-or-equal integrity level and a higher-or-equal confidentiality level.
* A process may only execute a file it the files integrity level is higher-equal than the processes integrity level
* A process can be trusted with information that has a confidentiality level that is dominated by its integrity level

The confidentiality requirement for process transitions hasn't really been implemented, and I'm debating leaving it out, but by default a process should not drop his confidentiality level to prevent accidents, as glblub would do:

glblub: process s0:c1-s0:c1.c5 executes file s0:c2-s0:c2.c3 resulting in process s0-s0:c2.c3
glblub2: process s0:c1-s0:c1.c5 executes file s0:c2-s0:c2.c3 resulting in process s0:c1.c2-s0:c1.c3

A more practical example (low = s0, high = s0:c0.c5):

Consider /bin/bash a file with no confidentiality but the highest integrity:

/bin/bash low-high

Executing bash is fine, and should result in just low-high ; no requirement to keep bash secret and bash can't be modified by someone who isn't already x-high.

If a user (low-high) executes a script in a project that e.g. was marked with some integrity and some confidentiality the process should range transition by default (and maybe enforced by constraints as set out above):

/home/abc/myproject/abc.sh s0:c1-s0:c1.c3

executing abc.sh should result in s0:c1-s0:c1.c3 

This ensures that no process without c1 could access any information about "myproject" by accident, and that "myproject" can't compromise the integrity of other processes (e.g. with c4).

If nobody stops me then I'll submit a patch once I've got some time again to work on this.

-- 
bauen1
https://dn42.bauen1.xyz/
