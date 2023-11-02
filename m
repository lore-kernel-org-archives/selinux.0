Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05211C4332F
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 21:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjKBVGW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 17:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKBVGW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 17:06:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0228188
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 14:06:19 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99de884ad25so225031266b.3
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 14:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698959178; x=1699563978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yej6NvlMdA0aqC0ujYrLZAj62b78tfRqAMklEpgpZdo=;
        b=a+/RYga070TMPZAou1o8mXhu04So3CetsggSIQOmr7A0LM6TS2UN2TPB8A+9k1D3xh
         b8pQeiwe2zLKawiKYbGLSzxuk+48Otn9kdOKyqsa7iqA2/67E7ZRKOAxZNDBtjcQ4DJR
         XfRnfWiv9medlJOCRTIABa0kekYwz/n1XvYqNKJoqSMttEjlpUyR3i5bwgYtdacDrI1I
         xeNVyiIVQ1mYPxOJnGCTicRYFmREzGgm0gKpve/53a5iBxWPLFwpCHuFfNOJlI4PSvQo
         JIl47ibkejRU8DfeDnWpIC1dXRmp0xRHNNPatQ8ewdiZ2eRZhhhC5+bU11LXSwhC+MCc
         OWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698959178; x=1699563978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yej6NvlMdA0aqC0ujYrLZAj62b78tfRqAMklEpgpZdo=;
        b=jYHDHbj8IIpTU/gvYdnGrYm2J4AsqUWDMu3HiSxxfpi1wNa3YnpMEC3unjT8gI6Ni4
         bLBZJRhCr0kav703TNjISisiNgMbN1ISXBHN1g7awZRcS2rTTx8eHio+bh12uSY9t3ZR
         YfVa6u/gX8WBy2MQTHma2aW+oPvUl2pfEF/izkUfdCLf48ojHLyXvyOMaXk8RyE8VeR8
         fUjEwVVgYgZBuevgMmrhnjoB9FTP2jfTGshFSDPQF5/XAPWCvG8kGuCavyMmTUve895O
         6HF3fO17kMUsxq+xUYUpdrIjDvtTS83QulACJzoOMBUnia0f/vDEkKK+rH+RnaEcv7bd
         n1Kw==
X-Gm-Message-State: AOJu0YwuLMpagXhvBV6ht4oKv7TgxON/At5lG5i7iU1KVdGkHR8yVhBb
        19WKAgXgG8eDMzPOKv0ej6k+f0NaMYuKNAvShI/OZmpT
X-Google-Smtp-Source: AGHT+IEKEPQnLfel3kAnOWe8GZvmvPVmkL7PuuCSNgRuqvvQVGlftY9aBzVMkb1W06fqTFucySKotypQKCSTph3zu7s=
X-Received: by 2002:a17:906:52d7:b0:9bf:7bef:fc08 with SMTP id
 w23-20020a17090652d700b009bf7beffc08mr4186388ejn.56.1698959177791; Thu, 02
 Nov 2023 14:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231102154524.12006-1-jsatterfield.linux@gmail.com>
 <20231102154524.12006-4-jsatterfield.linux@gmail.com> <CAEjxPJ7yHH1BPa4eowNu3pS_RXM22CKFziJug_FpkRofzUjxiQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7yHH1BPa4eowNu3pS_RXM22CKFziJug_FpkRofzUjxiQ@mail.gmail.com>
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
Date:   Thu, 2 Nov 2023 17:06:06 -0400
Message-ID: <CALMFcevTJGYGgpamhwx8YhnE=4g16uLMBxS6LDtDOpzMVoH8qA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: use arrays for avtab hashtable nodes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 2, 2023 at 1:34=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Nov 2, 2023 at 11:45=E2=80=AFAM Jacob Satterfield
> <jsatterfield.linux@gmail.com> wrote:
> >
> > The current avtab hashtable employs a separate chaining collision
> > resolution strategy where each bucket/chain holds an ordered linked lis=
t
> > of pointers to kmem_cache allocated avtab_node elements.
> >
> > On Fedora 38 (x86_64) using the default policy, avtab_node_cachep
> > uses 573 slabs each containing 170 objects totaling 2,337,840 bytes.
> > A call to kmem_cache_zalloc() is required for every single rule, which
> > in the default policy is currently 96,730 and continually rising.
> >
> > When both sets of avtab_node (regular and cond.) are turned into arrays
> > with the hash table chain heads pointing into it, this results in only
> > two additional kvcalloc() calls and the complete removal of the
> > kmem_cache itself and its memory and runtime overheads.
> >
> > Running "perf stat -r 100 -d load_policy" has shown a runtime reduction
> > of around 10% on a Fedora 38 x86_64 VM with this single patch. Future
> > patches focused on improving the hash table's collision resolution
> > strategy and array layout (struct-of-arrays vs. array-of-structs) may
> > elicit even more caching and therefore runtime performance improvements=
.
> >
> > To prevent the conditional table from under-allocating the avtab_node
> > array, which creates a heap-overflow bug, the two-pass algorithm in the
> > patch "selinux: fix conditional avtab slot hint" is required.
> >
> > Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
> > ---
>
> This patch doesn't apply cleanly via git am; it will apply manually
> with fuzz via patch but that suggests you sent the wrong version of
> the patch rather than one based on the latest series.

This is my fault. When I dropped a patch from the series, I did it
after git format-patch not realising the following hashes wouldn't
align. (I'm still learning this workflow...)

I will resend the patch series with the correct hashes. My apologies
for the spam.
