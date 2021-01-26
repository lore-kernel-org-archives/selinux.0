Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50978C433E0
	for <selinux@archiver.kernel.org>; Tue, 26 Jan 2021 19:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2519A22A85
	for <selinux@archiver.kernel.org>; Tue, 26 Jan 2021 19:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389022AbhAZF4z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732032AbhAZCDc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Jan 2021 21:03:32 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003CEC061786
        for <selinux@vger.kernel.org>; Mon, 25 Jan 2021 16:14:12 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o10so582451wmc.1
        for <selinux@vger.kernel.org>; Mon, 25 Jan 2021 16:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vz7Wx3SXxaN+HsWZGzhnHFVDxGZAroM2JwH4bW0nEhM=;
        b=WulKks/yUSJwwUol1tm6wB9TJkukXvTYKvdB2ceQgXomgHQMSU12Q0ukxoGukdPNr8
         HGAjlTfWtd5HvJzNWyfyy0crd2HH+/syiXerMgHWpnjKX2vL/MjmxngjAkb9Ff2XGB5O
         2/Kvk7D9kj7xdMH5EBWmOi+BQjBDhtTEW1Gfpa+yh52P9hNpbK7Lr+NmN28rhnuHGel+
         dO62MQLsOV4fBk09tq1r4tc2zrJUdUMA+jCyQbkJYdTVuaGSVsKAM9Ytr4Ozzu8qwh3t
         JdPEfNF7P53HhUk4Nx0zB6G5G3rIGu1xvUCi6Vt61QOVMpU8sH7py/rv4XF0bp+yCvWD
         rXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vz7Wx3SXxaN+HsWZGzhnHFVDxGZAroM2JwH4bW0nEhM=;
        b=IhDRLmbekB/ydYA5WU002GsMBqalk82Qs4q/5Qi9fB6paRbB2T00fS5jhpvhPUO+Uy
         pQbqgkbZK9PH3uVZzBGbTMVDcxMbgsAbOMWpYawjiDUuaYrlNBwjtuPzg3WFmIGT+48i
         AVLmtvavWLvVN1F0kxWtEfuOPWt2QhBQvZDdWUuSinBLdZhk4EilfQbHuhOL6lZmR9hM
         kdw0OBYEI4ZNx018FCAmVpJowHLiE3+7kOD5f9Ao+JhcijXtry5CwCw0F/PpfrhSx0hi
         6WQyB6kFfaEV1AMUjbWeSd7EG0gYUhdgsIO5QymkTaVj+regDVbKOgLadfl/YcPdFZbg
         Fd/w==
X-Gm-Message-State: AOAM531BYBEN09v8EkZ1JNmeh7YRPuzVEd4gzAACX8HW92B1JspQNYSV
        S4JuSvzu8Dmaa1VAZG5TD9hZFnD6ENTmzLfkdquN9w==
X-Google-Smtp-Source: ABdhPJytUOFxylJO9GQfWCZxkgmC08Bcn5+HCLBHOxR+Vvj6poU2sA/tL72vkNkKpaNCAmBDljbV4s4UOoZM8sJO7UI=
X-Received: by 2002:a1c:7906:: with SMTP id l6mr2247505wme.22.1611620051415;
 Mon, 25 Jan 2021 16:14:11 -0800 (PST)
MIME-Version: 1.0
References: <20210120202337.1481402-1-surenb@google.com> <20210125131935.GI827@dhcp22.suse.cz>
In-Reply-To: <20210125131935.GI827@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 25 Jan 2021 16:14:00 -0800
Message-ID: <CAJuCfpGu_x4vxXejTUfD4Mjun=qJOsdoRs42gQhiv30EnED=nA@mail.gmail.com>
Subject: Re: [PATCH 1/1] process_madvise.2: Add process_madvise man page
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-man@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>,
        SElinux list <selinux@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 25, 2021 at 5:19 AM 'Michal Hocko' via kernel-team
<kernel-team@android.com> wrote:
>
> On Wed 20-01-21 12:23:37, Suren Baghdasaryan wrote:
> [...]
> >     MADV_COLD (since Linux 5.4.1)
> >         Deactivate a given range of pages by moving them from active to
> >         inactive LRU list. This is done to accelerate the reclaim of these
> >         pages. The advice might be ignored for some pages in the range when it
> >         is not applicable.
>
> I do not think we want to talk about active/inactive LRU lists here.
> Wouldn't it be sufficient to say
> Deactive a given range of pages which will make them a more probable
> reclaim target should there be a memory pressure. This is a
> non-destructive operation.

That sounds better. Will update in the next version.

>
> Other than that, looks good to me from the content POV.
>
> Thanks!

Thanks for the review Michal!

> --
> Michal Hocko
> SUSE Labs
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
