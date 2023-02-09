Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BA2C05027
	for <selinux@archiver.kernel.org>; Thu,  9 Feb 2023 22:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjBIWIM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Feb 2023 17:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBIWIK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Feb 2023 17:08:10 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADCF66EC7
        for <selinux@vger.kernel.org>; Thu,  9 Feb 2023 14:08:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id nn4-20020a17090b38c400b00233a6f118d0so766226pjb.2
        for <selinux@vger.kernel.org>; Thu, 09 Feb 2023 14:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8B85+MOoP2a+A9GviFdp9ek5MNSbCztYvTpEh2rC7TI=;
        b=Tr/Z40/QJYHa6xc0gimCUBBqToTKUMEwZY/d0fsilm0OOfGA9pjr0eEjf4FvsBXRCx
         v1EGbRrjXV3RuAhydw4F9llxfxPM1TF5oW7Ltwkl4ATM+6BRoyAtdTrttDeSfI0daEbc
         8K844W3J8uD8RUDonLem5N3IzBC2Ezho7Nr3vGxxG5XhMF5fW21rkKYvSNAZ3/YKfnAi
         ohoGWK/9r91pcvLQrAHx4VqbB+Zm68GkCwdnc296ghFKyxoL4m5hbHUw/67N9cTJ0mSi
         2JustS55vDvgzeNRYRo6PKSm+SR8wAf/cvv9QTEMZHJ7IuNE2twJNm+Mir+sX7g3yzfe
         0QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8B85+MOoP2a+A9GviFdp9ek5MNSbCztYvTpEh2rC7TI=;
        b=oLqCmx9LtqtUWBAr/XSd+zW7BovMw5vRRbJx38le8YgUhOAMS9EyTBbJWZzSJPkpwq
         R+MSiLSsv03xybClBGvVgoc6tIq2F1xYICkSkaqbn6vNNqpcYyFGa/RAAt9Cj59hkHSi
         Xjj3tPFxIGFF+bmkmBsO2h4MHjG2NJ8IK5u7o4MpX0nARz0cAnFfniZ5s5H5f7BhZ1BZ
         6oMJnG5rZdjtfazyKCsk2PII4KU3wRjcoiESYHUvWc6dXH+EAYrdf+3hGOhzL34NuhBN
         4E/kIQdK0yRluF9uxXEGe4/0OaiW1KsQXSsRHNjFAkyaOd9RsizeYBoutyA14BmYZFxo
         DmSA==
X-Gm-Message-State: AO0yUKVjo8yVyFArAyHHo93ad6QdIAvN+Fh0Q9v/r6q+kLjgKgBv7sR1
        l7/WjK6DdYXSHqiMk9zPxXWupguxot8CrNrASbuwjr/Ybcdq3+8=
X-Google-Smtp-Source: AK7set/AsFgav/OpmJrtzOaSi/sQbGy/TwNRqXDq8ps3s+YwEDTd8juo727+Fb1u5j2aQTSR3EpYFzRTL1TkP1fmJ3E=
X-Received: by 2002:a17:90a:2946:b0:230:2889:ec8b with SMTP id
 x6-20020a17090a294600b002302889ec8bmr1864243pjf.121.1675980488070; Thu, 09
 Feb 2023 14:08:08 -0800 (PST)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Feb 2023 17:07:57 -0500
Message-ID: <CAHC9VhRT0d-XWkw8uLGOmXsaQFpA4MMP6+sL5kfONbf-Mz8UJg@mail.gmail.com>
Subject: selinux-testsuite failures, CONFIG_LEGACY_TIOCSTI, and recent Rawhide builds
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi all,

I just noticed a selinux-testsuite failure in the tests/file test:

# Test 8 got: "512" (file/test at line 103)
#   Expected: "0"
#  file/test line 103 is: ok( $result, 0 );
file/test ................... Failed 1/16 subtests

Digging into this a bit more it looks like the the fnctl(TIOCSTI) call
in test_sigiotask.c is failing due to a recent Rawhide change to
undefine CONFIG_LEGACY_TIOCSTI, disabling TIOCSTI.  Upstream kernel
commit 83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled") has more
information on the Kconfig option.

I'm not going to argue for reenabling CONFIG_LEGACY_TIOCSTI, I think
turning it off is a good idea, but it does mean we need to adjust the
selinux-testsuite.

Also, as a note to the Fedora folks who will see this, maybe don't
tweak the Kconfig knobs when the kernel is at -rc7?  Seeing kernel
test failures late in the -rc7 stage doesn't do wonders for my sanity
;)

-- 
paul-moore.com
