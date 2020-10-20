Return-Path: <SRS0=Dhgn=D3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B88C4363A
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 13:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C857D22247
	for <selinux@archiver.kernel.org>; Tue, 20 Oct 2020 13:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+1W/Rq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407500AbgJTNnY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45290 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407535AbgJTNnY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Oct 2020 09:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603201402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ak6/ioxfbn+/YRYWVOV79sGKIjWv1XAYt87Tnw0N69w=;
        b=d+1W/Rq4M+2uhLhWqPMSTyZSG6nJKZT5JGOqcSRT7h7Xh11Y3RHhGor7ppZQFBpxHSo5CX
        I7xbOgocoPIQZ0aLQj9nanYNC995CASSlqbtLAPT0e2BrG3eJeoNz+u+n1t/qgVUsmLL5F
        Gju4bpwjkKaCJHHbEFGcSBF0kmBuauc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-_vr0KPKlN6mCgtebaxI3qQ-1; Tue, 20 Oct 2020 09:43:20 -0400
X-MC-Unique: _vr0KPKlN6mCgtebaxI3qQ-1
Received: by mail-lj1-f198.google.com with SMTP id b8so854640ljk.20
        for <selinux@vger.kernel.org>; Tue, 20 Oct 2020 06:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ak6/ioxfbn+/YRYWVOV79sGKIjWv1XAYt87Tnw0N69w=;
        b=Gm3P+4uzzKS9ox6PuxV5z5haN8dFXmSYMyeRORVOnS/9fNf6qUAlqIgKxBh9QnrLbu
         DGsNVPVBppDylRtkpWLHxX2EqhTHFJDHUjyd9GbF7jLfqPrwPjyba/2lfm57r80E2Y1K
         +8hRb2uT6ZXeY8Y9dBQZ0x8rBTtzFVTtcsw7bWyxvu5xSZFyCi+GzGVFdIaYnBEseO0/
         Sl+NxHQBfOBBT0W+aDeNUAoDccls2k5ISyAD0/wztzBPWolBlmNhDC/QgfUvFWZM9LuS
         JgEpl+6XjRiULXBjsuiThYjoRATl+VgHcOBu5BQ82idWebeXoYzylQNeMWfD8GfXFrw7
         QBcg==
X-Gm-Message-State: AOAM5325psHJe6o0XGVQL8XX6BG/hw6MxdIAs4/rsDx0RQFgQo6g//ay
        JHohZ8LDjWXf+wBkkl4o+FnubcYree5XkuPN7HrDGjAOvcyX1oagHog1aWsks6L+nX2x16uNU06
        BI4djtljBB3g1wEo8yJz/Dh4PtEAOErZb7g==
X-Received: by 2002:a19:4a0b:: with SMTP id x11mr1085270lfa.354.1603201399009;
        Tue, 20 Oct 2020 06:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4ZLKPoIuto3HavbZANEWuUlzUJTDGw/8p106c0KkTFdR6npcE06imvstT7WvFRGlzJXoiWNQQpZtQLiVsQDA=
X-Received: by 2002:a19:4a0b:: with SMTP id x11mr1085263lfa.354.1603201398795;
 Tue, 20 Oct 2020 06:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201020132856.689870-1-jwcart2@gmail.com>
In-Reply-To: <20201020132856.689870-1-jwcart2@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 20 Oct 2020 15:43:07 +0200
Message-ID: <CAFqZXNt2h_Bp2piOvimndrQLW6si4s_AczGhe_YNFo8F2mFv=Q@mail.gmail.com>
Subject: Re: [PATCH V2] libsepol/cil: Give error for more than one true or
 false block
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 20, 2020 at 3:29 PM James Carter <jwcart2@gmail.com> wrote:
> Both tunableif and booleanif use conditional blocks (either true or
> false). No ordering is imposed, so a false block can be first (or even
> the only) block. Checks are made to ensure that the first and second
> (if it exists) blocks are either true or false, but no checks are made
> to ensure that there is only one true and/or one false block. If there
> are more than one true or false block, only the first will be used and
> the other will be ignored.
>
> Create a function, cil_verify_conditional_blocks(), that gives an error
> along with a message if more than one true or false block is specified
> and call that function when building tunableif and booleanif blocks in
> the AST.
>
> Signed-off-by: James Carter <jwcart2@gmail.com>
> ---
> V2: Put spaces between items in argument list
>
>  libsepol/cil/src/cil_build_ast.c | 44 +++++---------------------------
>  libsepol/cil/src/cil_verify.c    | 35 +++++++++++++++++++++++++
>  libsepol/cil/src/cil_verify.h    |  1 +
>  3 files changed, 42 insertions(+), 38 deletions(-)

Acked-by: Ondrej Mosnacek <omosnace@redhat.com>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

