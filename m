Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57310C12002
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 22:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B82B61396
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 22:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhGNWn7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhGNWn7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jul 2021 18:43:59 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FDFC06175F
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 15:41:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id k27so5320177edk.9
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 15:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SY7FRD1YxJIa4XWnUKgLOZvAO7layiMbA1nAyPr3oIQ=;
        b=lBjX2b8SYx4Gp6Wuo7pZZZMHDu/HKaKCnY9N7qbi8EuyK0eC9jNuD7wAvUMyyXBTOE
         fxVBYYnA2RpQFlqLWPYcrk6bBfviG0VbYJo8yE4uJNI9HS8b8dwt4dgmKPDGB8cj9LT4
         BcDCVy3b9nEz9NyrKv9O4wt5fuo53YJR3IpGyQuTkSEyBfm97OEttFksy4RYHuRylTUg
         o+oxhiH1t4YH/mowmUVyvbdn9SF7eeO0N0q8NMeDYPrQjE6cS1zYfBQbP09GIv1GQ+9q
         NK5u2+tLTXU8a+co6rR8XKPBRLjzL0c/6yyFoQXxZwzSpjisScgKFzJHRgqqseem9zsW
         m4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SY7FRD1YxJIa4XWnUKgLOZvAO7layiMbA1nAyPr3oIQ=;
        b=Pjg9YBU2szfAGybs6d+SHLmCSV2YDj+o0CyTTb/ZWEAFbtH2Jj/GSTmFshPevQy/3V
         HWX44K98XXfRXI5uVrdIyQv8KgTJnwF+S9BmaR/nFofHcVCspzegifgjn+FAwveuiSNa
         RtRGsIDFkSl+2NAbD6QFdHge0Urm2A3JtMyaeWGEW3gZVuHRZCxF5kf8svIq8l7OVLHo
         kjrsRuj2tgB7jlmJjAb1JF/yiynKfD6nN2aQP5XbgVmREFG0A0aDNnoMbJeyDtUg0er5
         LMU7sO6V40Kng+03G/1OcWyDhTb7KuTytFiFGpXWR1sHZlELJNaQqlrkGXP8ug5YmmT6
         6KuA==
X-Gm-Message-State: AOAM532n4KIZ9RWl9js3NvL9ojmItsPt0mmiFjTRCI8OsX/m1A/MWrnZ
        zFWLVo13B33Poft3uLEhQFqRHnFL/0GiRhs4CdU9vw==
X-Google-Smtp-Source: ABdhPJzlted5DsDp0SdUS1yKMqkqo9HSiJStoFu3OmcEEJsP72xBAgxJfTjuebLS3OU/NuAYCNlhC/umuF5pgWxeK7g=
X-Received: by 2002:aa7:c6d4:: with SMTP id b20mr905220eds.204.1626302465718;
 Wed, 14 Jul 2021 15:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210712223013.2165325-1-sethmo@google.com> <CAJ2a_DfTtk18K8GoXqnHR-yiEh=Vfmjg8VqJtHPSNW832Po_WA@mail.gmail.com>
In-Reply-To: <CAJ2a_DfTtk18K8GoXqnHR-yiEh=Vfmjg8VqJtHPSNW832Po_WA@mail.gmail.com>
From:   Seth Moore <sethmo@google.com>
Date:   Wed, 14 Jul 2021 15:40:54 -0700
Message-ID: <CAJsHiNx1E7x1jaBkS0i4L1nBWXp8YXLHRWcCaDaH4LOn=zm+Zw@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: add lock callbacks
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 14, 2021 at 11:41 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Tue, 13 Jul 2021 at 00:30, Seth Moore <sethmo@google.com> wrote:
> >
> > The old mechanism to initialize AVC, avc_init(3), is deprected. This
> > leaves libselinux with no way of guarding the AVC cache when accessed
> > from multiple threads. When applications call access check APIs from
> > multiple threads, the AVC cache may become corrupted.
> >
> > This change adds new callback functions to selinux_set_callback(3).
> > These new callbacks all correspond to the functions that used to be
> > passed via avc_init(3). Multi-threaded applications may set these
> > callbacks to guard the AVC cache against simultaneous access by
> > multiple threads.
> >
> > This change adds the following callbacks:
> >   - SELINUX_CB_ALLOC_LOCK
> >       is invoked to allocate new locks
> >   - SELINUX_CB_GET_LOCK
> >       is invoked to acquire a lock
> >   - SELINUX_CB_RELEASE_LOCK
> >       is invoked to release a previously-acquired lock
> >   - SELINUX_CB_FREE_LOCK
> >       is invoked to free a previosly-allocated lock
> >
> > Signed-off-by: Seth Moore <sethmo@google.com>
>
> Since libselinux 3.2 `avc_init_internal()` uses the SELinux status
> map, via `selinux_status_open()`, by default and by e.g.
> `selinux_check_access()` via `selinux_status_updated()`.
> The status page code is not thread-safe due to the non-thread local
> state variables, like `last_seqno` or `last_policyload`.
> One could mark them with the thread-local storage specifier `__thread`
> (already used within libselinux), but it will result in setenforce-
> and policyload-callbacks for a single event being called multiple
> times for each thread.

Looks like a proper fix for thread safety is a lot more work than I anticip=
ated.
A slightly deeper scan of the code turns up more gotchas/globals:

* `selinux_status_updated` is also reading the global `avc_enforcing`
* `selinux_status_updated` calls `avc_process_policyload`, who then calls
`selinux_flush_class_cache`, which frees global cache outside a lock.

I have a hunch there's more. With that in mind, I'm retracting this patch.
I think a proper one should look quite a bit different (protecting AVC is
not nearly enough).

Thanks for the eyeballs -- I appreciate the feedback/reviews.

Cheers,
Seth

> > diff --git a/libselinux/man/man3/selinux_set_callback.3 b/libselinux/ma=
n/man3/selinux_set_callback.3
> > index 75f49b06..f7371504 100644
> > --- a/libselinux/man/man3/selinux_set_callback.3
> > +++ b/libselinux/man/man3/selinux_set_callback.3
> > @@ -116,6 +116,52 @@ The
> >  .I seqno
> >  argument is the current sequential number of the policy generation in =
the system.
> >  .
> > +.TP
> > +.B SELINUX_CB_ALLOC_LOCK
> > +.BI "void *(*" alloc_lock ") ();"
> > +
> > +This callback is used to allocate a fresh lock for protecting critical=
 sections.
> > +Applications that call selinux library functions from multiple threads=
 must either
> > +perform their own locking or set each of the following:
>
> Maybe mention that these callbacks affect the thread-safety of only a
> subsection of libselinux; the AVC, security_compute_* and
> selinux_check_access interfaces (e.g. the get*con/set*con are
> thread-safe by default).
> Also selinux -> SELinux.
