Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7EEC433DF
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 13:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B4BB20776
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 13:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcEerde5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgFQN6s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgFQN6r (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 09:58:47 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89305C06174E;
        Wed, 17 Jun 2020 06:58:47 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id i74so1864173oib.0;
        Wed, 17 Jun 2020 06:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eorYSI4kx7e22DHninlhRFcMQd/uFdD7qtd2CZBW3V8=;
        b=HcEerde5q4FsPwHzHd40ZoWl8VfokXhhEa3ioIzfzPYVCXdK7stl038k3iAwVxirkW
         HoL4+REwXuV7Ijb4LiLKpixecTvO1DlW/4JX7bqQykyH2EvcH1ubRRF9gGu8HaiXa26F
         +hPaBbGl9T3tmwYYe0kIg9jggMazzfJDFjayCGL3o95lyFL5lLq8JLbH43qKQTw3LdvE
         LoRScNGy4XBOMrSuBoJ5W4fB65TDFU+gon3hGmnhsVLWUibIjWm1xvPkdSClLhqWqgJT
         JhyM46YZmcueaDu4a6v1FE6qpsjbpm0Zrd/hriPUOws07+snWV7/F+YX7sFkKxPGYmyf
         B1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eorYSI4kx7e22DHninlhRFcMQd/uFdD7qtd2CZBW3V8=;
        b=oxT1YUD7u37KzFyjhlj/3FjnXnotm6bncMPOXEvLejhq0lM5aii7R41d4VuZx19bcM
         TN3kecn4yKMnr1hwPu3j5AguXYd0bsg+Cd1xxeE35dqVYoBA8qKptl1h1349u84fw82p
         WkR2DpscwdVgilZSpeN71prdbXl3GUw+BbV/zjl38HADMuYZDeFgVDfKDMZ0X+rnHFrR
         ZbZ7tlzd4naNtVz+GyHLeHmreqdkTiI+g25fhMGRruOhokrDtMeRv+mKU+SKJgUo8kvH
         WZCcBTqNWT43CwpWlm2PSXIPBO9ydivCjsJA7EMiv9BB6BXgz8J3o6sKLksd4lpHF078
         TV7g==
X-Gm-Message-State: AOAM531Z6lZMy9HIStq/ZD6dJy3mPfdu//56bmKfxBQ7eK5cCPhqfYMG
        Q1Wbazdt6BPh5XtZqoT+LDzWRtiL9+/+1FDdsHPXAMlF
X-Google-Smtp-Source: ABdhPJwS8XlvZTqpLBiYZTp/YxzhuUzRvkvoBSCtAiWjZiXL07CBZlnr2rgNVVVwz5sDViq2xgLT+Z3197U2O/X6hjU=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr7083073oib.160.1592402326786;
 Wed, 17 Jun 2020 06:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200617124028.14130-1-trix@redhat.com>
In-Reply-To: <20200617124028.14130-1-trix@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 17 Jun 2020 09:58:35 -0400
Message-ID: <CAEjxPJ5uGV-SjKL7v5J=7YYEBOjyHwK625SX8fzCrbatuB=9hg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix undefined return of cond_evaluate_expr
To:     trix@redhat.com
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, weiyongjun1@huawei.com,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 17, 2020 at 8:40 AM <trix@redhat.com> wrote:
>
> From: Tom Rix <trix@redhat.com>
>
> clang static analysis reports an undefined return
>
> security/selinux/ss/conditional.c:79:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
>         return s[0];
>         ^~~~~~~~~~~
>
> static int cond_evaluate_expr( ...
> {
>         u32 i;
>         int s[COND_EXPR_MAXDEPTH];
>
>         for (i = 0; i < expr->len; i++)
>           ...
>
>         return s[0];
>
> When expr->len is 0, the loop which sets s[0] never runs.
>
> So return -1 if the loop never runs.
>
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

clang didn't complain about the similar pattern in
security/selinux/ss/services.c:constraint_expr_eval()?
