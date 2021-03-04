Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9CCC433E0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 23:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6775D64FFD
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 23:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhCDXNe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 4 Mar 2021 18:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbhCDXNe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 4 Mar 2021 18:13:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0FEC061756
        for <selinux@vger.kernel.org>; Thu,  4 Mar 2021 15:13:33 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b13so89031edx.1
        for <selinux@vger.kernel.org>; Thu, 04 Mar 2021 15:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a+pvUiOEZPbdTGLN8fNRt7l50iLnq5LKsr+xpPdAVAo=;
        b=0nwHNuENO61Aog4cf1zcPp2knTSezQUoTy4/9s3cVcuwXCZ2yXl1LapGYGZmiv8T1f
         x8CN1JWM9trwHDVo6EBXGs318W5rT/5PXLQiib+WZ42xkj9YX51SncLMX/uzohZKpGvx
         AR/yG+01wgcgmyNvz8pduR1lr9Hi6rkCIhFYz9aIKNmUNLoK1ZVz1SYZ1yly4jBg/gF4
         B/FE3rdsjtI5gd2lXC0QYhEpd4Nz/L3aSQn5Hj4yA8wyBpX2V7ZmdO4GZc0EnT0YtomT
         k6zPZiZaxSKf7DW8IxbZSsbhFyTVVC06hW89iOIcnxcjCBeppP0xxWaJpJ/T1iBfd/kh
         Rxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a+pvUiOEZPbdTGLN8fNRt7l50iLnq5LKsr+xpPdAVAo=;
        b=dLknxc4s75Ey4iZLIWOG3qMZIVXFwhZUjWtqZ5T9Rm0V+338KJw5h8fJ1cV+IiQeR7
         SUXMPp7tS+yr9XCuZ4G8b7cmst3U6wnTJ883eaTOYEUIhPmv9DwfJMdE6FHphOZtENCC
         TUDKJVKHPpOeQIqcP3mIj44fQ7/NtIMvxjTeUeZz5FeUzCEotCcQCvVjuIrXFECN3SoJ
         9yoA6XHMJC4lysAAMMvgZyYayAhQx8hjEHoeslIJ9HAtt72Ej8mM3KhLPm+kjex+1YIS
         9VuBCbffKiI+M3d4uy64rA7sWFPyIoYgJXTDoI4CKcG6x74hOcvX61WsAUlL2Z6Kp9YK
         GNLg==
X-Gm-Message-State: AOAM530hyJesb5wbAG9d9wzWNs8kbJ6nvyV8C2ba5L+p/Sd/HypzstdX
        ggO9dJ34yNfEBGyiiCOR+CF+bQ3NZ77A88fm+L9/
X-Google-Smtp-Source: ABdhPJwJRixMFbL/qncluaBbkPYrbJ7ufs602jV8p+pecaJ8ftDoqgqOKAyeg6sSI37/qk2tqimCTEBju+ud9N+glss=
X-Received: by 2002:aa7:db4f:: with SMTP id n15mr6841478edt.12.1614899612580;
 Thu, 04 Mar 2021 15:13:32 -0800 (PST)
MIME-Version: 1.0
References: <161489339182.63157.2775083878484465675.stgit@olly> <20210304.143347.415521310565498642.davem@davemloft.net>
In-Reply-To: <20210304.143347.415521310565498642.davem@davemloft.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 4 Mar 2021 18:13:21 -0500
Message-ID: <CAHC9VhTxfMOzABdAg=RO3k1cfyE2A2DEQ0gUQ9M6NVELpJVw7Q@mail.gmail.com>
Subject: Re: [PATCH] cipso,calipso: resolve a number of problems with the DOI refcounts
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 4, 2021 at 5:33 PM David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Thu, 04 Mar 2021 16:29:51 -0500
>
> > +static void calipso_doi_putdef(struct calipso_doi *doi_def);
> > +
>
> This is a global symbol, so why the static decl here?

To resolve this:

  CC      net/ipv6/calipso.o
net/ipv6/calipso.c: In function =E2=80=98calipso_doi_remove=E2=80=99:
net/ipv6/calipso.c:453:2: error: implicit declaration of function =E2=80=98=
calipso_doi_p
utdef=E2=80=99

I think there are some odd things with how the CALIPSO prototypes are
handled, some of that I'm guessing is due to handling IPv6
as-a-module, but regardless of the reason it seemed like the smallest
fix was to add the forward declaration at the top of the file.
Considering that I believe this should be sent to -stable I figured a
smaller patch, with less chance for merge conflicts, would be more
desirable.

Or are you simply concerned about the static tag?  I simply kept the
static from the function definition; removing it causes a mismatch
which makes the compiler unhappy.

Either way, if you want this done another way, let me know what you
want and I'll respin it.

--=20
paul moore
www.paul-moore.com
