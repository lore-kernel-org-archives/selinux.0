Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEACC67871
	for <selinux@archiver.kernel.org>; Thu, 12 Jan 2023 00:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbjALAty (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 11 Jan 2023 19:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbjALAtv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 11 Jan 2023 19:49:51 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24024084F
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 16:49:48 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 203so16941735yby.10
        for <selinux@vger.kernel.org>; Wed, 11 Jan 2023 16:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hDrqeCy2isEAcEZutQc18fIgv9oWhVupwebw91lgye4=;
        b=qxxyHu+WDybsKdsOve3HdK7LpgzBN/3GZRqgrxvs9Q5W9Kzwd7Dzc9/jYzxkNuDrul
         kQkTCY47Z2auo0ah8YGi8N0fYkfJOF7YxzNDRGT2TVVKTxh3xTGn5tExmfv9+PHBUfjc
         yw/X/nMCu8FyYUb99VuG8LjTaud4O30po5zBH3LKaw5V6vBQRwOmH59u3sd47u/bsD8t
         wqFwxSQZsBtZNU5U8hrEp3462X5hXd5zeVSkG1FDkuO9G+kbmGLsdETBG2DaHv5igzc1
         rEShl5bXFHof6n5bFLnvY/qrSb9Wg1ns/Lu0eWyU8NcGpi2ojYMe7+hIT1ATndOFXF0A
         cgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDrqeCy2isEAcEZutQc18fIgv9oWhVupwebw91lgye4=;
        b=pLj3Kasf5iswJQBPuQxcDu7f4DpZJjFPkX5aDhykp/v6zBbd+kw/DB0DAaq1Eh0zOD
         G9/PlrVvZJ73pQkKVzigqMYkilYF34G2ZR+OZ91FudljHhrNlx5hyK2s87vzcPVmtWzQ
         /GeC+N/wPfKJFEsa6fMyupBrid9RqzdFpKbfLpsT1i/wwGbm9Yb+3FzaWvEEFTdTAD9d
         R+PdZJQiQPHqv8RcXdcvyiHzGIlAlOSST2CNd6Jq6PRTC/i0xrtH5Is0cJBy3YfkzNgJ
         wTHg5snLSDWVNLygftByCYOmhAnBg2Ybx2yGGgjyYDcn04+daUsx3Tinjyr8QZpJUgV5
         RFpw==
X-Gm-Message-State: AFqh2kpMFjJxqWllGhoD3sZ+NBPYCmKqH+99SXeElV1P5Lwy2K6P/j+/
        O5BlxiSPL6N6dvedgXZPfruPfaMh1LEfyzg21miwUg==
X-Google-Smtp-Source: AMrXdXu17IFbx26OPrHPKXjmemxAqNaMOD1OWegMg2ItX26DTAFbkKoo8CQ39aLybKhS2ukHUzL7EAGQYL9SN8e9NYA=
X-Received: by 2002:a25:dd84:0:b0:756:35b9:e2de with SMTP id
 u126-20020a25dd84000000b0075635b9e2demr8569422ybg.117.1673484587884; Wed, 11
 Jan 2023 16:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20230109213809.418135-1-tjmercier@google.com> <CALvZod4ru7F38tAO-gM9ZFKaEhS0w3KqFbPwhwcTvgJs4xMUow@mail.gmail.com>
 <Y78+rfzXPq5XGs9O@phenom.ffwll.local>
In-Reply-To: <Y78+rfzXPq5XGs9O@phenom.ffwll.local>
From:   "T.J. Mercier" <tjmercier@google.com>
Date:   Wed, 11 Jan 2023 16:49:36 -0800
Message-ID: <CABdmKX0TAv=iRz0s+F6dVVX=xsK00BeUPkRM4bnsfemDAY9U4w@mail.gmail.com>
Subject: Re: [PATCH 0/4] Track exported dma-buffers with memcg
To:     Shakeel Butt <shakeelb@google.com>,
        "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, android-mm@google.com,
        jstultz@google.com, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jan 11, 2023 at 2:56 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Mon, Jan 09, 2023 at 04:18:12PM -0800, Shakeel Butt wrote:
> > Hi T.J.,
> >
> > On Mon, Jan 9, 2023 at 1:38 PM T.J. Mercier <tjmercier@google.com> wrote:
> > >
> > > Based on discussions at LPC, this series adds a memory.stat counter for
> > > exported dmabufs. This counter allows us to continue tracking
> > > system-wide total exported buffer sizes which there is no longer any
> > > way to get without DMABUF_SYSFS_STATS, and adds a new capability to
> > > track per-cgroup exported buffer sizes. The total (root counter) is
> > > helpful for accounting in-kernel dmabuf use (by comparing with the sum
> > > of child nodes or with the sum of sizes of mapped buffers or FD
> > > references in procfs) in addition to helping identify driver memory
> > > leaks when in-kernel use continually increases over time. With
> > > per-application cgroups, the per-cgroup counter allows us to quickly
> > > see how much dma-buf memory an application has caused to be allocated.
> > > This avoids the need to read through all of procfs which can be a
> > > lengthy process, and causes the charge to "stick" to the allocating
> > > process/cgroup as long as the buffer is alive, regardless of how the
> > > buffer is shared (unless the charge is transferred).
> > >
> > > The first patch adds the counter to memcg. The next two patches allow
> > > the charge for a buffer to be transferred across cgroups which is
> > > necessary because of the way most dmabufs are allocated from a central
> > > process on Android. The fourth patch adds a SELinux hook to binder in
> > > order to control who is allowed to transfer buffer charges.
> > >
> > > [1] https://lore.kernel.org/all/20220617085702.4298-1-christian.koenig@amd.com/
> > >
> >
> > I am a bit confused by the term "charge" used in this patch series.
> > From the patches, it seems like only a memcg stat is added and nothing
> > is charged to the memcg.
> >
> > This leads me to the question: Why add this stat in memcg if the
> > underlying memory is not charged to the memcg and if we don't really
> > want to limit the usage?
> >
> > I see two ways forward:
> >
> > 1. Instead of memcg, use bpf-rstat [1] infra to implement the
> > per-cgroup stat for dmabuf. (You may need an additional hook for the
> > stat transfer).
> >
> > 2. Charge the actual memory to the memcg. Since the size of dmabuf is
> > immutable across its lifetime, you will not need to do accounting at
> > page level and instead use something similar to the network memory
> > accounting interface/mechanism (or even more simple). However you
> > would need to handle the reclaim, OOM and charge context and failure
> > cases. However if you are not looking to limit the usage of dmabuf
> > then this option is an overkill.
>
> I think eventually, at least for other "account gpu stuff in cgroups" use
> case we do want to actually charge the memory.
>
Yes, I've been looking at this today.

> The problem is a bit that with gpu allocations reclaim is essentially "we
> pass the error to userspace and they get to sort the mess out". There are
> some exceptions (some gpu drivers to have shrinkers) would we need to make
> sure these shrinkers are tied into the cgroup stuff before we could enable
> charging for them?
>
I'm also not sure that we can depend on the dmabuf being backed at
export time 100% of the time? (They are for dmabuf heaps.) If not,
that'd make calling the existing memcg folio based functions a bit
difficult.

> Also note that at least from the gpu driver side this is all a huge
> endeavour, so if we can split up the steps as much as possible (and get
> something interim useable that doesn't break stuff ofc), that is
> practically need to make headway here. TJ has been trying out various
> approaches for quite some time now already :-/
> -Daniel
>
> > Please let me know if I misunderstood something.
> >
> > [1] https://lore.kernel.org/all/20220824233117.1312810-1-haoluo@google.com/
> >
> > thanks,
> > Shakeel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
