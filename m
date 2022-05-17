Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A23C433F5
	for <selinux@archiver.kernel.org>; Tue, 17 May 2022 22:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiEQWkJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 May 2022 18:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiEQWkI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 May 2022 18:40:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C489452E57
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 15:40:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m62so155396wme.5
        for <selinux@vger.kernel.org>; Tue, 17 May 2022 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mv1KR5CGQ8FzA2tBokD3FnIW3vImxgQqsqbepXgK1oA=;
        b=M8JtGwYnn1XKhPoVjiMjvrY6Z5iX0yyxozxw5vDMrYbQX/81ca0qMoBMZdee5NHp17
         +XRSVcCw069NR/ZN1shdS484EHojw4itKJDsoMKC4EuMMEddi2M6cdM3VkNiN2u1POEY
         kAO1FhO7y4HTg3ZCrsDVIPVnErRA2U6FTpbdvmO9FGbAgSszEUs7VmAbLqdNrFrwbddd
         eEPersb5QF2T7DpmRudMZAHTycz82b2rh2Tkq3qLtaqi/5hDCb6Dh2X3eqf2A4U1onGa
         9mZzly2Lm9sOjQKOX2Mef5ncSHmwBPbG4KXDpmYZfLrFNpiWiv4cfpLpL7gQyjMKpQJo
         ZQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mv1KR5CGQ8FzA2tBokD3FnIW3vImxgQqsqbepXgK1oA=;
        b=Wq/XbD93uK01O0mXTfdFgOYDKUgnHZm15SqczdgghPkI1GV3synlMeiHUBwlg4XfoS
         BNJXYl83XC5PYwfxiE0HfZGVl5tfr5c2IyDzYzlE4+OujbY1u/6OQYKg05xGVWcasRcE
         Y6P+2NGNvZqzniuXYhwrnjCptX+y+3VwqDCMYZ8iuFjeLyO6lCmdsQ7ac2wWQ4nGkmzq
         mRuLbysNT22ZPmWpi6hrlxEp4fipv/5WEKP3QVsi54myXgnCIYykulRtQprcum3tHBiw
         y3xVq8OAvDcCtYgBMw6LRYuibyLHcvqnE+BFuHmMysA9avs0+zZaj6eIKHR8ztuuZNBp
         Kalg==
X-Gm-Message-State: AOAM532mGqBvevDhZcb8Zz2tTKP4cPMwU/zVJoz5+RfCKIZ0nxm9EkmO
        nidHzowoH4ytvcZiRv0F1GP9qBSDw3awbSRwUTaX
X-Google-Smtp-Source: ABdhPJxmAvcEZiLDAdxta2DzrXC5aDCuPqConVm/2R7Ny2jtk2J8KfKg9KpXWZxsOdWnnQp8ootPGv0yl9C7EvhOtxg=
X-Received: by 2002:a05:600c:600d:b0:394:5353:507a with SMTP id
 az13-20020a05600c600d00b003945353507amr23492764wmb.96.1652827206340; Tue, 17
 May 2022 15:40:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220517120816.769108-1-omosnace@redhat.com>
In-Reply-To: <20220517120816.769108-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 May 2022 18:39:55 -0400
Message-ID: <CAHC9VhQ9ZtL8G1=N48CWBNDbf=J6ETp7fTD+MbL_WeUs0J5KSQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix bad cleanup on error in hashtab_duplicate()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Wander Lairson Costa <wander@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, May 17, 2022 at 8:08 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> The code attempts to free the 'new' pointer using kmem_cache_free(),
> which is wrong because this function isn't responsible of freeing it.
> Instead, the function should free new->htable and clear the contents of
> *new (to prevent double-free).
>
> Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
> Reported-by: Wander Lairson Costa <wander@redhat.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/hashtab.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Good catch, merged into selinux/stable-5.18 and I'll plan on sending
this to Linus tomorrow once the tests finish running.

-- 
paul-moore.com
