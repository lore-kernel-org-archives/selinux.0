Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAF6C433F5
	for <selinux@archiver.kernel.org>; Mon,  7 Feb 2022 17:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbiBGRDs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Feb 2022 12:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241385AbiBGQwX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Feb 2022 11:52:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBA74C0401D1
        for <selinux@vger.kernel.org>; Mon,  7 Feb 2022 08:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644252741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2SjZDex0SCJOjPXrkB4gDwjTI/FsNHK/bFrxgZZPO4U=;
        b=MiDDSmiHVrGAjNT0SbbVtrZF0WQl8zhjVveUIGCPbl/yWJ56myvC7Ngl4wIfHEA5SHXlgN
        RL9cJWB1lDQhubGX942FizXJQiGcOp2u0sZiIFMNDblj6pqCDiFe6+G4l6uWII5+mW8FKs
        USBj+Q9GD5KZWRGoexLyAZpeZ1D5tEs=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-534-FCH1rolXPl28YVJ017yjfg-1; Mon, 07 Feb 2022 11:52:20 -0500
X-MC-Unique: FCH1rolXPl28YVJ017yjfg-1
Received: by mail-yb1-f198.google.com with SMTP id c5-20020a25f305000000b0061dd6123f18so2913094ybs.17
        for <selinux@vger.kernel.org>; Mon, 07 Feb 2022 08:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SjZDex0SCJOjPXrkB4gDwjTI/FsNHK/bFrxgZZPO4U=;
        b=qL1sPKoN+UgD6AwgIHlQZhSY4GhtB/zLWVGFMe37SkOVunIEYEm31572jZbTdHWrT2
         sd6ZZHWdj/S/BpCWx/iADVNUO7nd3XxHQOWOg3+GxAz/vJgHM60qh9FEVO1L3rBxHb4X
         44dFMLz+1UlMm4lMNfSqNOxGQdgjWl42JCB860mlcrjc+V89Dzy530EaHhc0LIoMEGmX
         HkazfhkSOAfhk/gL48/YAPhPN8/nXqDvawcWVckUl22yTGebfo6G/a5HaCNsj0A+loQ0
         AWoaX61pxkpN+i4wwihz5ww4T3FUBD8c+qeaif/AK8aRTApglgSsqsOgbIi3ExYEusIM
         lnrg==
X-Gm-Message-State: AOAM532Rh93opP5dHsbXC1qcwoykb2UeZ08MGLwO5Qbd4l98mthGEzMl
        WXTi9r2dU/TIHBwfNNsEg8TNbRQ6s+Ki4zSw02yC72uBuWUGQVzjy/gDjBYcOQw76f8pu4R749N
        n8Wc0XrJljeSRbDveECFEkLnVPXI35Hr2gg==
X-Received: by 2002:a25:3449:: with SMTP id b70mr593373yba.426.1644252740404;
        Mon, 07 Feb 2022 08:52:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2r2RWJX+7wc5Ij11c6LjwAsF/aHbvsTtSCysjXZN8Zq45/JDt1/CzRafV4o0/Kb/p6Fhtb0hiMbPiW7TCwxk=
X-Received: by 2002:a25:3449:: with SMTP id b70mr593352yba.426.1644252740156;
 Mon, 07 Feb 2022 08:52:20 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNt0Xp1j7+hTrV9XZ936Yz+H8Le0pqazhLr3drO0tEzB2w@mail.gmail.com>
 <20220207154739.GH23216@worktop.programming.kicks-ass.net>
In-Reply-To: <20220207154739.GH23216@worktop.programming.kicks-ass.net>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 7 Feb 2022 17:52:03 +0100
Message-ID: <CAFqZXNuKgbq4ZKyzWvMS7yL5D4tkZA7xMJx_LTvLUoHDJwHxvw@mail.gmail.com>
Subject: Re: Semantics vs. usage of mutex_is_locked()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 7, 2022 at 4:47 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Feb 07, 2022 at 04:15:27PM +0100, Ondrej Mosnacek wrote:
> > Also, any opinions on the name of the new helper? Perhaps
> > mutex_is_held()? Or mutex_is_locked_by_current()?
>
> lockdep_assert_held*() and friends work on mutexes just fine.

Hm, good point, although it will only work if CONFIG_LOCKDEP=y, which
is usually not enabled on production kernels... But maybe it doesn't
make sense to do the check on non-debug kernels anyway?

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

