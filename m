Return-Path: <SRS0=sWNN=AT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4111CC433E0
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 13:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11DF920786
	for <selinux@archiver.kernel.org>; Wed,  8 Jul 2020 13:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFa1NDiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgGHNZv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgGHNZv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jul 2020 09:25:51 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790D6C061A0B
        for <selinux@vger.kernel.org>; Wed,  8 Jul 2020 06:25:51 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e90so6366107ote.1
        for <selinux@vger.kernel.org>; Wed, 08 Jul 2020 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAjG52LoqLgSEs8RRx/MQptOOvcG8PJDfvUlsCKhJeE=;
        b=qFa1NDiUOtb6Mwvu0FPkhF2/ZPWzStQVl3CS3Jgzmbs0ZecvWUJ9n0Guql1dIHkLOQ
         yKfUGAd0a2yszUV/MhqBG2zvTbw3uRirVGFhRdMzpAYy1d6CD4IE9rtxfa5rDIYzbk7X
         kupcoSvrx/0R4UUc1BseZPXysHS3Fh2N3jd86s8EGMhrdm1ZH9zIDbV3Cz+mrXpI0JHg
         TCh0pF2YIlwavOwf3AvWHmE2sfA7x4lOHRABeHU4tO3Ae6zs8NtO4MSGnqjSFRd61UAQ
         cGT5gf89Wur2i/bJahH5R8dG0YtEHweaclvSsJn0zrL+M8W+ev/+kg3MLM4KnGOqkUQn
         5/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAjG52LoqLgSEs8RRx/MQptOOvcG8PJDfvUlsCKhJeE=;
        b=ne8pAecD7OD7qSSmyUCnb7xsnI2/+JrfQfrov3DhWor2TPRNRi9rwrke/BXP2i5T2f
         umWGq2KX/0WM272SgqGNx4sSOdFBfJAwVLrk0O4o0CZRKyFiWS6ATcVpOyi2P+XtMxev
         0JnScNrXJKVOgkuWgKrcEOnpZF4NpPAECJcKTCl7WhVr8oE6xbhbLDbEP30rwoqazJzn
         ukV32Gc8UtMqyJIwrylTOOftsIrwWPyajMoVcO34+knCmKOD1PCMdGQLhsr1qPw/14Kk
         3h7c34NYiu1CPWTgOMKidSjmTfEFuYrc39yxaz+OJKfxyLooLE6amTXkBNUWRAeqeuly
         7jYg==
X-Gm-Message-State: AOAM532zWLOzuSYbCdk2dHfF3Mb4OUIOInH5iBYhDgMx0ATlYF3/m4YM
        KolLU0EdGayxUayS6WMyX9nzt6ETR3Jgb+U0KAPyHEvy
X-Google-Smtp-Source: ABdhPJza3X6PxemBCj1PKvaNHDQXivnKJjdvxuwwr1zVnpLDEzDBY0ptefNBqC6YxJBpNp5j6Q2KU66uvJyfZqc3OmU=
X-Received: by 2002:a05:6830:10ce:: with SMTP id z14mr42594216oto.135.1594214750893;
 Wed, 08 Jul 2020 06:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200708112447.292321-1-omosnace@redhat.com> <20200708112447.292321-2-omosnace@redhat.com>
In-Reply-To: <20200708112447.292321-2-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 8 Jul 2020 09:25:40 -0400
Message-ID: <CAEjxPJ4Fp_0m9w89suaVfiM_TH-vuVwcWFNAp5hw2ZTPuNDcTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] selinux: specialize symtab insert and search functions
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 8, 2020 at 7:24 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> This encapsulates symtab a little better and will help with further
> refactoring later.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
