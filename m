Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4CBC433E0
	for <selinux@archiver.kernel.org>; Sat,  9 Jan 2021 01:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413B023A75
	for <selinux@archiver.kernel.org>; Sat,  9 Jan 2021 01:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbhAIBDO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Jan 2021 20:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbhAIBDN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Jan 2021 20:03:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49954C061573
        for <selinux@vger.kernel.org>; Fri,  8 Jan 2021 17:02:33 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u4so5445101pjn.4
        for <selinux@vger.kernel.org>; Fri, 08 Jan 2021 17:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=oo3kBdaJhl9ExjF4SDMLaMM4Wh9mmEWqkI73c+HY9rM=;
        b=h4uxMGH9w0WgecwaPG6ABWiu4gFq2c1ZeVLGyUhBIRXGGCY7Dq+QZyBHoVP28cz2SU
         Qw/QLxB2y64egxksBjw8ECQEzPtCEA5K6wi7AS1QWrFqxE4C7C4U1uX+HVKlfnSqnsuL
         0RoGTArPQgSJgiuEBwCZUWEJxzsWs+dlJNAftBD37m4woo9XkfsFk/MuwCwjyg+WvYp2
         Dv0ZtL1OFx04SQ7Q7d/tPRSqnHmmKbCbbr7OwDC1MXxc7W/+PZgSPPClzVztxFi4yMus
         t0irObY9h7pVoguKlD54L+WsUTJfOtKqCLmunaaF6g5oS81dy0wZfYjx1y/CiU6t2dDR
         cBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=oo3kBdaJhl9ExjF4SDMLaMM4Wh9mmEWqkI73c+HY9rM=;
        b=lbOZbHViwESHTZX0zD1RUeEndvQIfAkm6zLKUfwKMZGPvY3FI31JtyZyj1l2ttVgXA
         J02g9n48/RP8eyTHnSQ7t8V/hSTJ+PsgHnhpax2hdZ1l13T2RRZaEIilyM/wIWnF0Pad
         OUpsLXpcB1kCWiE/74+3hxw+xgEfWsfWzjBiR0cNZY6Xc/xXZ/47xzmKlSgkRAVzFWoO
         nu1q1tbGKPNb7j8gjWKoWi5RNzp0GLrbNsim1v4wFRyekDxUKLaR9Ew0DSbYiGCGE9GR
         1bba84BXHduKZcTMRyYBc4l0b7CqZpLQk2Uoesc9MP5c9dAIrSt3kGPJRYFZ5Zcxrgar
         VM9w==
X-Gm-Message-State: AOAM530AGrxOCEJjE95gz+SMjeHd71+pCaH96OWleblWnPHnaggzguiM
        OhZy1RgIInE6rfaBfn/c5d8cuA==
X-Google-Smtp-Source: ABdhPJx3rDhAxu96iOR8z7R+/QTTxHMH7vX+ldpFGCDtk0cYl3KpU5yM45A3IG5M1Gtt10S9XqrGcw==
X-Received: by 2002:a17:90a:eb01:: with SMTP id j1mr6288651pjz.219.1610154152706;
        Fri, 08 Jan 2021 17:02:32 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id 186sm10090171pfx.100.2021.01.08.17.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 17:02:31 -0800 (PST)
Date:   Fri, 8 Jan 2021 17:02:30 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Suren Baghdasaryan <surenb@google.com>
cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Edgar_Arriaga_Garc=C3=ADa?= <edgararriaga@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-mm <linux-mm@kvack.org>, selinux@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Subject: Re: [PATCH 1/1] mm/madvise: replace ptrace attach requirement for
 process_madvise
In-Reply-To: <CAJuCfpHa3XHVEjNBDHJNo3RBWGdLnXsgZH9wyiGLqj655GwE2w@mail.gmail.com>
Message-ID: <db29d560-45d9-1eb3-60d0-8d6153ac7193@google.com>
References: <20210108205857.1471269-1-surenb@google.com> <X/jZibYD1B42D+r7@google.com> <CAJuCfpHa3XHVEjNBDHJNo3RBWGdLnXsgZH9wyiGLqj655GwE2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 8 Jan 2021, Suren Baghdasaryan wrote:

> > > @@ -1197,12 +1197,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> > >               goto release_task;
> > >       }
> > >
> > > -     mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > > +     /* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> > > +     mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > >       if (IS_ERR_OR_NULL(mm)) {
> > >               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > >               goto release_task;
> > >       }
> > >
> > > +     /*
> > > +      * Require CAP_SYS_NICE for influencing process performance. Note that
> > > +      * only non-destructive hints are currently supported.
> > > +      */
> > > +     if (!capable(CAP_SYS_NICE)) {
> > > +             ret = -EPERM;
> > > +             goto release_task;
> >
> > mmput?
> 
> Ouch! Thanks for pointing it out! Will include in the next respin.
> 

With the fix, feel free to add:

	Acked-by: David Rientjes <rientjes@google.com>

Thanks Suren!
