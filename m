Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199C4C433FE
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 02:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D600C239D1
	for <selinux@archiver.kernel.org>; Thu, 10 Dec 2020 02:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgLJCqe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Dec 2020 21:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgLJCqe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Dec 2020 21:46:34 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAEAC0613CF
        for <selinux@vger.kernel.org>; Wed,  9 Dec 2020 18:45:53 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id p22so3858231edu.11
        for <selinux@vger.kernel.org>; Wed, 09 Dec 2020 18:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C15LORIwDbkRhEXbz5yD/vbjZReVx/pQWrhGvV/BHXo=;
        b=1Alxujg/fSk+UE3ddximhA+vKPJE5f5RIykahjWlItRdyNgAQtsi1OEZWhehyYweFL
         WNoWTwNvRivvcm3EY+CO1Kl6rw9UFenAsQ10BZWXPiMhB+cRYtFvrtrDN5cg8k6QAbbL
         p9Myqak6pba921W6K0vtB/cO7fRbrkEfNXL76UPODJQPw+VbN4qLgP7R3m2CQ16zWQcU
         60fy5IbhsWwP/w2X1PjnMuwACOEV3EfhGCdH9/9OMuzR8KwhpfhxaNrt8rPubriAeCeO
         N751FPYPtTC0uS3OvazvyxwgZSjxlAk2p3STsTqz+liP5Bbsy2bB0XatzZRbzGslzie+
         PrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C15LORIwDbkRhEXbz5yD/vbjZReVx/pQWrhGvV/BHXo=;
        b=QCHsdugttImgKSRwDOlncIrK4RlqBodJ4SyuAX+dPN3Yw3G78mVN6fm4CBvElAPBr1
         eren4K4WXRVCJQjx0xvWreSEUkMa3edv+vh6gSkS0FspTqvz6haxij5LLBcTt8Edm7wv
         2FauJbHM/BL49W8wA+XVJ2PJTlb9uIN0Z8FG9c6cCZjssZOaMoirFRjmepViNKUgaqeh
         jLSpnz2lR2FxtfRbdaTjSQQgCWT43hPeGBRyBGMXqLakXhojRfZbdA55jL0WVggFPjOT
         nKcewaZ0I47pK5ZbV++CVPQwm7mQy+kblR+AxMsP25VLOwzRfDYvojLSds/PwcoVn1yE
         rELg==
X-Gm-Message-State: AOAM5326x7ckbLKOV3hwWybf07qrbJrDYsh3yJSCbwOJN/0Gi4/+/2Cq
        g5xMwPViWHoMyW4QlzMej/CPxeqQ4s3LoRDBHRvb
X-Google-Smtp-Source: ABdhPJyoQ4nUFXApPwPZketjO41uDTFSfV8SNxjs2Rv4bQWL43GNM3+DT/nSmeNRnHIyDop9UpgPI3+3BrnHZGKvM0E=
X-Received: by 2002:aa7:d64d:: with SMTP id v13mr4784728edr.196.1607568352646;
 Wed, 09 Dec 2020 18:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20201125125402.211692-1-lokeshgidra@google.com> <CAFqZXNsry1zqGND-iBaYmwb_KeCvoat-LQFywf04TAp998sqXQ@mail.gmail.com>
In-Reply-To: <CAFqZXNsry1zqGND-iBaYmwb_KeCvoat-LQFywf04TAp998sqXQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Dec 2020 21:45:41 -0500
Message-ID: <CAHC9VhQWXtLZfhwBppH_aFqipwED4u0qOCLX=LQL2YZ6P3CvMQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] selinux-testsuite: Add userfaultfd test
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        SElinux list <selinux@vger.kernel.org>, kaleshsingh@google.com,
        calin@google.com, surenb@google.com,
        Jeff Vander Stoep <jeffv@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 27, 2020 at 9:09 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Nov 25, 2020 at 1:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > Confirm SELinux policies are enforced on userfaultfd operations
> > via secure anon-inode interface.
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>

...

> This is a good start, but it is only a very basic test :)
>
> I would expect at least these tests here:
> 1. ...

Since it has been a while I wanted to check-in and see how this was
going?  Having a good test in place in the test suite is an important
part of getting the kernel code merged.

-- 
paul moore
www.paul-moore.com
