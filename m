Return-Path: <SRS0=sjmt=CJ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F259C433E2
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1209F20719
	for <selinux@archiver.kernel.org>; Mon, 31 Aug 2020 14:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4Bl0XRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHaONb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHaONa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 Aug 2020 10:13:30 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855B5C061573
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:13:30 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id z195so1075467oia.6
        for <selinux@vger.kernel.org>; Mon, 31 Aug 2020 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHNeb6roDR+k3mKU3abtjv6n0XyGaknlB7uUH3WtGUU=;
        b=P4Bl0XRo7ckRPkz4UHRCfI4fo4qpHMvW273BLLGA3PukAGcyfT3Uy4ZUTFGcuK6zdE
         0AD7muZOnQ2U6tZ7gq7Ocem+rBfEz14h3k/7fk1rHgdEsOuG0oj1eFxLjVoSP5nSjTP6
         Q4B8exxJeQj3ML/O93M3Alp3hAvR2BmZVqOeoNeJ+r8G8vqvn2oPWp2JKODsR1ETHAsx
         2NqDl29vlUDmvLIHrieR/S2UuYF+0mlI/Y57I+mLLIKutZSqX6zQ1isyjECcIragUz9X
         i8AlcOIcQAFXFGKGS/6Y/mdZNOLPsUqoG3g0V7d/WN8NtrDLiv5o9jFCNQEr9d/II74e
         ObMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHNeb6roDR+k3mKU3abtjv6n0XyGaknlB7uUH3WtGUU=;
        b=HdKaUv7Kjx3yHhluGfwIB0fUWWiok51EpJ6uJZor0CySOi0BnoaPNAogvSYUu8KBWl
         +x1ZHNO+hVYlJV5ky5ijHS4Qj6s3xj015TOD/C7PiCvBzIAYDNn1wKqTUH2f5az4K063
         o4U8osAX9gtzgBrjJ1vR7Yf1mieDkldENlJ1iQbVIhVnDBDos9eIBe9awmreWSrmSVVm
         T9U6mZgdAwnpAcWyHbv14uxdg572DpFmg1UkCIGk02RO43EYI7LDFXMu2FezO8Yvv+I5
         cLBf8e5ee9TeaODMytQNmVfG3v5bdIrt73EWPYCgBtSp5rGms9+jpemVvxTDShseYWcd
         CP8Q==
X-Gm-Message-State: AOAM530xFg0lVP1BOrNiQyt3VeSiYCUntiLdHf1bv3bfOsicH/6wmV7X
        q1HszHBGSZJR8UDuZcSPfcMKJ02BZIuDziagdaRU+7t6
X-Google-Smtp-Source: ABdhPJwoEwfh7pdGgtiXOt7KRTuWfdaqzkxkd3tt4MLBmjcgLbCz8Q9nE3HSsYXZOocz2kfMYDKb9W/F3CrNPeE2eww=
X-Received: by 2002:a05:6808:310:: with SMTP id i16mr804147oie.160.1598883209997;
 Mon, 31 Aug 2020 07:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200827081100.1954467-1-omosnace@redhat.com>
In-Reply-To: <20200827081100.1954467-1-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 31 Aug 2020 10:13:19 -0400
Message-ID: <CAEjxPJ7vAvyamDEUK1oAx9kyQHJiUoAKySd1fkfNwCHMukKw_g@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/sctp: bump connect timeout to 4 seconds
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 27, 2020 at 4:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The current value of 2 seconds causes transient failures too often in
> certain slow/unstable environments (including the nested KVM Travis CI
> setup). Our experience from downstream testing at Red Hat (across a
> variety of HW and architectures) has shown that a value of 4 seconds
> yields only very sporadic failures.
>
> Therefore, change the value to 4 to trade off some testing time for more
> stability.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

As much as I dislike relying on timeouts and making the testsuite even
slower, I don't have any better solution.

Acked-by:  Stephen Smalley <stephen.smalley.work@gmail.com>
(feel free to merge it yourself)
