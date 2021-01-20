Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C01C433E9
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 16:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB95A233EE
	for <selinux@archiver.kernel.org>; Wed, 20 Jan 2021 16:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404019AbhATQuJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:50:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403997AbhATQuA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Jan 2021 11:50:00 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B782EC0613C1
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 08:49:19 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id c128so3440005wme.2
        for <selinux@vger.kernel.org>; Wed, 20 Jan 2021 08:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUDg6TphmanEAstHgN26xAlXogE8/4FgyIPvwhmL7gs=;
        b=pghiOVPTDppHJ45SSMy2+CHFk9YLriSho7mdmM71ABsaxcBoFv3ja6EEAbJkf5fut1
         moGYip9Q1qdPy8y4PyQmDoI8F3NhweKRHJyYT6RVMgzcirgaWmSM2g7Hs1eCsPvVeqAQ
         Q9Tap+PfCVJTLJbmIpzQsMDcH4Pgt/9Wg0ut+dezxUd9sU7NI39nu5yftOWPfdjqtC5o
         f8/TLGh5A3BMY9NwmgGHwE0aiRnk3zEm2KI4zvQhwSbTeZrQvRDJIpVhtw+/fplBTQCo
         lSpsQygOwAoS1thaJoWKph0ap8WwR3uWeNh6HyM4d1PFoC0cpEZpkxM70rPlvlgCBYPK
         oAUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUDg6TphmanEAstHgN26xAlXogE8/4FgyIPvwhmL7gs=;
        b=KyRi8FQuteO2BlI59FHVGyCyJmwtxFU5Y4enoGR6sd5AiBIP9TN++WNGZ9KHa/B/mI
         Y5s5lTGrWOxIeIVnSLIgrvNQixFrnMWM+nCh9R8yFuC/iesVqK2FjuasDA6ahFPyT6V+
         OBzamZvdRiwYhd5ABiwAhYiVwq7RcHfrV3ckcU/B52Edhm9KMJ0bEPY3KcLPgiP3ss5P
         ew+5oZVYCTJdKvV+XCGQYm1NMq7EsWKvHzMllBc6zliPvstmN7FOMoABVS6JgtRKanjJ
         cNncAOfOSndt68BRIEzL8t9zdzzY89z2VTNeGrIQ2y9e7RQqEs/hDLJ5kIzAqElZq8rH
         Vz0g==
X-Gm-Message-State: AOAM533b/C5PKmXy8sGacjwwK4+0Op2B8Qtzk62y1SpCEmo30C3YxNmT
        tNMK5v/ogeYU+F+ekra0z37231IkCQ+bP/HauaKNDw==
X-Google-Smtp-Source: ABdhPJz0wZLMLD+76EyvUtDPstR+U0u7fb1/8zCKqlM+va0UuR2w0QT0/wXXhaj0lNefqt31Z564snWdZ0DTedYcOUo=
X-Received: by 2002:a05:600c:4e92:: with SMTP id f18mr5148677wmq.126.1611161358342;
 Wed, 20 Jan 2021 08:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20210111170622.2613577-1-surenb@google.com> <c586aa93-52d7-bd6c-3d5-77be4ed4afae@namei.org>
In-Reply-To: <c586aa93-52d7-bd6c-3d5-77be4ed4afae@namei.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 20 Jan 2021 08:49:07 -0800
Message-ID: <CAJuCfpG0+_4x=F7dpKabgmGwDf2KGcCcEfXixLBef6+zg8uNjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     James Morris <jmorris@namei.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 19, 2021 at 9:02 PM James Morris <jmorris@namei.org> wrote:
>
> On Mon, 11 Jan 2021, Suren Baghdasaryan wrote:
>
> > Replace PTRACE_MODE_ATTACH with a combination of PTRACE_MODE_READ
> > and CAP_SYS_NICE. PTRACE_MODE_READ to prevent leaking ASLR metadata
> > and CAP_SYS_NICE for influencing process performance.
>
>
> Almost missed these -- please cc the LSM mailing list when modifying
> capabilities or other LSM-related things.

Thanks for the note. Will definitely include it when sending the next version.

>
> --
> James Morris
> <jmorris@namei.org>
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
