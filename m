Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299A0C07E99
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04438611B0
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 15:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbhGLP2o (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 11:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbhGLP2o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 11:28:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945CBC0613DD
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 08:25:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v20so35339009eji.10
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 08:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gY7KE8MLwq4+eCUG9X4tCUTQICHiazu0YGmFsnsDUSY=;
        b=Nszz0jX6MWwz82FbxfzvRvMWnbTeLIW/z3JEawbfB6FARnR3SGEJJvYC1TL3jE8o+9
         6IBFVxhgpHpDYLVthYQBfIVEvibbtJI7Sifa/d3Isr4RNF+TloC2v3LJZ01jSgRik9kl
         uOqM1WLJJO3I2IOpFHxdtovChLLVYkytHlAkXFLkzgbxceMtIhPsjeeqMSskvEdP8AVV
         LIkscPchndPsaepF/ziCfGfTLdxiTJsYx62CDKQK2p0d+7iKEJPxlP35h+zLh9b75bOc
         oom1VuiisvhqeUQQ6NsSpf5W0SFBuo45W0Yy+ojXl1HejjRdaumOhM1KLPu8ohC8boih
         8wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gY7KE8MLwq4+eCUG9X4tCUTQICHiazu0YGmFsnsDUSY=;
        b=CidQac7Ot7/hb8J4m27VAHRRi/at92n8qewbCfwRh5/9nRVneMDrclTQLVbq9mbqAp
         dl0AQ/N1u4MUb7SQbOrTdH3dXgIidqLjKICPXnSb55LpzqWGRfKIi8PShWEoOjjFw7yc
         m8KsD9h0gL2rEE27qFoEyfoHPnY1sMAeXzj4/eRUpYTH8LIA0EH37b/XM/2sSm5cgEY5
         e6LjwLJtV2zBn7Kg8lrfPSyD2HXbb+VcmIpm78JI3s3XrPiwCOWPIR+6+fuBPwkSRE4N
         a5b3TrXm8j/wM485SSkw5ge97IQ1NtBoqxmxmxE8nDRFg3iA/XGC4Ydh8g+Uho3zEzW0
         VY8w==
X-Gm-Message-State: AOAM5318r11SLzoSDGb9URWHo/qcN3Sru+EsXr3rwSXEnTkfq6+YdnO9
        kacz63qDG8rr/4tp42kZYIUP9hF+8SwUKSu9iiZ01w==
X-Google-Smtp-Source: ABdhPJx+uSb5YwrNKX779bW1gadNBH59NFGrdOOQPaf2AOjLcKdTgqJo3u19t7zo1yaqYMaS0OFF7VTJYnf4d9xI0tc=
X-Received: by 2002:a17:907:9602:: with SMTP id gb2mr38911162ejc.354.1626103553777;
 Mon, 12 Jul 2021 08:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210709190803.1700915-1-sethmo@google.com> <CAJfZ7==M0rxn-0Bntw3+8O+Mf=v1zVR=4xNAKevrCSUPe5LkcA@mail.gmail.com>
In-Reply-To: <CAJfZ7==M0rxn-0Bntw3+8O+Mf=v1zVR=4xNAKevrCSUPe5LkcA@mail.gmail.com>
From:   Seth Moore <sethmo@google.com>
Date:   Mon, 12 Jul 2021 08:25:41 -0700
Message-ID: <CAJsHiNwy_838V0=Jtyd4bEBAoG_P8KPc=YY7Q5XfvOQGW9DGvw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: add lock callbacks
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 12, 2021 at 12:29 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Fri, Jul 9, 2021 at 9:08 PM Seth Moore <sethmo@google.com> wrote:
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
> Hello,
>
> I am not very familiar with libselinux's callback, but this patch
> looks good to me and it implements the solution which was discussed
> previously (https://lore.kernel.org/selinux/CAEjxPJ4A7KC=+0vTKNU_Z0K-e9Q6hSfTc5WiNms54EN_C5dCLA@mail.gmail.com/).
>
> Nevertheless there is a slight issue with the CHECK_LOCK_CALLBACKS
> macro: calling "CHECK_LOCK_CALLBACKS();" will expand to "if
> (...){...};", with an unnecessary semicolon which is reported by clang
> as -Wextra-semi-stmt (for example in
> https://github.com/fishilico/selinux/runs/3035178820?check_suite_focus=true).
> While I like this check, it seems better if CHECK_LOCK_CALLBACKS was a
> function (which would be static inline). Could you please send a
> version 2 with this macro replaced by a function? (or I may be wrong,
> in which case please explain why using a macro is better than an
> inline function).

Thanks for looking.

I debated making this a function, but in the end liked the idea of the
assert being inside the calling function body. However, the call stack
should have that info anyway, so... in hindsight perhaps I was
overthinking it.

I'll rework and submit a new patch that just calls a function. (Which
I generally prefer to a macro anyhow).

Cheers,
Seth

>
> Thanks,
> Nicolas
>
> > ---
> >  libselinux/include/selinux/selinux.h       | 12 ++++++
> >  libselinux/man/man3/selinux_set_callback.3 | 46 ++++++++++++++++++++++
> >  libselinux/src/avc_internal.h              | 22 +++++++++--
> >  libselinux/src/callbacks.c                 | 13 ++++++
> >  4 files changed, 90 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> > index ae98a92e..c3c68b3a 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -166,6 +166,14 @@ __attribute__ ((format(printf, 2, 3)))
> >         int (*func_setenforce) (int enforcing);
> >         /* netlink callback for policyload message */
> >         int (*func_policyload) (int seqno);
> > +       /* create a lock and return an opaque pointer to it */
> > +       void *(*func_alloc_lock) (void);
> > +       /* obtain a given lock, blocking if necessary */
> > +       void (*func_get_lock) (void *lock);
> > +       /* release a given lock */
> > +       void (*func_release_lock) (void *lock);
> > +       /* destroy a given lock */
> > +       void (*func_free_lock) (void *lock);
> >  };
> >
> >  #define SELINUX_CB_LOG         0
> > @@ -173,6 +181,10 @@ __attribute__ ((format(printf, 2, 3)))
> >  #define SELINUX_CB_VALIDATE    2
> >  #define SELINUX_CB_SETENFORCE  3
> >  #define SELINUX_CB_POLICYLOAD  4
> > +#define SELINUX_CB_ALLOC_LOCK   5
> > +#define SELINUX_CB_GET_LOCK     6
> > +#define SELINUX_CB_RELEASE_LOCK 7
> > +#define SELINUX_CB_FREE_LOCK    8
> >
> >  extern union selinux_callback selinux_get_callback(int type);
> >  extern void selinux_set_callback(int type, union selinux_callback cb);
> > diff --git a/libselinux/man/man3/selinux_set_callback.3 b/libselinux/man/man3/selinux_set_callback.3
> > index 75f49b06..f7371504 100644
> > --- a/libselinux/man/man3/selinux_set_callback.3
> > +++ b/libselinux/man/man3/selinux_set_callback.3
> > @@ -116,6 +116,52 @@ The
> >  .I seqno
> >  argument is the current sequential number of the policy generation in the system.
> >  .
> > +.TP
> > +.B SELINUX_CB_ALLOC_LOCK
> > +.BI "void *(*" alloc_lock ") ();"
> > +
> > +This callback is used to allocate a fresh lock for protecting critical sections.
> > +Applications that call selinux library functions from multiple threads must either
> > +perform their own locking or set each of the following:
> > +
> > +.B SELINUX_CB_ALLOC_LOCK
> > +
> > +.B SELINUX_CB_GET_LOCK
> > +
> > +.B SELINUX_CB_RELEASE_LOCK
> > +
> > +.B SELINUX_CB_FREE_LOCK
> > +
> > +.TP
> > +.B SELINUX_CB_GET_LOCK
> > +.BI "void (*" get_lock ") (void *" lock ");"
> > +
> > +This callback acquires the
> > +.I lock
> > +that was previously allocated with
> > +.I alloc_lock.
> > +This function must block until the
> > +.I lock
> > +can be acquired.
> > +.
> > +.TP
> > +.B SELINUX_CB_RELEASE_LOCK
> > +.BI "void (*" release_lock ") (void *" lock ");"
> > +
> > +This callback releases the
> > +.I lock
> > +that was previously acquired with
> > +.I get_lock.
> > +.
> > +.TP
> > +.B SELINUX_CB_FREE_LOCK
> > +.BI "void (*" free_lock ") (void *" lock ");"
> > +
> > +This callback frees the
> > +.I lock
> > +that was previously allocated with
> > +.I alloc_lock.
> > +.
> >  .SH "RETURN VALUE"
> >  None.
> >  .
> > diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
> > index a9a4aa0b..f23690a1 100644
> > --- a/libselinux/src/avc_internal.h
> > +++ b/libselinux/src/avc_internal.h
> > @@ -9,6 +9,7 @@
> >  #ifndef _SELINUX_AVC_INTERNAL_H_
> >  #define _SELINUX_AVC_INTERNAL_H_
> >
> > +#include <assert.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <string.h>
> > @@ -112,26 +113,41 @@ static inline void avc_stop_thread(void *thread)
> >                 avc_func_stop_thread(thread);
> >  }
> >
> > +#define CHECK_LOCK_CALLBACKS() \
> > +    if (avc_func_alloc_lock \
> > +            || avc_func_get_lock \
> > +            || avc_func_release_lock \
> > +            || avc_func_free_lock) { \
> > +        assert(avc_func_alloc_lock \
> > +                && avc_func_get_lock \
> > +                && avc_func_release_lock \
> > +                && avc_func_free_lock); \
> > +    }
> > +
> >  static inline void *avc_alloc_lock(void)
> >  {
> > +       CHECK_LOCK_CALLBACKS();
> >         return avc_func_alloc_lock ? avc_func_alloc_lock() : NULL;
> >  }
> >
> >  static inline void avc_get_lock(void *lock)
> >  {
> > -       if (avc_func_get_lock)
> > +       CHECK_LOCK_CALLBACKS();
> > +       if (avc_func_get_lock && lock)
> >                 avc_func_get_lock(lock);
> >  }
> >
> >  static inline void avc_release_lock(void *lock)
> >  {
> > -       if (avc_func_release_lock)
> > +       CHECK_LOCK_CALLBACKS();
> > +       if (avc_func_release_lock && lock)
> >                 avc_func_release_lock(lock);
> >  }
> >
> >  static inline void avc_free_lock(void *lock)
> >  {
> > -       if (avc_func_free_lock)
> > +       CHECK_LOCK_CALLBACKS();
> > +       if (avc_func_free_lock && lock)
> >                 avc_func_free_lock(lock);
> >  }
> >
> > diff --git a/libselinux/src/callbacks.c b/libselinux/src/callbacks.c
> > index c18ccc54..b635c8d8 100644
> > --- a/libselinux/src/callbacks.c
> > +++ b/libselinux/src/callbacks.c
> > @@ -9,6 +9,7 @@
> >  #include <errno.h>
> >  #include <selinux/selinux.h>
> >  #include "callbacks.h"
> > +#include "avc_internal.h"
> >
> >  /* default implementations */
> >  static int __attribute__ ((format(printf, 2, 3)))
> > @@ -95,6 +96,18 @@ selinux_set_callback(int type, union selinux_callback cb)
> >         case SELINUX_CB_POLICYLOAD:
> >                 selinux_netlink_policyload = cb.func_policyload;
> >                 break;
> > +       case SELINUX_CB_ALLOC_LOCK:
> > +               avc_func_alloc_lock = cb.func_alloc_lock;
> > +               break;
> > +       case SELINUX_CB_GET_LOCK:
> > +               avc_func_get_lock = cb.func_get_lock;
> > +               break;
> > +       case SELINUX_CB_RELEASE_LOCK:
> > +               avc_func_release_lock = cb.func_release_lock;
> > +               break;
> > +       case SELINUX_CB_FREE_LOCK:
> > +               avc_func_free_lock = cb.func_free_lock;
> > +               break;
> >         }
> >  }
> >
> > --
> > 2.32.0.93.g670b81a890-goog
> >
>
