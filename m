Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF5BC07E95
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D4C61178
	for <selinux@archiver.kernel.org>; Tue, 13 Jul 2021 20:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhGMUHH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Jul 2021 16:07:07 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:40435 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhGMUHF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Jul 2021 16:07:05 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 8D2585647E2
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 22:04:13 +0200 (CEST)
Received: by mail-io1-f44.google.com with SMTP id l18so23782013iow.4
        for <selinux@vger.kernel.org>; Tue, 13 Jul 2021 13:04:13 -0700 (PDT)
X-Gm-Message-State: AOAM5329u4UzvSlq80PBkhFdpqTfV+eghBiHRIZirEK/b0BraDDiaqKu
        yenG4VjhhZGxDWv9Xv+vDdjGTUSvLn5WL5YCxYE=
X-Google-Smtp-Source: ABdhPJxJcEKlX3ZbZ9VgMqwdUHuFJCVnMTrxrRjwAhhTEDR439H0QWKaDyCY43p42bTmuvaBJ7jAq1YPg0iHwXlIrnk=
X-Received: by 2002:a5d:8186:: with SMTP id u6mr4487047ion.45.1626206652667;
 Tue, 13 Jul 2021 13:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210712223013.2165325-1-sethmo@google.com>
In-Reply-To: <20210712223013.2165325-1-sethmo@google.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 13 Jul 2021 22:04:01 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kzjJj7oNFdqQFD4nkJpnsLtOKrB1iXTFNmEYoJF2-==g@mail.gmail.com>
Message-ID: <CAJfZ7=kzjJj7oNFdqQFD4nkJpnsLtOKrB1iXTFNmEYoJF2-==g@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: add lock callbacks
To:     Seth Moore <sethmo@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 13 22:04:13 2021 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 13, 2021 at 12:30 AM Seth Moore <sethmo@google.com> wrote:
>
> The old mechanism to initialize AVC, avc_init(3), is deprected. This
> leaves libselinux with no way of guarding the AVC cache when accessed
> from multiple threads. When applications call access check APIs from
> multiple threads, the AVC cache may become corrupted.
>
> This change adds new callback functions to selinux_set_callback(3).
> These new callbacks all correspond to the functions that used to be
> passed via avc_init(3). Multi-threaded applications may set these
> callbacks to guard the AVC cache against simultaneous access by
> multiple threads.
>
> This change adds the following callbacks:
>   - SELINUX_CB_ALLOC_LOCK
>       is invoked to allocate new locks
>   - SELINUX_CB_GET_LOCK
>       is invoked to acquire a lock
>   - SELINUX_CB_RELEASE_LOCK
>       is invoked to release a previously-acquired lock
>   - SELINUX_CB_FREE_LOCK
>       is invoked to free a previosly-allocated lock
>
> Signed-off-by: Seth Moore <sethmo@google.com>

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks,
Nicolas

> ---
>  libselinux/include/selinux/selinux.h       | 12 ++++++
>  libselinux/man/man3/selinux_set_callback.3 | 46 ++++++++++++++++++++++
>  libselinux/src/avc_internal.h              | 20 ++++++++--
>  libselinux/src/callbacks.c                 | 13 ++++++
>  4 files changed, 88 insertions(+), 3 deletions(-)
>
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index ae98a92e..c3c68b3a 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -166,6 +166,14 @@ __attribute__ ((format(printf, 2, 3)))
>         int (*func_setenforce) (int enforcing);
>         /* netlink callback for policyload message */
>         int (*func_policyload) (int seqno);
> +       /* create a lock and return an opaque pointer to it */
> +       void *(*func_alloc_lock) (void);
> +       /* obtain a given lock, blocking if necessary */
> +       void (*func_get_lock) (void *lock);
> +       /* release a given lock */
> +       void (*func_release_lock) (void *lock);
> +       /* destroy a given lock */
> +       void (*func_free_lock) (void *lock);
>  };
>
>  #define SELINUX_CB_LOG         0
> @@ -173,6 +181,10 @@ __attribute__ ((format(printf, 2, 3)))
>  #define SELINUX_CB_VALIDATE    2
>  #define SELINUX_CB_SETENFORCE  3
>  #define SELINUX_CB_POLICYLOAD  4
> +#define SELINUX_CB_ALLOC_LOCK   5
> +#define SELINUX_CB_GET_LOCK     6
> +#define SELINUX_CB_RELEASE_LOCK 7
> +#define SELINUX_CB_FREE_LOCK    8
>
>  extern union selinux_callback selinux_get_callback(int type);
>  extern void selinux_set_callback(int type, union selinux_callback cb);
> diff --git a/libselinux/man/man3/selinux_set_callback.3 b/libselinux/man/man3/selinux_set_callback.3
> index 75f49b06..f7371504 100644
> --- a/libselinux/man/man3/selinux_set_callback.3
> +++ b/libselinux/man/man3/selinux_set_callback.3
> @@ -116,6 +116,52 @@ The
>  .I seqno
>  argument is the current sequential number of the policy generation in the system.
>  .
> +.TP
> +.B SELINUX_CB_ALLOC_LOCK
> +.BI "void *(*" alloc_lock ") ();"
> +
> +This callback is used to allocate a fresh lock for protecting critical sections.
> +Applications that call selinux library functions from multiple threads must either
> +perform their own locking or set each of the following:
> +
> +.B SELINUX_CB_ALLOC_LOCK
> +
> +.B SELINUX_CB_GET_LOCK
> +
> +.B SELINUX_CB_RELEASE_LOCK
> +
> +.B SELINUX_CB_FREE_LOCK
> +
> +.TP
> +.B SELINUX_CB_GET_LOCK
> +.BI "void (*" get_lock ") (void *" lock ");"
> +
> +This callback acquires the
> +.I lock
> +that was previously allocated with
> +.I alloc_lock.
> +This function must block until the
> +.I lock
> +can be acquired.
> +.
> +.TP
> +.B SELINUX_CB_RELEASE_LOCK
> +.BI "void (*" release_lock ") (void *" lock ");"
> +
> +This callback releases the
> +.I lock
> +that was previously acquired with
> +.I get_lock.
> +.
> +.TP
> +.B SELINUX_CB_FREE_LOCK
> +.BI "void (*" free_lock ") (void *" lock ");"
> +
> +This callback frees the
> +.I lock
> +that was previously allocated with
> +.I alloc_lock.
> +.
>  .SH "RETURN VALUE"
>  None.
>  .
> diff --git a/libselinux/src/avc_internal.h b/libselinux/src/avc_internal.h
> index a9a4aa0b..1f8e0102 100644
> --- a/libselinux/src/avc_internal.h
> +++ b/libselinux/src/avc_internal.h
> @@ -9,6 +9,7 @@
>  #ifndef _SELINUX_AVC_INTERNAL_H_
>  #define _SELINUX_AVC_INTERNAL_H_
>
> +#include <assert.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -112,26 +113,39 @@ static inline void avc_stop_thread(void *thread)
>                 avc_func_stop_thread(thread);
>  }
>
> +static inline void check_lock_callbacks(void)
> +{
> +    if (avc_func_alloc_lock || avc_func_get_lock
> +            || avc_func_release_lock || avc_func_free_lock) {
> +        assert(avc_func_alloc_lock && avc_func_get_lock
> +                && avc_func_release_lock && avc_func_free_lock);
> +    }
> +}
> +
>  static inline void *avc_alloc_lock(void)
>  {
> +       check_lock_callbacks();
>         return avc_func_alloc_lock ? avc_func_alloc_lock() : NULL;
>  }
>
>  static inline void avc_get_lock(void *lock)
>  {
> -       if (avc_func_get_lock)
> +       check_lock_callbacks();
> +       if (avc_func_get_lock && lock)
>                 avc_func_get_lock(lock);
>  }
>
>  static inline void avc_release_lock(void *lock)
>  {
> -       if (avc_func_release_lock)
> +       check_lock_callbacks();
> +       if (avc_func_release_lock && lock)
>                 avc_func_release_lock(lock);
>  }
>
>  static inline void avc_free_lock(void *lock)
>  {
> -       if (avc_func_free_lock)
> +       check_lock_callbacks();
> +       if (avc_func_free_lock && lock)
>                 avc_func_free_lock(lock);
>  }
>
> diff --git a/libselinux/src/callbacks.c b/libselinux/src/callbacks.c
> index c18ccc54..b635c8d8 100644
> --- a/libselinux/src/callbacks.c
> +++ b/libselinux/src/callbacks.c
> @@ -9,6 +9,7 @@
>  #include <errno.h>
>  #include <selinux/selinux.h>
>  #include "callbacks.h"
> +#include "avc_internal.h"
>
>  /* default implementations */
>  static int __attribute__ ((format(printf, 2, 3)))
> @@ -95,6 +96,18 @@ selinux_set_callback(int type, union selinux_callback cb)
>         case SELINUX_CB_POLICYLOAD:
>                 selinux_netlink_policyload = cb.func_policyload;
>                 break;
> +       case SELINUX_CB_ALLOC_LOCK:
> +               avc_func_alloc_lock = cb.func_alloc_lock;
> +               break;
> +       case SELINUX_CB_GET_LOCK:
> +               avc_func_get_lock = cb.func_get_lock;
> +               break;
> +       case SELINUX_CB_RELEASE_LOCK:
> +               avc_func_release_lock = cb.func_release_lock;
> +               break;
> +       case SELINUX_CB_FREE_LOCK:
> +               avc_func_free_lock = cb.func_free_lock;
> +               break;
>         }
>  }
>
> --
> 2.32.0.93.g670b81a890-goog
>

