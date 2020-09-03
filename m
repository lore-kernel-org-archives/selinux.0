Return-Path: <SRS0=Ig95=CM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF9C433E9
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 14:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E8520716
	for <selinux@archiver.kernel.org>; Thu,  3 Sep 2020 14:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmfiKE0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgICOvu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbgICOPT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Sep 2020 10:15:19 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8ACC061247
        for <selinux@vger.kernel.org>; Thu,  3 Sep 2020 07:15:05 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id a65so2822405otc.8
        for <selinux@vger.kernel.org>; Thu, 03 Sep 2020 07:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XCLAG6BMNqZ/drzVbsicfkr0tCCxO5ChaIGbPHBKjU=;
        b=BmfiKE0mhHUeglTzqprdDpE2DCyp3+LnsoJy56ZlwWw6bPb6hnagzVPujuRJCwGx1J
         ctZI4OLnd97WvGXOuOCHFSk3KgVVpGyZ9nJNQ5oeRo/n0u1AiFrIUZ8TZPkC54U8MY0A
         N1IIP26Bqx4xLGfrjXR0RmrYKk8N9rrWYKemBKTDt50utA1wtYCR+w6At3pDW7VO/Yxy
         ID1IXeu32KTgIK4yrdkLDsfACm+axDGwMCYYmkf3GVFq8G1PPWo+P8fRqn53fZYMC8Ny
         U89WvC2HPZ36N3bwxc5gJE7wknmwBimDJ1EhKtgLiw/olJCeBVqdAd5jjY2RhLyrcSHk
         65eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XCLAG6BMNqZ/drzVbsicfkr0tCCxO5ChaIGbPHBKjU=;
        b=Q5z0JYRhsRTtbMbzuVgBo7LEJ4H2/VO3C1bRFCbZS6yyGsGTI5q1vPL9cp9wF+aYoO
         MhO1/kMQYzznvaCc6E8FYb7ktXm3mJE/UGfxhiuCfHfOuJxBA5RD+6uhdhbpx+yevigV
         1uBzT9DayrkEqvPh7PZBH335RhtwVjsfFbMGB/J36/AgDhVRLHeU0FliVLkK3L9E89Ym
         rot6qZcpBgol4yMf/OikcgQDBichdaR8NV3NQvTfYMvdaw43S1SX5o6wC6+3hLa57+rv
         luHN+4Kbo/MezczLGtid4lyNmjNgqIynvAjAOVYzDPJ6POiYfJweHCvS9rZ0avViOPer
         dtpg==
X-Gm-Message-State: AOAM530rYdmX84IaanSQyEuE5D6gpFmfnUeJHUKUap7nYHlTPf3//v4Y
        BAolSipqAiBjyv1nSLyKf93BSK3v71OFw5HTJAUUdmD7
X-Google-Smtp-Source: ABdhPJwOGOb1RVY4jhwLQokil+wuYzcdiX09ZjC1zyETpC/7060rtLG0jqhNLoyNLQqVV92LG5/1D/Ai0toj4r5d6q8=
X-Received: by 2002:a9d:7a92:: with SMTP id l18mr1716758otn.89.1599142502395;
 Thu, 03 Sep 2020 07:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200903072812.2281009-1-omosnace@redhat.com>
In-Reply-To: <20200903072812.2281009-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 3 Sep 2020 10:14:51 -0400
Message-ID: <CAEjxPJ7amfVLYxknKtaFNqtFWsLW71PaFmgB3a4YnhMmR=wW2A@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/Makefile: add kernel version check for watchkey
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 3, 2020 at 3:28 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The corresponding header files might be available even when the running
> kernel doesn't support the tested functionality, so add a kernel version
> check for this test (key notifications were introduced in kernel 5.8).
>
> Fixes: 34b7da22ef88 ("selinux-testsuite: Add check for key changes on watch_queue")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

Merge at will.
