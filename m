Return-Path: <SRS0=EYrt=7J=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F55AC433E0
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 13:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74728208FE
	for <selinux@archiver.kernel.org>; Wed, 27 May 2020 13:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izY2b8PN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387977AbgE0NQ0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 May 2020 09:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387942AbgE0NQZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 May 2020 09:16:25 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A829C08C5C1
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 06:16:24 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id z9so16807515oid.2
        for <selinux@vger.kernel.org>; Wed, 27 May 2020 06:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vH4wmWgxnUo3upNgzHLqVtITPqRF/T669Mxzd3x+5rk=;
        b=izY2b8PNOch9x/NTpp8BZFcGOvW4+SWktQVBVBx47knPRgqKKW+l5zfa7i2j+q1QTy
         3Gj9iqc/S3w12rF8zymVwb9gEUru22t9w2KlG+FR7DfM/1iixR56CO8uF8Sr/bL1VQwd
         Jtxx2cYT1KhmgUv5pfXD6SZUsrF5zmZvDsUMGHlg0j+AY1FL0U2oKgnHL6d4OQJy3L/G
         UnjUbWGhV3JSotGl/wdZnsYDYyAUU5AhqzU6aAOKhYWVgWC3gxlZXPPfp8Ia174Gt4B4
         HBWcSAwLq+2Jv8YfT0WvA02Ne8TXqwIUIfTZ6F/8BQEFd9P8+h2W9hCGmaFNfUJx21HE
         k+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vH4wmWgxnUo3upNgzHLqVtITPqRF/T669Mxzd3x+5rk=;
        b=IKkj4yYrtWLbGPJh2A1l6wGxpCo0SvAYQDqGd7/DTo9nHUkfjQC4M8l5PvUupSs526
         PdumhiOi8ewIsOoGuo9T0yTwkUxn+J4JunLhEz4vZWeKJqzppYT8cYpGo5TBwhK0lB37
         nm0tGBZ5jJzHPU621MvP4Gsh38k8wI7zDQajnfMxQ040xkuYPHDEJbCV6pTtvUeo7Xbi
         EuEy6uN559hAcpuKQGtET3ETlbL3CgMGF6QqaWTYKGY4Jw6X9GJJU/VYavYaqWqdr2Gm
         gK2gXz1PnAMGhb+rlRk68LqV5I5wUa8FBlFv83lFTTiUjA9uBpDxTrmCdX+AOI5r6B2Y
         ev8g==
X-Gm-Message-State: AOAM530jD7aRVWVshlJdzJORF6CE0uQVC4dGuLHTZzngU33afm3OyCPb
        xMyOFLzVIDoALW2Lv+HD/AbLSXJQ/bL4AvR6YSesTq20
X-Google-Smtp-Source: ABdhPJycElJNQd7eZxSotzJm8tb94VKQf3mpP/N8yoIBkZbf3cFgmgIVS0VNyyr5dJhdr8SEqHM7klTt7rRO3FTcfXQ=
X-Received: by 2002:aca:3d09:: with SMTP id k9mr2484132oia.160.1590585383882;
 Wed, 27 May 2020 06:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200526185058.42827-1-jwcart2@gmail.com> <20200526185058.42827-2-jwcart2@gmail.com>
In-Reply-To: <20200526185058.42827-2-jwcart2@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 27 May 2020 09:16:12 -0400
Message-ID: <CAEjxPJ4hG5ou+c5BY9g7BMBV1mCcVT5PEpEfuv_4WjNW2+NY_w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libsepol/cil: Return error when identifier
 declared as both type and attribute
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Topi Miettinen <toiwoton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 26, 2020 at 2:51 PM James Carter <jwcart2@gmail.com> wrote:
>
> CIL allows a type to be redeclared when using the multiple declarations
> option ("-m" or "--muliple-decls"), but make it an error for an identifier
> to be declared as both a type and an attribute.
>
> Change the error message so that it always gives the location and flavor
> of both declarations. The flavors will be the same in all other cases,
> but in this case they explain why there is an error even if multiple
> declartions are allowed.
>
> Fixes: Commit fafe4c212bf6c32c ("libsepol: cil: Add ability to redeclare types[attributes]")
> Reported-by: Topi Miettinen <toiwoton@gmail.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
