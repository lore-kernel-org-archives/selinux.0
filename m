Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5160BC433DF
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28BF42088E
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 21:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bWeuEGbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgFQVj0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFQVj0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 17:39:26 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD143C06174E
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 14:39:25 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dp18so4176141ejc.8
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 14:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ImI8Ok+4hTrVgMnlUOodKQsTvi7BmFR+KaXLQR11ZeI=;
        b=bWeuEGbxKUp0jXrRtQ/5nd/WrZaDrcxBK6Jyx8TLWnAVAx3o6u9Sqc+OZNGYldS5ed
         jIkDNUmJId0Z1cmQzbrgTgrHQhpdtSRR3HltaFucCJfncZJIhyNbr3xWbH05F2HoMQFS
         MyyRMQ2yKC1B8mI6JQ53DdiNlSiD9w5QPcU0BmcgaDdwjCQeXGDWQjq76W5ISLWOF+Zu
         IDhMdmHHGwe+kOHXmkkSB52LBxhlfAy6iHSRoQKoeLlyJnoMVwPbBUhxeKV3QVJx4+0f
         9GZElLuH4ywSm2+p9yievsmbujUlOkEqyCIGA3086WPOiUxLd5ow0xCLPMSrifpozBkQ
         mHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ImI8Ok+4hTrVgMnlUOodKQsTvi7BmFR+KaXLQR11ZeI=;
        b=P37Iw/D+HAJZ4U3TD2Sv/Ibp39ZAt44WR7EcjBK/QSvjNsC6l2+uoVbmqzkIsAVF1U
         xCxlyxVvXo20e5p7y3fZg5W7qGN3AGM6oBQG5B/4XLmSuENSSR3fHjpoSsRzLzGiIlbi
         uSFjiYLDC//Hth00vzxjZ1SoYHr+x29vAPM61kHcECnifzWyaP7fQ0z4TAtctzPjPK6h
         Cf8IpZ2C70olgnTDGusePCr07xuZ0VBD9mwryeiqaMcw4tBMz2UVX5kkqfA2RD8DWZiL
         JWRZUuQNTQqLbPe2ipcURG2Py8fps8JyMEYCFEcifVoFrWhuGQMDECLhqtB0QUNlv0Wr
         pbIw==
X-Gm-Message-State: AOAM531pp/Bh9c3UVcDA2NjNWRjHwQC8+PHdtQy6ZC5GtjTSVw5zM3tD
        Oi9GUmNL2/puL+dAKWSmrTddQeuyxcqjKCR+aHWU
X-Google-Smtp-Source: ABdhPJzk7u5uzrlLrFOB9CSpiyqTMZ6XeRa6IVwfWOgSjylCa8wf4CDed5CzCQUYQmqTFjOu3KaiA+TOznkJdjqC7oo=
X-Received: by 2002:a17:906:ecef:: with SMTP id qt15mr1075750ejb.91.1592429964536;
 Wed, 17 Jun 2020 14:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200617124028.14130-1-trix@redhat.com> <CAEjxPJ5uGV-SjKL7v5J=7YYEBOjyHwK625SX8fzCrbatuB=9hg@mail.gmail.com>
 <CAHC9VhT_mAd8pkboQX1xQpxmYkFvK=HW3pUB8_UzbgnW4+=RjA@mail.gmail.com>
In-Reply-To: <CAHC9VhT_mAd8pkboQX1xQpxmYkFvK=HW3pUB8_UzbgnW4+=RjA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Jun 2020 17:39:13 -0400
Message-ID: <CAHC9VhRb7W3NkXADz9+tW_FVNE=gR1-hikHdBYGg+O-ZAdY+bw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix undefined return of cond_evaluate_expr
To:     trix@redhat.com
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, weiyongjun1@huawei.com,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 17, 2020 at 4:51 PM Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Jun 17, 2020 at 9:58 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Jun 17, 2020 at 8:40 AM <trix@redhat.com> wrote:
> > >
> > > From: Tom Rix <trix@redhat.com>
> > >
> > > clang static analysis reports an undefined return
> > >
> > > security/selinux/ss/conditional.c:79:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
> > >         return s[0];
> > >         ^~~~~~~~~~~
> > >
> > > static int cond_evaluate_expr( ...
> > > {
> > >         u32 i;
> > >         int s[COND_EXPR_MAXDEPTH];
> > >
> > >         for (i = 0; i < expr->len; i++)
> > >           ...
> > >
> > >         return s[0];
> > >
> > > When expr->len is 0, the loop which sets s[0] never runs.
> > >
> > > So return -1 if the loop never runs.
> > >
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> >
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> >
> > clang didn't complain about the similar pattern in
> > security/selinux/ss/services.c:constraint_expr_eval()?
>
> Related question: I appreciate the work you are doing Tom, can you
> share how far along you are testing the SELinux code with clang?  I
> ask because it would be nice to roll all of these patches up into one
> PR for Linus instead of sending multiple updates.

Regardless, this patch looks good to me too so I've merged it into the
selinux/stable-5.8 branch with the others.  Thank you.

It would still be nice to know if there are other clang failures you
are working on fixing or if this is it for awhile.

-- 
paul moore
www.paul-moore.com
