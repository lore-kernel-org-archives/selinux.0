Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DB0C433F5
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 23:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B64160F6B
	for <selinux@archiver.kernel.org>; Wed, 22 Sep 2021 23:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhIVXpa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Sep 2021 19:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbhIVXp0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Sep 2021 19:45:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0994AC061574
        for <selinux@vger.kernel.org>; Wed, 22 Sep 2021 16:43:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id i25so19032665lfg.6
        for <selinux@vger.kernel.org>; Wed, 22 Sep 2021 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9k72VTW22NLqhNCFibUNzlVRlOLQo+ivDkN/xGzIL0=;
        b=iAQ5fOkNypbYTDMHDwefmxHPG3BnavaFtPjdsc6K5IFf8v4Aa05F1WOz/dqXf9D5eN
         VU9v9NDhqobgAH7LoBpnsbaNZxLD7pRX/kq2DnHdo1fZh5AcIdAV8GkZH4839jcnx9EZ
         W1YcQ3jdEj1KMiYH+mn3Qra281xA8lW3Id9vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9k72VTW22NLqhNCFibUNzlVRlOLQo+ivDkN/xGzIL0=;
        b=RDf2a2i/vCmAoNGyLC9MUaOKcWg8qtu9K88N32t0li1TMTAZ8HmG8e4LwBr0GBwOOA
         6MW6JHLbhoYAFjG3UBCRsOBYdlFoJTtgQSpxwKiycwEZSsmfCtJ9KIcKx0Wuxo/rb6o7
         9Wu+2940tZdhUrfAGFskaQVIKGNYjAAKofDDg7VHWNY+NFmYw9zr0qrq2QR6dmTUaVAK
         mQDI/FwISWA6plhgZTPfgETRt/beGcCd44gVvcKn3rGOHW3N8qQxVjoagPMBJrX1xHXg
         FBr7ZXuJ23tTLbQrwXxlpvt0jNn9ROyqwhriZAS7lYP8jblIDUp5H5uQRInUFqWvt7Yl
         hMTg==
X-Gm-Message-State: AOAM5301ELt8BFFWLrA8dsOM/6MYkGXaxU4zDDfOHW2BIGjqhPT5S/76
        QFLuWvH7+vz9HXDv2M1nRrF5lqXj8Fd9LDQAqGE=
X-Google-Smtp-Source: ABdhPJy71xvVxGb+TIIduz+p1K3ETAXirP1Zo+V723+KNxBqBTl6Iv+T4ZYk5IllRPWXbbaNimcRUw==
X-Received: by 2002:ac2:442f:: with SMTP id w15mr1413808lfl.491.1632354234093;
        Wed, 22 Sep 2021 16:43:54 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x33sm290681lfu.8.2021.09.22.16.43.53
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 16:43:53 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id b20so18949876lfv.3
        for <selinux@vger.kernel.org>; Wed, 22 Sep 2021 16:43:53 -0700 (PDT)
X-Received: by 2002:a05:6512:984:: with SMTP id w4mr268356lft.141.1632354233111;
 Wed, 22 Sep 2021 16:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQcxm=Zhe2XEesx3UsBgr8H6H=BtJc92roqeF8o+DK+XQ@mail.gmail.com>
 <CAHC9VhSu=ZWymS3RHa7jakQOU8gujGQ=PKO1BTcrNAM9-P4bmQ@mail.gmail.com>
 <CAHk-=wj=ADdpVjsKGuOyKDT2eO2UwfgW+cGsKAkxvTkP7=1Osg@mail.gmail.com>
 <CAHk-=winh0gLMqnQipt7VpbsxBL1frJQ-hJpRpe=kbR3U+DRHg@mail.gmail.com> <CAHC9VhSZp1-Qi7ApoQHauaFXDgoNaFTwFEieEFFuBtdPqAtXQg@mail.gmail.com>
In-Reply-To: <CAHC9VhSZp1-Qi7ApoQHauaFXDgoNaFTwFEieEFFuBtdPqAtXQg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Sep 2021 16:43:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoExoB6xGD0as0kpfwr38B=W7GRkO2NXWDRW-tmQS6Qw@mail.gmail.com>
Message-ID: <CAHk-=whoExoB6xGD0as0kpfwr38B=W7GRkO2NXWDRW-tmQS6Qw@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v5.15 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 22, 2021 at 2:40 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The basic idea, or problem from a LSM point of view, is that in some
> cases you have a user task which is doing the lockdown access check
> and in others you have the kernel itself

I don't understand. In that case, it would be a boolean for "kernel vs user".

But that's not what it is. It literally seems to care about _which_
user, and looks at cred_sid().

This is what makes no sense to me. If it's about lockdown,. then the
user is immaterial. Either it's locked down, or it's not.

Yeah, yeah, clearly that isn't how it works. Something is very rotten
in the state of lockdown. But that rottenness shouldn't then be
exposed as a horrible interface.

Why has selinux allowed the SID to be an issue for SECCLASS_LOCKDOWN at all?

And why is selinux foceing it's very odd and arguably completely
misguided "lockdown" logic onto the security layer?

Yes, using "current_sid()" in selinux_lockdown() is clearly wrong,
since it's not sensible in an interrupt, but lockdown questions are.

But why isn't that just considered a selinux bug, and that

        u32 sid = current_sid();

just replaced with something silly like

        // lockdown is lockdown, user labeling isn't relevant
        u32 sid = SECINITSID_UNLABELED;

and solve that issue that way? Just say that lockdown cannot depend on
who is asking for it.

         Linus
