Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2A0C4338F
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 10:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156DA610E6
	for <selinux@archiver.kernel.org>; Tue, 24 Aug 2021 10:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhHXK4Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Aug 2021 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbhHXK4P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 24 Aug 2021 06:56:15 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5649C061764
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 03:55:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id f2so36893622ljn.1
        for <selinux@vger.kernel.org>; Tue, 24 Aug 2021 03:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=j3iKJyks9Lr5CSLNWkR0jeOEs3hLf3OtUTvJSXpj9sg=;
        b=DuaMnGf2NkhZH7pqQmOHZs5q9Y1DicYtktJku8iBeHGrbcSohr+lbiKQ0KPR9KSmKR
         uVcZ818+7tyI45/EPSx/VQP+xTGD0sTsbSigxlpzontV2KZggISLGtnnC880VwdDH8l3
         9TD2cXYPeFb4wtSbr+7yEIEyZ1FKqW9c/9CZAJwxhnI6069pU+6s59XGRyJ6pyZEkk8Z
         6y11+lU8wlTzrKUAKcxOa+l1V5LMWEF9nOk1CyMIF2i0lSigsISLIsVU440KS9oiTj/0
         FSpepvNAoz3P1UVvYfOdP71zrAIobZahlUhF8ycirnDwq1vVth5Ykczbqv6CMNRZbyVJ
         uTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=j3iKJyks9Lr5CSLNWkR0jeOEs3hLf3OtUTvJSXpj9sg=;
        b=N7ell3RHeNmJmW3v2Dy0p8kP6A+n+9Ua4URw89NlNLBYBdODrPxkeFjBVkFUPiq0JG
         L4QcDLAMw4B0Y1wT3dSTRL13s+wf+Yyoosb4A9cWDbGCMP6jiNKNzgh4mbC78AVq2xBe
         1kHA07xHwVpgQ0fIfYQht9CykcFjLGwpjCXkesFWwL8qsLAdF/kw8jlTWHFThj9xZwLh
         X4S6Sm9/INbjMbyP0j0zgeekoNHStwIaYmYl2MLxRfEt6tduPHoIeaseVFzvx7njCyWk
         1RYNa89ZtmSq5fCCyEklPz6YjkuE6eDRy19o7eRr1IXS3uvBG3AuyejBgLiWxrdN8j9T
         6EGg==
X-Gm-Message-State: AOAM531zCdixTMbYdnrFP1pOYFSau7RaMXZaRjDCt5anQIfftsJpWVoE
        DoWDko7G7q7ctfMKmn+d4ZchL1cZL1vM/Q==
X-Google-Smtp-Source: ABdhPJxBbu3zAX9/ZRUTFLK1h60eCL6tH9rP0+92Q8UiblaqcW73imo+xSxHYgG3Y+hYwNOQBhUN2A==
X-Received: by 2002:a2e:8881:: with SMTP id k1mr9031854lji.443.1629802529852;
        Tue, 24 Aug 2021 03:55:29 -0700 (PDT)
Received: from [192.168.1.38] (88-114-216-93.elisa-laajakaista.fi. [88.114.216.93])
        by smtp.gmail.com with ESMTPSA id g16sm1726477lfh.144.2021.08.24.03.55.28
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 03:55:29 -0700 (PDT)
To:     SElinux list <selinux@vger.kernel.org>
From:   Topi Miettinen <toiwoton@gmail.com>
Subject: security/selinux/hooks.c: FILE__ perms used as DIR__ perms
Message-ID: <f505f5bd-437a-2e38-5a93-b4abfac9fe81@gmail.com>
Date:   Tue, 24 Aug 2021 13:55:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

Doing some post-processing of the SELinux policy (more about this some 
other time), I noticed that permissions for class "dir" could be 
tightened, for example "execmod" doesn't make a lot of sense for 
directories. Perhaps there are even more useless permissions? Let's grep 
for all use cases of permissions with DIR__ prefix:

$ git grep DIR__ -- :^drivers/ :^arch/
security/selinux/hooks.c:                         DIR__ADD_NAME | 
DIR__SEARCH,
security/selinux/hooks.c:       av = DIR__SEARCH;
security/selinux/hooks.c:       av |= (kind ? DIR__REMOVE_NAME : 
DIR__ADD_NAME);
security/selinux/hooks.c:               av = DIR__RMDIR;
security/selinux/hooks.c:                         DIR__REMOVE_NAME | 
DIR__SEARCH, &ad);
security/selinux/hooks.c: 
old_isec->sclass, DIR__REPARENT, &ad);
security/selinux/hooks.c:       av = DIR__ADD_NAME | DIR__SEARCH;
security/selinux/hooks.c:               av |= DIR__REMOVE_NAME;
security/selinux/hooks.c:                                 (new_is_dir ? 
DIR__RMDIR : FILE__UNLINK), &ad);
security/selinux/hooks.c:                       av |= DIR__SEARCH;
security/selinux/hooks.c:                       av |= DIR__WRITE;
security/selinux/hooks.c:                       av |= DIR__READ;

So, no instances of for example DIR__IOCTL or DIR__OPEN can be seen. But 
blindly removing all unreferenced DIR__ perms from policy is a big 
mistake, which I learned the hard way as the system didn't work normally 
anymore after installing such a filtered policy.

The reason for this is that in security/selinux/hooks.c, FILE__ perms 
are used sometimes as DIR__ perms and "git grep" won't find them. While 
semantically incorrect, the #defines for DIR__xyz are identical bitwise 
to corresponding FILE__xyz and so either works.

Perhaps the situation could be improved:

1. Add a comment to security/selinux/hooks.c to alert readers that 
FILE__ perms are sometimes used in place of DIR__ perms and why this is 
in fact OK.

2. Add static asserts to verify the hard way that each DIR__abc #define 
matches the corresponding FILE__abc #define. If one day this would no 
longer be the case, the compiler would warn.

3. Add a new unified set of #defines, for example COMMON_INODE__xyz, to 
document that the same perms are used for both files and directories.

4. Replace the semantically incorrect uses of FILE__ with something more 
complex (but technically useless) like
if (S_ISDIR(xyz)
	av = DIR__abc
else
	av = FILE__abc
and since the values are identical bitwise, compilers could be expected 
to eliminate the useless checks and branches.

Would patches be acceptable along some of these ideas?

Maybe the unused permissions could be even removed entirely with lots of 
work and perhaps no real benefit.

-Topi
