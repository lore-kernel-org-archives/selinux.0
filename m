Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085FDC4332F
	for <selinux@archiver.kernel.org>; Fri,  3 Nov 2023 18:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbjKCSXs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Nov 2023 14:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjKCSXr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Nov 2023 14:23:47 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78698CF
        for <selinux@vger.kernel.org>; Fri,  3 Nov 2023 11:23:44 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5b9a7357553so1889044a12.0
        for <selinux@vger.kernel.org>; Fri, 03 Nov 2023 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699035824; x=1699640624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TCNQb+0Kp96Zh6xMIZrAIrptmKLA5zY+wHW7rjfY3+s=;
        b=T9c6Q5aW7hY9brm7bCls64YeJWqDUxvUPrMxSAy/MEW9IokZsdR4SP+WrF0VmZ8LVQ
         YSqsQv9Y1ALNse+N5QqGp72Yh+JnV/TfRAefOZkK+8r/LvXRCnMr2wdDhKloxoMVuRBY
         pOrkCbHg2KKEFp4LUUWvLl6WOv/Oj3ucKh0BuPKrnwS7F+a1d134fHbIxv/pQcFBNdmi
         tNnl14tpE1me6pNW2eHDlXGHA/CVf7dVXj9yNBOmuSnrEFXEhOTcUekx75JVvd7Ao7J+
         fZSxnk7qKbO4BLfaM9Vthr1cFHwl/MbvFlY1AITTvCwwFuHt34B1lFQgMRodt+XFZ+If
         E02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699035824; x=1699640624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCNQb+0Kp96Zh6xMIZrAIrptmKLA5zY+wHW7rjfY3+s=;
        b=XUNrMYOWc+6Qwc8LyuwMVbESQTMApeYmmgfs6yY/Fq5nVF6+i0Sc3dE2jWG+mvXdwj
         qGOoUBtlVk1KSXZ13os2MCH6mUQ2U2cpHQq1TEGM5HlBKsjWBcAtWsj4jc2+bG9VLtP5
         HK9NuRN4Yid2UpBkfOnBrQdT8C66cLqOvRzuJfVW+ldA1EgOl4PH3xD+7REcTBay9u47
         zCfgJCpzF9nKc+J4B3Ansg9NBCI1TZfxhYMaazyeD9sEUsqIFA2q3r080yJG82xU9YeO
         4+Ft9ApzzxlhDhsZQsXsycO3/ncj1FPP8sbhASqOyx5zzZzLgkrEnBH5JPe+YvdrlmsJ
         gJzg==
X-Gm-Message-State: AOJu0Yy3wF+aNDL0AVeS8VT0d/WoDN6X3MvuV7PNeBcaRk6wcgw0SS3/
        Z5nXKAocgVAVO9nb6AWe2lqwXUuWAq5MWjp6rkfdn58XZkc=
X-Google-Smtp-Source: AGHT+IFV7k9jfqFLjfPULH9Yj9sCE26c93uwFr5PffF1BRBGJ61tJOC55UUUspalvZJa+3ssQJE7RklXBpn1FugE9Z8=
X-Received: by 2002:a17:90a:d358:b0:280:3a0e:d34f with SMTP id
 i24-20020a17090ad35800b002803a0ed34fmr15672827pjx.10.1699035823816; Fri, 03
 Nov 2023 11:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20231103172953.24667-1-jsatterfield.linux@gmail.com> <20231103172953.24667-4-jsatterfield.linux@gmail.com>
In-Reply-To: <20231103172953.24667-4-jsatterfield.linux@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 3 Nov 2023 14:23:32 -0400
Message-ID: <CAEjxPJ7aStwa8A_wRELN8o29yggGnKaPUiV7aU7v+WzSZUD9sw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] selinux: use arrays for avtab hashtable nodes
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 3, 2023 at 1:30=E2=80=AFPM Jacob Satterfield
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
> with the hash table chain heads pointing into it, this results in only
> two additional kvcalloc() calls and the complete removal of the
> kmem_cache itself and its memory and runtime overheads.
>
> Running "perf stat -r 100 -d load_policy" has shown a runtime reduction
> of around 10% on a Fedora 38 x86_64 VM with this single patch. Future
> patches focused on improving the hash table's collision resolution
> strategy and array layout (struct-of-arrays vs. array-of-structs) may
> elicit even more caching and therefore runtime performance improvements.
>
> To prevent the conditional table from under-allocating the avtab_node
> array, which creates a heap-overflow bug, the two-pass algorithm in the
> patch "selinux: fix conditional avtab slot hint" is required.
>
> Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
