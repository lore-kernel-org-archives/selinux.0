Return-Path: <SRS0=k17o=CX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35627C43461
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 17:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D671520EDD
	for <selinux@archiver.kernel.org>; Mon, 14 Sep 2020 17:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1gyyzDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgINRwG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgINRwB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Sep 2020 13:52:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D7DC06174A
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 10:52:00 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id y6so778930oie.5
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2020 10:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=733o04NZTSb4ERGPYCtVEKKtkSNX15cgAl0RcjEvsu4=;
        b=u1gyyzDH10JH4nA8vOunO4voZVWwix+3FWeoV3SprwDt9bGwibWnLS6+pGPIH3O2sS
         gD34u+RGbur81fZFTt9NeGO+F/pPN2ut5ZW9YS7LB8WHTEzattD/5Ymvw/ncIbxZdcQR
         Ai7GCS3FR15meJJxtTglMg/6MEz8fnDWRWscEfc5KDsB+eCu+rAub6AOQqSwsonVF8vi
         VP42wbuJllg0Aiw/omI63cgwnY8tBa0XgqoxbrLhou3jUXwFveBiocF2n3vaxRJkNNwu
         UKVqSxx6eLvI0EHpqGw+Eud+byFnbDcAsryADuh9pmdjUZ4KLSRRCEy3WR0Jbgb+mhxE
         rvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=733o04NZTSb4ERGPYCtVEKKtkSNX15cgAl0RcjEvsu4=;
        b=RedAKu7/JBUC6yo1XREUjPmQpjwLgJ3RvZ7/SMcRQIFD2URIHRRQMDmWRvPusOchPD
         fdCgZ0ZwGuaBw6BcI+rA2dwFatFoECSl5yEr98rilg/YQc18ohatDPI5VykO4oDhK2pk
         vY7xT70R2KwpC8Qw4+9s5WFRucEzMb38F6tGK1j3KI22KCi3yGiASQufMWy420roAhjO
         VKCnV2UiP4+8WDAS+Ld0d2si3HKGKooTk4sylTFpHqoOn9rAcc+mqoaRq3C0i+7FdOyb
         B2K78jLh01PPKueqMoiCguWmUSZTCQU6YDFeXixQmHuDichS4dufETTF+2/1dkC2GTC5
         jpNA==
X-Gm-Message-State: AOAM530umFUO6qzHu7Fu1djeQn9sVts7dR5wGnBBbgh2vg6DJRgtbtO/
        gx1+72V4gKciDsTUQM2jSHTuw2jFbuwt/5RUM8E=
X-Google-Smtp-Source: ABdhPJzWoKZxOEvKY6g2OLA0lg+2xm7fMX4vTMJd6FEhiyxBYqtjDbyiSx6Rtv+n0lM4q4oycAQ8NOzvfkRwWZl/zXE=
X-Received: by 2002:aca:ec53:: with SMTP id k80mr351314oih.92.1600105920379;
 Mon, 14 Sep 2020 10:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <6a791504-7728-3026-17ee-c22cbff8c3d1@gmail.com> <d4e55b23-41da-902d-8b6d-83c9c47e7618@gmail.com>
In-Reply-To: <d4e55b23-41da-902d-8b6d-83c9c47e7618@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 14 Sep 2020 13:51:49 -0400
Message-ID: <CAEjxPJ5FXkArFZgC2Ps56Q_odPGfM5=O79puG3PEtuuYxKxU+A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: allow dontauditx rules to take effect
 without allowx
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Sep 12, 2020 at 3:54 PM bauen1 <j2468h@googlemail.com> wrote:
>
> This allows for dontauditing very specific ioctls e.g. TCGETS without
> dontauditing every ioctl or granting additional permissions.
>
> Now either an allowx, dontauditx or auditallowx rules enables checking
> for extended permissions.
>
> Dontaudit rules take precedence over dontauditx rules and auditallowx
> rules take precedence over auditallow rules.

I'm not following why you are providing different precedence for
dontauditx vs auditallowx.
Regardless, since this changes the semantics of such rules I'll need
confirmation from Android that they want this change in behavior since
they are the original developers of the ioctl whitelisting support and
its primary users to date.  We may also need to make the change
conditional on a policy capability if backward compatibility is an
issue.  However, I suspect no one has been relying on the current
behavior for dontauditx and auditallowx.
