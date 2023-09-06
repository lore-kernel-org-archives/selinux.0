Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125EFEE14B9
	for <selinux@archiver.kernel.org>; Wed,  6 Sep 2023 17:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjIFRQa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Sep 2023 13:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjIFRQ3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Sep 2023 13:16:29 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B99D199F
        for <selinux@vger.kernel.org>; Wed,  6 Sep 2023 10:16:25 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bee392fe9dso82062a34.1
        for <selinux@vger.kernel.org>; Wed, 06 Sep 2023 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694020585; x=1694625385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSYxraWxfxU0nDwx4DDk7lr5kPFS/3z2DvlSRLoS6pI=;
        b=TvCweb94YLCc44rHLm2gXSfgfOky81+2YbikTPjO85fydTWYAGjCQ/gJBmtnxS2mst
         JwAZ/ouGqbPGDn1XOZQNGR9gnM4LCSxncLfAwXISrt0LjC3dbuoRlU8dDBUQpTH7VQ88
         RhcBOoH9It5kP5XlvP9GgN6no/jIJgZVaLK5Gn/xszMC+UITIjSciwkvM1rWNNNPE9Ny
         s7lcVmlkO84GTyjMSE0Xnn6AiXn/S0aKKfQqGNewGEYXso9+NS6Gyv9yXNhq+TLTGc8i
         OKr5B4uM0o7N+fU5t+TQwT1fn3nNxItDkSr+GPOICkK/beM25R08lFvfS4k/2OKv8QwQ
         SWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694020585; x=1694625385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSYxraWxfxU0nDwx4DDk7lr5kPFS/3z2DvlSRLoS6pI=;
        b=SVFnD32cCefNruohAvZrpe5oHlEVbrpKNmjnK7fsRefzJUPuN3LULriElWQIrH1ihe
         ++zuM6vMczeOC2MEbD8EaGROToBPEtRPviXNgLaCNH6xbI1eYM5P3Yeh01EwXQy34cWR
         xISZJmDJV5mi/KIVL+DR5rWt4w+HQtOot/95U8vSLm+KoKnErAOKN7lzsG0dooshJAJr
         M1FnGKrZkEjQuxf6Q4FsKp035tmXaLxjqAGfbA0yOBx9sS7A36U9So0kdl3UiO/4Wej1
         OkhmID7WmtZktbvoFQVpMLd0rCdGPYHmUdDy4RIvZl5GnDCpSrF36vXChfyTiRRnpAaJ
         KR7w==
X-Gm-Message-State: AOJu0Yz80Y20btFfG08VqVCLwV/QZF0OWoux4mHxjjTlhcSlavJOnX5K
        3bWrNXS0JAu9GloMXBEQpGwVzgNh9bediQPaLQQ=
X-Google-Smtp-Source: AGHT+IHtaDbM1T6nLr1+JDA+bLod+OemUSgBgwdvMfX/EpZAZicQ+laJbpnr2tpm13Y3cvDjYDYsQcYKSPFRXoo/i3w=
X-Received: by 2002:a05:6830:18d5:b0:6bd:bd0f:4d52 with SMTP id
 v21-20020a05683018d500b006bdbd0f4d52mr18255982ote.4.1694020584825; Wed, 06
 Sep 2023 10:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230906154611.31762-1-jsatterfield.linux@gmail.com> <20230906154611.31762-2-jsatterfield.linux@gmail.com>
In-Reply-To: <20230906154611.31762-2-jsatterfield.linux@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 6 Sep 2023 13:16:13 -0400
Message-ID: <CAEjxPJ48nkALPa+hdKVaC8uV0yYK05_TBq94hzP6mcqmETn5ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: use arrays for avtab hashtable nodes
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 6, 2023 at 11:46=E2=80=AFAM Jacob Satterfield
<jsatterfield.linux@gmail.com> wrote:
>
> The current avtab hashtable employs a separate chaining collision
> resolution strategy where each bucket/chain holds an ordered linked list
> of pointers to kmem_cache allocated avtab_node elements.
>
> On Fedora 38 (x86_64) using the default policy, avtab_node_cachep
> uses 573 slabs each containing 170 objects totaling 2,337,840 bytes.
> A call to kmem_cache_zalloc() is required for every single rule, which
> in the default policy is currently 96,730 and continually rising.
>
> When both sets of avtab_node (regular and cond.) are turned into arrays
> with the hash table slot indexing into it rather than a pointer, then
> this results in only 2 additional kvcalloc() calls and the complete
> removal of the kmem_cache itself.
>
> The caching characteristics of iterating a single array are better due
> to locality of reference. Running "perf stat -r 100 -d load_policy"
> has shown a runtime reduction of at least 10% on a Fedora 38 x86_64 VM
> with this single patch. Future patches focused on improving the hash
> table's collision resolution strategy and array layout (struct-of-arrays
> vs. array-of-structs) may elicit even more caching and therefore runtime
> performance improvements.
>
> On 64-bit machines, the memory usage of the hash table slots is cut in
> half due to the use of u32 indices instead of memory pointers. Since
> ~65k hash slots are used between the regular and cond. tables with the
> default Fedora 38 policy, this equates to around 256KB of memory saved.
>
> Notes:
>
> A couple helper functions avtab_get_chain() and avtab_get_node() are
> introduced to provide more standardized interfaces for use in functions
> that need to search through the hash table.
>
> NULL_NODE_IDX defines a sentinel value which helps determinine if a spot
> in the hash table or the "next" member of an avtab_node are valid.
>
> This patch causes the cond. rules table to waste memory as the size
> requested for the kvcalloc() is the size of the regular rules table.
> These tables rarely, if ever, have the same number of rules in practice.
> The next patch addresses this shortcoming.
>
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>

> ---
>  security/selinux/ss/avtab.c       | 75 +++++++++++++++----------------
>  security/selinux/ss/avtab.h       | 28 ++++++++++--
>  security/selinux/ss/conditional.c | 13 +++---
>  security/selinux/ss/services.c    | 20 +++++----
>  4 files changed, 81 insertions(+), 55 deletions(-)
>
