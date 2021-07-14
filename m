Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F212C07E9A
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E455B61260
	for <selinux@archiver.kernel.org>; Wed, 14 Jul 2021 18:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhGNSoD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 14 Jul 2021 14:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhGNSoB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 14 Jul 2021 14:44:01 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99A4C06175F
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:41:09 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v32-20020a0568300920b02904b90fde9029so3518304ott.7
        for <selinux@vger.kernel.org>; Wed, 14 Jul 2021 11:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uU3buDzpPdhv1gqJ5KuLQk5ZmsmqyTqPkc5h5Awthhc=;
        b=mW2BbzC3/RteuoNL//n1u+B0/zcAUQx5oIs3VOr3jCW2snPOKbMENN9S9nmODZtoER
         sg2K3P73D3uB4czuLAELIeZV1UEXO5F0KsVaz1JbA+0Zl20tNdaWl+9oOrDoqFem4jvC
         X5aZAUhP4VBK4WqX9OpTWCWs47I8TlXIz+9pW15t3hEncv94IrHlQy8sESUNAbGVCdTS
         Vr6PV9010DHVngkSnM06M01uDAbabbw+ck0t0TBpUpmfa/k7VI+lnpBVO303PAOHDM9H
         2MAFy/RJZV/Jc3oK6bl7a40hQwpfZeW9GlC3WzMYPUA5HHECVHhas8Ns1kuAx/MZrqPW
         WSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uU3buDzpPdhv1gqJ5KuLQk5ZmsmqyTqPkc5h5Awthhc=;
        b=sDqgl3hiy3ThAxpBneYlL7R361sxiqfuklvmffEn3LV16aU6CcwAvMaFs3idu2+BdJ
         MRTIerd1Ctw1xgqRSFnjzukLtsS0by8qU0UWx58XkChkUJK3446cc4jh4sMUxpNWcOBe
         c05qiFepto7lIphGRzDVqeSrFvdFQVxZh0mRSPGzEkV1ilpMiIHSp3JGn6Txgzkyk2eM
         xHHrqunYVe/iOaYj3GpgzadwvlkN2WShS7GM6O+0WjwAoJwOnIHE4xDz/kKIsVu/qbpS
         PKQ4dwWSCIQrTw768cgn4Iwe7bW/bV80cLEiRDy2lYZ5U9/Jugm3QjN5sXhroZVuPLuF
         3FYQ==
X-Gm-Message-State: AOAM531vvlTQWZ15NVJED+eW56QlNI4fP9YBTxppBRpG7tZFRtJjG6KN
        IaHPkcfHhC3pybMdsyfbu+ybwNPApm8zz9Iq5KogxB85W/8ZyQ==
X-Google-Smtp-Source: ABdhPJxoN1FmNdNXTqXm3TnlnhBwJH8nh6qJHXIPPD70czuVwzrOflPVhksOCqSlpsQqnazdG+rgv645oZT5PhpIolM=
X-Received: by 2002:a9d:1464:: with SMTP id h91mr9085836oth.237.1626288068998;
 Wed, 14 Jul 2021 11:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210712223013.2165325-1-sethmo@google.com>
In-Reply-To: <20210712223013.2165325-1-sethmo@google.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 14 Jul 2021 20:40:57 +0200
Message-ID: <CAJ2a_DfTtk18K8GoXqnHR-yiEh=Vfmjg8VqJtHPSNW832Po_WA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: add lock callbacks
To:     Seth Moore <sethmo@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Nicolas Iooss <nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 13 Jul 2021 at 00:30, Seth Moore <sethmo@google.com> wrote:
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

Since libselinux 3.2 `avc_init_internal()` uses the SELinux status
map, via `selinux_status_open()`, by default and by e.g.
`selinux_check_access()` via `selinux_status_updated()`.
The status page code is not thread-safe due to the non-thread local
state variables, like `last_seqno` or `last_policyload`.
One could mark them with the thread-local storage specifier `__thread`
(already used within libselinux), but it will result in setenforce-
and policyload-callbacks for a single event being called multiple
times for each thread.

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

Maybe mention that these callbacks affect the thread-safety of only a
subsection of libselinux; the AVC, security_compute_* and
selinux_check_access interfaces (e.g. the get*con/set*con are
thread-safe by default).
Also selinux -> SELinux.
