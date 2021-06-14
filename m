Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530A6C2B9F4
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 18:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37915610A3
	for <selinux@archiver.kernel.org>; Mon, 14 Jun 2021 18:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhFNSFJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Jun 2021 14:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbhFNSFI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Jun 2021 14:05:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A04BC061767
        for <selinux@vger.kernel.org>; Mon, 14 Jun 2021 11:03:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j2so22377334lfg.9
        for <selinux@vger.kernel.org>; Mon, 14 Jun 2021 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hth5OJx5DLnrqVkGsO9sFZaOxm24SUjgcf7q16vYO9k=;
        b=SYh2bWEUABHXqRB6ouYLMnFXIxkuBj3g9OGoJcjymr/uDkZ0b2ocpQIxY7OD3aoqry
         y/WDysWKakiopu5mag8D+4V2VdjD01blp+N5edF/BQ0EXgzT8QLbBsWXILbf7+h84XUb
         ftZIOw1NIhwgxMzRUzmXKeXGQC6u8yO//bp98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hth5OJx5DLnrqVkGsO9sFZaOxm24SUjgcf7q16vYO9k=;
        b=nfhaml6Moo2oJHCsEtmweYCVYDCSXeW3vufscJ54AXOdVaYcsqpS9RJY1ogi6GU8ga
         J9IpeZFxLADJdQ4MTE8Dtww4k4Ur3QpvDIdv2+5maseKsySbrgMFyU7+oPVBdWQg9e6k
         K6jxNtl0qbebgHkxjIG1ahOL6tq9owExmLtDL1PH7rpXaazDpNWqf311RwokEDXRTzHZ
         V+pE0GvjotZFjvTHKcW1R6mcojcvMV+jfzDBsTBVKqXT1SYmkdzFPpTokFiLB1/MqScc
         agbmKbB+QAiy/EKxu6J1CYLfEu5b2BBAAf7hxQkwlmol9KTMq+tJh47NZUtLCbm3CAEf
         bzmw==
X-Gm-Message-State: AOAM530QLh1oy45w1av1/skMaHqzmcwxvXhqSHvjtf9jmmI8k5M0+HWy
        oREvvzOuvrWn6WXzfmbWisfTEoy5thk7avNlt6o=
X-Google-Smtp-Source: ABdhPJwDlYy2IJR7894CSyqvPwcNF0sS1c2DPULkB2BFEha9GT44OuRm8wfovmjnHHxY7QkS0EY4kw==
X-Received: by 2002:ac2:44c9:: with SMTP id d9mr12948502lfm.290.1623693783557;
        Mon, 14 Jun 2021 11:03:03 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id y24sm571544ljj.16.2021.06.14.11.03.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 11:03:02 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id v22so22548297lfa.3
        for <selinux@vger.kernel.org>; Mon, 14 Jun 2021 11:03:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr12358175lfa.421.1623693782157;
 Mon, 14 Jun 2021 11:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210608171221.276899-1-keescook@chromium.org>
 <20210614100234.12077-1-youling257@gmail.com> <202106140826.7912F27CD@keescook>
 <202106140941.7CE5AE64@keescook>
In-Reply-To: <202106140941.7CE5AE64@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Jun 2021 11:02:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLBq63v_h71YuBM2aNjCSBprkBEO3fevbWnkp8TDeh5g@mail.gmail.com>
Message-ID: <CAHk-=whLBq63v_h71YuBM2aNjCSBprkBEO3fevbWnkp8TDeh5g@mail.gmail.com>
Subject: Re: [PATCH] proc: Track /proc/$pid/attr/ opener mm_struct
To:     Kees Cook <keescook@chromium.org>
Cc:     youling257 <youling257@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, regressions@lists.linux.dev,
        LSM List <linux-security-module@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 14, 2021 at 9:45 AM Kees Cook <keescook@chromium.org> wrote:
>
>         /* A task may only write when it was the opener. */
> -       if (file->private_data != current->mm)
> +       if (!file->private_data || file->private_data != current->mm)

I don't think this is necessary.

If file->private_data is NULL, then the old test for private_data !=
current->mm will still work just fine.

Because if you can fool kernel threads to do the write for you, you
have bigger security issues than that test.

               Linus
