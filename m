Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB5CC4332F
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 17:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjKBReW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 13:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjKBReV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 13:34:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76E018C
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 10:34:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-280351c32afso1122413a91.1
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 10:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698946457; x=1699551257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wfAqKr0veWqngPAu/0To83vJNijTViugzS3exw2YRB4=;
        b=DE+JemQp82gfrcIq5q55vYtnUt3qRN/sOeDonny8/PlFaFOqKII4SSD+4/H9hMeItX
         83SluTxiwYNMhxj/G29edQZsNcro+vQCL0+nemyS9LHw9d+3PTJV5pd3z6lRu6YCl7J3
         kWeCVlAsznZLBPmRt32xBGN/d/aSX+Bi2I0CmG5YxGSsMAujdZQrwIxVeCUNz7sNI0TH
         ZTStWZOuVV2cMLA8StxQkEkTSl1kITSNVLVGoBX/I33UkudHNgeQk0gFQux0kM0WAW1q
         yA755nGNG0UK4MbrykRwHJFJYG1NsCTasYM0ywFFnAR/Ltsy0XEkF4/25/+Tpsu6P6fV
         cHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698946457; x=1699551257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfAqKr0veWqngPAu/0To83vJNijTViugzS3exw2YRB4=;
        b=eWCEG+nIG9DoJN5PF0FjPCwozpYmgw3gfyW4LGUK+kQAZ7IsCY6bv1lvwsusPnradE
         A+/mrLlDdAADKi8SMzGL/wcc8oWXWyTFWBrgx9HBbeEqkynzl+afuE94Hofa+KlgIlEr
         YggNAdiNfVCbQbvaljPrNOcvXEf7l3ZmqpBHvD5ejYlmgaFpbDYj4Y2FNAP1X2kNIf/w
         sf0xLuP1AAfaeHxeV59f9DHChWFm++XilybksvMoBgBwFm7cEeOuGZ5lOgTM/cYA3ydq
         yQoT35B8rmVGjIyVrUxA/wCB86PLuQfRQbrMv+wh1B+rsGvU2uEzOXrSqDyfrwuI1pIV
         xNlA==
X-Gm-Message-State: AOJu0YwI7laNYoxhI0FZNPW76fCWbOADi9x9FRL2AXKgTyoHAgehA8pa
        EGaC8ot9FarrhGGqfAMjyY1VGLNnpYKzIn9UpgI=
X-Google-Smtp-Source: AGHT+IFOBybLr+PhK1YDzu7/+OFrjk2OWTjGF1chXeYJTiKEOhmi1jCthMVo+wrQ+DpyGJTJbitnmagE42YB/VJqrks=
X-Received: by 2002:a17:90a:1996:b0:27d:2054:9641 with SMTP id
 22-20020a17090a199600b0027d20549641mr18471597pji.36.1698946457036; Thu, 02
 Nov 2023 10:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231102154524.12006-1-jsatterfield.linux@gmail.com> <20231102154524.12006-4-jsatterfield.linux@gmail.com>
In-Reply-To: <20231102154524.12006-4-jsatterfield.linux@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 2 Nov 2023 13:34:05 -0400
Message-ID: <CAEjxPJ7yHH1BPa4eowNu3pS_RXM22CKFziJug_FpkRofzUjxiQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] selinux: use arrays for avtab hashtable nodes
To:     Jacob Satterfield <jsatterfield.linux@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 2, 2023 at 11:45=E2=80=AFAM Jacob Satterfield
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
> ---

This patch doesn't apply cleanly via git am; it will apply manually
with fuzz via patch but that suggests you sent the wrong version of
the patch rather than one based on the latest series.
