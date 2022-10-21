Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3BCC3A59D
	for <selinux@archiver.kernel.org>; Fri, 21 Oct 2022 21:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiJUVmf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJUVme (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Oct 2022 17:42:34 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24222A79C9
        for <selinux@vger.kernel.org>; Fri, 21 Oct 2022 14:42:33 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id x15so2747572qvp.1
        for <selinux@vger.kernel.org>; Fri, 21 Oct 2022 14:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T2R37JCCGa30iGWXb8Vf5Wr0AmT8I6MQXcpjnTh2wkY=;
        b=I80BmYwmapXMsaFaO7z6zYbaghq7BAhIzcq3bRl9+ijNCbn+7jyWwY0lu51t1rXyFx
         mDpjRRP6dUKPk7ucQ12SPEPo/rKwU8pKTkN+duv7lVufggHpQttUQ8vU0+M/J/sE80oJ
         C1PuDo5G8mzbJFa3TGFzOk66a6+I3X53Vg0Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2R37JCCGa30iGWXb8Vf5Wr0AmT8I6MQXcpjnTh2wkY=;
        b=VgOTODeqsN66GE+bKxAfWQW0HBvrFR7IwYkcfgx/SCIDSnsQgv3zeG36jfjxlimHWb
         XbgY52iC3B7QmkUM6dKBFMxV4ubFZwsy2B2rz6ruKKaUOySK/QzNqB8CX3UUhjCRr62B
         7hf6ufBGdHtJ0UeLpSfKEDaLPrrbb7UVkEBaUAaqqVL+r6BRcUAp8AIdDuf1+1+T1p3K
         T5KuGYjLc8I0jsOKrSoyt5nbhJOe0uhpRs9K+pyjJHMATIIYshW+stE8c30IhddpmR0E
         7MsLjAF/u+SvUcjbpkg8eqYiB3U89Ad7/UHxQl8eN1MO1fKD3XjdZGOsLS8NgL2ss6s7
         UPuA==
X-Gm-Message-State: ACrzQf03ct9XtDxyjGgX5yX9QiZcHIz/DnXXiaoAnSmRFx98z0Kv9WDr
        jQHTyJKUMxgTXoCpA1ojfKdp3WkP35ODig==
X-Google-Smtp-Source: AMsMyM5SEOlnLCGE4GRA89ei58gJy9u/T09QBo8AUCJOHJyQK6zK/bU8lTAnGBpDvRBYkJBSnB2YZA==
X-Received: by 2002:ad4:5941:0:b0:4b4:46b5:e36b with SMTP id eo1-20020ad45941000000b004b446b5e36bmr18128485qvb.33.1666388552631;
        Fri, 21 Oct 2022 14:42:32 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a0b5b00b006ecdfcf9d81sm10119192qkg.84.2022.10.21.14.42.32
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 14:42:32 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id n130so4761268yba.10
        for <selinux@vger.kernel.org>; Fri, 21 Oct 2022 14:42:32 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr19715171ybu.310.1666388551764; Fri, 21
 Oct 2022 14:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhSXRDUw0CGLqinogP6g5rHWz4rg3N4Dr-VV8RshWt56Jw@mail.gmail.com>
In-Reply-To: <CAHC9VhSXRDUw0CGLqinogP6g5rHWz4rg3N4Dr-VV8RshWt56Jw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Oct 2022 14:42:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXx=0AKgMA8dGRROi5EarYxkEfHNu_zsezLgjtPrqNow@mail.gmail.com>
Message-ID: <CAHk-=wgXx=0AKgMA8dGRROi5EarYxkEfHNu_zsezLgjtPrqNow@mail.gmail.com>
Subject: Re: [GIT PULL] SELinux fixes for v6.1 (#1)
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 20, 2022 at 8:20 AM Paul Moore <paul@paul-moore.com> wrote:
>
>         The patch, while still fairly small, is a bit
> larger than one might expect from a simple s/GFP_KERNEL/GFP_ATOMIC/
> conversion because we added support for the function to be called with
> different gfp flags depending on the context, preserving GFP_KERNEL
> for those cases that can safely sleep.

Hmm.

So I've pulled this, but that patch actually makes it obvious that
there is only one single possible function for "convert->func", namely
that "convert_context()" function.

So why is that an indirect function call in the first place? That just
makes for slower (particularly in this age of indirect call
speculation costs), and bigger code, and only makes it harder to see
what is going on.

In the call-site, it looks like "Oh, this will call some
conversion-specific callback function".

In reality, there is no context-specific callback, there is only ever
convert_context().

Inefficient and misleading code. Not a great combination.

              Linus
