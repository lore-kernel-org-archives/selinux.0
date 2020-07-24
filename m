Return-Path: <SRS0=Hma/=BD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8076C433E3
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 12:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF10F2065E
	for <selinux@archiver.kernel.org>; Fri, 24 Jul 2020 12:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuiJHtgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGXMTF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMTF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 Jul 2020 08:19:05 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD21AC0619D3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 05:19:04 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 72so6831637otc.3
        for <selinux@vger.kernel.org>; Fri, 24 Jul 2020 05:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9rVaVeK70x/Zf+xewHJz6PJiKrHeOkuqL5DgCwkdTus=;
        b=RuiJHtgfB2KBZ660uqd4kbfJIDK+QKO9IeINxLZRXijM6CqztKsIOkaCKNv3FxxKW1
         eXjW6vu+l1AtKRna+ZvcNpwuiJBBFr2F59X3jVd3b0ZKkOggQNP52xdKDeTZeCeiDa4x
         A3noPjBz+XwGATLz4gESpTbvPLmll+6sJWssj/dl/zxXTdbsOjiv+X3sXH5cjGHUPIKx
         him4v0arAwpRrt9LBqyKxz2+OpatvL485SRLbvjMDce7T7ZT36yIgSyKA1rQlbXK2vWH
         b+QKsblIUlPEEXfJO+hdUUXPIJgm+sua0v/qYbiNBVPxzkfl8UAFqmv1vGlSCSrEfLVY
         H8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9rVaVeK70x/Zf+xewHJz6PJiKrHeOkuqL5DgCwkdTus=;
        b=hMp29urKp0AP9YUwNNcs5T9nFpGr2QhtGWJFzDJxaOuIIFIFa1x6f0d8AzgWXR7aQO
         dRfdmHnKL2HXUooy8KzgwYUM1X18aqK0hS17ZEPmptR7Sh0ZGSb9aVCYPe4/OTQ+B67w
         ZPCT+lnQTJ8693XxwSKhyK6/ydKUFt7EAJn1Vl71VEb5Bs2r5HfFjkoj7UtpXTlMs8mq
         5QaJG6xrSNax8NuXfWePMaDlgKnjufHCHUX2lHOjVjFXZSxXyjYpC/ftqn2CJ4YW61p5
         pgFGF81osn6IYvdnIkA7TF4oIHXd1jq+s5BeR0bYRl9+1F/CZ77QkmLrB/yRboH3oUch
         9Icg==
X-Gm-Message-State: AOAM532g3wO9LrbhX3QCX76AdOZ6fJndbVsE7PTLctVEyN9INGocs62W
        klr8rmcSH3i2W3UeUwufUaDgHZ/X/GvMJn58LG+PYw==
X-Google-Smtp-Source: ABdhPJyaDsHOl8meLL0A3PhAQ+FuRelcoi9yMcDtc5YAsS9hgrasQ28Ngcfg3fnc33jJQEqoVfJq3xD0vWamoFPESAc=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr8742150oto.135.1595593144316;
 Fri, 24 Jul 2020 05:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200723223827.16027-1-mike.palmiotto@crunchydata.com> <CAMN686H-0KVjM7KpMuwMP9J1vOd00oZ=9agm_nEvUUP8fMfVJg@mail.gmail.com>
In-Reply-To: <CAMN686H-0KVjM7KpMuwMP9J1vOd00oZ=9agm_nEvUUP8fMfVJg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 24 Jul 2020 08:18:53 -0400
Message-ID: <CAEjxPJ4=UEgrXytEsPF20EvyNdpDpL7VcHYC1mMdy9C9QW7AxA@mail.gmail.com>
Subject: Re: [PATCH v3] libselinux: use kernel status page by default
To:     Mike Palmiotto <mike.palmiotto@crunchydata.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 23, 2020 at 6:41 PM Mike Palmiotto
<mike.palmiotto@crunchydata.com> wrote:
>
> On Thu, Jul 23, 2020 at 6:38 PM Mike Palmiotto
> <mike.palmiotto@crunchydata.com> wrote:
 > > diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> > index 86267ff8..cbc7dbbe 100644
> > --- a/libselinux/src/sestatus.c
> > +++ b/libselinux/src/sestatus.c
> > @@ -316,6 +326,23 @@ error:
> >         return -1;
> >  }
> >
> > +/*
> > + * selinux_status_loop
> > + *
> > + * Run routine for checking kernel status page in a listening thread.
> > + * Falls back on netlink socket in the event of failure to open status page.
> > + */
> > +void selinux_status_loop(void)
> > +{
> > +       /* Check kernel status page until error occurs */
> > +       while (selinux_status_updated() >= 0)
> > +       ;

Also please fix the indentation before the semicolon above.
