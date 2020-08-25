Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458A1C433E3
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 16:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2824720786
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 16:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RapDDaZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgHYQHb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgHYQHa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 12:07:30 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49462C061574;
        Tue, 25 Aug 2020 09:07:30 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id r6so2815154oon.13;
        Tue, 25 Aug 2020 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjGfeIk9l5icN6djyNEL6TqKfVYkE6E61keGU7ky82c=;
        b=RapDDaZ/1H+10Ln3sKtjoQLr62DQ6TQNJrfSZpYfbTXod+zCEEerFTuRCm7RcBtXmN
         NC0ne/5xEdgZcyPWavBK42tnNVW5UjSbcpu14cBuqxJO1lPwJMsZxbJACOfd6NFcqso9
         ghEy3/Av9ciPLTezFoGod5M2DnpYbtACi0h2wlTu/1iGYBd1/2UFmOz4HtU75Tk3ZHX8
         QkIN/JddIhgRHiYYtF1qEumZ7O0NfgEV79cJOlOhTr/8KbxeiTUV8Cxr0WJ+7WVhX7B8
         8ZWtRijjh+wrkryR1yjKwbz80mh03av9Qs03vfvBo9Ra3U8j8g6c+E0/wrOBfuG/Jqm6
         vsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjGfeIk9l5icN6djyNEL6TqKfVYkE6E61keGU7ky82c=;
        b=nqkEET36Ktn+BdrQ8dhydknstqn9UPo0awVz5fAgPzF6SxqW2H0Va0fqtPxq41UC3w
         jLPLkTWIsuQjwsSd+EkyJqdNUPCZn8XYp96y1Fya8LX64ahRKy+XAG1HjcKBpBkKiwpY
         MDXG6JbR/FTWIR1RD4uBLGi8G1FUegIoJwOJ6aZfUH/SwzW+rf7yhKRqofFLhoPjBq1r
         GUkCYfLbkSAOH/gl/HeZwR0mHoKCe+cKhLtKCHVotk8rB+Nrz/cI/QpAIFpolT5mCswn
         TYmmMIHeiHAn6W6D2RzV9v0lH7hlMbeNu6u79Ehp6uMUKyYMyM5k7V8sfI6sXoTKIYeI
         QYYw==
X-Gm-Message-State: AOAM5337S4RCr66ptpdM9DligbM2EITRnFfpltOOLqfoudbqfSKtg80Y
        dni2l/D5PvFyXTg3GnbjrFFukAR6OL1Fk0yzDgw=
X-Google-Smtp-Source: ABdhPJxSJfomarMJqUX0NZuLD3FY2ZNOI3YeCf7apWfaN8CGQHh7UUJzr3iHC+XJe3C88Wjj2Y9xGpnD4xi1RkDSy0Q=
X-Received: by 2002:a4a:b80b:: with SMTP id g11mr7562372oop.13.1598371649754;
 Tue, 25 Aug 2020 09:07:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200825152045.1719298-1-omosnace@redhat.com> <20200825152045.1719298-3-omosnace@redhat.com>
In-Reply-To: <20200825152045.1719298-3-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 25 Aug 2020 12:06:03 -0400
Message-ID: <CAEjxPJ4UYV5OqtumoN9tK5wAQbOjuP0tUKW6dTPgftWxbY+R-w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] selinux: remove the 'initialized' flag from selinux_state
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 11:20 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> After the RCU conversion, it is possible to simply check the policy
> pointer against NULL instead.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ec4570d6c38f7..d863b23f2a670 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2221,20 +2218,19 @@ void selinux_policy_commit(struct selinux_state *state,
>         /* Load the policycaps from the new policy */
>         security_load_policycaps(state, newpolicy);
>
> -       if (!selinux_initialized(state)) {
> +       if (!oldpolicy) {
>                 /*
>                  * After first policy load, the security server is
>                  * marked as initialized and ready to handle requests and
>                  * any objects created prior to policy load are then labeled.
>                  */
> -               selinux_mark_initialized(state);
>                 selinux_complete_init();

This isn't quite equivalent. The difference is whether
security_load_policycaps() has completed.  Not sure of the
implications but could yield different behavior.
