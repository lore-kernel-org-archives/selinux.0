Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81172C433E0
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 14:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53803206C3
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 14:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZHBogpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgGIOdT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgGIOdS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 10:33:18 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB877C08C5CE
        for <selinux@vger.kernel.org>; Thu,  9 Jul 2020 07:33:18 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 5so1809941oty.11
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iEnLc2N93uUxTjYI0qzbJTP8CqCcVFnXdCj0036lb38=;
        b=sZHBogpyGeV4xnsS2tu+Endm46Yw4++WplGg5lHt2ZCsjqygyR8E871CScGno0GLr9
         PvS6LMGhAnkCxjS4RTQZN1zcZM97iCkuB6eH6KP3eWJRdac9gvWwyzqFh1nLcZZHboGD
         gYrxoJJ7rmHMvzPry7rmGqSGlkHRixEdCH1LXFJxjqymC6YDdAuzm5jkvkdXmdt6XZ9R
         GRjsuzDU4giJM3PTC9k7080xnb5LR5kihYZYNl5mNJhM7pcMw50n8qPR1T5hx6RxzveM
         1RM5JMRdRqHu6ix7wubjJzhmklXeR9AVvx8wx5rJngEW0nbYDXN7l1JLifneCjonlVsE
         KJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iEnLc2N93uUxTjYI0qzbJTP8CqCcVFnXdCj0036lb38=;
        b=neg5QTMQmfwhrYjxVJTSPlUIlM83BJnd35Z3+WmafuLIfv2n9nEZhL26p0SI6d3gYA
         d1iTssS+LH2OUKGvBe0KS7FCzaSKkFcASOCWG7uH7RVWjPQZdoTAs+GPiwAGCG4r/REe
         ePOWxuNTqqxnIdSiHOMqPe3L6Am2EWJ5r+vIhEudMteu8oYmXpvJSe4angQrZX48TlxD
         G0KIwiMbldLdgiQ6E4dkitApEwwlFjZDms+PqIQF9a6Uovgpj8dRhlMpLz+8Q2ld8xIf
         blGZuUMTUMGmrzBCHq2Wz/kDpUPX+K+IoZ7OUwZRSdVVT4xeGtSGMjJSs8r9g/7xJwNE
         4Rgg==
X-Gm-Message-State: AOAM533J5JSIytJCG5oB1NsJ04JrWQcxfcmkMoyhAVF98qY5n+iZhWc7
        ugTKX3iUG/iRKYEtg1m9JwQchceBo9nDM3frfE7Hlw==
X-Google-Smtp-Source: ABdhPJxszi/CoBuIl5vUf6NQF4CQe3B4bR7mT7FdXn61qSV9tTEV1VN+/+1x6aK1MsG/hx7f6flwR3nro0/zPQewrws=
X-Received: by 2002:a05:6830:1db5:: with SMTP id z21mr40210008oti.162.1594305198118;
 Thu, 09 Jul 2020 07:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200709090352.1681563-1-dominick.grift@defensec.nl>
In-Reply-To: <20200709090352.1681563-1-dominick.grift@defensec.nl>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 9 Jul 2020 10:33:07 -0400
Message-ID: <CAEjxPJ5zZVu_rR+YZntVuhUyLwHFWYekkWOH2UKVTKnhU_Nb+w@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH] avc_rules.md: mention secilc with the
 neverallow statement
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 9, 2020 at 5:04 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> I was unable to determine whether checkpolicy can be told to disable
> neverallow checking.

There is presently no way to disable neverallow checking for checkpolicy.
