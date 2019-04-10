Return-Path: <SRS0=bkjU=SM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A384CC10F11
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 15:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6845C20818
	for <selinux@archiver.kernel.org>; Wed, 10 Apr 2019 15:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="J6D0bqhq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfDJPfh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:35:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34654 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfDJPfg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Apr 2019 11:35:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id j89so2575538ljb.1
        for <selinux@vger.kernel.org>; Wed, 10 Apr 2019 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ww7mJdMONNjZyGS6cJmp6axun3jFK0uGF9gO5JYFGs4=;
        b=J6D0bqhqXAKsiCWk1VKUamGJA48k5A29HtVZAW83fLtDCdru5IdONGDfB1rFJk3Bh0
         1Z5/D66JHSxj5/2dL6z7qFxxi4OTqj3rlHro09aJxCYNDAHef62JkVsniCEqZbYjTdhV
         OtUlZLttSmtI8aYKJL6Ye3vT7wtt98+UHSVw98GDi1rQSqAGb8FhmP55n3Bmbfi1BCAK
         e3Tg8YPamghM1bUa0xnQCCmsKFvuDzqehaO0J5hV2GumkPADjhi2DFy6FonD05Lt7juY
         Q8eMjOJ+uxM2WbkpQHk6jpP2p6DtPRHkrc3LJy+KLTWpST+RQ1ihpiJcsq7UFN2IoVeW
         5TjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ww7mJdMONNjZyGS6cJmp6axun3jFK0uGF9gO5JYFGs4=;
        b=d4lRZjHQ1sz2UDtZhtuqK6fTGBLjA8BR6yEOnwhPNVIr86+eV8ORi30VyVMRcMP9kc
         bjEufIx+uji4kkJUHwDZbdog3+3tAW8b7uxWW8UzGL9NlRwMmjt17xe5K7axU7J/s9rZ
         E16n98C2s/nYBSr6oYCm7WRodNKKk04+XbIkVy2+0O0DUMnKZBxvZ2GkSDGOU0IGIciD
         Qcp/AAeSeHX0GBJP62Hl9xqj9vdyyXsorsZouXVKVA5RvzLPiwNxC8VHyn8kuiEdeAVx
         iyVpyps7Lg/7xEOeicb8fJbgzac657jAPuseBtdi9Iv0uoHr+BjDMZdYsTQXym6RaCfG
         E6IA==
X-Gm-Message-State: APjAAAVty7MXPYrN9SFxRD1QqMRywd+CpDSwFbbJP0X5iIcRp4TdrGUC
        TwPLZvGrKVuKiYbgYNdneo/NtsAa+YsFfbrYRRxn
X-Google-Smtp-Source: APXvYqyJtWmIsUycvQZ4Fha5zh2AIUpAOVTs7BCMwR/MTkAaZQ4nvjOeLDa3jAOkVUGJOoCjmgGx/V2UE9747RgWGio=
X-Received: by 2002:a2e:8508:: with SMTP id j8mr5122460lji.26.1554910534982;
 Wed, 10 Apr 2019 08:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190403122611.6543-1-richard_c_haines@btinternet.com>
In-Reply-To: <20190403122611.6543-1-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 10 Apr 2019 11:35:23 -0400
Message-ID: <CAHC9VhTTeetqR03+zaV0d_2rdHr4r6eKnqKNrXO6k9O7+tz=gQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux-testsuite: Update binder test applications
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org, tkjos@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 3, 2019 at 8:43 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> Replace binder_test.c with separate manager, client and service provider.
> This works in the same way as a service provider/client interacts
> with a service manager in the Android world. It passes the service
> providers binder file descriptor to the client for the impersonate
> permission check.
>
> Also added tests for Dynamically Allocated Binder Devices and passing
> the sender SELinux security context on binder transactions.
>
> Note that the tests require a minimum kernel of 4.16, else some tests may
> fail. To run successfully the "binder: Add thread->process_todo flag"
> patch may be required that is available from:
> https://lore.kernel.org/patchwork/patch/851324/
> This patch has been backported to some earlier kernels.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  defconfig                       |   3 +
>  policy/test_binder.te           | 176 ++++----
>  tests/binder/.gitignore         |   6 +-
>  tests/binder/Makefile           |  13 +-
>  tests/binder/binder_common.c    | 155 +++++++
>  tests/binder/binder_common.h    |  37 ++
>  tests/binder/check_binder.c     |  27 +-
>  tests/binder/check_binderfs.c   |  53 +++
>  tests/binder/client.c           | 450 ++++++++++++++++++++
>  tests/binder/manager.c          | 362 ++++++++++++++++
>  tests/binder/service_provider.c | 404 ++++++++++++++++++
>  tests/binder/test               | 257 ++++++++++--
>  tests/binder/test_binder.c      | 705 --------------------------------
>  13 files changed, 1785 insertions(+), 863 deletions(-)
>  create mode 100644 tests/binder/binder_common.c
>  create mode 100644 tests/binder/binder_common.h
>  create mode 100644 tests/binder/check_binderfs.c
>  create mode 100644 tests/binder/client.c
>  create mode 100644 tests/binder/manager.c
>  create mode 100644 tests/binder/service_provider.c
>  delete mode 100644 tests/binder/test_binder.c

Hi Richard,

Welcome back :)

I had hoped to spend some time reading up on Binder so I could give
this a proper review, but that hasn't happened so I'm inclined to
merge it, assuming it works on my test system.  However, considering
your comment about this not working on kernel's older than 4.16, I
think we should probably add some checks to only run this test on
systems with the appropriate kernel support.

If you look at tests/Makefile you will see a number of distro specific
test list modifications, and there is even an example of checking the
kernel version (search for "kvercmp" in the Makefile).  I would
suggest a simple check to make sure the kernel is at least v4.16, and
if we find distro specific support (e.g. a particular distro
backported the listed patch) we can always add an exception for that
distro.

How does that sound?

-- 
paul moore
www.paul-moore.com
