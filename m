Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D193C433E0
	for <selinux@archiver.kernel.org>; Sat,  9 Jan 2021 02:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83BE238EC
	for <selinux@archiver.kernel.org>; Sat,  9 Jan 2021 02:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbhAICUP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Jan 2021 21:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbhAICUP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Jan 2021 21:20:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFB1C061574
        for <selinux@vger.kernel.org>; Fri,  8 Jan 2021 18:19:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a12so10670747wrv.8
        for <selinux@vger.kernel.org>; Fri, 08 Jan 2021 18:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=052XPomPT0oPS9EFhbYOVhGRK5vb4IUUAo6lA6fY0a0=;
        b=Z//feIYP4BzIRBimKHRKIg3TS3FG+WbtsSOWeEzhIELipSoM/VopcW5yHQ8lBDSyNb
         cYtg10MGwnE3DBvOmC7Cpkkka8+K1+w3YgfHSDm78A6+pyVCRaqWSasoAB5OfPOaXT/k
         YtbB8X2JQ0DgQoyVeZW3R/ffL8fnqs5nVmfG4gr0Kzwnf350NBWSMa2sQuHmz48Cf3Xm
         n7tiAIB8q22oaykBB+CZ6214yMk/0IEKYux2zUP9uEa/x+RWWIL84MlWht+vNT0DTTom
         sLdoXIhK6FD3DANRI8tlhK+mZBRIzG51rgmCIwhhWVAyGx19W1RqftDiE8wf81zgHmO1
         1b0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=052XPomPT0oPS9EFhbYOVhGRK5vb4IUUAo6lA6fY0a0=;
        b=WKAcnKNPKbzhV6SAD7QoJHNOfoHxP8uUw0IdURte8aPLgCUmPM+6FlhPeC1jpxb/Rp
         lhVwfOAb54zPhKpDve/ESZvnu09LFjKV79YMSZqVMVjcY4TVzcl6cjIs6Jo5WacL/eIr
         DaEveKIi95TH11sEOGlDHbftv09l7hqwFqd8y1/yqZ1aMjj3kSdN0jDhckIE5vRtrZOD
         nOPDrkxqqOq/Ypn2g1GzvfBzBhICE67vM01zWSLSLiculBblToDsYSYCPwyp5XEzg/A3
         MAbDURlya5ozj/Gyg9tGM4CZq3u5IOdl4OyNQ5E0qfPAsrmXkwF8OMjEHTd1H+BzyGxg
         LzPQ==
X-Gm-Message-State: AOAM532/fdEh1SV6wHXcRqAPMeKGmpws0X6ZcpC97h/bfSz4KX/x7gRJ
        jgRblu01M0VyBxb77GwLhR7ztj76EAYKuDDOpKmqgw==
X-Google-Smtp-Source: ABdhPJyvZEkJKALenbMvuoA7Rd/6gdTN0lh35/p88gWogUSV/ynhdTPItqFJ8Ggl7nc3v8PnPlUz5dEz5QJjKO1PF4Q=
X-Received: by 2002:adf:f0d0:: with SMTP id x16mr6298503wro.162.1610158773355;
 Fri, 08 Jan 2021 18:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20210108205857.1471269-1-surenb@google.com> <X/jZibYD1B42D+r7@google.com>
 <CAJuCfpHa3XHVEjNBDHJNo3RBWGdLnXsgZH9wyiGLqj655GwE2w@mail.gmail.com> <db29d560-45d9-1eb3-60d0-8d6153ac7193@google.com>
In-Reply-To: <db29d560-45d9-1eb3-60d0-8d6153ac7193@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 8 Jan 2021 18:19:22 -0800
Message-ID: <CAJuCfpE3QR-8Lm_0cnCFQsDiU2Ui87E6ARQ+ScQuDZ1TNfm-tg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: replace ptrace attach requirement for process_madvise
To:     David Rientjes <rientjes@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 8, 2021 at 5:02 PM David Rientjes <rientjes@google.com> wrote:
>
> On Fri, 8 Jan 2021, Suren Baghdasaryan wrote:
>
> > > > @@ -1197,12 +1197,22 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
> > > >               goto release_task;
> > > >       }
> > > >
> > > > -     mm = mm_access(task, PTRACE_MODE_ATTACH_FSCREDS);
> > > > +     /* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
> > > > +     mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > > >       if (IS_ERR_OR_NULL(mm)) {
> > > >               ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> > > >               goto release_task;
> > > >       }
> > > >
> > > > +     /*
> > > > +      * Require CAP_SYS_NICE for influencing process performance. Note that
> > > > +      * only non-destructive hints are currently supported.
> > > > +      */
> > > > +     if (!capable(CAP_SYS_NICE)) {
> > > > +             ret = -EPERM;
> > > > +             goto release_task;
> > >
> > > mmput?
> >
> > Ouch! Thanks for pointing it out! Will include in the next respin.
> >
>
> With the fix, feel free to add:
>
>         Acked-by: David Rientjes <rientjes@google.com>

Thanks! Will post a new version with the fix on Monday.

>
> Thanks Suren!
