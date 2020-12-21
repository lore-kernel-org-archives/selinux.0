Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A061DC433DB
	for <selinux@archiver.kernel.org>; Mon, 21 Dec 2020 18:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 569622253A
	for <selinux@archiver.kernel.org>; Mon, 21 Dec 2020 18:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgLUS5b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 21 Dec 2020 13:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgLUS5b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 21 Dec 2020 13:57:31 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EA1C0613D3
        for <selinux@vger.kernel.org>; Mon, 21 Dec 2020 10:56:50 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m12so26159546lfo.7
        for <selinux@vger.kernel.org>; Mon, 21 Dec 2020 10:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7s9hr5dA0fkx/QFZ7NM96YTbkBxRmWF3/JfxOfZsQMc=;
        b=cC2mCzLCRMTQ/nBYz4nuN6Pl2inYkAn6iuDtvKgSLMm28Yh/okc49VAwJduL90FCTT
         YFqOu6H5ezgYcm/Xm31wbBqeVdL0y1V0Jspa295j/QP4Lb+eZxNAMXSthS/zq9mw+sNd
         cKG62TYQTzmvDmQuvUgr696xZcycGsSvLrbQPkKZf4RzIQy6qJMakLR4Q6O6hk4tZdK4
         x0rXo1q2VuJkUgR/tYaWP7aY5Me1yA/5FobpU37in71kZQ0X8uBKVKVvRCvvO9+kQjMr
         dxb6VgHetww2qew3dT7tnum4qZd6uaSAg9WZDeCqyJeCHvvEz6xihwjxqjwh8qcyXqUq
         AFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7s9hr5dA0fkx/QFZ7NM96YTbkBxRmWF3/JfxOfZsQMc=;
        b=kZAUMem69H9KuvUxZrWf56eoW4OxMRviiy3bWBKDu0kOb5VFhspF6CuMWrHn4+EHfD
         pd5T2nd+PsG6t3s1LzAMCrgeXRWZYuyof9hOlSHeqx05Dcr56H0wLy7AY2MyYBEFHssq
         BRolP+meXG9Qs31T4jss2UjKgv1Mqb/9Rk+WRU9R0Yah2jqK6A9/KKizi9KKEmXxCiyf
         plebIqGa5Q7oA1pRVy7JLKASmSNXakqnt7B8n0z4PphLVh48HMlri/GRf6vENF/F+rQz
         JiIHweI0aAQsgRflx+XSebz12q8oqCA9egSuYM1+0i+Ni05O83qz52vZuEVVEZo5qVcv
         nHYQ==
X-Gm-Message-State: AOAM53044in1+QHZFHFNikPDdXUZaprNDBChQIuBwbR6RdNkqdLpwkBb
        nufAIqFNHw2Zef1QruOCBOlPO9J5CPHxmVAc9jFCH4ZlxA==
X-Google-Smtp-Source: ABdhPJya3APIOqcDyWt08s07GpfF6usRNvPf7LcRwVxMpAteQvJVL4vTvdssZEwzbuzrjt4u+KGb9OrGLN3CKkyVXrw=
X-Received: by 2002:a05:6402:1593:: with SMTP id c19mr16694527edv.269.1608566650603;
 Mon, 21 Dec 2020 08:04:10 -0800 (PST)
MIME-Version: 1.0
References: <X9vP2uwRZb1l1ySE@server-build.lan> <CAFqZXNtvY4tJnH07wNvTGuynzGYQQrwVQiXVWBTDfzWUPCWpsw@mail.gmail.com>
In-Reply-To: <CAFqZXNtvY4tJnH07wNvTGuynzGYQQrwVQiXVWBTDfzWUPCWpsw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Dec 2020 11:03:59 -0500
Message-ID: <CAHC9VhTfs_qfyiY916dW3GOMtzyUSebgH8W5H-k7GdBii7vHzg@mail.gmail.com>
Subject: Re: [kernel-secnext] Automated Testing Results Linux
 5.11.0-0.rc0.20201217gite994cc240a3b.102.1.secnext.fc34.x86_64 [12/17/2020 16:38]
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     kernel-secnext@googlegroups.com,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Dec 19, 2020 at 6:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Thu, Dec 17, 2020 at 10:38 PM <paul@paul-moore.com> wrote:
> >
> > SYSTEM: test-rawhide-1.lan
> > DATE: Thu, 17 Dec 2020 16:38:34 -0500
> >
> > KERNEL: Linux 5.11.0-0.rc0.20201217gite994cc240a3b.102.1.secnext.fc34.x86_64
> >
> >    audit-testsuite: PASS
> >  selinux-testsuite: FAILED

...

> > ### START SELINUX TEST LOG
> > Compiling targeted test_policy module
> > Creating targeted test_policy.pp policy package
> > domain_fd_use --> on
> > Running as user root with context unconfined_u:unconfined_r:unconfined_t
> >
> > domain_trans/test ........... ok

...

> > tun_tap/test ................ ok
> >
> > #   Failed test at perf_event/test line 61.
> > # Looks like you failed 1 test of 9.
> > perf_event/test .............
> > Dubious, test returned 1 (wstat 256, 0x100)
> > Failed 1/9 subtests
>
> So as you can see, we finally added the perf_event class to Fedora
> policy :) (at least that one for a start...)
>
> The failure seems to be caused by the introduction of CAP_PERFMON (and
> the fact that we haven't yet added *that one* to the policy...). I'll
> try to come up with a patch, but it probably won't happen until next
> year, so if someone wants to have a go at it, they are of course free
> to do so :)

Thanks for looking into this.  I noticed some consistent test failures
last week but figured I would give it a few days to see if it resolved
upstream (test failures during the merge window are not uncommon, and
they often resolve themselves in a day or two).

At the very least I'll see if there is a quick patch I can do for my
automated test runs so we don't keep seeing this failure.

-- 
paul moore
www.paul-moore.com
